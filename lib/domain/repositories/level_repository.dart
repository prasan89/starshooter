import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';

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

  /// Returns a [LevelDefinition] by ID, or failure if not found.
  Future<Result<LevelDefinition>> getLevel(int id);

  /// Returns all [LevelDefinition]s for a given [worldId].
  Future<Result<List<LevelDefinition>>> getLevels(int worldId);

  /// Returns the next level the player should play.
  Future<Result<LevelDefinition>> getNextLevel();

  /// Validates a level and returns the result.
  Future<Result<LevelValidationResult>> validateLevel(int id);

  /// Returns the highest level ID that has been unlocked.
  Future<Result<int>> getHighestUnlockedLevel();

  /// Persists [levelId] as the highest unlocked level.
  Future<Result<void>> setHighestUnlockedLevel(int levelId);
}
