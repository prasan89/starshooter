import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/shooter_game_state.dart';
import 'package:star_shooter/game/models/star_model.dart';
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

  static const double _speed = 600.0; // pixels per second

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
    _active = false;
    final board = game.board;
    final snapGrid =
        board.grid.pixelToGrid(Offset(pos.x, pos.y), board.boardRect);
    _placeAtGrid(snapGrid);
  }

  void _placeAtGrid(GridPosition gridPos) {
    if (!_active) return;
    _active = false;
    final board = game.board;

    // Place on board.
    board.placeProjectile(_model, Offset(position.x, position.y));

    // Notify turn system.
    game.gameManager.updateShooterState(ShooterGameState.resolving);

    // Advance turn.
    game.gameManager.advanceTurn(
      game.gameManager.nextStarType,
      game.gameManager.currentStarType,
    );
    game.shooter.loadStars(
      game.gameManager.currentStarType,
      game.gameManager.nextStarType,
    );
    game.gameManager.updateShooterState(ShooterGameState.ready);
    removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final center = size / 2;
    final r = _model.collisionRadius;

    final glowPaint = Paint()
      ..color = _model.type.color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(center.toOffset(), r * 1.3, glowPaint);

    final paint = Paint()
      ..color = _model.type.color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center.toOffset(), r, paint);
  }
}
