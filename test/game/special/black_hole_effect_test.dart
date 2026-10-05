import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/black_hole_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';

void main() {
  group('BlackHoleEffect', () {
    test('targets stars within configured radius', () {
      const config = SpecialStarConfig(blackHoleRadius: 1);
      var g = BoardGrid();
      const near = GridPosition(1, 1);
      const far = GridPosition(5, 5);
      g = g.placeStar(
        StarModel.create(type: StarType.normal, gridPosition: near),
        near,
      );
      g = g.placeStar(
        StarModel.create(type: StarType.normal, gridPosition: far),
        far,
      );
      const center = GridPosition(1, 0);
      final targets = BlackHoleEffect(config: config).computeTargets(g, center);
      expect(targets.contains(near), isTrue);
      expect(targets.contains(far), isFalse);
    });

    test('score multiplier >= 1.5', () {
      expect(BlackHoleEffect().scoreMultiplier, greaterThanOrEqualTo(1.5));
    });
  });
}
