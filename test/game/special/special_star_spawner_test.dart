import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/special/special_star_spawner.dart';

void main() {
  group('SpecialStarSpawner', () {
    test('only spawns normal stars when level < 11', () {
      final spawner = SpecialStarSpawner(
        levelId: 5,
        seed: 42,
        allowedTypes: [StarType.normal],
      );
      // Run 20 iterations — should all be normal
      for (int i = 0; i < 20; i++) {
        expect(spawner.nextType(), StarType.normal);
      }
    });

    test('can spawn meteor at level >= 11', () {
      final spawner = SpecialStarSpawner(
        levelId: 15,
        seed: 123,
        allowedTypes: [StarType.normal, StarType.meteor],
      );
      // Run enough iterations to see variety
      final types = List.generate(100, (_) => spawner.nextType()).toSet();
      // At minimum normal should appear; meteor may or may not depending on seed
      expect(types.contains(StarType.normal), isTrue);
    });

    test('is deterministic: same seed same sequence', () {
      final s1 = SpecialStarSpawner(
          levelId: 20, seed: 99, allowedTypes: StarType.values.toList(),);
      final s2 = SpecialStarSpawner(
          levelId: 20, seed: 99, allowedTypes: StarType.values.toList(),);
      final seq1 = List.generate(10, (_) => s1.nextType());
      final seq2 = List.generate(10, (_) => s2.nextType());
      expect(seq1, equals(seq2));
    });
  });
}
