import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/game/level/level_catalog.dart';

/// Unlocks the next level after a player completes the current one.
///
/// Steps performed:
/// 1. Verify the next level exists in [LevelCatalog].
/// 2. Update [LevelRepository.setHighestUnlockedLevel] when [nextId] exceeds the
///    current highest.
/// 3. Advance [PlayerProfile.currentLevel] when [nextId] exceeds the stored
///    value.
class UnlockNextLevelUseCase {
  const UnlockNextLevelUseCase(
    this._levelRepository,
    this._playerRepository,
  );

  final LevelRepository _levelRepository;
  final PlayerRepository _playerRepository;

  Future<Result<void>> call(int completedLevelId) async {
    final nextId = completedLevelId + 1;

    // Check the next level exists in the catalog — if not, we are at the end.
    final nextLevel = LevelCatalog.getLevelById(nextId);
    if (nextLevel == null) return Result.success(null);

    // Update highest unlocked level if the next level is further ahead.
    final currentHighest = await _levelRepository.getHighestUnlockedLevel();
    final highest =
        currentHighest.when(onSuccess: (v) => v, onFailure: (_) => 1);
    if (nextId > highest) {
      await _levelRepository.setHighestUnlockedLevel(nextId);
    }

    // Advance the player profile's currentLevel when appropriate.
    final profileResult = await _playerRepository.getProfile();
    await profileResult.when(
      onSuccess: (profile) async {
        if (nextId > profile.currentLevel) {
          await _playerRepository.saveProfile(
            profile.copyWith(currentLevel: nextId),
          );
        }
      },
      onFailure: (_) async {},
    );

    return Result.success(null);
  }
}
