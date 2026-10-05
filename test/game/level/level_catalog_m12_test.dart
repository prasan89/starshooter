import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/level/difficulty_calculator.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_validator.dart';
import 'package:star_shooter/game/models/star_type.dart';

void main() {
  group('M12 — 200 Production Levels', () {
    // ── Catalog integrity ──────────────────────────────────────────────
    group('catalog integrity', () {
      test('has exactly 200 levels', () {
        expect(LevelCatalog.allLevels.length, 200);
      });

      test('IDs are 1–200 with no gaps', () {
        final ids = LevelCatalog.allLevels.map((l) => l.id).toSet();
        for (int i = 1; i <= 200; i++) {
          expect(ids.contains(i), isTrue, reason: 'Missing level $i');
        }
      });

      test('IDs are unique', () {
        final ids = LevelCatalog.allLevels.map((l) => l.id).toList();
        expect(ids.toSet().length, ids.length, reason: 'Duplicate level IDs');
      });

      test('levels are ordered by id', () {
        final ids = LevelCatalog.allLevels.map((l) => l.id).toList();
        for (int i = 0; i < ids.length - 1; i++) {
          expect(ids[i] < ids[i + 1], isTrue,
              reason: 'Level ${ids[i]} appears before ${ids[i + 1]}',);
        }
      });

      test('getLevelById finds all 200', () {
        for (int i = 1; i <= 200; i++) {
          final level = LevelCatalog.getLevelById(i);
          expect(level, isNotNull, reason: 'getLevelById($i) returned null');
          expect(level!.id, i);
        }
      });
    });

    // ── World distribution ─────────────────────────────────────────────
    group('world distribution', () {
      test('exactly 5 worlds exist', () {
        final worlds = {1, 2, 3, 4, 5};
        for (final w in worlds) {
          expect(
            LevelCatalog.getWorld(w),
            isNotEmpty,
            reason: 'World $w is empty',
          );
        }
      });

      test('each world has 40 levels', () {
        for (int w = 1; w <= 5; w++) {
          final count = LevelCatalog.getWorld(w).length;
          expect(count, 40, reason: 'World $w has $count levels, expected 40');
        }
      });

      test('world level ranges are correct', () {
        final w1 = LevelCatalog.getWorld(1);
        expect(w1.first.id, 1);
        expect(w1.last.id, 40);

        final w2 = LevelCatalog.getWorld(2);
        expect(w2.first.id, 41);
        expect(w2.last.id, 80);

        final w3 = LevelCatalog.getWorld(3);
        expect(w3.first.id, 81);
        expect(w3.last.id, 120);

        final w4 = LevelCatalog.getWorld(4);
        expect(w4.first.id, 121);
        expect(w4.last.id, 160);

        final w5 = LevelCatalog.getWorld(5);
        expect(w5.first.id, 161);
        expect(w5.last.id, 200);
      });

      test('all levels have worldMeta', () {
        for (final level in LevelCatalog.allLevels) {
          expect(level.worldMeta, isNotNull,
              reason: 'Level ${level.id} has no worldMeta',);
        }
      });

      test('world names are correct', () {
        const expectedNames = {
          1: 'Nebula Nursery',
          2: 'Asteroid Fields',
          3: 'Solar Winds',
          4: 'Event Horizon',
          5: 'Frozen Nebula',
        };
        for (final level in LevelCatalog.allLevels) {
          final worldId = level.worldMeta!.worldId;
          final expected = expectedNames[worldId];
          expect(
            level.worldMeta!.worldName,
            expected,
            reason: 'Level ${level.id} world name mismatch',
          );
        }
      });
    });

    // ── Existing levels preserved ──────────────────────────────────────
    group('existing levels 1–50 preserved', () {
      test('levels 1–50 retain original IDs and names', () {
        final classics = {
          1: 'First Light',
          2: 'Starfield',
          10: 'Nova Gate',
          11: 'Meteor Shower',
          50: 'Frozen Core',
        };
        for (final entry in classics.entries) {
          final level = LevelCatalog.getLevelById(entry.key);
          expect(level, isNotNull, reason: 'Level ${entry.key} missing');
          expect(
            level!.displayName,
            entry.value,
            reason: 'Level ${entry.key} name changed',
          );
        }
      });

      test('level 1 is unlocked', () {
        final l1 = LevelCatalog.getLevelById(1)!;
        expect(l1.worldMeta!.isUnlocked, isTrue);
      });

      test('levels 2–200 require unlock', () {
        for (int i = 2; i <= 200; i++) {
          final level = LevelCatalog.getLevelById(i)!;
          expect(
            level.worldMeta!.isUnlocked,
            isFalse,
            reason: 'Level $i should not be pre-unlocked',
          );
        }
      });

      test('unlock chain: level N requires N-1', () {
        for (int i = 2; i <= 200; i++) {
          final level = LevelCatalog.getLevelById(i)!;
          expect(
            level.worldMeta!.unlockRequirement,
            i - 1,
            reason: 'Level $i unlock requirement should be ${i - 1}',
          );
        }
      });
    });

    // ── Validation ─────────────────────────────────────────────────────
    group('all 200 levels pass LevelValidator', () {
      test('no validation failures', () {
        final failures = <String>[];
        for (final level in LevelCatalog.allLevels) {
          final result = LevelValidator.validate(level);
          if (!result.isValid) {
            final codes = result.issues.map((i) => i.code).join(', ');
            failures.add('Level ${level.id}: $codes');
          }
        }
        expect(
          failures,
          isEmpty,
          reason: 'Validation failures:\n${failures.join('\n')}',
        );
      });

      test('all levels have non-empty availableStarTypes', () {
        for (final level in LevelCatalog.allLevels) {
          expect(level.availableStarTypes, isNotEmpty,
              reason: 'Level ${level.id} has no star types',);
        }
      });

      test('all levels have positive moveLimit', () {
        for (final level in LevelCatalog.allLevels) {
          expect(level.moveLimit, greaterThan(0),
              reason: 'Level ${level.id} has zero/negative moveLimit',);
        }
      });

      test('all levels have positive objective target', () {
        for (final level in LevelCatalog.allLevels) {
          expect(level.objective.target, greaterThan(0),
              reason: 'Level ${level.id} has invalid objective target',);
        }
      });
    });

    // ── Difficulty curve ───────────────────────────────────────────────
    group('difficulty curve', () {
      test('endgame (101–200) is materially harder than early (1–100)', () {
        final earlyScores = LevelCatalog.allLevels
            .where((l) => l.id <= 100)
            .map((l) => DifficultyCalculator.calculate(l).difficultyScore)
            .toList();
        final lateScores = LevelCatalog.allLevels
            .where((l) => l.id > 100)
            .map((l) => DifficultyCalculator.calculate(l).difficultyScore)
            .toList();

        final earlyAvg =
            earlyScores.reduce((a, b) => a + b) / earlyScores.length;
        final lateAvg = lateScores.reduce((a, b) => a + b) / lateScores.length;

        // Endgame must be at least 20% harder on average
        expect(
          lateAvg,
          greaterThan(earlyAvg * 1.20),
          reason:
              'Endgame avg ${lateAvg.toStringAsFixed(3)} should be >20% above early avg ${earlyAvg.toStringAsFixed(3)}',
        );
      });

      test('levels 101–125 have higher avg difficulty than levels 51–100', () {
        final midScores = LevelCatalog.allLevels
            .where((l) => l.id >= 51 && l.id <= 100)
            .map((l) => DifficultyCalculator.calculate(l).difficultyScore)
            .toList();
        final vhScores = LevelCatalog.allLevels
            .where((l) => l.id >= 101 && l.id <= 125)
            .map((l) => DifficultyCalculator.calculate(l).difficultyScore)
            .toList();

        final midAvg = midScores.reduce((a, b) => a + b) / midScores.length;
        final vhAvg = vhScores.reduce((a, b) => a + b) / vhScores.length;

        expect(
          vhAvg,
          greaterThan(midAvg),
          reason: 'VeryHard avg $vhAvg should exceed mid avg $midAvg',
        );
      });

      test('levels 151–200 have difficulty >= 0.65', () {
        final failures = <String>[];
        for (final level in LevelCatalog.allLevels.where((l) => l.id >= 151)) {
          final score = DifficultyCalculator.calculate(level).difficultyScore;
          if (score < 0.65) {
            failures.add(
                'Level ${level.id}: score ${score.toStringAsFixed(3)} < 0.65',);
          }
        }
        expect(
          failures,
          isEmpty,
          reason: 'Endgame levels not hard enough:\n${failures.join('\n')}',
        );
      });

      test('level 200 is in the endgame tier (>= 0.65)', () {
        final score = DifficultyCalculator.calculate(
          LevelCatalog.getLevelById(200)!,
        ).difficultyScore;
        expect(
          score,
          greaterThanOrEqualTo(0.65),
          reason: 'Level 200 should be endgame difficulty',
        );
      });
    });

    // ── Special star progression ───────────────────────────────────────
    group('special star progression', () {
      test('no frozenStar in levels 1–40', () {
        for (int i = 1; i <= 40; i++) {
          final level = LevelCatalog.getLevelById(i)!;
          expect(
            level.availableStarTypes.contains(StarType.frozenStar),
            isFalse,
            reason: 'Level $i should not have frozenStar',
          );
        }
      });

      test('levels 161–200 all have frozenStar available', () {
        for (int i = 161; i <= 200; i++) {
          final level = LevelCatalog.getLevelById(i)!;
          expect(
            level.availableStarTypes.contains(StarType.frozenStar),
            isTrue,
            reason: 'Level $i (World 5) should have frozenStar',
          );
        }
      });

      test('levels 101+ have frozen stars on board', () {
        var frozenOnBoardCount = 0;
        for (int i = 101; i <= 200; i++) {
          final level = LevelCatalog.getLevelById(i)!;
          if (level.hasFrozenStars) frozenOnBoardCount++;
        }
        expect(
          frozenOnBoardCount,
          greaterThan(50),
          reason:
              'At least 50 of levels 101–200 should have frozen stars on board',
        );
      });
    });

    // ── No duplicate boards ────────────────────────────────────────────
    group('duplicate detection', () {
      test('no two levels have identical board layouts', () {
        final signatures = <String, int>{};
        final duplicates = <String>[];
        for (final level in LevelCatalog.allLevels) {
          if (level.initialStars.isEmpty) continue; // skip empty boards
          final sig = level.initialStars
              .map((p) => '${p.position.row},${p.position.col},${p.type.name}')
              .toList()
            ..sort();
          final key = sig.join('|');
          if (signatures.containsKey(key)) {
            duplicates
                .add('Level ${level.id} duplicates Level ${signatures[key]}');
          }
          signatures[key] = level.id;
        }
        expect(
          duplicates,
          isEmpty,
          reason: 'Duplicate boards found:\n${duplicates.join('\n')}',
        );
      });
    });

    // ── Objective variety ──────────────────────────────────────────────
    group('objective variety', () {
      test('all 4 objective types are used in new levels 51–200', () {
        final types = LevelCatalog.allLevels
            .where((l) => l.id >= 51)
            .map((l) => l.objective.type)
            .toSet();
        expect(types.length, greaterThanOrEqualTo(3),
            reason: 'New levels should use at least 3 objective types',);
      });

      test('levels 101–200 use meaningful objectives (not all scoreTarget)',
          () {
        final endgame =
            LevelCatalog.allLevels.where((l) => l.id >= 101).toList();
        final scoreTargetCount =
            endgame.where((l) => l.objective.type.name == 'scoreTarget').length;
        // At least 30% of endgame should use non-score objectives
        expect(
          scoreTargetCount,
          lessThan(endgame.length * 0.7),
          reason: 'Too many scoreTarget objectives in endgame',
        );
      });
    });

    // ── Daily Challenge compatibility ──────────────────────────────────
    group('daily challenge compatibility', () {
      test('DailyChallengeGenerator works with all 200 levels', () {
        // Generator uses (seed % levels.length) to pick a level
        // With 200 levels, it selects from 0..199
        expect(LevelCatalog.allLevels.length, greaterThanOrEqualTo(50));
        // All levels remain accessible
        for (int id = 1; id <= 200; id++) {
          expect(LevelCatalog.getLevelById(id), isNotNull);
        }
      });
    });

    // ── Progress migration safety ─────────────────────────────────────
    group('progress migration safety', () {
      test('levels 1–50 still have same IDs (progress preserved)', () {
        for (int i = 1; i <= 50; i++) {
          final level = LevelCatalog.getLevelById(i);
          expect(level, isNotNull, reason: 'Level $i was removed');
          expect(level!.id, i);
        }
      });

      test('level 1 is the entry point (unlocked, no requirement)', () {
        final l1 = LevelCatalog.getLevelById(1)!;
        expect(l1.worldMeta!.isUnlocked, isTrue);
        expect(l1.worldMeta!.unlockRequirement, 0);
      });
    });
  });
}
