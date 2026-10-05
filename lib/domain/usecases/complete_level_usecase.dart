import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/game_session.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/game/level/star_rating_calculator.dart';

/// Finalises a completed [GameSession].
///
/// Steps performed:
/// 1. Load existing [LevelProgress] (or default to empty).
/// 2. Compute star rating using [StarRatingCalculator].
/// 3. Update progress when the session yields a better score, star count,
///    combo, or remaining-shot count.
/// 4. Persist the updated [LevelProgress].
/// 5. Add any newly earned stars to the [PlayerProfile] total.
/// 6. Unlock the next level if needed.
/// 7. Return the final [LevelProgress].
class CompleteLevelUseCase {
  const CompleteLevelUseCase({
    required LevelRepository levelRepository,
    required PlayerRepository playerRepository,
  })  : _levelRepository = levelRepository,
        _playerRepository = playerRepository;

  final LevelRepository _levelRepository;
  final PlayerRepository _playerRepository;

  /// [shotsUsed]  – number of shots fired during this session.
  /// [comboLevel] – highest combo chain reached in this session (default 0).
  Future<Result<LevelProgress>> call(
    GameSession session, {
    int shotsUsed = 0,
    int comboLevel = 0,
  }) async {
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

    // --- 2. Compute star rating ---
    final levelResult = await _levelRepository.getLevel(session.levelId);
    final int computedStars;
    final int shotsRemaining;
    if (levelResult case Success<dynamic>(:final value)) {
      final rating = StarRatingCalculator.calculate(
        level: value,
        score: session.score,
        shotsUsed: shotsUsed,
      );
      computedStars = rating.stars;
      shotsRemaining = value.moveLimit - shotsUsed;
    } else {
      // Fallback: use the stars already on the session if level lookup fails.
      computedStars = session.starsEarned;
      shotsRemaining = 0;
    }

    // Honour the higher of the two star values (session may carry pre-computed
    // stars from the game engine).
    final effectiveStars = computedStars > session.starsEarned
        ? computedStars
        : session.starsEarned;

    // --- 3. Determine best-record updates ---
    final isBetterScore = session.score > existing.bestScore;
    final isBetterStars = effectiveStars > existing.stars;
    final isBetterCombo = comboLevel > existing.bestCombo;
    final isBetterShots = shotsRemaining > existing.bestRemainingShots;
    final isBetter =
        isBetterScore || isBetterStars || isBetterCombo || isBetterShots;

    final updated = existing.copyWith(
      isCompleted: true,
      stars: isBetterStars ? effectiveStars : existing.stars,
      bestScore: isBetterScore ? session.score : existing.bestScore,
      bestCombo: isBetterCombo ? comboLevel : existing.bestCombo,
      bestRemainingShots:
          isBetterShots ? shotsRemaining : existing.bestRemainingShots,
      attemptCount: existing.attemptCount + 1,
    );

    // --- 4. Persist updated level progress ---
    final saveProgressResult =
        await _levelRepository.saveLevelProgress(updated);
    if (saveProgressResult is ResultFailure) {
      return Result.failure(
        (saveProgressResult as ResultFailure<void>).error,
      );
    }

    // --- 5. Update total stars on the player profile ---
    final profileResult = await _playerRepository.getProfile();
    if (profileResult case Success<dynamic>(:final value)) {
      final starDelta =
          isBetter ? (effectiveStars - existing.stars).clamp(0, 3) : 0;
      if (starDelta > 0) {
        final updatedProfile =
            value.copyWith(totalStars: value.totalStars + starDelta);
        // Best-effort — ignore save failures for profile so the level result
        // is still returned to the caller.
        await _playerRepository.saveProfile(updatedProfile);
      }
    }

    // --- 6. Unlock next level if this is the furthest progress ---
    final highestResult = await _levelRepository.getHighestUnlockedLevel();
    final highestUnlocked = highestResult.when(
      onSuccess: (v) => v,
      onFailure: (_) => 1,
    );
    final nextLevelId = session.levelId + 1;
    if (nextLevelId > highestUnlocked) {
      // Best-effort — ignore failures so the level result is still returned.
      await _levelRepository.setHighestUnlockedLevel(nextLevelId);
    }

    return Result.success(updated);
  }
}
