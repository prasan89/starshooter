import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';

abstract interface class DailyAttemptRepository {
  /// Load persisted state, resetting if the stored date != today.
  Future<Result<DailyAttemptState>> getState();

  /// Atomically increment attemptsUsed and persist.
  Future<Result<DailyAttemptState>> consumeAttempt(String todayDate);

  /// Reset to 0 used for the given date and persist.
  Future<Result<DailyAttemptState>> resetForNewDay(String todayDate);

  /// Return the config (limit).
  DailyAttemptConfig get config;
}
