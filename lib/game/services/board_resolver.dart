import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/services/combo_system.dart';
import 'package:star_shooter/game/services/floating_cluster_detector.dart';
import 'package:star_shooter/game/services/match_detector.dart';
import 'package:star_shooter/game/services/scoring_config.dart';
import 'package:star_shooter/game/special/frozen_star_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';

/// The result of running the full board resolution cascade after a star lands.
class ResolutionResult {
  final BoardGrid finalBoard;
  final int scoreGained;
  final int comboLevel;
  final List<List<GridPosition>> matchedGroups; // all groups that popped
  final List<GridPosition> floatingStars; // all floaters that dropped
  final List<GridPosition>
      specialEffectTargets; // positions removed by special effects
  final bool boardCleared; // true if no stars remain

  const ResolutionResult({
    required this.finalBoard,
    required this.scoreGained,
    required this.comboLevel,
    required this.matchedGroups,
    required this.floatingStars,
    required this.specialEffectTargets,
    required this.boardCleared,
  });
}

/// Runs the full cascade resolution pipeline after a star is placed on the
/// board.
///
/// The pipeline is:
///   0. (first iteration) If the placed star is special, run its effect,
///      collect targets, remove them, and score.
///   1. Detect matches from any occupied position (frozen stars are skipped).
///   2. Decrement frozen-star hit counters for stars adjacent to matches.
///   3. Remove matched stars, award score via [ComboSystem].
///   4. Detect floating clusters (stars no longer connected to the ceiling row).
///   5. Remove floaters, award score.
///   6. Repeat from step 1 until the board is stable (no more changes).
abstract final class BoardResolver {
  /// Runs the full cascade resolution starting from [placedPos] on [board].
  ///
  /// Returns a [ResolutionResult] describing what happened and the final board.
  /// The algorithm is purely synchronous and deterministic.
  static ResolutionResult resolve({
    required BoardGrid board,
    required GridPosition placedPos,
    ScoringConfig? scoringConfig,
    SpecialStarConfig? specialConfig,
  }) {
    final config = scoringConfig ?? ScoringConfig.standard;
    final combo = ComboSystem(config: config);
    combo.beginResolution();

    var current = board;
    final allMatchedGroups = <List<GridPosition>>[];
    final allFloatingStars = <GridPosition>[];
    final allSpecialTargets = <GridPosition>[];
    bool firstIteration = true;

    while (true) {
      bool anyChange = false;

      // ── STEP 0: Special star pre-pass (first iteration only) ──
      if (firstIteration) {
        final placedStar = current.starAt(placedPos);
        if (placedStar != null && placedStar.type.isSpecial) {
          final effect = SpecialStarRegistry.effectFor(placedStar.type);
          if (effect != null) {
            final targets = effect.computeTargets(current, placedPos);
            if (targets.isNotEmpty) {
              anyChange = true;
              allSpecialTargets.addAll(targets);
              // Score the special targets (scored as a "match group").
              combo.recordMatch(
                (targets.length * effect.scoreMultiplier).round(),
              );
              // Remove the special star itself + its targets.
              current = current.removeStars([placedPos, ...targets]);
            } else {
              // Special star placed but no targets (e.g. frozen star) — remove just the star.
              // Actually for FrozenStar placed as projectile, it STAYS on board as an obstacle.
              // For meteor/supernova/blackhole/rainbow with 0 targets, nothing to do.
              // Only truly remove if targets were found (handled above).
            }
          }
        }
      }
      firstIteration = false;

      // ── STEP 1: Normal match detection ──
      final matchedThisRound = <List<GridPosition>>[];
      final checkedTypes = <GridPosition, bool>{};

      for (final pos in current.occupiedPositions) {
        if (checkedTypes.containsKey(pos)) continue;
        final star = current.starAt(pos);
        // Skip frozen stars from normal matching (they are obstacles).
        if (star != null && star.isFrozen) {
          checkedTypes[pos] = true;
          continue;
        }
        final groups = MatchDetector.findMatches(current, pos);
        for (final group in groups) {
          // Mark all positions in this group so we don't re-check them.
          for (final gPos in group) {
            checkedTypes[gPos] = true;
          }
          matchedThisRound.add(group);
        }
      }

      if (matchedThisRound.isNotEmpty) {
        anyChange = true;
        allMatchedGroups.addAll(matchedThisRound);

        // Award score for each group.
        for (final group in matchedThisRound) {
          combo.recordMatch(group.length);
        }

        final allMatchedPositions = matchedThisRound.expand((g) => g).toList();

        // ── STEP 2: Frozen adjacent-hit decrement (before removal) ──
        current =
            FrozenStarEffect.applyAdjacentHits(current, allMatchedPositions);

        // Remove all matched stars.
        current = current.removeStars(allMatchedPositions);
      }

      // ── STEP 3: Gravity / floating ──
      final floaters = FloatingClusterDetector.findFloatingStars(current);
      if (floaters.isNotEmpty) {
        anyChange = true;
        allFloatingStars.addAll(floaters);
        combo.recordFloating(floaters.length);
        current = current.removeStars(floaters);
      }

      if (!anyChange) break;
    }

    return ResolutionResult(
      finalBoard: current,
      scoreGained: combo.totalScore,
      comboLevel: combo.comboLevel,
      matchedGroups: allMatchedGroups,
      floatingStars: allFloatingStars,
      specialEffectTargets: allSpecialTargets,
      boardCleared: current.occupiedPositions.isEmpty,
    );
  }
}
