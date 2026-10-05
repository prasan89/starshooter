import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/models/level_definition.dart';

/// The difficulty tier of a daily challenge.
enum ChallengeDifficulty { easy, medium, hard, expert }

/// A single daily challenge — one per calendar date.
class DailyChallenge {
  const DailyChallenge({
    required this.id,
    required this.date,
    required this.levelId,
    required this.levelDefinition,
    required this.objective,
    required this.difficulty,
    required this.reward,
    required this.seed,
    required this.bonusMoveLimit,
  });

  /// Unique challenge identifier — "{date}" e.g. "2024-10-05"
  final String id;
  final String date;
  final int levelId;
  final LevelDefinition levelDefinition;
  final LevelObjective objective;
  final ChallengeDifficulty difficulty;
  final ChallengeReward reward;
  final int seed;

  /// Override the level's standard moveLimit for this challenge.
  /// May be tighter than the level's default for harder daily challenges.
  final int bonusMoveLimit;

  int get effectiveMoveLimit =>
      bonusMoveLimit > 0 ? bonusMoveLimit : levelDefinition.moveLimit;
}

class ChallengeReward {
  const ChallengeReward({
    required this.dailyStars,
    required this.description,
  });

  final int dailyStars; // always 1 for M11
  final String description; // e.g. "Daily Star +1"

  static const standard = ChallengeReward(
    dailyStars: 1,
    description: 'Daily Star +1',
  );
}
