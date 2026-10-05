// ignore_for_file: avoid_print
/// Level validation tool: dart run tool/validate_levels.dart
///
/// Reports on all 200 production levels: validity, difficulty distribution,
/// objective distribution, special-star coverage, duplicate detection,
/// solvability warnings, difficulty spikes, and endgame analysis.
library;

import 'package:star_shooter/game/level/difficulty_calculator.dart';
import 'package:star_shooter/game/level/difficulty_model.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_validator.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  final levels = LevelCatalog.allLevels;

  print('═══════════════════════════════════════════════════════════════');
  print('  STAR SHOOTER — LEVEL CATALOG VALIDATION REPORT');
  print('═══════════════════════════════════════════════════════════════');
  print('');

  // ── 1. Basic catalog integrity ─────────────────────────────────────────
  _section('CATALOG INTEGRITY');
  print('Total levels: ${levels.length}');

  final ids = levels.map((l) => l.id).toList()..sort();
  final duplicateIds = <int>[];
  final seenIds = <int>{};
  for (final id in ids) {
    if (!seenIds.add(id)) duplicateIds.add(id);
  }

  final missingIds = <int>[];
  for (int i = 1; i <= 200; i++) {
    if (!seenIds.contains(i)) missingIds.add(i);
  }

  print('IDs present:    ${seenIds.length}');
  print(
      'Duplicate IDs:  ${duplicateIds.isEmpty ? 'none' : duplicateIds.join(', ')}',);
  print(
      'Missing IDs:    ${missingIds.isEmpty ? 'none' : missingIds.join(', ')}',);

  // ── 2. World distribution ──────────────────────────────────────────────
  _section('WORLD DISTRIBUTION');
  for (int w = 1; w <= 5; w++) {
    final worldLevels = LevelCatalog.getWorld(w);
    final name = worldLevels.isNotEmpty
        ? worldLevels.first.worldMeta?.worldName ?? 'World $w'
        : 'World $w';
    final first = worldLevels.isNotEmpty ? worldLevels.first.id : -1;
    final last = worldLevels.isNotEmpty ? worldLevels.last.id : -1;
    print('World $w ($name): ${worldLevels.length} levels  [$first–$last]');
  }

  // ── 3. Validation results ──────────────────────────────────────────────
  _section('VALIDATION RESULTS');
  var validCount = 0;
  var invalidCount = 0;
  final validationFailures = <String>[];

  for (final level in levels) {
    final result = LevelValidator.validate(level);
    if (result.isValid) {
      validCount++;
    } else {
      invalidCount++;
      final codes = result.issues.map((i) => i.code).join(', ');
      validationFailures
          .add('Level ${level.id} (${level.displayName}): $codes');
    }
  }
  print('Valid:   $validCount');
  print('Invalid: $invalidCount');
  if (validationFailures.isNotEmpty) {
    print('');
    print('FAILURES:');
    for (final f in validationFailures) {
      print('  ✗ $f');
    }
  }

  // ── 4. Difficulty analysis ─────────────────────────────────────────────
  _section('DIFFICULTY ANALYSIS');
  final difficulties = <int, DifficultyModel>{};
  for (final level in levels) {
    difficulties[level.id] = DifficultyCalculator.calculate(level);
  }

  _printDifficultyBand('Easy     (0.00–0.30)', difficulties, 0.00, 0.30);
  _printDifficultyBand('Medium   (0.30–0.55)', difficulties, 0.30, 0.55);
  _printDifficultyBand('Hard     (0.55–0.80)', difficulties, 0.55, 0.80);
  _printDifficultyBand('Expert   (0.80–1.00)', difficulties, 0.80, 1.00);
  print('');

  final firstHalf = levels.where((l) => l.id <= 100).toList();
  final secondHalf = levels.where((l) => l.id > 100).toList();

  final avg1 = _avgDifficulty(firstHalf, difficulties);
  final avg2 = _avgDifficulty(secondHalf, difficulties);
  final pctIncrease = avg1 > 0 ? ((avg2 - avg1) / avg1 * 100).round() : 0;

  print('Levels   1–100 average difficulty: ${avg1.toStringAsFixed(3)}');
  print('Levels 101–200 average difficulty: ${avg2.toStringAsFixed(3)}');
  print('Endgame difficulty increase:       $pctIncrease%');
  print('');

  // Sub-ranges
  _printRangeStats('Levels   1– 20 (Tutorial)', difficulties, 1, 20);
  _printRangeStats('Levels  21– 50 (Learning)', difficulties, 21, 50);
  _printRangeStats('Levels  51–100 (Advanced)', difficulties, 51, 100);
  _printRangeStats('Levels 101–125 (Very Hard)', difficulties, 101, 125);
  _printRangeStats('Levels 126–150 (Expert)', difficulties, 126, 150);
  _printRangeStats('Levels 151–175 (Master)', difficulties, 151, 175);
  _printRangeStats('Levels 176–200 (Extreme)', difficulties, 176, 200);

  // ── 5. Difficulty spikes ───────────────────────────────────────────────
  _section('DIFFICULTY SPIKES');
  final spikes = <String>[];
  for (int i = 0; i < levels.length - 1; i++) {
    final curr = difficulties[levels[i].id]!.difficultyScore;
    final next = difficulties[levels[i + 1].id]!.difficultyScore;
    final jump = next - curr;
    if (jump > 0.15) {
      spikes.add(
        'Level ${levels[i].id}→${levels[i + 1].id}: '
        '${curr.toStringAsFixed(3)}→${next.toStringAsFixed(3)} '
        '(+${jump.toStringAsFixed(3)}) ⚠',
      );
    } else if (jump < -0.20) {
      spikes.add(
        'Level ${levels[i].id}→${levels[i + 1].id}: '
        '${curr.toStringAsFixed(3)}→${next.toStringAsFixed(3)} '
        '(${jump.toStringAsFixed(3)}) ⚠ drop',
      );
    }
  }
  if (spikes.isEmpty) {
    print('No significant spikes detected (threshold ±0.15)');
  } else {
    print('${spikes.length} spike(s) detected:');
    for (final s in spikes) { print('  $s'); }
  }

  // ── 6. Objective distribution ──────────────────────────────────────────
  _section('OBJECTIVE DISTRIBUTION');
  final objCounts = <ObjectiveType, int>{};
  for (final level in levels) {
    objCounts[level.objective.type] =
        (objCounts[level.objective.type] ?? 0) + 1;
  }
  for (final entry in objCounts.entries) {
    final pct = (entry.value / levels.length * 100).round();
    print(
        '  ${entry.key.name.padRight(15)}: ${entry.value.toString().padLeft(3)}  ($pct%)',);
  }

  // ── 7. Special-star distribution ──────────────────────────────────────
  _section('SPECIAL STAR AVAILABILITY (first level each type appears)');
  for (final type in StarType.values) {
    final firstLevel = levels
        .where((l) => l.availableStarTypes.contains(type))
        .map((l) => l.id)
        .fold<int?>(null, (min, id) => min == null || id < min ? id : min);
    print(
      '  ${type.name.padRight(12)}: '
      '${firstLevel != null ? 'from level $firstLevel' : 'never used'}',
    );
  }

  print('');
  final frozenOnBoard = levels.where((l) => l.hasFrozenStars).length;
  print('  Levels with frozen stars on board: $frozenOnBoard');

  // ── 8. Duplicate board detection ──────────────────────────────────────
  _section('DUPLICATE DETECTION');
  final boardSignatures = <String, List<int>>{};
  for (final level in levels) {
    final sig = _boardSignature(level);
    boardSignatures.putIfAbsent(sig, () => []).add(level.id);
  }
  final duplicateBoards =
      boardSignatures.entries.where((e) => e.value.length > 1).toList();
  if (duplicateBoards.isEmpty) {
    print('No exact board duplicates detected');
  } else {
    print('${duplicateBoards.length} duplicate board(s):');
    for (final d in duplicateBoards) {
      print('  Levels: ${d.value.join(', ')}');
    }
  }

  // ── 9. Solvability checks ──────────────────────────────────────────────
  _section('SOLVABILITY WARNINGS');
  final solvabilityWarnings = <String>[];
  for (final level in levels) {
    final issues = _checkSolvability(level);
    for (final issue in issues) {
      solvabilityWarnings.add('Level ${level.id}: $issue');
    }
  }
  if (solvabilityWarnings.isEmpty) {
    print('No solvability warnings');
  } else {
    print('${solvabilityWarnings.length} warning(s):');
    for (final w in solvabilityWarnings) { print('  ⚠ $w'); }
  }

  // ── 10. Shot / board stats ─────────────────────────────────────────────
  _section('BOARD STATISTICS');
  final allMoveLimits = levels.map((l) => l.moveLimit).toList();
  final allStarCounts = levels
      .map((l) => l.initialStars.isEmpty ? 72 : l.initialStars.length)
      .toList();

  print(
    'Move limit — min: ${allMoveLimits.reduce((a, b) => a < b ? a : b)}'
    '  max: ${allMoveLimits.reduce((a, b) => a > b ? a : b)}'
    '  avg: ${(allMoveLimits.reduce((a, b) => a + b) / allMoveLimits.length).toStringAsFixed(1)}',
  );
  print(
    'Star count — min: ${allStarCounts.reduce((a, b) => a < b ? a : b)}'
    '  max: ${allStarCounts.reduce((a, b) => a > b ? a : b)}'
    '  avg: ${(allStarCounts.reduce((a, b) => a + b) / allStarCounts.length).toStringAsFixed(1)}',
  );

  // ── 11. Final summary ──────────────────────────────────────────────────
  _section('SUMMARY');
  final allPassed = invalidCount == 0 &&
      duplicateIds.isEmpty &&
      missingIds.isEmpty &&
      levels.length == 200;
  print('Total levels: ${levels.length}  (target: 200)');
  print('Valid:        $validCount / ${levels.length}');
  print('Invalid:      $invalidCount');
  print(
      'Duplicates:   ${duplicateIds.length} duplicate IDs, ${duplicateBoards.length} duplicate boards',);
  print('Spikes:       ${spikes.length}');
  print('Solvability:  ${solvabilityWarnings.length} warnings');
  print('');
  print(allPassed
      ? '✅ ALL CHECKS PASSED — catalog ready for production'
      : '❌ ISSUES DETECTED — see details above',);
  print('');
  print('═══════════════════════════════════════════════════════════════');
}

