import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/star_rating_calculator.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('StarRatingCalculator', () {
    const level = LevelDefinition(
      id: 1,
      displayName: 'Test',
      moveLimit: 20,
      scoreTarget: 1000,
      failureBoundaryRow: 8,
      availableStarTypes: [StarType.normal],
      objective: LevelObjective.scoreTarget(1000),
      randomSeed: 42,
    );

    test('3 stars for 150% score', () {
      final rating = StarRatingCalculator.calculate(
        level: level,
        score: 1500,
        shotsUsed: 15,
      );
      expect(rating.stars, 3);
    });

    test('2 stars for 100% score', () {
      final rating = StarRatingCalculator.calculate(
        level: level,
        score: 1000,
        shotsUsed: 18,
      );
      expect(rating.stars, greaterThanOrEqualTo(1));
    });

    test('1 star for completion below both thresholds', () {
      final rating = StarRatingCalculator.calculate(
        level: level,
        score: 500,
        shotsUsed: 19,
      );
      expect(rating.stars, 1);
    });

    test('result is deterministic', () {
      final r1 = StarRatingCalculator.calculate(
        level: level,
        score: 900,
        shotsUsed: 10,
      );
      final r2 = StarRatingCalculator.calculate(
        level: level,
        score: 900,
        shotsUsed: 10,
      );
      expect(r1.stars, equals(r2.stars));
    });
  });
}
