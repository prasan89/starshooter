import 'package:star_shooter/game/services/scoring_config.dart';

/// Tracks the current cascade depth and multiplier.
class ComboSystem {
  int _comboLevel = 0;
  int _totalScore = 0;
  final ScoringConfig config;

  ComboSystem({ScoringConfig? config})
      : config = config ?? ScoringConfig.standard;

  int get comboLevel => _comboLevel;
  int get totalScore => _totalScore;
  bool get hasActiveCombo => _comboLevel > 1;

  /// Call this at the start of each resolution cycle (after a shot lands).
  void beginResolution() {
    _comboLevel = 1;
  }

  /// Call this for each match event during resolution.
  ///
  /// Returns the score earned by this specific match.
  int recordMatch(int groupSize) {
    final score = config.calculateMatchScore(groupSize, _comboLevel);
    _totalScore += score;
    _comboLevel++;
    return score;
  }

  /// Call this for floating stars removed by gravity.
  ///
  /// Returns the score earned.
  int recordFloating(int count) {
    final score = config.calculateFloatingScore(count, _comboLevel);
    _totalScore += score;
    return score;
  }

  /// Resets combo after board becomes stable. Does NOT reset total score.
  void resetCombo() {
    _comboLevel = 0;
  }

  /// Resets everything (new level).
  void reset() {
    _comboLevel = 0;
    _totalScore = 0;
  }
}
