import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/models/level_definition.dart';

class RatingResult {
  final int stars; // 1-3
  final String label; // "Completed", "Good", "Excellent"

  const RatingResult({required this.stars, required this.label});
}

/// Deterministically calculates star rating from completion data.
class StarRatingCalculator {
  static RatingResult calculate({
    required LevelDefinition level,
    required int score,
    required int shotsUsed,
  }) {
    final config = level.starRatingConfig;
    final scoreTarget = level.objective.type == ObjectiveType.scoreTarget
        ? level.objective.target
        : level.scoreTarget;
    final shotsRemaining = level.moveLimit - shotsUsed;
    final scoreFraction = scoreTarget > 0 ? score / scoreTarget : 1.0;
    final shotsFraction =
        level.moveLimit > 0 ? shotsRemaining / level.moveLimit : 0.0;

    int stars;
    if (scoreFraction >= config.threeStarScoreFraction ||
        shotsFraction >= config.threeStarShotsFraction) {
      stars = 3;
    } else if (scoreFraction >= config.twoStarScoreFraction ||
        shotsFraction >= config.twoStarShotsFraction) {
      stars = 2;
    } else {
      stars = 1;
    }

    const labels = ['', 'Completed', 'Good', 'Excellent'];
    return RatingResult(stars: stars, label: labels[stars]);
  }
}
