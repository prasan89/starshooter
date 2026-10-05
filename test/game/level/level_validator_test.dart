import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/level_validator.dart';
import 'package:star_shooter/game/models/board_config.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/level_definition.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('LevelValidator', () {
    LevelDefinition makeValid({
      int id = 1,
      int moveLimit = 20,
      int failureBoundaryRow = 8,
    }) =>
        LevelDefinition(
          id: id,
          displayName: 'Test',
          moveLimit: moveLimit,
          scoreTarget: 500,
          failureBoundaryRow: failureBoundaryRow,
          availableStarTypes: const [StarType.normal],
          objective: const LevelObjective.scoreTarget(500),
          randomSeed: 42,
        );

    test('valid level passes', () {
      final result = LevelValidator.validate(makeValid());
      expect(result.isValid, isTrue);
      expect(result.issues, isEmpty);
    });

    test('rejects zero moveLimit', () {
      final level = makeValid(moveLimit: 0);
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(result.issues.any((i) => i.code == 'INVALID_SHOT_COUNT'), isTrue);
    });

    test('rejects duplicate star positions', () {
      const pos = GridPosition(0, 0);
      const level = LevelDefinition(
        id: 1,
        displayName: 'Test',
        moveLimit: 20,
        scoreTarget: 500,
        failureBoundaryRow: 8,
        availableStarTypes: [StarType.normal],
        objective: LevelObjective.scoreTarget(500),
        randomSeed: 42,
        initialStars: [
          InitialStarPlacement(position: pos, type: StarType.normal),
          InitialStarPlacement(position: pos, type: StarType.normal),
        ],
      );
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(result.issues.any((i) => i.code == 'DUPLICATE_POSITION'), isTrue);
    });

    test('rejects invalid board rows', () {
      const level = LevelDefinition(
        id: 1,
        displayName: 'T',
        moveLimit: 20,
        scoreTarget: 100,
        failureBoundaryRow: 8,
        availableStarTypes: [StarType.normal],
        objective: LevelObjective.scoreTarget(100),
        randomSeed: 1,
        boardConfig: BoardConfig(rows: 1, cols: 9),
      );
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(result.issues.any((i) => i.code == 'INVALID_BOARD_ROWS'), isTrue);
    });

    test('rejects clearStarType objective with no targetStarType', () {
      const level = LevelDefinition(
        id: 1,
        displayName: 'T',
        moveLimit: 20,
        scoreTarget: 100,
        failureBoundaryRow: 8,
        availableStarTypes: [StarType.normal],
        objective: LevelObjective(type: ObjectiveType.clearStarType, target: 5),
        randomSeed: 1,
      );
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(
        result.issues.any((i) => i.code == 'CLEAR_TYPE_MISSING_STAR_TYPE'),
        isTrue,
      );
    });

    test('rejects out-of-bounds star placement', () {
      const level = LevelDefinition(
        id: 1,
        displayName: 'T',
        moveLimit: 20,
        scoreTarget: 100,
        failureBoundaryRow: 8,
        availableStarTypes: [StarType.normal],
        objective: LevelObjective.scoreTarget(100),
        randomSeed: 1,
        initialStars: [
          InitialStarPlacement(
            position: GridPosition(99, 0),
            type: StarType.normal,
          ),
        ],
      );
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(result.issues.any((i) => i.code == 'OUT_OF_BOUNDS_ROW'), isTrue);
    });

    test('rejects invalid objective target', () {
      const level = LevelDefinition(
        id: 1,
        displayName: 'T',
        moveLimit: 20,
        scoreTarget: 0,
        failureBoundaryRow: 8,
        availableStarTypes: [StarType.normal],
        objective: LevelObjective(type: ObjectiveType.scoreTarget, target: 0),
        randomSeed: 1,
      );
      final result = LevelValidator.validate(level);
      expect(result.isValid, isFalse);
      expect(
        result.issues.any((i) => i.code == 'INVALID_OBJECTIVE_TARGET'),
        isTrue,
      );
    });
  });
}
