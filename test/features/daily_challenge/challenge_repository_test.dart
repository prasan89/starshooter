import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/features/daily_challenge/data/local_daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/challenge_history_entry.dart';

void main() {
  late LocalStorage storage;
  late LocalDailyChallengeRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
    repo = LocalDailyChallengeRepository(storage: storage);
  });

  group('LocalDailyChallengeRepository', () {
    test('getTodayCompleted returns false when no data', () {
      final result = repo.getTodayCompleted('2024-10-05');
      expect(result.when(onSuccess: (v) => v, onFailure: (_) => true), isFalse);
    });

    test('markTodayCompleted persists', () async {
      await repo.markTodayCompleted('2024-10-05');
      final result = repo.getTodayCompleted('2024-10-05');
      expect(
        result.when(onSuccess: (v) => v, onFailure: (_) => false),
        isTrue,
      );
    });

    test('completed state is date-specific', () async {
      await repo.markTodayCompleted('2024-10-05');
      final result = repo.getTodayCompleted('2024-10-06');
      expect(
        result.when(onSuccess: (v) => v, onFailure: (_) => true),
        isFalse,
      );
    });

    test('history upserts by date', () async {
      const entry = ChallengeHistoryEntry(
        date: '2024-10-05',
        levelId: 1,
        completed: true,
        score: 1000,
        stars: 2,
      );
      await repo.saveHistoryEntry(entry);
      final history = repo.getHistory();
      expect(history.length, 1);
      expect(history.first.score, 1000);
    });

    test('history is capped at 30 entries', () async {
      for (int i = 1; i <= 35; i++) {
        await repo.saveHistoryEntry(ChallengeHistoryEntry(
          date: '2024-10-${i.toString().padLeft(2, '0')}',
          levelId: i % 50 + 1,
          completed: true,
          score: i * 100,
          stars: 1,
        ));
      }
      expect(repo.getHistory().length, 30);
    });
  });
}
