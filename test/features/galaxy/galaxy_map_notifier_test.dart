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
  int highestUnlocked = 1;
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
  group('GalaxyMapNotifier', () {
    _FakeLevelRepository makeRepo({
      int highest = 1,
      List<LevelProgress>? progress,
    }) =>
        _FakeLevelRepository(progress: progress ?? [], highest: highest);

    test('loads successfully and sets highestUnlockedLevel', () async {
      final repo = makeRepo();
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      await notifier.load();
      expect(notifier.loadState, GalaxyLoadState.loaded);
      expect(notifier.highestUnlockedLevel, 1);
    });

    test('level 1 is unlocked, level 2 is not', () async {
      final repo = makeRepo();
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      await notifier.load();
      expect(notifier.isLevelUnlocked(1), isTrue);
      expect(notifier.isLevelUnlocked(2), isFalse);
    });

    test('completed level is marked completed', () async {
      final repo = makeRepo(
        progress: [
          const LevelProgress(
            levelId: 1,
            isCompleted: true,
            stars: 3,
            bestScore: 1000,
          ),
        ],
      );
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      await notifier.load();
      expect(notifier.isLevelCompleted(1), isTrue);
      expect(notifier.isLevelCompleted(2), isFalse);
    });

    test('currentLevelId returns first incomplete unlocked level', () async {
      final repo = makeRepo(
        highest: 2,
        progress: [
          const LevelProgress(
            levelId: 1,
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
      expect(notifier.currentLevelId, 2);
    });

    test('levelsForWorld returns 10 levels for each world', () async {
      final repo = makeRepo();
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      // levelsForWorld delegates to LevelCatalog — no load() required
      for (int w = 1; w <= 5; w++) {
        expect(notifier.levelsForWorld(w).length, 10);
      }
    });

    test('refresh re-loads data', () async {
      final repo = makeRepo();
      final notifier = GalaxyMapNotifier(
        levelRepository: repo,
        worldProgressUseCase: GetWorldProgressUseCase(repo),
      );
      await notifier.load();
      repo.highestUnlocked = 5;
      await notifier.refresh();
      expect(notifier.highestUnlockedLevel, 5);
    });
  });
}
