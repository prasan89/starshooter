import 'dart:collection';

import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';

/// Detects stars that are "floating" — not connected (directly or
/// transitively) to any star anchored in row 0 (the ceiling row).
abstract final class FloatingClusterDetector {
  /// Returns all [GridPosition]s on [board] whose stars are floating
  /// (not connected to the top row).
  ///
  /// Algorithm:
  ///   1. BFS/DFS from every occupied position in row 0.
  ///   2. Mark all reachable occupied positions as "supported".
  ///   3. Any occupied position not in "supported" is floating.
  static List<GridPosition> findFloatingStars(BoardGrid board) {
    final allOccupied = board.occupiedPositions.toSet();
    if (allOccupied.isEmpty) return [];

    // Seed with all top-row occupied positions.
    final supported = <GridPosition>{};
    final queue = Queue<GridPosition>();

    for (final pos in allOccupied) {
      if (pos.row == 0) {
        supported.add(pos);
        queue.add(pos);
      }
    }

    // Expand connectivity.
    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      for (final neighbor in board.neighborsOf(current)) {
        if (supported.contains(neighbor)) continue;
        if (allOccupied.contains(neighbor)) {
          supported.add(neighbor);
          queue.add(neighbor);
        }
      }
    }

    // Everything occupied but not supported is floating.
    return allOccupied.difference(supported).toList();
  }

  /// Returns true if the board has ANY floating stars.
  static bool hasFloatingStars(BoardGrid board) =>
      findFloatingStars(board).isNotEmpty;
}
