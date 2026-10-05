import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/usecases/check_daily_attempts_usecase.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Consumes one daily attempt.
///
/// Returns a [Failure] when no attempts remain for today. Automatically
/// resets the counter when a new day has started (delegates to
/// [CheckDailyAttemptsUseCase]).
class UseDailyAttemptUseCase {
  const UseDailyAttemptUseCase({
    required PlayerRepository playerRepository,
    required CheckDailyAttemptsUseCase checkDailyAttemptsUseCase,
  })  : _playerRepository = playerRepository,
        _checkDailyAttemptsUseCase = checkDailyAttemptsUseCase;

  final PlayerRepository _playerRepository;
  final CheckDailyAttemptsUseCase _checkDailyAttemptsUseCase;

  Future<Result<DailyAttempts>> call() async {
    // Fetch (and auto-reset if needed) the current attempts.
    final checkResult = await _checkDailyAttemptsUseCase();
    return switch (checkResult) {
      Failure<DailyAttempts>() => checkResult,
      Success<DailyAttempts>(:final value) => _consume(value),
    };
  }

  Future<Result<DailyAttempts>> _consume(DailyAttempts attempts) async {
    if (!attempts.hasAttemptsLeft) {
      return Failure(
        const ValidationFailure('No daily attempts remaining. Please try again tomorrow.'),
      );
    }

    final updated = attempts.useOne();
    final saveResult = await _playerRepository.saveDailyAttempts(updated);
    return switch (saveResult) {
      Failure<void>(:final error) => Failure(error),
      Success<void>() => Success(updated),
    };
  }
}
