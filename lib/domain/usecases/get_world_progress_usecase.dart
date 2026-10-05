import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/game/level/level_catalog.dart';

/// Aggregated progress for a single world.
class WorldProgress {
  const WorldProgress({
    required this.worldId,
    required this.worldName,
    required this.totalLevels,
    required this.completedLevels,
    required this.totalStars,
    required this.maxStars,
    required this.isUnlocked,
  });

  final int worldId;
  final String worldName;
  final int totalLevels;
  final int completedLevels;
  final int totalStars;
  final int maxStars;
  final bool isUnlocked;

  /// Fraction of levels completed (0.0–1.0).
  double get completionFraction =>
      totalLevels > 0 ? completedLevels / totalLevels : 0.0;
}

/// Returns the aggregated [WorldProgress] for every world in [LevelCatalog].
///
/// Worlds with no catalog entries are omitted from the result.
class GetWorldProgressUseCase {
  const GetWorldProgressUseCase(this._levelRepo);

  final LevelRepository _levelRepo;

  Future<Result<List<WorldProgress>>> call() async {
    // Load all persisted progress records into a map keyed by levelId.
    final allProgressResult = await _levelRepo.getAllLevelProgress();
    final allProgress = allProgressResult.when(
      onSuccess: (list) => {for (final p in list) p.levelId: p},
      onFailure: (_) => <int, LevelProgress>{},
    );

    // Determine the furthest level the player has unlocked.
    final highestResult = await _levelRepo.getHighestUnlockedLevel();
    final highest =
        highestResult.when(onSuccess: (v) => v, onFailure: (_) => 1);

    const worldIds = [1, 2, 3, 4, 5];
    final result = <WorldProgress>[];

    for (final worldId in worldIds) {
      final worldLevels = LevelCatalog.getWorld(worldId);
      if (worldLevels.isEmpty) continue;

      // The world is unlocked when the player has reached (or passed) its first
      // level ID.
      final firstLevelId = worldLevels.first.id;
      final isUnlocked = highest >= firstLevelId;

      var completed = 0;
      var stars = 0;
      for (final level in worldLevels) {
        final progress = allProgress[level.id];
        if (progress != null && progress.isCompleted) {
          completed++;
          stars += progress.stars;
        }
      }

      final worldName =
          worldLevels.first.worldMeta?.worldName ?? 'World $worldId';
      result.add(
        WorldProgress(
          worldId: worldId,
          worldName: worldName,
          totalLevels: worldLevels.length,
          completedLevels: completed,
          totalStars: stars,
          maxStars: worldLevels.length * 3,
          isUnlocked: isUnlocked,
        ),
      );
    }

    return Result.success(result);
  }
}
