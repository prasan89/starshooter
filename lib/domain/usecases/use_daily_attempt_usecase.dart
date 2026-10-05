import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/usecases/check_daily_attempts_usecase.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Consumes one daily attempt.
///
/// Returns a [ResultFailure] when no attempts remain for today. Automatically
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
    final checkResult = await _checkDailyAttemptsUseCase();
    return switch (checkResult) {
      ResultFailure<DailyAttempts>() => checkResult,
      Success<DailyAttempts>(:final value) => await _consume(value),
    };
  }

  Future<Result<DailyAttempts>> _consume(DailyAttempts attempts) async {
    if (!attempts.hasAttemptsLeft) {
      return Result.failure(
        const ValidationFailure(
          'No daily attempts remaining. Please try again tomorrow.',
        ),
      );
    }

    final updated = attempts.useOne();
    final saveResult = await _playerRepository.saveDailyAttempts(updated);
    return switch (saveResult) {
      ResultFailure<void>(:final error) => Result.failure(error),
      Success<void>() => Result.success(updated),
    };
  }
}
