import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/grid_position.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_state.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('StarModel', () {
    group('StarModel.create()', () {
      test('generates unique IDs on repeated calls', () {
        const pos = GridPosition(0, 0);
        final a = StarModel.create(type: StarType.normal, gridPosition: pos);
        final b = StarModel.create(type: StarType.normal, gridPosition: pos);
        expect(a.id, isNot(equals(b.id)));
      });

      test('state is idle', () {
        const pos = GridPosition(2, 3);
        final star = StarModel.create(type: StarType.normal, gridPosition: pos);
        expect(star.state, equals(StarState.idle));
      });

      test('gridPosition is set to the provided position', () {
        const pos = GridPosition(1, 4);
        final star = StarModel.create(type: StarType.normal, gridPosition: pos);
        expect(star.gridPosition, equals(pos));
      });
    });

    group('StarModel.projectile()', () {
      test('has invalid grid position', () {
        final star = StarModel.projectile(type: StarType.normal);
        expect(star.gridPosition.isValid, isFalse);
        expect(star.gridPosition, equals(GridPosition.invalid()));
      });

      test('state is projectile', () {
        final star = StarModel.projectile(type: StarType.normal);
        expect(star.state, equals(StarState.projectile));
      });
    });

    group('copyWith', () {
      test('preserves unchanged fields', () {
        const pos = GridPosition(3, 2);
        final original = StarModel.create(
          type: StarType.meteor,
          gridPosition: pos,
        );

        final copy = original.copyWith(state: StarState.matched);

        expect(copy.id, equals(original.id));
        expect(copy.type, equals(original.type));
        expect(copy.gridPosition, equals(original.gridPosition));
        expect(copy.collisionRadius, equals(original.collisionRadius));
        // Only state changed
        expect(copy.state, equals(StarState.matched));
      });

      test('can override all fields', () {
        const pos = GridPosition(0, 0);
        final original = StarModel.create(
          type: StarType.normal,
          gridPosition: pos,
        );

        const newPos = GridPosition(5, 5);
        final copy = original.copyWith(
          type: StarType.supernova,
          gridPosition: newPos,
          state: StarState.removing,
          collisionRadius: 30.0,
        );

        expect(copy.type, equals(StarType.supernova));
        expect(copy.gridPosition, equals(newPos));
        expect(copy.state, equals(StarState.removing));
        expect(copy.collisionRadius, equals(30.0));
      });

      test('returns copy equal by id when no fields overridden', () {
        const pos = GridPosition(1, 1);
        final original = StarModel.create(
          type: StarType.normal,
          gridPosition: pos,
        );
        final copy = original.copyWith();
        // Equality is based on id
        expect(copy, equals(original));
      });
    });
  });
}
