import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';

abstract interface class LevelRepository {
  /// Returns the [LevelProgress] for a specific [levelId].
  Future<Result<LevelProgress>> getLevelProgress(int levelId);

  /// Returns the [LevelProgress] for every level that has been played.
  Future<Result<List<LevelProgress>>> getAllLevelProgress();

  /// Persists [progress] to the underlying storage.
  Future<Result<void>> saveLevelProgress(LevelProgress progress);

  /// Returns the current 1-indexed level the player is on.
  Future<Result<int>> getCurrentLevel();

  /// Persists [level] as the player's current level.
  Future<Result<void>> setCurrentLevel(int level);
}
