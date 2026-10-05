import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_validator.dart';

void main() {
  group('LevelCatalog', () {
    test('has exactly 200 levels (M12)', () {
      expect(LevelCatalog.allLevels.length, 200);
    });

    test('level IDs are 1–200', () {
      final ids = LevelCatalog.allLevels.map((l) => l.id).toSet();
      for (int i = 1; i <= 200; i++) {
        expect(ids.contains(i), isTrue, reason: 'Missing level $i');
      }
    });

    test('getLevelById finds correct level', () {
      final level = LevelCatalog.getLevelById(1);
      expect(level, isNotNull);
      expect(level!.id, 1);
    });

    test('getLevelById returns null for missing level', () {
      expect(LevelCatalog.getLevelById(999), isNull);
    });

    test('all levels pass validation', () {
      final failures = <String>[];
      for (final level in LevelCatalog.allLevels) {
        final result = LevelValidator.validate(level);
        if (!result.isValid) {
          failures.add(
            'Level ${level.id}: ${result.issues.map((i) => i.code).join(', ')}',
          );
        }
      }
      expect(
        failures,
        isEmpty,
        reason: 'Validation failures:\n${failures.join('\n')}',
      );
    });

    // M12 world structure: 5 worlds × 40 levels
    test('world 1 (Nebula Nursery) has levels 1–40', () {
      final w1 = LevelCatalog.getWorld(1);
      expect(w1.length, 40);
      expect(w1.first.id, 1);
      expect(w1.last.id, 40);
    });

    test('world 5 (Frozen Nebula) has levels 161–200', () {
      final w5 = LevelCatalog.getWorld(5);
      expect(w5.length, 40);
      expect(w5.first.id, 161);
      expect(w5.last.id, 200);
    });

    test('levels are ordered by id', () {
      final ids = LevelCatalog.allLevels.map((l) => l.id).toList();
      for (int i = 0; i < ids.length - 1; i++) {
        expect(ids[i] < ids[i + 1], isTrue);
      }
    });

    test('no level has empty availableStarTypes', () {
      for (final level in LevelCatalog.allLevels) {
        expect(
          level.availableStarTypes,
          isNotEmpty,
          reason: 'Level ${level.id} has no star types',
        );
      }
    });
  });
}
