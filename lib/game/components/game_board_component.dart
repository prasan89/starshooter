import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/components/star_component.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/star_model.dart';
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

  GameBoardComponent()
      : _grid = BoardGrid.initialBoard(rows: 5),
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

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Places a projectile star at the grid cell nearest to [pixelPos].
  ///
  /// If the resolved cell is invalid or already occupied the call is a no-op.
  Future<void> placeProjectile(StarModel star, Offset pixelPos) async {
    final gridPos = _grid.pixelToGrid(pixelPos, _boardRect);
    if (!_grid.isValidPosition(gridPos) || _grid.isOccupied(gridPos)) {
      return;
    }
    final placed = star.copyWith(gridPosition: gridPos);
    _grid = _grid.placeStar(placed, gridPos);
    await _syncStarsToBoard();
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
