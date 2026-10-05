import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Returns the player's [DailyAttempts] for today.
///
/// If the stored [DailyAttempts.lastResetDate] is before today (UTC) the
/// attempts are automatically reset and the reset record is persisted before
/// being returned.
class CheckDailyAttemptsUseCase {
  const CheckDailyAttemptsUseCase(this._playerRepository);

  final PlayerRepository _playerRepository;

  Future<Result<DailyAttempts>> call() async {
    final result = await _playerRepository.getDailyAttempts();
    return switch (result) {
      ResultFailure<DailyAttempts>() => result,
      Success<DailyAttempts>(:final value) => await _maybeReset(value),
    };
  }

  Future<Result<DailyAttempts>> _maybeReset(DailyAttempts attempts) async {
    final now = DateTime.now().toUtc();
    final lastReset = attempts.lastResetDate.toUtc();

    final isNewDay = now.year != lastReset.year ||
        now.month != lastReset.month ||
        now.day != lastReset.day;

    if (!isNewDay) {
      return Result.success(attempts);
    }

    final reset = attempts.reset();
    final saveResult = await _playerRepository.saveDailyAttempts(reset);
    return switch (saveResult) {
      ResultFailure<void>(:final error) => Result.failure(error),
      Success<void>() => Result.success(reset),
    };
  }
}
