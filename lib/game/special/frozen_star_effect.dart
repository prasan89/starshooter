import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// Frozen stars are board obstacles that require multiple adjacent matches to
/// thaw before they can be cleared normally.
///
/// When a frozen-type projectile lands on the board it does not trigger
/// immediate matches.  Instead, [applyAdjacentHits] is called by
/// [BoardResolver] after each normal match round to decrement the
/// [StarModel.frozenHitsRemaining] counter of every frozen star adjacent to
/// the matched positions.  When the counter reaches zero the star is thawed
/// and may participate in subsequent matches.
class FrozenStarEffect extends SpecialStarEffect {
  final SpecialStarConfig config;

  FrozenStarEffect({SpecialStarConfig? config})
      : config = config ?? SpecialStarConfig.standard;

  @override
  StarType get type => StarType.frozenStar;

  @override
  double get scoreMultiplier => config.frozenScoreMultiplier;

  @override
  String get description =>
      'Frozen stars require multiple hits to thaw before they can be cleared.';

  /// A frozen star placed on the board is an obstacle — it targets no positions
  /// itself.  Instead, FrozenStarResolver (called by BoardResolver) handles
  /// decrementing neighbor hits after each normal match round.
  @override
  List<GridPosition> computeTargets(BoardGrid board, GridPosition placedPos) {
    // Frozen stars placed as projectiles: no immediate targets.
    // The thaw mechanic is handled by BoardResolver's frozen-hit step.
    return [];
  }

  /// Decrement [StarModel.frozenHitsRemaining] for all frozen stars adjacent
  /// to any of [matchedPositions].  Returns the updated [BoardGrid].
  ///
  /// Stars whose [StarModel.frozenHitsRemaining] reaches 0 become thawed
  /// (they remain on the board as a normal star — type stays
  /// [StarType.frozenStar] but [StarModel.isFrozen] becomes `false`).
  static BoardGrid applyAdjacentHits(
    BoardGrid board,
    List<GridPosition> matchedPositions,
  ) {
    // Collect all frozen neighbors of the matched positions.
    final frozenNeighbors = <GridPosition>{};
    for (final pos in matchedPositions) {
      for (final n in board.neighborsOf(pos)) {
        final star = board.starAt(n);
        if (star != null && star.isFrozen) {
          frozenNeighbors.add(n);
        }
      }
    }
    if (frozenNeighbors.isEmpty) return board;

    // Decrement each frozen neighbor's hit count.
    var updated = board;
    for (final pos in frozenNeighbors) {
      final star = board.starAt(pos)!;
      final newHits = star.frozenHitsRemaining - 1;
      updated = updated.placeStar(
        star.copyWith(frozenHitsRemaining: newHits),
        pos,
      );
    }
    return updated;
  }
}
