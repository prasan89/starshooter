import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/supernova_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';

void main() {
  group('SupernovaEffect', () {
    BoardGrid buildGrid(List<(int r, int c)> positions) {
      var g = BoardGrid();
      for (final (r, c) in positions) {
        final pos = GridPosition(r, c);
        g = g.placeStar(
          StarModel.create(type: StarType.normal, gridPosition: pos),
          pos,
        );
      }
      return g;
    }

    test('clears stars within radius', () {
      const config = SpecialStarConfig(supernovaRadius: 1);
      const center = GridPosition(2, 2);
      final g = buildGrid([(2, 3), (2, 1), (0, 0)]); // (0,0) is far away
      final targets = SupernovaEffect(config: config).computeTargets(g, center);
      expect(targets.any((p) => p == const GridPosition(2, 3)), isTrue);
      expect(targets.any((p) => p == const GridPosition(0, 0)), isFalse);
    });

    test('does not include placed position in targets', () {
      const config = SpecialStarConfig(supernovaRadius: 2);
      const center = GridPosition(2, 2);
      final g = buildGrid([(2, 2), (2, 3)]);
      final targets = SupernovaEffect(config: config).computeTargets(g, center);
      expect(targets.contains(center), isFalse);
    });

    test('score multiplier >= 2.0', () {
      expect(SupernovaEffect().scoreMultiplier, greaterThanOrEqualTo(2.0));
    });
  });
}
