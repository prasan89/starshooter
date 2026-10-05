import 'dart:math' show Random;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/components/premium_star_renderer.dart';
import 'package:star_shooter/game/fx/shooting_trail_component.dart';
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
    position += _velocity * dt;
    _shimmerT = (_shimmerT + dt * 3.0) % (2 * 3.1415926535);

    // Spawn trail puffs at fixed intervals.
    _trailTimer += dt;
    if (_trailTimer >= _trailInterval) {
      _trailTimer = 0;
      game.add(
        ShootingTrailComponent(
          position: position.clone(),
          color: _model.displayColor,
        ),
      );
    }

    final gs = game.size;
    final board = game.board;
    final boardRect = board.boardRect;

    // Wall collision.
    final wallResult = CollisionSystem.checkWallCollision(
      position: position,
      radius: _model.collisionRadius,
      gameSize: gs,
      boardRect: boardRect,
    );
    if (wallResult == CollisionResult.leftWall ||
        wallResult == CollisionResult.rightWall) {
      _velocity = CollisionSystem.reflectHorizontal(_velocity);
      return;
    }
    if (wallResult == CollisionResult.ceiling) {
      _landAt(position);
      return;
    }

    // Star collision.
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
      _placeAtGrid(snapPos);
      return;
    }

    // Out of bounds — fell off the bottom of the screen.
    if (position.y > gs.y + 50) {
      removeFromParent();
    }
  }

  void _landAt(Vector2 pos) {
    if (!_active) return;
    final board = game.board;
    // Find the nearest free cell to where the projectile is.
    var gridPos = board.grid.pixelToGrid(Offset(pos.x, pos.y), board.boardRect);
    // If invalid (e.g. hit ceiling above row 0), clamp to row 0.
    if (!board.grid.isValidPosition(gridPos)) {
      gridPos = GridPosition(0, gridPos.col.clamp(0, board.grid.config.cols - 1));
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
        if (result.comboLevel > 2) {
          game.audioService.playCascade();
          game.hapticService.onCascade();
          game.screenEffects.onCascade(result.comboLevel, _model.displayColor);
        }
      }
      if (result.specialEffectTargets.isNotEmpty) {
        game.audioService.playCascade(); // reuse cascade sfx for specials
        game.hapticService.onCascade();
        game.screenEffects.onCascade(2, _model.displayColor);
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
