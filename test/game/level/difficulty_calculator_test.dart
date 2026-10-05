import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/difficulty_calculator.dart';
import 'package:star_shooter/game/level/difficulty_model.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('DifficultyCalculator', () {
    test('is deterministic — same input same result', () {
      final level = LevelDefinition.forLevel(5);
      final r1 = DifficultyCalculator.calculate(level);
      final r2 = DifficultyCalculator.calculate(level);
      expect(r1.difficultyScore, closeTo(r2.difficultyScore, 0.0001));
      expect(r1.category, equals(r2.category));
    });

    test('easy level has low difficulty score', () {
      final level = LevelDefinition.forLevel(1);
      final result = DifficultyCalculator.calculate(level);
      expect(
        result.category,
        anyOf([DifficultyCategory.easy, DifficultyCategory.medium]),
      );
    });

    test('hard level has high difficulty score', () {
      final level = LevelDefinition.forLevel(45);
      final result = DifficultyCalculator.calculate(level);
      expect(result.difficultyScore, greaterThan(0.4));
    });

    test('more star colors increases complexity', () {
      const easy = LevelDefinition(
        id: 1,
        displayName: 'E',
        moveLimit: 30,
        scoreTarget: 300,
        failureBoundaryRow: 8,
        objective: LevelObjective.scoreTarget(300),
        availableStarTypes: [StarType.normal],
        randomSeed: 1,
      );
      const harder = LevelDefinition(
        id: 2,
        displayName: 'H',
        moveLimit: 30,
        scoreTarget: 300,
        failureBoundaryRow: 8,
        objective: LevelObjective.scoreTarget(300),
        availableStarTypes: [
          StarType.normal,
          StarType.meteor,
          StarType.rainbow,
        ],
        randomSeed: 2,
      );
      final easyScore = DifficultyCalculator.calculate(easy).difficultyScore;
      final harderScore =
          DifficultyCalculator.calculate(harder).difficultyScore;
      expect(harderScore, greaterThan(easyScore));
    });
  });
}
