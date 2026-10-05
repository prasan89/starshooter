import 'dart:collection';

import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// A rainbow star acts as a wildcard: it matches any adjacent star type and
/// extends the match group to include all connected stars of those types.
///
/// When [SpecialStarConfig.rainbowMatchAllAdjacent] is `true` (the default),
/// every distinct non-frozen, non-rainbow neighbour type is flood-filled and
/// all resulting positions are returned.  When `false`, only the most-common
/// adjacent type is matched.
class RainbowEffect extends SpecialStarEffect {
  final SpecialStarConfig config;

  RainbowEffect({SpecialStarConfig? config})
      : config = config ?? SpecialStarConfig.standard;

  @override
  StarType get type => StarType.rainbow;

  @override
  double get scoreMultiplier => config.rainbowScoreMultiplier;

  @override
  String get description =>
      'Matches with any adjacent star type — clears all connected groups.';

  @override
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos) {
    // Find all adjacent occupied positions.
    final neighbors =
        board.neighborsOf(placedPos).where((n) => board.isOccupied(n)).toList();
    if (neighbors.isEmpty) return [];

    if (config.rainbowMatchAllAdjacent) {
      // Collect all connected groups for each unique adjacent type.
      final seenTypes = <StarType>{};
      final allTargets = <GridPosition>{};

      for (final neighbor in neighbors) {
        final star = board.starAt(neighbor)!;
        // Skip frozen stars (they need thawing first) and other rainbows.
        if (star.type == StarType.rainbow || star.isFrozen) continue;
        if (seenTypes.contains(star.type)) continue;
        seenTypes.add(star.type);
        // BFS flood-fill to collect all connected stars of this type.
        allTargets.addAll(_collectConnected(board, neighbor, star.type));
      }
      return allTargets.toList();
    } else {
      // Match only the most-common adjacent type.
      final typeCounts = <StarType, int>{};
      for (final n in neighbors) {
        final t = board.starAt(n)?.type;
        if (t != null) typeCounts[t] = (typeCounts[t] ?? 0) + 1;
      }
      final dominant =
          typeCounts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      return _collectConnected(board, neighbors.first, dominant);
    }
  }

  /// BFS flood-fill: returns all connected positions whose star has [type]
  /// and is not frozen, starting from [start].
  List<GridPosition> _collectConnected(
    BoardGrid board,
    GridPosition start,
    StarType type,
  ) {
    final visited = <GridPosition>{start};
    final queue = Queue<GridPosition>()..add(start);
    while (queue.isNotEmpty) {
      final cur = queue.removeFirst();
      for (final n in board.neighborsOf(cur)) {
        if (visited.contains(n)) continue;
        final s = board.starAt(n);
        if (s != null && s.type == type && !s.isFrozen) {
          visited.add(n);
          queue.add(n);
        }
      }
    }
    return visited.toList();
  }
}