// ── Helpers ──────────────────────────────────────────────────────────────────

void _section(String title) {
  print('');
  print('── $title ─────────────────────────────────────────────────────');
}

void _printDifficultyBand(
  String label,
  Map<int, DifficultyModel> diffs,
  double low,
  double high,
) {
  final count = diffs.values
      .where((d) => d.difficultyScore >= low && d.difficultyScore < high)
      .length;
  final bar = '█' * (count ~/ 5);
  print('  $label: ${count.toString().padLeft(3)}  $bar');
}

void _printRangeStats(
  String label,
  Map<int, DifficultyModel> diffs,
  int from,
  int to,
) {
  final inRange = diffs.entries
      .where((e) => e.key >= from && e.key <= to)
      .map((e) => e.value.difficultyScore)
      .toList();
  if (inRange.isEmpty) return;
  final avg = inRange.reduce((a, b) => a + b) / inRange.length;
  final min = inRange.reduce((a, b) => a < b ? a : b);
  final max = inRange.reduce((a, b) => a > b ? a : b);
  print(
    '  $label: avg=${avg.toStringAsFixed(3)}  '
    'min=${min.toStringAsFixed(3)}  max=${max.toStringAsFixed(3)}',
  );
}

double _avgDifficulty(
  List<LevelDefinition> levels,
  Map<int, DifficultyModel> diffs,
) {
  if (levels.isEmpty) return 0.0;
  final total = levels.fold<double>(
    0.0,
    (sum, l) => sum + (diffs[l.id]?.difficultyScore ?? 0.0),
  );
  return total / levels.length;
}

