import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_validator.dart';

void main() {
  group('LevelCatalog', () {
    test('has exactly 50 levels', () {
      expect(LevelCatalog.allLevels.length, 50);
    });

    test('level IDs are 1–50', () {
      final ids = LevelCatalog.allLevels.map((l) => l.id).toList();
      for (int i = 1; i <= 50; i++) {
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

    test('all 50 levels pass validation', () {
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

    test('world 1 has levels 1–10', () {
      final w1 = LevelCatalog.getWorld(1);
      expect(w1.length, 10);
      expect(w1.first.id, 1);
      expect(w1.last.id, 10);
    });

    test('world 5 has levels 41–50', () {
      final w5 = LevelCatalog.getWorld(5);
      expect(w5.length, 10);
      expect(w5.first.id, 41);
      expect(w5.last.id, 50);
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
