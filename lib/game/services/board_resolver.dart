import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/services/combo_system.dart';
import 'package:star_shooter/game/services/floating_cluster_detector.dart';
import 'package:star_shooter/game/services/match_detector.dart';
import 'package:star_shooter/game/services/scoring_config.dart';

/// The result of running the full board resolution cascade after a star lands.
class ResolutionResult {
  final BoardGrid finalBoard;
  final int scoreGained;
  final int comboLevel;
  final List<List<GridPosition>> matchedGroups; // all groups that popped
  final List<GridPosition> floatingStars; // all floaters that dropped
  final bool boardCleared; // true if no stars remain

  const ResolutionResult({
    required this.finalBoard,
    required this.scoreGained,
    required this.comboLevel,
    required this.matchedGroups,
    required this.floatingStars,
    required this.boardCleared,
  });
}

/// Runs the full cascade resolution pipeline after a star is placed on the
/// board.
///
/// The pipeline is:
///   1. Detect matches from any occupied position (first iteration seeds from
///      [placedPos]; subsequent iterations scan all occupied positions).
///   2. Remove matched stars, award score via [ComboSystem].
///   3. Detect floating clusters (stars no longer connected to the ceiling row).
///   4. Remove floaters, award score.
///   5. Repeat from step 1 until the board is stable (no more changes).
abstract final class BoardResolver {
  /// Runs the full cascade resolution starting from [placedPos] on [board].
  ///
  /// Returns a [ResolutionResult] describing what happened and the final board.
  /// The algorithm is purely synchronous and deterministic.
  static ResolutionResult resolve({
    required BoardGrid board,
    required GridPosition placedPos,
    ScoringConfig? scoringConfig,
  }) {
    final config = scoringConfig ?? ScoringConfig.standard;
    final combo = ComboSystem(config: config);
    combo.beginResolution();

    var current = board;
    final allMatchedGroups = <List<GridPosition>>[];
    final allFloatingStars = <GridPosition>[];

    // Cascade loop — keep resolving until stable.
    while (true) {
      bool anyChange = false;

      // --- Step 1: find matches ---
      // On first iteration, seed from placedPos.
      // On subsequent iterations, scan the whole board for any new matches
      // that formed after gravity (simplified: check all occupied positions
      // as potential seeds, dedup).
      final matchedThisRound = <List<GridPosition>>[];
      final checkedTypes = <GridPosition, bool>{};

      for (final pos in current.occupiedPositions) {
        if (checkedTypes.containsKey(pos)) continue;
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

        // Remove all matched stars.
        final allMatchedPositions = matchedThisRound.expand((g) => g).toList();
        current = current.removeStars(allMatchedPositions);
      }

      // --- Step 2: gravity / floating ---
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
      boardCleared: current.occupiedPositions.isEmpty,
    );
  }
}
