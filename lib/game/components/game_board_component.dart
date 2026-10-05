import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/components/pop_animation_component.dart';
import 'package:star_shooter/game/components/gravity_drop_component.dart';
import 'package:star_shooter/game/components/star_component.dart';
import 'package:star_shooter/game/fx/floating_score_component.dart';
import 'package:star_shooter/game/fx/particle_config.dart';
import 'package:star_shooter/game/fx/particle_emitter_component.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/services/board_resolver.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// The real game-board Flame component for Star Shooter.
///
/// Owns the [BoardGrid] data model and keeps a matching list of
/// [StarComponent] children in sync. Layout is re-computed on every
/// [onGameResize] call so the board looks correct on any screen size.
///
/// Board geometry:
/// * 94 % of canvas width, centred horizontally.
/// * Starts 6 % from the top, spans 62 % of canvas height.
class GameBoardComponent extends PositionComponent
    with HasGameReference<StarShooterGame> {
  BoardGrid _grid;
  final List<StarComponent> _starComponents = [];
  Rect _boardRect = Rect.zero;
  final Random _rng = Random();

  GameBoardComponent({LevelDefinition? levelDef})
      : _grid =
            (levelDef?.buildInitialBoard()) ?? BoardGrid.initialBoard(rows: 5),
        super(priority: 0);

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _updateBoardRect();
    await _syncStarsToBoard();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _updateBoardRect();
    _repositionStars();
  }

  // ── Board geometry ─────────────────────────────────────────────────────────

  void _updateBoardRect() {
    final gameSize = game.size;

    final boardW = gameSize.x * 0.94;
    final boardLeft = (gameSize.x - boardW) / 2;
    final boardTop = gameSize.y * 0.06;
    final boardH = gameSize.y * 0.62;

    _boardRect = Rect.fromLTWH(boardLeft, boardTop, boardW, boardH);

    // Position this component at the board origin so render() draws at (0,0).
    position = Vector2(_boardRect.left, _boardRect.top);
  }

  // ── Star synchronisation ───────────────────────────────────────────────────

  Future<void> _syncStarsToBoard() async {
    for (final child in _starComponents) {
      child.removeFromParent();
    }
    _starComponents.clear();

    for (final star in _grid.allStars) {
      final pixelCenter = _grid.gridToPixel(star.gridPosition, _boardRect);
      final component = StarComponent(star);
      // Convert absolute pixel position to local (component-relative) coords.
      component.position = Vector2(
        pixelCenter.dx - _boardRect.left,
        pixelCenter.dy - _boardRect.top,
      );
      await add(component);
      _starComponents.add(component);
    }
  }

  void _repositionStars() {
    for (final component in _starComponents) {
      final pixelCenter =
          _grid.gridToPixel(component.model.gridPosition, _boardRect);
      component.position = Vector2(
        pixelCenter.dx - _boardRect.left,
        pixelCenter.dy - _boardRect.top,
      );
    }
  }

  // ── Resolution ─────────────────────────────────────────────────────────────

  Future<void> _applyResolution(
    ResolutionResult result,
    GridPosition placedPos,
  ) async {
    // Spawn pop animations and particle bursts for matched stars.
    for (final group in result.matchedGroups) {
      for (final pos in group) {
        final pixel = _grid.gridToPixel(pos, _boardRect);
        final star = _grid.starAt(pos);
        if (star != null) {
          game.add(
            PopAnimationComponent(
              position: Vector2(pixel.dx, pixel.dy),
              color: star.type.color,
            ),
          );
          final config = group.length >= 5
              ? ParticleConfig.popLarge
              : ParticleConfig.popSmall;
          game.add(
            ParticleEmitterComponent(
              position: Vector2(pixel.dx, pixel.dy),
              color: star.type.color,
              config: config,
            ),
          );
        }
      }
      // Spawn one floating score per group at the centroid.
      if (group.isNotEmpty) {
        var sumX = 0.0;
        var sumY = 0.0;
        for (final pos in group) {
          final px = _grid.gridToPixel(pos, _boardRect);
          sumX += px.dx;
          sumY += px.dy;
        }
        final centroid = Vector2(sumX / group.length, sumY / group.length);
        game.add(
          FloatingScoreComponent(
            position: centroid,
            score: group.length * 50,
            comboLevel: result.comboLevel,
          ),
        );
      }
    }
    // Spawn gravity-drop and particle burst for floating stars.
    for (final pos in result.floatingStars) {
      final pixel = _grid.gridToPixel(pos, _boardRect);
      final star = _grid.starAt(pos);
      if (star != null) {
        final drift = (_rng.nextDouble() - 0.5) * 60.0;
        game.add(
          GravityDropComponent(
            startPos: Vector2(pixel.dx, pixel.dy),
            color: star.type.color,
            horizontalDrift: drift,
          ),
        );
      }
      game.add(
        ParticleEmitterComponent(
          position: Vector2(pixel.dx, pixel.dy),
          color: star?.type.color ?? const Color(0xFFFFBF00),
          config: ParticleConfig.popSmall,
        ),
      );
    }
    // Update grid to final resolved state.
    _grid = result.finalBoard;
    await _syncStarsToBoard();
  }

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Places a projectile star at the grid cell nearest to [pixelPos].
  ///
  /// Triggers full board resolution (match detection, floating-cluster removal,
  /// pop animations). Returns the [ResolutionResult] or `null` if no valid cell
  /// was available.
  Future<ResolutionResult?> placeProjectile(
    StarModel star,
    Offset pixelPos,
  ) async {
    final gridPos = _grid.pixelToGrid(pixelPos, _boardRect);
    if (!_grid.isValidPosition(gridPos) || _grid.isOccupied(gridPos)) {
      // Try neighbours — find the closest valid unoccupied cell.
      GridPosition? bestPos;
      double bestDist = double.infinity;
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          if (dr == 0 && dc == 0) continue;
          final candidate = GridPosition(gridPos.row + dr, gridPos.col + dc);
          if (_grid.isValidPosition(candidate) &&
              !_grid.isOccupied(candidate)) {
            final pixel = _grid.gridToPixel(candidate, _boardRect);
            final dx = pixelPos.dx - pixel.dx;
            final dy = pixelPos.dy - pixel.dy;
            final d = dx * dx + dy * dy;
            if (d < bestDist) {
              bestDist = d;
              bestPos = candidate;
            }
          }
        }
      }
      if (bestPos == null) return null;
      final placed = star.copyWith(gridPosition: bestPos);
      _grid = _grid.placeStar(placed, bestPos);
      final result = BoardResolver.resolve(board: _grid, placedPos: bestPos);
      await _applyResolution(result, bestPos);
      return result;
    }
    final placed = star.copyWith(gridPosition: gridPos);
    _grid = _grid.placeStar(placed, gridPos);
    final result = BoardResolver.resolve(board: _grid, placedPos: gridPos);
    await _applyResolution(result, gridPos);
    return result;
  }

  /// Returns `true` when any star has reached or passed [boundaryRow].
  bool isFailureBoundaryReached(int boundaryRow) {
    return _grid.occupiedPositions.any((pos) => pos.row >= boundaryRow);
  }

  BoardGrid get grid => _grid;
  Rect get boardRect => _boardRect;

  // ── Render ─────────────────────────────────────────────────────────────────

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Subtle semi-transparent dark panel behind the star grid.
    final bgPaint = Paint()
      ..color = const Color(0x1A4A90E2)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, _boardRect.width, _boardRect.height),
        const Radius.circular(16),
      ),
      bgPaint,
    );

    // Board outline.
    final borderPaint = Paint()
      ..color = const Color(0x594A90E2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, _boardRect.width, _boardRect.height),
        const Radius.circular(16),
      ),
      borderPaint,
    );
  }
}
