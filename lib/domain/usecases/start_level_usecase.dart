import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';

enum StartLevelStatus { allowed, dailyLimitReached, error }

class StartLevelResult {
  const StartLevelResult({
    required this.status,
    this.state,
    this.attemptsRemaining,
    this.isPremium = false,
  });

  final StartLevelStatus status;
  final DailyAttemptState? state;
  final int? attemptsRemaining;
  final bool isPremium;

  bool get isAllowed => status == StartLevelStatus.allowed;
}

class StartLevelUseCase {
  StartLevelUseCase({
    required this.dailyAttemptRepository,
    required this.premiumEntitlementRepository,
  });

  final DailyAttemptRepository dailyAttemptRepository;
  final PremiumEntitlementRepository premiumEntitlementRepository;

  // Double-tap guard: prevents concurrent calls from consuming > 1 attempt.
  bool _inProgress = false;

  Future<StartLevelResult> call({required int levelId}) async {
    if (_inProgress) {
      // Return a soft error so the caller doesn't navigate.
      return const StartLevelResult(status: StartLevelStatus.error);
    }
    _inProgress = true;
    try {
      return await _execute(levelId: levelId);
    } finally {
      _inProgress = false;
    }
  }

  Future<StartLevelResult> _execute({required int levelId}) async {
    // 1. Check premium
    final entitlementResult =
        await premiumEntitlementRepository.getEntitlement();
    final isPremium = entitlementResult.when(
      onSuccess: (e) => e.isPremium,
      onFailure: (_) => false,
    );

    if (isPremium) {
      return const StartLevelResult(
        status: StartLevelStatus.allowed,
        isPremium: true,
      );
    }

    // 2. Load / reset daily state
    final todayDate = DateHelper.todayLocalDate();
    final stateResult = await dailyAttemptRepository.getState();
    final currentState = stateResult.when(
      onSuccess: (s) => s,
      onFailure: (_) => DailyAttemptState.fresh(todayDate),
    );

    // Reset if day has changed
    DailyAttemptState workingState = currentState;
    if (currentState.lastResetDate != todayDate) {
      final resetResult =
          await dailyAttemptRepository.resetForNewDay(todayDate);
      workingState = resetResult.when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(todayDate),
      );
    }

    final limit = dailyAttemptRepository.config.freeDailyLimit;

    // 3. Check limit
    if (workingState.attemptsUsed >= limit) {
      return StartLevelResult(
        status: StartLevelStatus.dailyLimitReached,
        state: workingState,
        attemptsRemaining: 0,
        isPremium: false,
      );
    }

    // 4. Consume
    final consumeResult =
        await dailyAttemptRepository.consumeAttempt(todayDate);
    final newState = consumeResult.when(
      onSuccess: (s) => s,
      onFailure: (_) => workingState.copyWith(
        attemptsUsed: workingState.attemptsUsed + 1,
      ),
    );

    final remaining = (limit - newState.attemptsUsed).clamp(0, limit);

    return StartLevelResult(
      status: StartLevelStatus.allowed,
      state: newState,
      attemptsRemaining: remaining,
      isPremium: false,
    );
  }
}
