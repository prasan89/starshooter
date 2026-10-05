import 'dart:developer' as dev;

import 'package:star_shooter/core/constants/storage_keys.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';

/// Local-storage-backed implementation of [LevelRepository].
///
/// All level progress records are stored as a JSON list under
/// [kKeyLevelCompletions].  The current level index is stored separately under
/// [kKeyCurrentLevel].  Corrupt or missing data is handled gracefully by
/// returning safe defaults rather than propagating exceptions.
class LevelRepositoryImpl implements LevelRepository {
  LevelRepositoryImpl(this._storage);

  final LocalStorage _storage;

  // ---------------------------------------------------------------------------
  // Level progress list
  // ---------------------------------------------------------------------------

  @override
  Future<Result<List<LevelProgress>>> getAllLevelProgress() async {
    try {
      final rawList = _storage.getJsonList(kKeyLevelCompletions);
      if (rawList == null) return Result.success(const []);

      final progress = <LevelProgress>[];
      for (final item in rawList) {
        try {
          progress.add(LevelProgress.fromJson(item));
        } catch (e) {
          // Skip corrupt entries — log and continue with what we can parse.
          dev.log(
            'LevelRepositoryImpl: skipping corrupt entry: $item',
            error: e,
          );
        }
      }
      return Result.success(progress);
    } catch (e, st) {
      dev.log(
        'LevelRepositoryImpl.getAllLevelProgress failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to load level progress: $e'),
      );
    }
  }

  @override
  Future<Result<LevelProgress>> getLevelProgress(int levelId) async {
    final allResult = await getAllLevelProgress();
    return allResult.when(
      onSuccess: (list) {
        try {
          return Result.success(
            list.firstWhere(
              (p) => p.levelId == levelId,
              orElse: () => LevelProgress.empty(levelId),
            ),
          );
        } catch (e, st) {
          dev.log(
            'LevelRepositoryImpl.getLevelProgress($levelId) failed',
            error: e,
            stackTrace: st,
          );
          return Result.failure(
            StorageFailure('Failed to retrieve level $levelId: $e'),
          );
        }
      },
      onFailure: Result.failure,
    );
  }

  @override
  Future<Result<void>> saveLevelProgress(LevelProgress progress) async {
    try {
      // Load existing list, update or insert the entry for this level.
      final allResult = await getAllLevelProgress();
      final existing = allResult.when(
        onSuccess: (list) => list,
        onFailure: (_) => <LevelProgress>[],
      );

      final updated = [
        for (final p in existing)
          if (p.levelId == progress.levelId) progress else p,
        if (!existing.any((p) => p.levelId == progress.levelId)) progress,
      ];

      final jsonList = updated.map((p) => p.toJson()).toList();
      final ok = await _storage.setJsonList(kKeyLevelCompletions, jsonList);
      if (!ok) {
        return Result.failure(
          const StorageFailure('setJsonList returned false for level progress'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'LevelRepositoryImpl.saveLevelProgress failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to save level progress: $e'),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Current level
  // ---------------------------------------------------------------------------

  @override
  Future<Result<int>> getCurrentLevel() async {
    try {
      final value = _storage.getInt(kKeyCurrentLevel);
      return Result.success(value ?? 1);
    } catch (e, st) {
      dev.log(
        'LevelRepositoryImpl.getCurrentLevel failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to read current level: $e'),
      );
    }
  }

  @override
  Future<Result<void>> setCurrentLevel(int level) async {
    try {
      final ok = await _storage.setInt(kKeyCurrentLevel, level);
      if (!ok) {
        return Result.failure(
          const StorageFailure('setInt returned false for current level'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'LevelRepositoryImpl.setCurrentLevel failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to save current level: $e'),
      );
    }
  }
}
