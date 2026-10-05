import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/models/level_definition.dart';

/// Generates a deterministic daily challenge from a calendar date string.
///
/// Given the same 'YYYY-MM-DD' date string this generator always produces an
/// identical [DailyChallenge]. It works entirely offline, carries no mutable
/// state, and has no network dependency.
///
/// Algorithm summary:
///   1. Hash the date string with a polynomial rolling hash, then XOR-fold in
///      the year / month / day integers for additional variance.
///   2. Drive all selections (level index, objective type, difficulty tier,
///      move-limit modifier) from a chain of LCG-derived secondary seeds so
///      that each dimension is independently varied while remaining fully
///      reproducible.
class DailyChallengeGenerator {
  const DailyChallengeGenerator();

  /// Generate a deterministic daily challenge for the given local date string.
  /// Same date → same challenge. Offline. No randomness.
  DailyChallenge generateForDate(String date) {
    final seed = _hashDate(date);
    return _buildChallenge(date: date, seed: seed);
  }

  // ── Hash ──────────────────────────────────────────────────────────────────

  static int _hashDate(String date) {
    // Deterministic hash of 'YYYY-MM-DD'
    // Use a simple polynomial rolling hash with prime multipliers
    // Produces a stable positive integer for any date string
    int h = 0x45678901;
    for (int i = 0; i < date.length; i++) {
      final c = date.codeUnitAt(i);
      h = ((h ^ c) * 0x9e3779b9) & 0x7FFFFFFF;
    }
    // XOR fold with day/month/year components for more variation
    final parts = date.split('-');
    if (parts.length == 3) {
      final y = int.tryParse(parts[0]) ?? 2024;
      final m = int.tryParse(parts[1]) ?? 1;
      final d = int.tryParse(parts[2]) ?? 1;
      h = ((h ^ (y * 31)) ^ (m * 37) ^ (d * 41)) & 0x7FFFFFFF;
    }
    return h.abs();
  }

  // ── Challenge builder ─────────────────────────────────────────────────────

  DailyChallenge _buildChallenge({
    required String date,
    required int seed,
  }) {
    final levels = LevelCatalog.allLevels;
    final levelIndex = seed % levels.length;
    final level = levels[levelIndex];

    // Secondary seeds for objective, difficulty, move modifier — LCG chain.
    final objSeed =
        (seed * 6364136223846793005 + 1442695040888963407) & 0x7FFFFFFF;
    final diffSeed =
        (objSeed * 6364136223846793005 + 1442695040888963407) & 0x7FFFFFFF;
    final moveSeed =
        (diffSeed * 6364136223846793005 + 1442695040888963407) & 0x7FFFFFFF;

    final difficulty = _selectDifficulty(diffSeed);
    final objective =
        _buildObjective(level: level, seed: objSeed, difficulty: difficulty);
    final moveLimit =
        _buildMoveLimit(level: level, seed: moveSeed, difficulty: difficulty);

    return DailyChallenge(
      id: date,
      date: date,
      levelId: level.id,
      levelDefinition: level,
      objective: objective,
      difficulty: difficulty,
      reward: ChallengeReward.standard,
      seed: seed,
      bonusMoveLimit: moveLimit,
    );
  }

  // ── Difficulty ────────────────────────────────────────────────────────────

  ChallengeDifficulty _selectDifficulty(int seed) {
    // 40% easy, 35% medium, 20% hard, 5% expert
    final r = seed % 100;
    if (r < 40) return ChallengeDifficulty.easy;
    if (r < 75) return ChallengeDifficulty.medium;
    if (r < 95) return ChallengeDifficulty.hard;
    return ChallengeDifficulty.expert;
  }

  // ── Objective ─────────────────────────────────────────────────────────────

  LevelObjective _buildObjective({
    required LevelDefinition level,
    required int seed,
    required ChallengeDifficulty difficulty,
  }) {
    // Rotate through objective types based on seed and level capabilities
    final objectiveTypeIndex =
        seed % 3; // 0=scoreTarget, 1=clearStars, 2=baseObjective

    // Difficulty multipliers for score targets
    final scoreMultiplier = switch (difficulty) {
      ChallengeDifficulty.easy => 0.8,
      ChallengeDifficulty.medium => 1.0,
      ChallengeDifficulty.hard => 1.3,
      ChallengeDifficulty.expert => 1.6,
    };

    switch (objectiveTypeIndex) {
      case 0:
        // Score target based on level's score target, scaled by difficulty
        final target = (level.scoreTarget * scoreMultiplier).round();
        // Round to nearest 50
        final rounded = ((target + 25) ~/ 50) * 50;
        return LevelObjective.scoreTarget(rounded.clamp(100, 50000));
      case 1:
        // Clear stars — base on difficulty
        final count = switch (difficulty) {
          ChallengeDifficulty.easy => 10,
          ChallengeDifficulty.medium => 15,
          ChallengeDifficulty.hard => 20,
          ChallengeDifficulty.expert => 25,
        };
        return LevelObjective.clearStars(count);
      default:
        // Use the level's existing objective (with difficulty scale if score-based)
        final base = level.objective;
        if (base.type == ObjectiveType.scoreTarget) {
          final t = (base.target * scoreMultiplier).round();
          final r = ((t + 25) ~/ 50) * 50;
          return LevelObjective.scoreTarget(r.clamp(100, 50000));
        }
        return base;
    }
  }

  // ── Move limit ────────────────────────────────────────────────────────────

  int _buildMoveLimit({
    required LevelDefinition level,
    required int seed,
    required ChallengeDifficulty difficulty,
  }) {
    // Daily challenges may have slightly tighter move limits
    final modifier = switch (difficulty) {
      ChallengeDifficulty.easy => 1.2, // 20% more moves
      ChallengeDifficulty.medium => 1.0, // same as level
      ChallengeDifficulty.hard => 0.85, // 15% fewer moves
      ChallengeDifficulty.expert => 0.7, // 30% fewer moves
    };
    final adjusted = (level.moveLimit * modifier).round();
    return adjusted.clamp(8, 60);
  }
}
