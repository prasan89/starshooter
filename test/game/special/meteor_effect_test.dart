import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/meteor_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';

void main() {
  group('MeteorEffect', () {
    BoardGrid buildGrid(List<(int r, int c, StarType t)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    test('clears stars in same column as placed meteor', () {
      const meteor = GridPosition(3, 2);
      final g = buildGrid([
        (0, 2, StarType.normal), // same column
        (1, 2, StarType.normal), // same column
        (2, 2, StarType.normal), // same column
        (0, 0, StarType.normal), // different column
      ]);
      final effect =
          MeteorEffect(config: const SpecialStarConfig(meteorClearWidth: 1));
      final targets = effect.computeTargets(g, meteor);
      expect(targets.any((p) => p.col == 2), isTrue);
      expect(targets.any((p) => p.col == 0), isFalse);
    });

    test('does not include the meteor position itself', () {
      const meteor = GridPosition(2, 2);
      final g = buildGrid([(0, 2, StarType.normal), (2, 2, StarType.normal)]);
      final effect =
          MeteorEffect(config: const SpecialStarConfig(meteorClearWidth: 1));
      final targets = effect.computeTargets(g, meteor);
      expect(targets.contains(meteor), isFalse);
    });

    test('score multiplier > 1', () {
      expect(MeteorEffect().scoreMultiplier, greaterThan(1.0));
    });

    test('clears adjacent columns with width=3', () {
      const config = SpecialStarConfig(meteorClearWidth: 3);
      const meteor = GridPosition(3, 4);
      final g = buildGrid([
        (0, 3, StarType.normal), // col 3 (adjacent left)
        (0, 4, StarType.normal), // col 4 (same)
        (0, 5, StarType.normal), // col 5 (adjacent right)
        (0, 7, StarType.normal), // col 7 (out of range)
      ]);
      final targets = MeteorEffect(config: config).computeTargets(g, meteor);
      expect(targets.any((p) => p.col == 3), isTrue);
      expect(targets.any((p) => p.col == 5), isTrue);
      expect(targets.any((p) => p.col == 7), isFalse);
    });
  });
}
