import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/board_resolver.dart';

void main() {
  group('BoardResolver', () {
    BoardGrid buildGrid(List<(int, int, StarType)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    test('no match — board unchanged, score 0', () {
      // Place 2 normal stars; adding a 3rd of different type → no match
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.meteor),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 2));
      expect(result.scoreGained, 0);
      expect(result.matchedGroups, isEmpty);
      expect(result.finalBoard.occupiedPositions, hasLength(3));
    });

    test('match 3 normal stars, awards score > 0', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 2));
      expect(result.scoreGained, greaterThan(0));
      expect(result.matchedGroups, hasLength(1));
      expect(result.matchedGroups.first, hasLength(3));
      expect(result.finalBoard.occupiedPositions, isEmpty);
    });

    test('matched stars are removed from final board', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        (0, 3, StarType.meteor),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 2));
      // Normal stars matched; meteor remains
      expect(result.finalBoard.occupiedPositions, hasLength(1));
      expect(
        result.finalBoard.starAt(const GridPosition(0, 3))?.type,
        StarType.meteor,
      );
    });

    test('floating stars are removed and scored', () {
      // Row 0: nothing. Row 2: 2 stars (floating)
      final g = buildGrid([
        (2, 0, StarType.normal),
        (2, 1, StarType.normal),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(2, 0));
      expect(result.floatingStars, hasLength(2));
      expect(result.finalBoard.occupiedPositions, isEmpty);
    });

    test('boardCleared is true when all stars removed', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 0));
      expect(result.boardCleared, isTrue);
    });

    test('combo level is at least 2 after a match', () {
      // After beginResolution (level 1) then recordMatch (level increments to 2)
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final result =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 0));
      expect(result.comboLevel, greaterThanOrEqualTo(2));
    });

    test('deterministic: same board + same seed gives same result', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final r1 =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 0));
      final r2 =
          BoardResolver.resolve(board: g, placedPos: const GridPosition(0, 0));
      expect(r1.scoreGained, equals(r2.scoreGained));
      expect(r1.matchedGroups.length, equals(r2.matchedGroups.length));
    });
  });
}
