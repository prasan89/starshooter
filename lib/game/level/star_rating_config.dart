/// Thresholds controlling how many stars a player earns on level completion.
class StarRatingConfig {
  /// Minimum fraction of [scoreTarget] needed for 3 stars.
  final double threeStarScoreFraction;

  /// Minimum fraction for 2 stars.
  final double twoStarScoreFraction;

  /// Minimum remaining-shots fraction of moveLimit for 3 stars (bonus criterion).
  final double threeStarShotsFraction;

  /// Minimum remaining-shots fraction for 2 stars.
  final double twoStarShotsFraction;

  const StarRatingConfig({
    this.threeStarScoreFraction = 1.5, // 150% of target
    this.twoStarScoreFraction = 1.0, // 100% of target
    this.threeStarShotsFraction = 0.4, // ≥40% shots remaining
    this.twoStarShotsFraction = 0.15, // ≥15% shots remaining
  });

  static const StarRatingConfig standard = StarRatingConfig();
}
