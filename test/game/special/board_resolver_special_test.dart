import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/services/board_resolver.dart';
import 'package:star_shooter/game/special/black_hole_effect.dart';
import 'package:star_shooter/game/special/frozen_star_effect.dart';
import 'package:star_shooter/game/special/meteor_effect.dart';
import 'package:star_shooter/game/special/rainbow_effect.dart';
import 'package:star_shooter/game/special/special_star_config.dart';
import 'package:star_shooter/game/special/special_star_effect.dart';
import 'package:star_shooter/game/special/supernova_effect.dart';

void main() {
  group('BoardResolver with special stars', () {
    BoardGrid buildGrid(List<(int r, int c, StarType t)> stars) {
      var g = BoardGrid();
      for (final (r, c, t) in stars) {
        final pos = GridPosition(r, c);
        g = g.placeStar(StarModel.create(type: t, gridPosition: pos), pos);
      }
      return g;
    }

    setUpAll(() {
      SpecialStarRegistry.register(MeteorEffect());
      SpecialStarRegistry.register(RainbowEffect());
      SpecialStarRegistry.register(SupernovaEffect());
      SpecialStarRegistry.register(BlackHoleEffect());
      SpecialStarRegistry.register(FrozenStarEffect());
    });

    test('supernova clears nearby stars', () {
      final g = buildGrid([
        (0, 1, StarType.normal),
        (0, 2, StarType.normal),
        // Place supernova at (1,1) — neighbors include (0,0) and (0,1)
      ]);
      const supernovaPos = GridPosition(1, 1);
      var withSupernova = g;
      withSupernova = withSupernova.placeStar(
        StarModel.create(
          type: StarType.supernova,
          gridPosition: supernovaPos,
        ),
        supernovaPos,
      );
      final result = BoardResolver.resolve(
        board: withSupernova,
        placedPos: supernovaPos,
        specialConfig: const SpecialStarConfig(supernovaRadius: 1),
      );
      expect(result.specialEffectTargets, isNotEmpty);
      expect(result.scoreGained, greaterThan(0));
    });

    test('meteor clears column', () {
      const meteorPos = GridPosition(3, 2);
      var g = buildGrid([
        (0, 2, StarType.normal),
        (1, 2, StarType.normal),
      ]);
      g = g.placeStar(
        StarModel.create(
          type: StarType.meteor,
          gridPosition: meteorPos,
        ),
        meteorPos,
      );
      final result = BoardResolver.resolve(
        board: g,
        placedPos: meteorPos,
        specialConfig: const SpecialStarConfig(meteorClearWidth: 1),
      );
      expect(result.specialEffectTargets.any((p) => p.col == 2), isTrue);
    });

    test('special star removal is deterministic', () {
      const supernovaPos = GridPosition(2, 2);
      var g = buildGrid([(0, 2, StarType.normal), (0, 3, StarType.normal)]);
      g = g.placeStar(
        StarModel.create(
          type: StarType.supernova,
          gridPosition: supernovaPos,
        ),
        supernovaPos,
      );
      final r1 = BoardResolver.resolve(board: g, placedPos: supernovaPos);
      final r2 = BoardResolver.resolve(board: g, placedPos: supernovaPos);
      expect(r1.scoreGained, equals(r2.scoreGained));
      expect(
        r1.specialEffectTargets.length,
        equals(r2.specialEffectTargets.length),
      );
    });
  });
}
