import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';

class _FakeLevelRepository implements LevelRepository {
  int highestUnlocked;
  final List<LevelProgress> _progress;

  _FakeLevelRepository({List<LevelProgress>? progress, int highest = 1})
      : _progress = progress ?? [],
        highestUnlocked = highest;

  @override
  Future<Result<LevelProgress>> getLevelProgress(int id) async =>
      Result.success(
        _progress.firstWhere(
          (p) => p.levelId == id,
          orElse: () => LevelProgress.empty(id),
        ),
      );

  @override
  Future<Result<List<LevelProgress>>> getAllLevelProgress() async =>
      Result.success(_progress);

  @override
  Future<Result<void>> saveLevelProgress(LevelProgress p) async =>
      Result.success(null);

  @override
  Future<Result<int>> getCurrentLevel() async => Result.success(1);

  @override
  Future<Result<void>> setCurrentLevel(int level) async => Result.success(null);

  @override
  Future<Result<LevelDefinition>> getLevel(int id) async {
    final l = LevelCatalog.getLevelById(id);
    if (l == null) return Result.failure(const NotFoundFailure('not found'));
    return Result.success(l);
  }

  @override
  Future<Result<List<LevelDefinition>>> getLevels(int worldId) async =>
      Result.success(LevelCatalog.getWorld(worldId));

  @override
  Future<Result<LevelDefinition>> getNextLevel() async =>
      Result.success(LevelCatalog.allLevels.first);

  @override
  Future<Result<LevelValidationResult>> validateLevel(int id) async =>
      Result.success(LevelValidationResult.valid());

  @override
  Future<Result<int>> getHighestUnlockedLevel() async =>
      Result.success(highestUnlocked);

  @override
  Future<Result<void>> setHighestUnlockedLevel(int level) async {
    highestUnlocked = level;
    return Result.success(null);
  }
}

void main() {
  group('World progression', () {
    test('world 1 unlocked by default (level 1 unlocked)', () {
      // World 1 has levels 1–10. Level 1 is always unlocked (isUnlocked: true
      // in the catalog definition).
      final world1Levels = LevelCatalog.getWorld(1);
      expect(world1Levels.first.id, 1);
      expect(world1Levels.first.worldMeta?.isUnlocked, isTrue);
    });

    test('world 2 first level is 11', () {
      final world2Levels = LevelCatalog.getWorld(2);
      expect(world2Levels.first.id, 11);
    });

    test('completing level 10 unlocks level 11', () async {
      final repo = _FakeLevelRepository(
        highest: 11,
        progress: [
          for (int i = 1; i <= 10; i++)
            LevelProgress(
              levelId: i,
              isCompleted: true,
              stars: 1,
              bestScore: 500,
            ),
        ],
      );
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      await notifier.load();
      expect(notifier.isLevelUnlocked(11), isTrue);
    });

    test('GetWorldProgressUseCase returns 5 worlds', () async {
      final repo = _FakeLevelRepository();
      final useCase = GetWorldProgressUseCase(repo);
      final result = await useCase.call();
      result.when(
        onSuccess: (worlds) => expect(worlds.length, 5),
        onFailure: (_) => fail('should succeed'),
      );
    });

    test('world progress reflects completed levels', () async {
      // Complete all 10 levels of world 1
      final repo = _FakeLevelRepository(
        highest: 11,
        progress: [
          for (int i = 1; i <= 10; i++)
            LevelProgress(
              levelId: i,
              isCompleted: true,
              stars: 2,
              bestScore: 800,
            ),
        ],
      );
      final useCase = GetWorldProgressUseCase(repo);
      final result = await useCase.call();
      result.when(
        onSuccess: (worlds) {
          final world1 = worlds.firstWhere((w) => w.worldId == 1);
          expect(world1.completedLevels, 10);
          expect(world1.totalStars, 20); // 10 levels x 2 stars
        },
        onFailure: (_) => fail('should succeed'),
      );
    });
  });
}
