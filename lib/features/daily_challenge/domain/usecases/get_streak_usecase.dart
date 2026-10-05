import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';

class GetStreakUseCase {
  const GetStreakUseCase({required this.streakRepository});

  final StreakRepository streakRepository;

  StreakState call() => streakRepository.getStreak();
}
