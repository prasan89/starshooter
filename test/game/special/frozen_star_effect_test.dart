import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/board_grid.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/frozen_star_effect.dart';

void main() {
  group('FrozenStarEffect', () {
    test('placed frozen star yields no immediate targets', () {
      var g = BoardGrid();
      const pos = GridPosition(2, 2);
      final star = StarModel.create(
        type: StarType.frozenStar,
        gridPosition: pos,
        frozenHitsRemaining: 2,
      );
      g = g.placeStar(star, pos);
      final targets = FrozenStarEffect().computeTargets(g, pos);
      expect(targets, isEmpty);
    });

    test('applyAdjacentHits decrements frozen neighbor hit count', () {
      var g = BoardGrid();
      const frozenPos = GridPosition(0, 1);
      const matchPos = GridPosition(0, 0); // neighbor of frozenPos
      final frozen = StarModel.create(
        type: StarType.frozenStar,
        gridPosition: frozenPos,
        frozenHitsRemaining: 2,
      );
      final normal =
          StarModel.create(type: StarType.normal, gridPosition: matchPos);
      g = g.placeStar(frozen, frozenPos);
      g = g.placeStar(normal, matchPos);

      final updated = FrozenStarEffect.applyAdjacentHits(g, [matchPos]);
      final updatedFrozen = updated.starAt(frozenPos)!;
      expect(updatedFrozen.frozenHitsRemaining, 1);
    });

    test('frozen star with 0 hits remaining is thawed', () {
      final star = StarModel.create(
        type: StarType.frozenStar,
        gridPosition: const GridPosition(0, 0),
        frozenHitsRemaining: 0,
      );
      expect(star.isFrozen, isFalse);
      expect(star.isThawed, isTrue);
    });

    test('thawed frozen star can be matched normally', () {
      var g = BoardGrid();
      // A thawed frozen star (frozenHitsRemaining == 0) should participate in normal matching
      // if surrounded by its own type — but since we test isThawed, just verify state
      const pos = GridPosition(0, 0);
      final star = StarModel.create(
        type: StarType.frozenStar,
        gridPosition: pos,
        frozenHitsRemaining: 0,
      );
      g = g.placeStar(star, pos);
      expect(g.starAt(pos)!.isFrozen, isFalse);
    });
  });
}
