import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';
import 'package:star_shooter/domain/usecases/get_attempts_usecase.dart';

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

void main() {
  group('GetAttemptsUseCase', () {
    test('0 used → 5 remaining', () async {
      final useCase = GetAttemptsUseCase(
        dailyAttemptRepository: _FakeDailyAttemptRepository(
          config: DailyAttemptConfig.defaultConfig,
          initialState: DailyAttemptState.fresh(DateHelper.todayLocalDate()),
        ),
        premiumEntitlementRepository:
            _FakePremiumEntitlementRepository(isPremium: false),
      );
      final info = await useCase();
      expect(info.attemptsUsed, 0);
      expect(info.attemptsRemaining, 5);
      expect(info.hasAttemptsRemaining, isTrue);
    });

    for (int used = 0; used <= 5; used++) {
      final expected = 5 - used;
      test('$used used → $expected remaining', () async {
        final useCase = GetAttemptsUseCase(
          dailyAttemptRepository: _FakeDailyAttemptRepository(
            config: DailyAttemptConfig.defaultConfig,
            initialState: DailyAttemptState(
              attemptsUsed: used,
              lastResetDate: DateHelper.todayLocalDate(),
            ),
          ),
          premiumEntitlementRepository:
              _FakePremiumEntitlementRepository(isPremium: false),
        );
        final info = await useCase();
        expect(info.attemptsRemaining, expected);
      });
    }

    test('premium user hasAttemptsRemaining always true', () async {
      final useCase = GetAttemptsUseCase(
        dailyAttemptRepository: _FakeDailyAttemptRepository(
          config: DailyAttemptConfig.defaultConfig,
          initialState: DailyAttemptState(
            attemptsUsed: 5,
            lastResetDate: DateHelper.todayLocalDate(),
          ),
        ),
        premiumEntitlementRepository:
            _FakePremiumEntitlementRepository(isPremium: true),
      );
      final info = await useCase();
      expect(info.isPremium, isTrue);
      expect(info.hasAttemptsRemaining, isTrue);
    });
  });
}
