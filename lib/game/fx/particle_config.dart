/// Configuration for a particle burst emitter.
///
/// All fields are immutable so configs can be declared as `const` singletons
/// and shared freely across components without allocation overhead.
class ParticleConfig {
  final int count;
  final double minRadius;
  final double maxRadius;
  final double minSpeed;
  final double maxSpeed;
  final double lifetime; // seconds
  final bool hasGlow;
  final double glowBlur;

  const ParticleConfig({
    this.count = 12,
    this.minRadius = 2.0,
    this.maxRadius = 5.0,
    this.minSpeed = 80.0,
    this.maxSpeed = 200.0,
    this.lifetime = 0.6,
    this.hasGlow = true,
    this.glowBlur = 4.0,
  });

  /// Small pop — used for low-value or single-star pops.
  static const ParticleConfig popSmall =
      ParticleConfig(count: 8, lifetime: 0.5);

  /// Large pop — used for high-value or multi-star pops.
  static const ParticleConfig popLarge =
      ParticleConfig(count: 16, lifetime: 0.7, maxSpeed: 250.0);

  /// Cascade burst — fired when a matching cascade is triggered.
  static const ParticleConfig cascade = ParticleConfig(
    count: 20,
    lifetime: 0.8,
    maxSpeed: 280.0,
    hasGlow: true,
  );

  /// Impact flash — fired on projectile–star collision.
  static const ParticleConfig impact = ParticleConfig(
    count: 6,
    minRadius: 1.5,
    maxRadius: 3.0,
    lifetime: 0.3,
    minSpeed: 60.0,
    maxSpeed: 120.0,
  );

  /// Trail puff — emitted continuously along a projectile's path.
  static const ParticleConfig trail = ParticleConfig(
    count: 3,
    minRadius: 2.0,
    maxRadius: 4.0,
    lifetime: 0.2,
    minSpeed: 10.0,
    maxSpeed: 40.0,
    hasGlow: false,
  );

  /// Combo celebration — large saturated burst on high combos.
  static const ParticleConfig combo = ParticleConfig(
    count: 24,
    lifetime: 0.9,
    maxSpeed: 300.0,
    maxRadius: 6.0,
    hasGlow: true,
    glowBlur: 6.0,
  );

  // ── Special-star presets ─────────────────────────────────────────────────

  /// Meteor star destruction burst.
  static const ParticleConfig meteor = ParticleConfig(
    count: 20,
    lifetime: 0.6,
    maxSpeed: 300.0,
    maxRadius: 5.0,
    hasGlow: true,
    glowBlur: 5.0,
  );

  /// Supernova star explosion burst.
  static const ParticleConfig supernova = ParticleConfig(
    count: 30,
    lifetime: 0.8,
    maxSpeed: 350.0,
    maxRadius: 7.0,
    hasGlow: true,
    glowBlur: 8.0,
  );

  /// Black hole star implosion burst.
  static const ParticleConfig blackHole = ParticleConfig(
    count: 18,
    lifetime: 0.7,
    maxSpeed: 200.0,
    maxRadius: 4.0,
    hasGlow: true,
    glowBlur: 6.0,
  );

  /// Rainbow star destruction burst.
  static const ParticleConfig rainbow = ParticleConfig(
    count: 22,
    lifetime: 0.7,
    maxSpeed: 260.0,
    maxRadius: 5.0,
    hasGlow: true,
    glowBlur: 5.0,
  );

  /// Frozen star thaw burst.
  static const ParticleConfig frozenThaw = ParticleConfig(
    count: 14,
    lifetime: 0.5,
    minSpeed: 40.0,
    maxSpeed: 150.0,
    maxRadius: 4.0,
    hasGlow: false,
  );
}
