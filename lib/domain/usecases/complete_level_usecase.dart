import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/game_session.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Finalises a completed [GameSession].
///
/// Steps performed:
/// 1. Load existing [LevelProgress] (or default to empty).
/// 2. Update it when the session yields a better score or star count.
/// 3. Persist the updated [LevelProgress].
/// 4. Add any newly earned stars to the [PlayerProfile] total.
/// 5. Return the final [LevelProgress].
class CompleteLevelUseCase {
  const CompleteLevelUseCase({
    required LevelRepository levelRepository,
    required PlayerRepository playerRepository,
  })  : _levelRepository = levelRepository,
        _playerRepository = playerRepository;

  final LevelRepository _levelRepository;
  final PlayerRepository _playerRepository;

  Future<Result<LevelProgress>> call(GameSession session) async {
    if (!session.isCompleted) {
      return Result.failure(
        const ValidationFailure(
          'GameSession must be completed before calling CompleteLevelUseCase.',
        ),
      );
    }

    // --- 1. Load existing progress ---
    final existingResult =
        await _levelRepository.getLevelProgress(session.levelId);
    final existing = switch (existingResult) {
      Success<LevelProgress>(:final value) => value,
      ResultFailure<LevelProgress>() => LevelProgress.empty(session.levelId),
    };

    // --- 2. Determine if the new session improves on the record ---
    final isBetter = session.score > existing.bestScore ||
        session.starsEarned > existing.stars;

    final updated = isBetter
        ? existing.copyWith(
            isCompleted: true,
            stars: session.starsEarned > existing.stars
                ? session.starsEarned
                : existing.stars,
            bestScore: session.score > existing.bestScore
                ? session.score
                : existing.bestScore,
          )
        : existing.copyWith(isCompleted: true);

    // --- 3. Persist updated level progress ---
    final saveProgressResult =
        await _levelRepository.saveLevelProgress(updated);
    if (saveProgressResult is ResultFailure) {
      return Result.failure(
        (saveProgressResult as ResultFailure<void>).error,
      );
    }

    // --- 4. Update total stars on the player profile ---
    final profileResult = await _playerRepository.getProfile();
    if (profileResult case Success<dynamic>(:final value)) {
      final starDelta =
          isBetter ? (session.starsEarned - existing.stars).clamp(0, 3) : 0;
      if (starDelta > 0) {
        final updatedProfile =
            value.copyWith(totalStars: value.totalStars + starDelta);
        // Best-effort — ignore save failures for profile so the level result
        // is still returned to the caller.
        await _playerRepository.saveProfile(updatedProfile);
      }
    }

    return Result.success(updated);
  }
}
