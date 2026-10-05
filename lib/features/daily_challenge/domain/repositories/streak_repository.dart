import 'package:star_shooter/features/daily_challenge/domain/models/streak_state.dart';

abstract interface class StreakRepository {
  StreakState getStreak();
  Future<void> saveStreak(StreakState state);
}
