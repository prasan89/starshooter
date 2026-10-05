import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// Gravitational pull removes all stars within [SpecialStarConfig.blackHoleRadius]
/// hex-hops of the placement position.
///
/// The "attraction" is visual only — logically the black hole removes all
/// occupied stars within the event horizon radius, identically to a supernova
/// but with its own radius and score multiplier tuning values.
class BlackHoleEffect extends SpecialStarEffect {
  final SpecialStarConfig config;

  BlackHoleEffect({SpecialStarConfig? config})
      : config = config ?? SpecialStarConfig.standard;

  @override
  StarType get type => StarType.blackHole;

  @override
  double get scoreMultiplier => config.blackHoleScoreMultiplier;

  @override
  String get description =>
      'Gravitational pull removes all stars within its event horizon.';

  @override
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos) {
    final visited = <GridPosition>{placedPos};
    var frontier = <GridPosition>[placedPos];

    for (int hop = 0; hop < config.blackHoleRadius; hop++) {
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

    return visited.where((p) => p != placedPos && board.isOccupied(p)).toList();
  }
}
