// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/level_objective.dart';
import 'package:star_shooter/game/level/objective_evaluator.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('ObjectiveEvaluator', () {
    BoardGrid emptyBoard() => BoardGrid();

    test('scoreTarget satisfied when accumulated score meets target', () {
      final evaluator = ObjectiveEvaluator(
        objective: LevelObjective.scoreTarget(1000),
      );
      evaluator.onResolution(
        scoreGained: 600,
        matchedPositions: [],
        floatingPositions: [],
        specialEffectPositions: [],
        board: emptyBoard(),
      );
      expect(evaluator.isSatisfied, isFalse);
      evaluator.onResolution(
        scoreGained: 500,
        matchedPositions: [],
        floatingPositions: [],
        specialEffectPositions: [],
        board: emptyBoard(),
      );
      expect(evaluator.isSatisfied, isTrue);
    });

    test('clearStars counts all removed positions', () {
      final evaluator = ObjectiveEvaluator(
        objective: LevelObjective.clearStars(5),
      );
      var board = BoardGrid();
      final positions = [
        const GridPosition(0, 0),
        const GridPosition(0, 1),
        const GridPosition(0, 2),
      ];
      for (final p in positions) {
        board = board.placeStar(
          StarModel.create(type: StarType.normal, gridPosition: p),
          p,
        );
      }
      evaluator.onResolution(
        scoreGained: 0,
        matchedPositions: positions,
        floatingPositions: [],
        specialEffectPositions: [],
        board: board,
      );
      expect(evaluator.currentProgress, 3);
      expect(evaluator.isSatisfied, isFalse);
      evaluator.onResolution(
        scoreGained: 0,
        matchedPositions: [
          const GridPosition(1, 0),
          const GridPosition(1, 1),
        ],
        floatingPositions: [],
        specialEffectPositions: [],
        board: board,
      );
      expect(evaluator.isSatisfied, isTrue);
    });

    test('progress fraction is capped at 1.0', () {
      final evaluator = ObjectiveEvaluator(
        objective: LevelObjective.scoreTarget(100),
      );
      evaluator.onResolution(
        scoreGained: 500,
        matchedPositions: [],
        floatingPositions: [],
        specialEffectPositions: [],
        board: emptyBoard(),
      );
      expect(evaluator.progressFraction, 1.0);
    });

    test('reset clears progress', () {
      final evaluator = ObjectiveEvaluator(
        objective: LevelObjective.clearStars(10),
      );
      evaluator.onResolution(
        scoreGained: 100,
        matchedPositions: [const GridPosition(0, 0)],
        floatingPositions: [],
        specialEffectPositions: [],
        board: emptyBoard(),
      );
      expect(evaluator.currentProgress, 1);
      evaluator.reset();
      expect(evaluator.currentProgress, 0);
    });
  });
}
