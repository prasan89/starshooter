import 'dart:math' show Random;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/components/premium_star_renderer.dart';
import 'package:star_shooter/game/fx/impact_flash_effect.dart';
import 'package:star_shooter/game/fx/shooting_trail_component.dart';
import 'package:star_shooter/game/fx/combo_cinematic_component.dart';
import 'package:star_shooter/game/managers/game_manager.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/shooter_game_state.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/star_shooter_game.dart';
import 'package:star_shooter/game/systems/collision_system.dart';

/// A moving star that travels along the aim direction until it hits something.
///
/// Handles wall bouncing, star-collision snapping, and out-of-bounds cleanup.
class ProjectileComponent extends PositionComponent
    with HasGameReference<StarShooterGame> {
  final StarModel _model;
  Vector2 _velocity;
  bool _active = true;
  double _trailTimer = 0.0;
  double _shimmerT = 0.0;

  // Premium renderer cached per color index (shared across all projectiles).
  static final _renderers = <int, PremiumStarRenderer>{};
  static PremiumStarRenderer _renderer(int colorIndex) {
    return _renderers.putIfAbsent(colorIndex, () {
      const styles = [
        StarVisualStyle.yellow,
        StarVisualStyle.red,
        StarVisualStyle.green,
        StarVisualStyle.blue,
        StarVisualStyle.purple,
      ];
      return PremiumStarRenderer(styles[colorIndex % styles.length]);
    });
  }

  static const double _speed = 600.0; // pixels per second
  static const double _trailInterval = 0.05; // seconds between trail puffs

  ProjectileComponent({
    required StarModel model,
    required Vector2 direction,
  })  : _model = model,
        _velocity = direction.normalized() * _speed,
        super(
          priority: 4,
          size: Vector2.all(model.collisionRadius * 2),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    if (!_active) return;

    _shimmerT = (_shimmerT + dt * 3.0) % (2 * 3.1415926535);

    // Flame can occasionally deliver a large frame delta during startup,
    // backgrounding, or device load. Sub-stepping prevents a fast projectile
    // from tunnelling through stars or skipping a wall.
    var remaining = dt.clamp(0.0, 0.12).toDouble();
    const maxStep = 1.0 / 120.0;

    while (remaining > 0 && _active) {
      final step = remaining < maxStep ? remaining : maxStep;
      remaining -= step;

      final nextPosition = position + _velocity * step;
      final gs = game.size;
      final board = game.board;
      final boardRect = board.boardRect;

      // Horizontal walls are handled first. Clamp to the wall after reflecting
      // so the next sub-step starts inside the playable area instead of
      // repeatedly bouncing on the same wall.
      if (nextPosition.x - _model.collisionRadius <= 0) {
        position = Vector2(_model.collisionRadius, nextPosition.y);
        _velocity = CollisionSystem.reflectHorizontal(_velocity);
        game.add(
          ShootingTrailComponent(
            position: position.clone(),
            color: _model.displayColor,
            isBounce: true,
          ),
        );
        continue;
      }

      if (nextPosition.x + _model.collisionRadius >= gs.x) {
        position = Vector2(
          gs.x - _model.collisionRadius,
          nextPosition.y,
        );
        _velocity = CollisionSystem.reflectHorizontal(_velocity);
        game.add(
          ShootingTrailComponent(
            position: position.clone(),
            color: _model.displayColor,
            isBounce: true,
          ),
        );
        continue;
      }

      position = nextPosition;

      // Check star collision BEFORE the ceiling. A star occupying the top row
      // must still be hittable; the old ordering could classify that shot as a
      // ceiling hit first.
      final hitGrid = CollisionSystem.checkStarCollision(
        projectilePos: position,
        projectileRadius: _model.collisionRadius,
        board: board.grid,
        boardRect: boardRect,
      );

      if (hitGrid != null) {
        final snapPos = CollisionSystem.findSnapPosition(
          projectilePos: position,
          hitPos: hitGrid,
          board: board.grid,
          boardRect: boardRect,
        );
        if (board.grid.isValidPosition(snapPos) &&
            !board.grid.isOccupied(snapPos)) {
          _placeAtGrid(snapPos);
        } else {
          // A completely blocked local neighbourhood should not replace an
          // existing star. Resolve the shot against the nearest valid cell
          // instead of corrupting the board.
          _landAt(position);
        }
        return;
      }

      // Ceiling collision. Clamp exactly to the playable ceiling before
      // choosing the top-row landing cell.
      if (position.y - _model.collisionRadius <= boardRect.top) {
        position.y = boardRect.top + _model.collisionRadius;
        _landAt(position);
        return;
      }

      // A projectile should never fall below the launcher. This is a safety
      // guard for malformed/custom levels.
      if (position.y > gs.y + 50) {
        _active = false;
        removeFromParent();
        return;
      }

      // Spawn trail puffs at fixed intervals.
      _trailTimer += step;
      if (_trailTimer >= _trailInterval) {
        _trailTimer -= _trailInterval;
        game.add(
          ShootingTrailComponent(
            position: position.clone(),
            color: _model.displayColor,
          ),
        );
      }
    }
  }

  void _landAt(Vector2 pos) {
    if (!_active) return;
    final board = game.board;

    // Ceiling shots land in the top row. pixelToGrid() can return invalid for
    // a position slightly above the mathematical cell centre, so normalize it
    // explicitly against the top row.
    var gridPos = board.grid.pixelToGrid(
      Offset(pos.x, board.boardRect.top + board.grid.config.starRadius),
      board.boardRect,
    );

    if (!board.grid.isValidPosition(gridPos)) {
      final col = ((pos.x - board.boardRect.left - board.grid.config.starRadius) /
              board.grid.config.cellWidth)
          .round()
          .clamp(0, board.grid.config.cols - 1);
      gridPos = GridPosition(0, col);
      if (!board.grid.isValidPosition(gridPos)) {
        gridPos = GridPosition(0, board.grid.config.cols - 1);
      }
    }

    // Never silently replace an existing top-row star.
    if (board.grid.isOccupied(gridPos)) {
      final free = board.grid.neighborsOf(gridPos)
          .where((candidate) => !board.grid.isOccupied(candidate))
          .toList();
      if (free.isNotEmpty) {
        free.sort((a, b) {
          final ap = board.grid.gridToPixel(a, board.boardRect);
          final bp = board.grid.gridToPixel(b, board.boardRect);
          final da = (ap.dx - pos.x) * (ap.dx - pos.x) +
              (ap.dy - pos.y) * (ap.dy - pos.y);
          final db = (bp.dx - pos.x) * (bp.dx - pos.x) +
              (bp.dy - pos.y) * (bp.dy - pos.y);
          return da.compareTo(db);
        });
        gridPos = free.first;
      }
    }

    _placeAtGrid(gridPos);
  }

  void _placeAtGrid(GridPosition gridPos) {
    if (!_active) return;
    _active = false;
    _resolveAsync(gridPos);
    removeFromParent();
  }

  Future<void> _resolveAsync(GridPosition gridPos) async {
    final board = game.board;
    final gm = game.gameManager;
    final ts = game.turnSystem;

    // Tell state machine: resolving
    gm.updateShooterState(ShooterGameState.resolving);
    ts.onProjectileLanded();
    game.audioService.playImpact();

    // Impact flash effect at the landing position
    game.add(
      ImpactFlashEffect(
        position: position.clone(),
        color: _model.displayColor,
      ),
    );

    // Capture board state BEFORE resolution for the objective evaluator.
    final boardBefore = game.board.grid;

    // Place at the already-snapped grid position (avoids pixel→grid drift
    // from using position after removeFromParent).
    final result = await board.placeProjectileAtGridPos(_model, gridPos);

    // Trigger audio / haptic / screen effects based on result
    if (result != null) {
      if (result.matchedGroups.isNotEmpty) {
        game.audioService.playMatch();
        game.hapticService.onMatch();
        game.screenEffects.onMatch(_model.displayColor);
        game.background.triggerPulse(
          color: _model.displayColor,
          intensity: 0.25,
          comboLevel: result.comboLevel,
        );
        if (result.comboLevel > 2) {
          game.audioService.playCascade();
          game.hapticService.onCascade();
          game.screenEffects.onCascade(result.comboLevel, _model.displayColor);
          // Combo cinematic overlay
          game.add(
            ComboCinematicComponent(
              position: game.size / 2,
              comboLevel: result.comboLevel,
              color: _model.displayColor,
            ),
          );
        }
      }
      if (result.specialEffectTargets.isNotEmpty) {
        game.audioService.playCascade(); // reuse cascade sfx for specials
        game.hapticService.onCascade();
        game.screenEffects.onCascade(2, _model.displayColor);
        game.background.triggerPulse(
          color: _model.displayColor,
          intensity: 0.3,
          comboLevel: 2,
        );
      }
    }

    // Apply scoring result
    if (result != null) {
      final starsPopped =
          result.matchedGroups.fold(0, (sum, g) => sum + g.length);
      gm.onResolutionComplete(
        scoreGained: result.scoreGained,
        comboLevel: result.comboLevel,
        starsPopped: starsPopped,
        floatingDropped: result.floatingStars.length,
        boardCleared: result.boardCleared,
        matchedPositions: result.matchedGroups.expand((g) => g).toList(),
        floatingPositions: result.floatingStars,
        specialPositions: result.specialEffectTargets,
        boardBeforeResolution: boardBefore,
      );
      ts.onResolvingComplete(scoreGained: result.scoreGained);
    } else {
      ts.onResolvingComplete();
    }

    // Check failure boundary
    final levelDef = game.currentLevelDef;
    if (levelDef != null &&
        board.isFailureBoundaryReached(levelDef.failureBoundaryRow)) {
      gm.gameOver();
    }

    // Advance launcher to next star (if game not over/complete)
    if (!gm.boardCleared && gm.state == GameState.playing) {
      // Pick next color only from colors still on the board so matches stay possible.
      final boardColors = game.board.grid.colorsInBottomRows(rows: 3).toList();
      final palette = boardColors.isNotEmpty ? boardColors : List.generate(5, (i) => i);
      final nextColorIndex = palette[Random().nextInt(palette.length)];
      gm.advanceTurn(
        gm.nextStarType,
        StarType.normal,
        currentColorIndex: gm.nextColorIndex,
        nextColorIndex: nextColorIndex,
      );
      game.shooter.loadStars(gm.currentStarType, gm.nextStarType, currentColorIndex: gm.currentColorIndex, nextColorIndex: gm.nextColorIndex);
      game.trajectory.setTintColor(
        StarColor.fromIndex(gm.currentColorIndex).color,
      );
      gm.updateShooterState(ShooterGameState.ready);
    }
  }

  @override
  void render(Canvas canvas) {
    final center = size / 2;
    final r = _model.collisionRadius;

    if (_model.type == StarType.normal) {
      // Premium star shape in flight — same renderer as board stars.
      canvas.save();
      canvas.translate(center.x, center.y);
      _renderer(_model.colorIndex).render(canvas, r, shimmerT: _shimmerT);
      canvas.restore();
    } else {
      // Special stars: glowing orb.
      final glowPaint = Paint()
        ..color = _model.displayColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(center.toOffset(), r * 1.3, glowPaint);
      final paint = Paint()
        ..color = _model.displayColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center.toOffset(), r, paint);
    }
  }
}
