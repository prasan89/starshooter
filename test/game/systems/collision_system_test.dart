import 'dart:ui' show Rect;

import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/systems/collision_system.dart';

void main() {
  group('CollisionSystem', () {
    // Common game size and board rect used across tests
    const double screenWidth = 400.0;
    const double screenHeight = 600.0;
    final Vector2 gameSize = Vector2(screenWidth, screenHeight);
    const Rect boardRect = Rect.fromLTWH(0, 50, screenWidth, 300);
    const double radius = 20.0;

    group('checkWallCollision', () {
      test('returns none when projectile is in middle of screen', () {
        final position = Vector2(screenWidth / 2, screenHeight / 2);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.none));
      });

      test('returns leftWall when x - radius <= 0', () {
        // Position x = radius means x - radius = 0 (exactly on boundary)
        final position = Vector2(radius, screenHeight / 2);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.leftWall));
      });

      test('returns leftWall when x is inside left boundary', () {
        // Position x < radius means x - radius < 0
        final position = Vector2(radius - 1, screenHeight / 2);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.leftWall));
      });

      test('returns rightWall when x + radius >= width', () {
        // Position x = width - radius means x + radius = width
        final position = Vector2(screenWidth - radius, screenHeight / 2);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.rightWall));
      });

      test('returns ceiling when y - radius <= boardRect.top', () {
        // Position y = boardRect.top + radius means y - radius = boardRect.top
        final position = Vector2(screenWidth / 2, boardRect.top + radius);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.ceiling));
      });

      test('returns ceiling when projectile is above boardRect.top', () {
        // Position y < boardRect.top + radius (y - radius < boardRect.top)
        final position = Vector2(screenWidth / 2, boardRect.top + radius - 5);
        final result = CollisionSystem.checkWallCollision(
          position: position,
          radius: radius,
          gameSize: gameSize,
          boardRect: boardRect,
        );
        expect(result, equals(CollisionResult.ceiling));
      });
    });

    group('reflectHorizontal', () {
      test('negates x component, preserves y component', () {
        final velocity = Vector2(3.0, -5.0);
        final reflected = CollisionSystem.reflectHorizontal(velocity);
        expect(reflected.x, closeTo(-3.0, 0.001));
        expect(reflected.y, closeTo(-5.0, 0.001));
      });

      test('negating a negative x produces positive x', () {
        final velocity = Vector2(-4.0, 2.0);
        final reflected = CollisionSystem.reflectHorizontal(velocity);
        expect(reflected.x, closeTo(4.0, 0.001));
        expect(reflected.y, closeTo(2.0, 0.001));
      });
    });

    group('checkStarCollision', () {
      test('returns null when no stars near', () {
        final board = BoardGrid();
        // Projectile is far from any star (board is empty)
        final projectilePos = Vector2(200.0, 300.0);
        final result = CollisionSystem.checkStarCollision(
          projectilePos: projectilePos,
          projectileRadius: radius,
          board: board,
          boardRect: boardRect,
        );
        expect(result, isNull);
      });

      test('returns null when star is far away', () {
        const starPos = GridPosition(0, 0);
        final star =
            StarModel.create(type: StarType.normal, gridPosition: starPos);
        final board = BoardGrid().placeStar(star, starPos);

        // Put projectile far from the star's pixel position
        final projectilePos = Vector2(350.0, 500.0);
        final result = CollisionSystem.checkStarCollision(
          projectilePos: projectilePos,
          projectileRadius: radius,
          board: board,
          boardRect: boardRect,
        );
        expect(result, isNull);
      });

      test('returns grid position when projectile overlaps a star', () {
        const starPos = GridPosition(0, 0);
        final star =
            StarModel.create(type: StarType.normal, gridPosition: starPos);
        final board = BoardGrid().placeStar(star, starPos);

        // Compute the pixel center of the star on the board
        final starPixel = board.gridToPixel(starPos, boardRect);

        // Place the projectile at exactly the same pixel center — guaranteed overlap
        final projectilePos = Vector2(starPixel.dx, starPixel.dy);
        final result = CollisionSystem.checkStarCollision(
          projectilePos: projectilePos,
          projectileRadius: radius,
          board: board,
          boardRect: boardRect,
        );
        expect(result, equals(starPos));
      });
    });
  });
}
