import 'package:star_shooter/game/level/difficulty_model.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// Analyses a [LevelDefinition] and produces a [DifficultyModel].
///
/// All computations are deterministic — same input always returns same output.
class DifficultyCalculator {
  static DifficultyModel calculate(LevelDefinition level) {
    final boardScore = _boardComplexity(level);
    final colorScore = _colorComplexity(level);
    final specialScore = _specialComplexity(level);
    final shotScore = _shotPressure(level);
    final objectiveScore = _objectiveComplexity(level);
    final cascadeScore = _cascadePotential(level);

    // Weighted composite
    final composite = (boardScore * 0.20 +
            colorScore * 0.15 +
            specialScore * 0.20 +
            shotScore * 0.20 +
            objectiveScore * 0.15 +
            cascadeScore * 0.10)
        .clamp(0.0, 1.0);

    final category = DifficultyCategory.values[composite < 0.30
        ? 0
        : composite < 0.55
            ? 1
            : composite < 0.80
                ? 2
                : 3];

    // Rough heuristics for estimated shot usage
    final totalStars = level.initialStars.isEmpty
        ? level.boardConfig.rows * level.boardConfig.cols
        : level.initialStars.length;
    final minShots = (totalStars * 0.3).round().clamp(5, level.moveLimit);
    final avgShots =
        (totalStars * 0.6).round().clamp(minShots, level.moveLimit);

    return DifficultyModel(
      category: category,
      difficultyScore: composite,
      estimatedCompletionRate: (1.0 - composite * 0.7).clamp(0.1, 0.95),
      estimatedMinimumShots: minShots,
      estimatedAverageShots: avgShots,
      specialStarComplexity: specialScore,
      boardComplexity: boardScore,
    );
  }

  static double _boardComplexity(LevelDefinition level) {
    final cfg = level.boardConfig;
    final maxDensity = cfg.rows * cfg.cols;
    final starCount =
        level.initialStars.isEmpty ? maxDensity : level.initialStars.length;
    final density = (starCount / maxDensity).clamp(0.0, 1.0);
    // More rows = more complex (more to clear)
    final sizeFactor = ((cfg.rows - 2) / 18.0).clamp(0.0, 1.0);
    return (density * 0.6 + sizeFactor * 0.4);
  }

  static double _colorComplexity(LevelDefinition level) {
    final colors = level.availableStarTypes.where((t) => !t.isSpecial).length;
    // More distinct normal colors = harder to match
    return ((colors - 1) / 5.0).clamp(0.0, 1.0);
  }

  static double _specialComplexity(LevelDefinition level) {
    final specials = level.availableStarTypes.where((t) => t.isSpecial).length;
    final hasFrozen =
        level.initialStars.any((p) => p.type == StarType.frozenStar);
    return ((specials / 5.0) * 0.6 + (hasFrozen ? 0.4 : 0.0)).clamp(0.0, 1.0);
  }

  static double _shotPressure(LevelDefinition level) {
    // Tighter shot limits = more pressure
    // Standard is 20 shots; 30 = easy, 15 = hard, 10 = very hard
    final normalised = 1.0 - ((level.moveLimit - 10) / 25.0).clamp(0.0, 1.0);
    return normalised;
  }

  static double _objectiveComplexity(LevelDefinition level) {
    switch (level.objective.type) {
      case ObjectiveType.scoreTarget:
        // Higher score targets are harder
        return (level.objective.target / 10000.0).clamp(0.0, 1.0);
      case ObjectiveType.clearStars:
        final total = level.initialStars.isEmpty
            ? level.boardConfig.rows * level.boardConfig.cols
            : level.initialStars.length;
        return (level.objective.target / total.toDouble()).clamp(0.0, 1.0);
      case ObjectiveType.clearStarType:
        return 0.7; // type-specific clears are inherently harder
      case ObjectiveType.clearSpecial:
        return 0.9; // obstacle removal is the hardest objective type
    }
  }

  static double _cascadePotential(LevelDefinition level) {
    if (level.initialStars.isEmpty) return 0.5;
    // Count clusters (adjacent same-type pairs as proxy)
    // A rough heuristic: many same-type placements = high cascade potential (easier)
    final typeCounts = <StarType, int>{};
    for (final p in level.initialStars) {
      typeCounts[p.type] = (typeCounts[p.type] ?? 0) + 1;
    }
    if (typeCounts.isEmpty) return 0.5;
    final maxCount = typeCounts.values.reduce((a, b) => a > b ? a : b);
    final fraction = maxCount / level.initialStars.length;
    // High fraction of one type = easy cascades = lower difficulty contribution
    return (1.0 - fraction).clamp(0.0, 1.0);
  }
}
