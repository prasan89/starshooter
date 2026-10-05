import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';
import 'package:star_shooter/domain/usecases/start_level_usecase.dart';

class _FakeDailyAttemptRepository implements DailyAttemptRepository {
  _FakeDailyAttemptRepository({
    required DailyAttemptConfig config,
    DailyAttemptState? initialState,
  })  : _config = config,
        _state = initialState ??
            DailyAttemptState.fresh(DateHelper.todayLocalDate());

  final DailyAttemptConfig _config;
  DailyAttemptState _state;

  @override
  DailyAttemptConfig get config => _config;

  @override
  Future<Result<DailyAttemptState>> getState() async => Result.success(_state);

  @override
  Future<Result<DailyAttemptState>> consumeAttempt(String todayDate) async {
    _state = _state.copyWith(
      attemptsUsed: _state.attemptsUsed + 1,
      lastResetDate: todayDate,
    );
    return Result.success(_state);
  }

  @override
  Future<Result<DailyAttemptState>> resetForNewDay(String todayDate) async {
    _state = DailyAttemptState.fresh(todayDate);
    return Result.success(_state);
  }
}

class _FakePremiumEntitlementRepository
    implements PremiumEntitlementRepository {
  _FakePremiumEntitlementRepository({required bool isPremium})
      : _isPremium = isPremium;
  final bool _isPremium;

  @override
  Future<Result<PremiumEntitlement>> getEntitlement() async =>
      Result.success(PremiumEntitlement(isPremium: _isPremium));
}

StartLevelUseCase _buildUseCase({
  int limit = 5,
  bool isPremium = false,
  int initialUsed = 0,
  String? storedDate,
}) {
  final today = DateHelper.todayLocalDate();
  final config = DailyAttemptConfig(freeDailyLimit: limit);
  final repo = _FakeDailyAttemptRepository(
    config: config,
    initialState: DailyAttemptState(
      attemptsUsed: initialUsed,
      lastResetDate: storedDate ?? today,
    ),
  );
  final premiumRepo = _FakePremiumEntitlementRepository(isPremium: isPremium);
  return StartLevelUseCase(
    dailyAttemptRepository: repo,
    premiumEntitlementRepository: premiumRepo,
  );
}

void main() {
  group('StartLevelUseCase — free user', () {
    test('attempt 1 of 5 is allowed', () async {
      final useCase = _buildUseCase(limit: 5, initialUsed: 0);
      final r = await useCase(levelId: 1);
      expect(r.isAllowed, isTrue);
      expect(r.attemptsRemaining, 4);
    });

    test('attempt 5 of 5 is allowed', () async {
      final useCase = _buildUseCase(limit: 5, initialUsed: 4);
      final r = await useCase(levelId: 1);
      expect(r.isAllowed, isTrue);
      expect(r.attemptsRemaining, 0);
    });

    test('6th attempt is blocked', () async {
      final useCase = _buildUseCase(limit: 5, initialUsed: 5);
      final r = await useCase(levelId: 1);
      expect(r.status, StartLevelStatus.dailyLimitReached);
      expect(r.isAllowed, isFalse);
      expect(r.attemptsRemaining, 0);
    });

    test('attempts 1-5 all allowed, 6 blocked', () async {
      const config = DailyAttemptConfig(freeDailyLimit: 5);
      final today = DateHelper.todayLocalDate();
      final repo = _FakeDailyAttemptRepository(
        config: config,
        initialState: DailyAttemptState.fresh(today),
      );
      final premiumRepo = _FakePremiumEntitlementRepository(isPremium: false);
      final useCase = StartLevelUseCase(
        dailyAttemptRepository: repo,
        premiumEntitlementRepository: premiumRepo,
      );
      for (int i = 1; i <= 5; i++) {
        final r = await useCase(levelId: 1);
        expect(r.isAllowed, isTrue, reason: 'Attempt $i should be allowed');
      }
      final r6 = await useCase(levelId: 1);
      expect(
        r6.status,
        StartLevelStatus.dailyLimitReached,
        reason: '6th attempt should be blocked',
      );
    });

    test('daily reset: stored date = yesterday → resets to 0', () async {
      final yesterday = () {
        final d = DateTime.now().subtract(const Duration(days: 1));
        return '${d.year.toString().padLeft(4, "0")}-${d.month.toString().padLeft(2, "0")}-${d.day.toString().padLeft(2, "0")}';
      }();
      final useCase =
          _buildUseCase(limit: 5, initialUsed: 5, storedDate: yesterday);
      final r = await useCase(levelId: 1);
      expect(
        r.isAllowed,
        isTrue,
        reason: 'After new day, attempts should be reset',
      );
    });

    test('same day: app restart does NOT reset attempts', () async {
      final today = DateHelper.todayLocalDate();
      const config = DailyAttemptConfig(freeDailyLimit: 5);
      final repo = _FakeDailyAttemptRepository(
        config: config,
        initialState: DailyAttemptState(attemptsUsed: 3, lastResetDate: today),
      );
      final premiumRepo = _FakePremiumEntitlementRepository(isPremium: false);
      final useCase = StartLevelUseCase(
        dailyAttemptRepository: repo,
        premiumEntitlementRepository: premiumRepo,
      );
      // Simulate app restart with stored date = today, 3 used
      final state = (await repo.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(today),
      );
      expect(state.attemptsUsed, 3);
      // 4th attempt should succeed (not reset to 0)
      final r = await useCase(levelId: 1);
      expect(r.isAllowed, isTrue);
      final state2 = (await repo.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(today),
      );
      expect(state2.attemptsUsed, 4);
    });
  });

  group('StartLevelUseCase — premium user', () {
    test('premium user is always allowed', () async {
      final useCase = _buildUseCase(limit: 5, isPremium: true, initialUsed: 5);
      final r = await useCase(levelId: 1);
      expect(r.isAllowed, isTrue);
      expect(r.isPremium, isTrue);
    });

    test('premium user does not consume attempts', () async {
      const config = DailyAttemptConfig(freeDailyLimit: 5);
      final today = DateHelper.todayLocalDate();
      final repo = _FakeDailyAttemptRepository(
        config: config,
        initialState: DailyAttemptState(attemptsUsed: 0, lastResetDate: today),
      );
      final premiumRepo = _FakePremiumEntitlementRepository(isPremium: true);
      final useCase = StartLevelUseCase(
        dailyAttemptRepository: repo,
        premiumEntitlementRepository: premiumRepo,
      );
      for (int i = 0; i < 10; i++) {
        final r = await useCase(levelId: 1);
        expect(r.isAllowed, isTrue);
      }
      // attemptsUsed should still be 0 — premium bypasses consumption
      final state = (await repo.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(today),
      );
      expect(state.attemptsUsed, 0);
    });

    test('premium user never sees daily limit', () async {
      final useCase = _buildUseCase(limit: 5, isPremium: true, initialUsed: 5);
      for (int i = 0; i < 20; i++) {
        final r = await useCase(levelId: 1);
        expect(r.status, StartLevelStatus.allowed);
      }
    });
  });

  group('StartLevelUseCase — double-tap guard', () {
    test('concurrent calls do not consume two attempts', () async {
      final useCase = _buildUseCase(limit: 5, initialUsed: 0);
      // Call concurrently — second call hits _inProgress guard
      final results = await Future.wait([
        useCase(levelId: 1),
        useCase(levelId: 1),
      ]);
      final allowed = results.where((r) => r.isAllowed).length;
      final errors =
          results.where((r) => r.status == StartLevelStatus.error).length;
      expect(allowed, 1);
      expect(errors, 1);
    });
  });
}
