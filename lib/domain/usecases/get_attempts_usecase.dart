import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';

class AttemptInfo {
  const AttemptInfo({
    required this.isPremium,
    required this.attemptsUsed,
    required this.attemptsRemaining,
    required this.dailyLimit,
    required this.todayDate,
  });

  final bool isPremium;
  final int attemptsUsed;
  final int attemptsRemaining;
  final int dailyLimit;
  final String todayDate;

  bool get hasAttemptsRemaining => isPremium || attemptsRemaining > 0;
}

class GetAttemptsUseCase {
  GetAttemptsUseCase({
    required this.dailyAttemptRepository,
    required this.premiumEntitlementRepository,
  });

  final DailyAttemptRepository dailyAttemptRepository;
  final PremiumEntitlementRepository premiumEntitlementRepository;

  Future<AttemptInfo> call() async {
    final todayDate = DateHelper.todayLocalDate();

    final entitlementResult =
        await premiumEntitlementRepository.getEntitlement();
    final isPremium = entitlementResult.when(
      onSuccess: (e) => e.isPremium,
      onFailure: (_) => false,
    );

    final stateResult = await dailyAttemptRepository.getState();
    DailyAttemptState state = stateResult.when(
      onSuccess: (s) => s,
      onFailure: (_) => DailyAttemptState.fresh(todayDate),
    );

    // Auto-reset on new day
    if (state.lastResetDate != todayDate) {
      final resetResult =
          await dailyAttemptRepository.resetForNewDay(todayDate);
      state = resetResult.when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(todayDate),
      );
    }

    final limit = dailyAttemptRepository.config.freeDailyLimit;
    final remaining =
        isPremium ? 999 : (limit - state.attemptsUsed).clamp(0, limit);

    return AttemptInfo(
      isPremium: isPremium,
      attemptsUsed: state.attemptsUsed,
      attemptsRemaining: remaining,
      dailyLimit: limit,
      todayDate: todayDate,
    );
  }
}
