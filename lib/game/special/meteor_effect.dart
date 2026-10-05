import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// Clears a vertical stripe of columns centred on the column where the meteor lands.
///
/// The stripe width is controlled by [SpecialStarConfig.meteorClearWidth]:
/// a value of 1 clears only the landed column; 3 clears that column plus one
/// neighbour on each side.
class MeteorEffect extends SpecialStarEffect {
  final SpecialStarConfig config;

  MeteorEffect({SpecialStarConfig? config})
      : config = config ?? SpecialStarConfig.standard;

  @override
  StarType get type => StarType.meteor;

  @override
  double get scoreMultiplier => config.meteorScoreMultiplier;

  @override
  String get description => 'Clears a column of stars on impact.';

  @override
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos) {
    // Clear all stars in a vertical stripe of width meteorClearWidth
    // centered on placedPos.col.
    final halfW = config.meteorClearWidth ~/ 2;
    final targets = <GridPosition>[];

    for (final pos in board.occupiedPositions) {
      // Don't include the meteor star itself — it's handled separately.
      if (pos == placedPos) continue;
      final colDiff = (pos.col - placedPos.col).abs();
      if (colDiff <= halfW) {
        targets.add(pos);
      }
    }

    return targets;
  }
}
