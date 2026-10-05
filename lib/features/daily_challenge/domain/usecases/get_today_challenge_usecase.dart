import 'package:star_shooter/core/utils/game_clock.dart';
import 'package:star_shooter/features/daily_challenge/domain/generators/daily_challenge_generator.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/daily_challenge.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';

class TodayChallengeInfo {
  const TodayChallengeInfo({
    required this.challenge,
    required this.todayCompleted,
    required this.streak,
    required this.todayDate,
  });

  final DailyChallenge challenge;
  final bool todayCompleted;
  final StreakState streak;
  final String todayDate;
}

class GetTodayChallengeUseCase {
  const GetTodayChallengeUseCase({
    required this.generator,
    required this.challengeRepository,
    required this.streakRepository,
    required this.clock,
  });

  final DailyChallengeGenerator generator;
  final DailyChallengeRepository challengeRepository;
  final StreakRepository streakRepository;
  final GameClock clock;

  TodayChallengeInfo call() {
    final today = clock.todayLocalDate();
    final challenge = generator.generateForDate(today);
    final completedResult = challengeRepository.getTodayCompleted(today);
    final todayCompleted = completedResult.when(
      onSuccess: (v) => v,
      onFailure: (_) => false,
    );
    final streak = streakRepository.getStreak();
    return TodayChallengeInfo(
      challenge: challenge,
      todayCompleted: todayCompleted,
      streak: streak,
      todayDate: today,
    );
  }
}
