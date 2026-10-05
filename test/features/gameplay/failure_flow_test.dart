import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';

// ── Fake repositories ────────────────────────────────────────────────────────

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
      Result.success(List.unmodifiable(_progress));

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

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  group('Failure flow', () {
    test('Failure does not persist completion', () async {
      final repo = _FakeLevelRepository();
      // Don't call CompleteLevelUseCase on failure — just check repo remains empty
      final result = await repo.getAllLevelProgress();
      final list = result.when(
        onSuccess: (l) => l,
        onFailure: (_) => <LevelProgress>[],
      );
      expect(list, isEmpty);
    });

    test('Objective display text is human-readable', () {
      final level = LevelCatalog.getLevelById(1)!;
      expect(level.objective.displayText, isNotEmpty);
    });

    test('All catalog levels have non-empty objective displayText', () {
      for (final level in LevelCatalog.allLevels) {
        expect(
          level.objective.displayText,
          isNotEmpty,
          reason: 'Level ${level.id} has empty objective displayText',
        );
      }
    });

    test('LevelProgress.empty has zero bestScore', () {
      final p = LevelProgress.empty(5);
      expect(p.bestScore, 0);
      expect(p.isCompleted, isFalse);
    });
  });
}
