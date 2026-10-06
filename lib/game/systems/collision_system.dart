import 'dart:ui' show Rect;

import 'package:flame/components.dart';
import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';

/// The result of a wall-collision test.
enum CollisionResult {
  /// No collision detected.
  none,

  /// Projectile hit the left boundary wall.
  leftWall,

  /// Projectile hit the right boundary wall.
  rightWall,

  /// Projectile reached the top of the board area.
  ceiling,

  /// Projectile overlapped with an existing star on the board.
  star,
}

/// Pure-static helpers for detecting collisions in the Star Shooter physics loop.
///
/// All methods are stateless and operate on the values passed in, making them
/// trivial to unit-test without a running Flame context.
abstract final class CollisionSystem {
  // Private constructor prevents instantiation.
  CollisionSystem._();

  // ── Wall collisions ────────────────────────────────────────────────────────

  /// Returns the [CollisionResult] when a circular projectile (centred at
  /// [position] with the given [radius]) is tested against the game walls and
  /// the top of [boardRect].
  ///
  /// Tests are evaluated in priority order: left wall, right wall, ceiling.
  /// Returns [CollisionResult.none] when no boundary is breached.
  static CollisionResult checkWallCollision({
    required Vector2 position,
    required double radius,
    required Vector2 gameSize,
    required Rect boardRect,
  }) {
    // Left boundary.
    if (position.x - radius <= 0) return CollisionResult.leftWall;
    // Right boundary.
    if (position.x + radius >= gameSize.x) return CollisionResult.rightWall;
    // Ceiling (top edge of the board area).
    if (position.y - radius <= boardRect.top) return CollisionResult.ceiling;
    return CollisionResult.none;
  }

  /// Returns the velocity after reflecting it off a vertical wall (left or right).
  ///
  /// Negates only the horizontal component so the projectile bounces back
  /// while keeping its vertical speed intact.
  static Vector2 reflectHorizontal(Vector2 velocity) {
    return Vector2(-velocity.x, velocity.y);
  }

  // ── Star collisions ────────────────────────────────────────────────────────

  /// Scans every occupied cell on [board] and returns the [GridPosition] of
  /// the first star whose centre is within the combined radii of the projectile
  /// and the board star.
  ///
  /// Returns `null` when no overlap is found.
  ///
  /// Distances are compared squared to avoid a square-root per candidate.
  static GridPosition? checkStarCollision({
    required Vector2 projectilePos,
    required double projectileRadius,
    required BoardGrid board,
    required Rect boardRect,
  }) {
    for (final pos in board.occupiedPositions) {
      final starPixel = board.gridToPixel(pos, boardRect);
      final dx = projectilePos.x - starPixel.dx;
      final dy = projectilePos.y - starPixel.dy;
      final distSquared = dx * dx + dy * dy;
      final minDist = projectileRadius + BoardConfig.standard.starRadius;
      if (distSquared <= minDist * minDist) {
        return pos;
      }
    }
    return null;
  }

  // ── Snap-position resolution ───────────────────────────────────────────────

  /// Determines where the projectile should be placed after hitting the star
  /// at [hitPos].
  ///
  /// Examines every valid, unoccupied neighbour of [hitPos] and returns the one
  /// whose pixel centre is closest to [projectilePos].  Falls back to [hitPos]
  /// itself (replacing whatever is there) when no free neighbour is available —
  /// this edge case should be rare in normal play.
  static GridPosition findSnapPosition({
    required Vector2 projectilePos,
    required GridPosition hitPos,
    required BoardGrid board,
    required Rect boardRect,
    Vector2? velocity,
  }) {
    final neighbors = board.neighborsOf(hitPos);
    GridPosition? best;
    double bestScore = double.infinity;

    // Step back one radius along velocity to get the contact point.
    final Vector2 approachPos;
    if (velocity != null && velocity.length2 > 0) {
      final dir = velocity.normalized();
      final r = BoardConfig.standard.starRadius;
      approachPos = projectilePos - dir * r;
    } else {
      approachPos = projectilePos;
    }

    // When the projectile is moving upward, strongly prefer neighbours that
    // are above (lower row index) the hit star. Same-row is neutral; below
    // is heavily penalised (already was). This stops side-hits from snapping
    // to a sideways neighbour when an above-neighbour is also free.
    final movingUp = velocity != null && velocity.y < 0;

    for (final n in neighbors) {
      if (!board.isOccupied(n) && board.isValidPosition(n)) {
        final nPixel = board.gridToPixel(n, boardRect);
        final dx = approachPos.x - nPixel.dx;
        final dy = approachPos.y - nPixel.dy;
        final distSquared = dx * dx + dy * dy;

        double penalty = 0.0;
        if (n.row > hitPos.row) {
          // Never snap below the hit star.
          penalty = 999999.0;
        } else if (movingUp && n.row == hitPos.row) {
          // Moving upward: same-row neighbours are less preferred than
          // above-row neighbours — add a moderate penalty so an above cell
          // at a slightly larger distance still wins.
          penalty = 40000.0;
        }

        final score = distSquared + penalty;
        if (score < bestScore) {
          bestScore = score;
          best = n;
        }
      }
    }

    return best ?? hitPos;
  }
}
