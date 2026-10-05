/// All scoring constants in one place — easy to tune.
class ScoringConfig {
  final int baseMatchScore; // per star in a matched group
  final int largeGroupBonus; // extra points per star when group size > 5
  final int largeGroupThreshold; // group size that triggers the bonus
  final int floatingStarScore; // per floating star removed by gravity
  final int comboBaseMultiplier; // multiplier increase per cascade level

  const ScoringConfig({
    this.baseMatchScore = 50,
    this.largeGroupBonus = 25,
    this.largeGroupThreshold = 5,
    this.floatingStarScore = 30,
    this.comboBaseMultiplier = 1,
  });

  static const ScoringConfig standard = ScoringConfig();

  /// Calculates total score for a match event.
  ///
  /// [groupSize] — number of matched stars
  /// [comboLevel] — current cascade depth (1 = first match, 2 = first cascade, …)
  int calculateMatchScore(int groupSize, int comboLevel) {
    final base = groupSize * baseMatchScore;
    final bonus = groupSize > largeGroupThreshold
        ? (groupSize - largeGroupThreshold) * largeGroupBonus
        : 0;
    final multiplier = comboLevel * comboBaseMultiplier;
    return (base + bonus) * multiplier;
  }

  /// Score for [count] floating stars dropped by gravity.
  ///
  /// [comboLevel] also applies to floating-star removal.
  int calculateFloatingScore(int count, int comboLevel) {
    return count * floatingStarScore * comboLevel;
  }
}
