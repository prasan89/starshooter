/// All balance tuning constants for special stars in one place.
///
/// Pass a custom [SpecialStarConfig] instance to level or game configuration
/// to override individual parameters without subclassing.
class SpecialStarConfig {
  // ── Meteor ────────────────────────────────────────────────────────────────

  /// Number of columns cleared by the meteor (centred on the placed column).
  final int meteorClearWidth;
  final double meteorScoreMultiplier;

  // ── Rainbow ───────────────────────────────────────────────────────────────

  /// When true, a rainbow star placed adjacent to normal stars matches them all.
  final bool rainbowMatchAllAdjacent;
  final double rainbowScoreMultiplier;

  // ── Supernova ─────────────────────────────────────────────────────────────

  /// Radius in hex-cells of the area cleared by the supernova.
  final int supernovaRadius;
  final double supernovaScoreMultiplier;

  // ── Black Hole ────────────────────────────────────────────────────────────

  /// Radius in hex-cells that the black hole attracts stars from.
  final int blackHoleRadius;
  final double blackHoleScoreMultiplier;

  // ── Frozen Star ───────────────────────────────────────────────────────────

  /// Number of matches required adjacent to a frozen star to thaw it.
  final int frozenThawHits;
  final double frozenScoreMultiplier;

  // ── Spawning ──────────────────────────────────────────────────────────────

  /// Base probability [0..1] that the next launcher star is special
  /// (when special stars are enabled for the level).
  final double specialSpawnRate;

  const SpecialStarConfig({
    this.meteorClearWidth = 3,
    this.meteorScoreMultiplier = 1.5,
    this.rainbowMatchAllAdjacent = true,
    this.rainbowScoreMultiplier = 1.2,
    this.supernovaRadius = 2,
    this.supernovaScoreMultiplier = 2.0,
    this.blackHoleRadius = 2,
    this.blackHoleScoreMultiplier = 1.8,
    this.frozenThawHits = 2,
    this.frozenScoreMultiplier = 1.3,
    this.specialSpawnRate = 0.15,
  });

  static const SpecialStarConfig standard = SpecialStarConfig();
}
