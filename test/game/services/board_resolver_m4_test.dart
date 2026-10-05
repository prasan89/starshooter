// Additional gameplay integrity tests for M4
import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/board_resolver.dart';

void main() {
  group('BoardResolver M4 gameplay integrity', () {
    BoardGrid buildGrid(List<(int, int, StarType)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    test('score is deterministic for same input', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final r1 = BoardResolver.resolve(
        board: g,
        placedPos: const GridPosition(0, 0),
      );
      final r2 = BoardResolver.resolve(
        board: g,
        placedPos: const GridPosition(0, 0),
      );
      expect(r1.scoreGained, equals(r2.scoreGained));
    });

    test('FX does not modify board state — resolve returns correct final board',
        () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        (0, 3, StarType.meteor),
      ]);
      final result = BoardResolver.resolve(
        board: g,
        placedPos: const GridPosition(0, 2),
      );
      // Normal stars matched; meteor remains untouched
      expect(
        result.finalBoard.starAt(const GridPosition(0, 3))?.type,
        StarType.meteor,
      );
      expect(result.finalBoard.occupiedPositions.length, 1);
    });

    test('multiple cascades resolve correctly', () {
      // Set up a board where after removing 3 normals from row 0,
      // a row-1 set of 3 becomes accessible (connected to new row-0 empty space)
      // This tests cascade — note: in our current engine, cascade re-scans the
      // board so as long as 3 connected same-type stars exist they will be matched
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        // Row 1: 3 more normal — after row 0 is cleared, these might be floating
        // OR they form their own group
        (1, 0, StarType.normal),
        (1, 1, StarType.normal),
        (1, 2, StarType.normal),
      ]);
      final result = BoardResolver.resolve(
        board: g,
        placedPos: const GridPosition(0, 0),
      );
      // All 6 normals should be removed (two matches cascaded)
      expect(result.finalBoard.occupiedPositions, isEmpty);
      expect(result.comboLevel, greaterThan(1));
    });
  });
}
