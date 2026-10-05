import 'dart:math';

import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_config.dart';

/// A single rule that governs when and how often a [StarType] may appear in
/// the launcher.
class SpawnRule {
  final StarType type;

  /// Relative spawn weight — higher values make this type appear more often.
  final double weight;

  /// This type only appears from this level onward.
  final int minLevel;

  const SpawnRule({
    required this.type,
    required this.weight,
    this.minLevel = 1,
  });
}

/// Decides what type of star to load into the launcher.
///
/// The spawner is seeded and therefore deterministic: given the same [seed] and
/// [levelId] it will always produce the same sequence of star types.
class SpecialStarSpawner {
  final int levelId;
  final int seed;
  final SpecialStarConfig config;

  /// Star types that are permitted for this level (from
  /// [LevelDefinition.availableStarTypes]).
  final List<StarType> allowedTypes;

  /// Weighted spawn rules applied by [nextType].
  final List<SpawnRule> rules;

  late final Random _rng;

  SpecialStarSpawner({
    required this.levelId,
    required this.seed,
    required this.allowedTypes,
    SpecialStarConfig? config,
    List<SpawnRule>? rules,
  })  : config = config ?? SpecialStarConfig.standard,
        rules = rules ?? _defaultRules() {
    _rng = Random(seed);
  }

  /// Default weighted rules for all star types.
  static List<SpawnRule> _defaultRules() => [
        const SpawnRule(type: StarType.normal, weight: 0.7, minLevel: 1),
        const SpawnRule(type: StarType.meteor, weight: 0.08, minLevel: 11),
        const SpawnRule(type: StarType.rainbow, weight: 0.08, minLevel: 21),
        const SpawnRule(type: StarType.supernova, weight: 0.06, minLevel: 31),
        const SpawnRule(type: StarType.blackHole, weight: 0.05, minLevel: 41),
        const SpawnRule(type: StarType.frozenStar, weight: 0.03, minLevel: 51),
      ];

  /// Returns the next star type to load into the launcher.
  ///
  /// Only rules whose [SpawnRule.minLevel] is satisfied **and** whose
  /// [SpawnRule.type] appears in [allowedTypes] are considered. Falls back to
  /// [StarType.normal] when nothing is eligible.
  StarType nextType() {
    // Filter rules by level and allowedTypes.
    final eligible = rules
        .where(
          (r) => r.minLevel <= levelId && allowedTypes.contains(r.type),
        )
        .toList();

    if (eligible.isEmpty) return StarType.normal;

    // Weighted random selection.
    final totalWeight = eligible.fold(0.0, (sum, r) => sum + r.weight);
    double pick = _rng.nextDouble() * totalWeight;
    for (final rule in eligible) {
      pick -= rule.weight;
      if (pick <= 0) return rule.type;
    }
    return eligible.last.type;
  }
}
