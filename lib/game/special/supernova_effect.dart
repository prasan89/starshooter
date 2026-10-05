import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// Explodes in a radial burst, clearing all occupied stars within
/// [SpecialStarConfig.supernovaRadius] hex-hops of the placement position.
class SupernovaEffect extends SpecialStarEffect {
  final SpecialStarConfig config;

  SupernovaEffect({SpecialStarConfig? config})
      : config = config ?? SpecialStarConfig.standard;

  @override
  StarType get type => StarType.supernova;

  @override
  double get scoreMultiplier => config.supernovaScoreMultiplier;

  @override
  String get description =>
      'Explodes in a radial burst, clearing nearby stars.';

  @override
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos) {
    // BFS up to supernovaRadius hops from placedPos.
    // Collect all occupied positions within that radius.
    final visited = <GridPosition>{placedPos};
    var frontier = <GridPosition>[placedPos];

    for (int hop = 0; hop < config.supernovaRadius; hop++) {
      final next = <GridPosition>[];
      for (final pos in frontier) {
        for (final n in board.neighborsOf(pos)) {
          if (!visited.contains(n)) {
            visited.add(n);
            next.add(n);
          }
        }
      }
      frontier = next;
    }

    // Return all occupied positions within the radius (except the supernova itself).
    return visited.where((p) => p != placedPos && board.isOccupied(p)).toList();
  }
}
