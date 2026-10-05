import 'dart:collection';

import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Pure-Dart service that finds connected groups of same-type stars on a
/// [BoardGrid].
///
/// Two stars match when they share the same [StarType] AND — for normal stars —
/// the same [StarModel.colorIndex]. Special stars still match on type alone.
/// A group formed by flood-fill must contain at least three stars.
abstract final class MatchDetector {
  /// Returns all groups of matching stars rooted at [seedPos] (the star just
  /// placed). Each group is a List<GridPosition>. Only groups with length >= 3
  /// are returned. If the star at seedPos has no group >= 3, returns empty.
  static List<List<GridPosition>> findMatches(
    BoardGrid board,
    GridPosition seedPos,
  ) {
    final seedStar = board.starAt(seedPos);
    if (seedStar == null) return [];
    if (seedStar.isFrozen) return []; // frozen stars are obstacles

    final group = _floodFill(board, seedPos, seedStar);
    if (group.length >= 3) return [group];
    return [];
  }

  /// Returns true when [a] and [b] should be considered matching.
  /// Normal stars must share both type and colorIndex.
  /// Special stars match on type alone.
  static bool _starMatches(StarModel a, StarModel b) {
    if (a.type != b.type) return false;
    if (a.type == StarType.normal) return a.colorIndex == b.colorIndex;
    return true;
  }

  /// BFS flood-fill collecting all connected positions occupied by stars
  /// that match [seed].
  static List<GridPosition> _floodFill(
    BoardGrid board,
    GridPosition start,
    StarModel seed,
  ) {
    final visited = <GridPosition>{};
    final queue = Queue<GridPosition>();
    queue.add(start);
    visited.add(start);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      for (final neighbor in board.neighborsOf(current)) {
        if (visited.contains(neighbor)) continue;
        final star = board.starAt(neighbor);
        if (star != null && !star.isFrozen && _starMatches(seed, star)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }

    return visited.toList();
  }

  /// Checks whether [pos] is part of ANY group >= 3 matching stars.
  static bool isPartOfMatch(BoardGrid board, GridPosition pos) {
    return findMatches(board, pos).isNotEmpty;
  }
}
