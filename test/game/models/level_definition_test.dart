import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/level_definition.dart';

void main() {
  group('LevelDefinition', () {
    test('forLevel generates deterministic result', () {
      final l1a = LevelDefinition.forLevel(1);
      final l1b = LevelDefinition.forLevel(1);
      expect(l1a.id, equals(l1b.id));
      expect(l1a.randomSeed, equals(l1b.randomSeed));
      expect(l1a.moveLimit, equals(l1b.moveLimit));
    });

    test('different levels have different seeds', () {
      final l1 = LevelDefinition.forLevel(1);
      final l2 = LevelDefinition.forLevel(2);
      expect(l1.randomSeed, isNot(equals(l2.randomSeed)));
    });

    test('buildInitialBoard returns non-empty grid', () {
      final def = LevelDefinition.forLevel(1);
      final board = def.buildInitialBoard();
      expect(board.occupiedPositions, isNotEmpty);
    });

    test('failureBoundaryRow is within board rows', () {
      final def = LevelDefinition.forLevel(1);
      expect(def.failureBoundaryRow, lessThan(def.boardConfig.rows + 5));
    });
  });
}
