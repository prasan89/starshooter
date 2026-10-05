import 'package:star_shooter/core/utils/game_clock.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/challenge_history_entry.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';

class CompleteDailyChallengeUseCase {
  const CompleteDailyChallengeUseCase({
    required this.challengeRepository,
    required this.streakRepository,
    required this.clock,
  });

  final DailyChallengeRepository challengeRepository;
  final StreakRepository streakRepository;
  final GameClock clock;

  /// Call after successful challenge gameplay.
  /// [alreadyCompleted] flag prevents double-counting.
  Future<StreakState> call({
    required DailyChallenge challenge,
    required int score,
    required int stars,
    required bool alreadyCompleted,
  }) async {
    final today = clock.todayLocalDate();
    final currentStreak = streakRepository.getStreak();

    // Persist history entry regardless (for score tracking / replay)
    await challengeRepository.saveHistoryEntry(
      ChallengeHistoryEntry(
        date: today,
        levelId: challenge.levelId,
        completed: true,
        score: score,
        stars: stars,
      ),
    );

    // Idempotency: if already completed today, skip streak update
    if (alreadyCompleted) return currentStreak;

    // Mark today complete
    await challengeRepository.markTodayCompleted(today);

    // Compute new streak
    final newStreak = _computeStreak(
      current: currentStreak,
      today: today,
    );
    await streakRepository.saveStreak(newStreak);
    return newStreak;
  }

  static StreakState _computeStreak({
    required StreakState current,
    required String today,
  }) {
    final yesterday = _yesterday(today);
    int newCurrent;
    if (current.lastCompletedDate == yesterday) {
      // Consecutive day — extend streak
      newCurrent = current.currentStreak + 1;
    } else if (current.lastCompletedDate == today) {
      // Already counted today (shouldn't happen due to alreadyCompleted guard,
      // but be safe)
      newCurrent = current.currentStreak;
    } else {
      // Missed one or more days — reset to 1
      newCurrent = 1;
    }
    final newLongest =
        newCurrent > current.longestStreak ? newCurrent : current.longestStreak;
    return current.copyWith(
      currentStreak: newCurrent,
      longestStreak: newLongest,
      lastCompletedDate: today,
      totalDaysCompleted: current.totalDaysCompleted + 1,
    );
  }

  static String _yesterday(String today) {
    try {
      final parts = today.split('-');
      final dt = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      ).subtract(const Duration(days: 1));
      return '${dt.year.toString().padLeft(4, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}
