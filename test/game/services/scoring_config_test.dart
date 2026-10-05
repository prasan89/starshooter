import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/services/scoring_config.dart';

void main() {
  group('ScoringConfig', () {
    test('base match score scales with group size', () {
      const config = ScoringConfig();
      final s3 = config.calculateMatchScore(3, 1);
      final s5 = config.calculateMatchScore(5, 1);
      expect(s5, greaterThan(s3));
    });

    test('combo multiplier doubles score at level 2', () {
      const config = ScoringConfig(baseMatchScore: 50, comboBaseMultiplier: 1);
      final s1 = config.calculateMatchScore(3, 1);
      final s2 = config.calculateMatchScore(3, 2);
      expect(s2, equals(s1 * 2));
    });

    test('large group bonus activates above threshold', () {
      const config = ScoringConfig(largeGroupThreshold: 5, largeGroupBonus: 25);
      final sSmall = config.calculateMatchScore(5, 1);
      final sLarge = config.calculateMatchScore(6, 1);
      expect(sLarge, greaterThan(sSmall));
    });

    test('floating star score scales with count', () {
      const config = ScoringConfig(floatingStarScore: 30);
      expect(config.calculateFloatingScore(3, 1), equals(90));
      expect(config.calculateFloatingScore(3, 2), equals(180));
    });
  });
}