String _boardSignature(LevelDefinition level) {
  if (level.initialStars.isEmpty) {
    return 'empty_${level.boardConfig.rows}x${level.boardConfig.cols}';
  }
  final placements = level.initialStars
      .map((p) => '${p.position.row},${p.position.col},${p.type.name}')
      .toList()
    ..sort();
  return placements.join('|');
}

List<String> _checkSolvability(LevelDefinition level) {
  final warnings = <String>[];
  final totalStars = level.initialStars.isEmpty
      ? level.boardConfig.rows * level.boardConfig.cols
      : level.initialStars.length;

  switch (level.objective.type) {
    case ObjectiveType.clearStars:
      if (level.objective.target > totalStars) {
        warnings.add(
          'clearStars target ${level.objective.target} > board stars $totalStars (impossible)',
        );
      }
      // Warn if very tight: target > 90% of stars with very few shots
      final ratio = level.objective.target / totalStars;
      if (ratio > 0.95 && level.moveLimit < 15) {
        warnings.add(
          'clearStars target ${level.objective.target}/$totalStars (${(ratio * 100).round()}%) '
          'with only ${level.moveLimit} shots may be very tight',
        );
      }
    case ObjectiveType.clearSpecial:
      final specialOnBoard =
          level.initialStars.where((p) => p.type == StarType.frozenStar).length;
      if (specialOnBoard < level.objective.target) {
        warnings.add(
          'clearSpecial target ${level.objective.target} > frozen stars on board $specialOnBoard',
        );
      }
    case ObjectiveType.clearStarType:
      if (level.objective.targetStarType != null) {
        final typeOnBoard = level.initialStars
            .where((p) => p.type == level.objective.targetStarType)
            .length;
        if (typeOnBoard == 0) {
          warnings.add(
            'clearStarType targets ${level.objective.targetStarType!.name} '
            'but none are on the initial board',
          );
        }
      }
    case ObjectiveType.scoreTarget:
      // Score targets: very high targets with very few stars might be problematic
      final minPossibleScore = totalStars * 50; // rough lower bound
      if (level.objective.target > minPossibleScore * 3) {
        warnings.add(
          'scoreTarget ${level.objective.target} may be unreachable with '
          'only $totalStars stars on board',
        );
      }
  }

  // Check: moveLimit too low to make progress
  if (level.moveLimit < 8) {
    warnings.add('moveLimit ${level.moveLimit} is very low (< 8)');
  }

  return warnings;
}
