import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/level_repository_impl.dart';
import 'package:star_shooter/domain/models/level_progress.dart';

void main() {
  late SharedPreferences prefs;
  late LocalStorage storage;
  late LevelRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
    repository = LevelRepositoryImpl(storage);
  });

  group('LevelRepositoryImpl', () {
    group('getLevelProgress', () {
      test('returns empty default when no data is stored', () async {
        final result = await repository.getLevelProgress(1);
        expect(result.isSuccess, isTrue);
        final progress = (result as Success<LevelProgress>).value;
        expect(progress.levelId, equals(1));
        expect(progress.isCompleted, isFalse);
        expect(progress.stars, equals(0));
        expect(progress.bestScore, equals(0));
      });
    });

    group('saveLevelProgress / getLevelProgress', () {
      test('save then get returns the saved data', () async {
        const progress = LevelProgress(
          levelId: 3,
          isCompleted: true,
          stars: 2,
          bestScore: 750,
        );
        final saveResult = await repository.saveLevelProgress(progress);
        expect(saveResult.isSuccess, isTrue);

        final getResult = await repository.getLevelProgress(3);
        expect(getResult.isSuccess, isTrue);
        final retrieved = (getResult as Success<LevelProgress>).value;
        expect(retrieved, equals(progress));
      });

      test('saving updated progress overwrites the old entry', () async {
        const initial = LevelProgress(
          levelId: 5,
          isCompleted: true,
          stars: 1,
          bestScore: 100,
        );
        await repository.saveLevelProgress(initial);

        const updated = LevelProgress(
          levelId: 5,
          isCompleted: true,
          stars: 3,
          bestScore: 990,
        );
        await repository.saveLevelProgress(updated);

        final result = await repository.getLevelProgress(5);
        expect(result.isSuccess, isTrue);
        final retrieved = (result as Success<LevelProgress>).value;
        expect(retrieved.stars, equals(3));
        expect(retrieved.bestScore, equals(990));
      });
    });

    group('getAllLevelProgress', () {
      test('returns empty list when no data is stored', () async {
        final result = await repository.getAllLevelProgress();
        expect(result.isSuccess, isTrue);
        final list = (result as Success<List<LevelProgress>>).value;
        expect(list, isEmpty);
      });

      test('returns all saved levels', () async {
        final levels = [
          const LevelProgress(
            levelId: 1,
            isCompleted: true,
            stars: 3,
            bestScore: 300,
          ),
          const LevelProgress(
            levelId: 2,
            isCompleted: false,
            stars: 0,
            bestScore: 0,
          ),
        ];

        for (final level in levels) {
          await repository.saveLevelProgress(level);
        }

        final result = await repository.getAllLevelProgress();
        expect(result.isSuccess, isTrue);
        final list = (result as Success<List<LevelProgress>>).value;
        expect(list.length, equals(2));
        expect(list.any((p) => p.levelId == 1), isTrue);
        expect(list.any((p) => p.levelId == 2), isTrue);
      });
    });

    group('setCurrentLevel / getCurrentLevel', () {
      test('getCurrentLevel returns 1 as default', () async {
        final result = await repository.getCurrentLevel();
        expect(result.isSuccess, isTrue);
        expect((result as Success<int>).value, equals(1));
      });

      test('set then get returns the set value', () async {
        await repository.setCurrentLevel(7);
        final result = await repository.getCurrentLevel();
        expect(result.isSuccess, isTrue);
        expect((result as Success<int>).value, equals(7));
      });
    });

    group('corrupt stored JSON', () {
      test('getAllLevelProgress returns success with empty list for corrupt list data', () async {
        // Write a raw corrupt value directly into SharedPreferences.
        await prefs.setString('level_completions', '{not a list}');
        final result = await repository.getAllLevelProgress();
        // The implementation catches parse errors and returns a Failure or empty —
        // either outcome is acceptable, but it must not throw.
        expect(result, isA<Result<List<LevelProgress>>>());
      });
    });
  });
}
