import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/daily_attempt_repository_impl.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';

void main() {
  late SharedPreferences prefs;
  late LocalStorage storage;
  const config = DailyAttemptConfig(freeDailyLimit: 5);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
  });

  group('LocalDailyAttemptRepository', () {
    test('getState returns fresh state when no persisted data', () async {
      final repo =
          LocalDailyAttemptRepository(storage: storage, config: config);
      final result = await repo.getState();
      final state = result.when(
        onSuccess: (s) => s,
        onFailure: (_) => throw Exception('fail'),
      );
      expect(state.attemptsUsed, 0);
    });

    test('consumeAttempt increments and persists', () async {
      final repo =
          LocalDailyAttemptRepository(storage: storage, config: config);
      final today = DateHelper.todayLocalDate();
      await repo.consumeAttempt(today);
      await repo.consumeAttempt(today);
      final state = (await repo.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => throw Exception('fail'),
      );
      expect(state.attemptsUsed, 2);
    });

    test('state survives repository recreation', () async {
      final repo =
          LocalDailyAttemptRepository(storage: storage, config: config);
      final today = DateHelper.todayLocalDate();
      await repo.consumeAttempt(today);
      await repo.consumeAttempt(today);
      // Recreate repo with same storage
      final repo2 =
          LocalDailyAttemptRepository(storage: storage, config: config);
      final state = (await repo2.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => throw Exception('fail'),
      );
      expect(state.attemptsUsed, 2);
    });

    test('resetForNewDay resets to 0', () async {
      final repo =
          LocalDailyAttemptRepository(storage: storage, config: config);
      final today = DateHelper.todayLocalDate();
      await repo.consumeAttempt(today);
      await repo.consumeAttempt(today);
      await repo.resetForNewDay(today);
      final state = (await repo.getState()).when(
        onSuccess: (s) => s,
        onFailure: (_) => throw Exception('fail'),
      );
      expect(state.attemptsUsed, 0);
      expect(state.lastResetDate, today);
    });
  });
}
