import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/match_detector.dart';

void main() {
  group('MatchDetector', () {
    BoardGrid buildGrid(List<(int, int, StarType)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    test('returns empty for single star', () {
      final g = buildGrid([(0, 0, StarType.normal)]);
      expect(
        MatchDetector.findMatches(g, const GridPosition(0, 0)),
        isEmpty,
      );
    });

    test('returns empty for 2 connected stars', () {
      final g =
          buildGrid([(0, 0, StarType.normal), (0, 1, StarType.normal)]);
      expect(
        MatchDetector.findMatches(g, const GridPosition(0, 0)),
        isEmpty,
      );
    });

    test('detects group of exactly 3', () {
      // Row 0: cols 0,1,2 — all normal; adjacent in even-row hex
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      final matches = MatchDetector.findMatches(g, const GridPosition(0, 0));
      expect(matches, hasLength(1));
      expect(matches.first, hasLength(3));
    });

    test('detects group of 5', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        (0, 3, StarType.normal),
        (0, 4, StarType.normal),
      ]);
      final matches = MatchDetector.findMatches(g, const GridPosition(0, 2));
      expect(matches, hasLength(1));
      expect(matches.first, hasLength(5));
    });

    test('does not match different types', () {
      // 2 normal + 1 meteor adjacent — no match of size 3
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.meteor),
      ]);
      expect(
        MatchDetector.findMatches(g, const GridPosition(0, 0)),
        isEmpty,
      );
    });

    test('isPartOfMatch returns false for no match', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
      ]);
      expect(
        MatchDetector.isPartOfMatch(g, const GridPosition(0, 0)),
        isFalse,
      );
    });

    test('isPartOfMatch returns true for match', () {
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
      ]);
      expect(
        MatchDetector.isPartOfMatch(g, const GridPosition(0, 1)),
        isTrue,
      );
    });

    test('non-adjacent same-color stars are separate groups', () {
      // Two isolated pairs of normal stars — neither forms a group of 3
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 5, StarType.normal),
        (0, 6, StarType.normal),
      ]);
      for (final pos in [const GridPosition(0, 0), const GridPosition(0, 5)]) {
        expect(MatchDetector.findMatches(g, pos), isEmpty);
      }
    });
  });
}
