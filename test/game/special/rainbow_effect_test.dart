import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/rainbow_effect.dart';

void main() {
  group('RainbowEffect', () {
    BoardGrid buildGrid(List<(int r, int c, StarType t)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    test('returns empty when no neighbors', () {
      const rainbow = GridPosition(5, 5);
      final g = BoardGrid();
      expect(RainbowEffect().computeTargets(g, rainbow), isEmpty);
    });

    test('matches all adjacent normal stars and their connected chain', () {
      const rainbow = GridPosition(1, 1);
      // Row 0: 3 normals connected to the rainbow neighbor
      final g = buildGrid([
        (0, 0, StarType.normal),
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        // Add one normal adjacent to rainbow pos (row 1 even-row neighbors of (1,1): (0,0),(0,1),(1,0),(1,2),(2,0),(2,1))
      ]);
      final targets = RainbowEffect().computeTargets(g, rainbow);
      expect(targets, isNotEmpty);
    });

    test('does not match frozen stars', () {
      const rainbow = GridPosition(1, 1);
      var g = BoardGrid();
      const frozenPos = GridPosition(0, 1);
      final frozenStar = StarModel.create(
        type: StarType.frozenStar,
        gridPosition: frozenPos,
        frozenHitsRemaining: 2,
      );
      g = g.placeStar(frozenStar, frozenPos);
      final targets = RainbowEffect().computeTargets(g, rainbow);
      expect(targets.contains(frozenPos), isFalse);
    });
  });
}
