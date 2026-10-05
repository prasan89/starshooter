import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';

void main() {
  group('DailyAttempts', () {
    final baseDate = DateTime.utc(2026, 10, 5);

    DailyAttempts make({int used = 2, int max = 5}) =>
        DailyAttempts(used: used, max: max, lastResetDate: baseDate);

    group('hasAttemptsLeft', () {
      test('returns true when used is less than max', () {
        final attempts = make(used: 2, max: 5);
        expect(attempts.hasAttemptsLeft, isTrue);
      });

      test('returns false when used equals max', () {
        final attempts = make(used: 5, max: 5);
        expect(attempts.hasAttemptsLeft, isFalse);
      });

      test('returns false when used exceeds max', () {
        final attempts = make(used: 6, max: 5);
        expect(attempts.hasAttemptsLeft, isFalse);
      });

      test('returns true when used is zero', () {
        final attempts = make(used: 0, max: 5);
        expect(attempts.hasAttemptsLeft, isTrue);
      });
    });

    group('useOne()', () {
      test('increments used count by one', () {
        final before = make(used: 2);
        final after = before.useOne();
        expect(after.used, equals(3));
      });

      test('does not modify max', () {
        final before = make(used: 2, max: 5);
        final after = before.useOne();
        expect(after.max, equals(5));
      });

      test('preserves lastResetDate', () {
        final before = make(used: 2);
        final after = before.useOne();
        expect(after.lastResetDate, equals(before.lastResetDate));
      });

      test('allows used to exceed max without guarding', () {
        final before = make(used: 5, max: 5);
        final after = before.useOne();
        expect(after.used, equals(6));
      });
    });

    group('reset()', () {
      test('sets used to zero', () {
        final before = make(used: 4);
        final after = before.reset();
        expect(after.used, equals(0));
      });

      test('preserves max', () {
        final before = make(max: 7);
        final after = before.reset();
        expect(after.max, equals(7));
      });

      test('updates lastResetDate to today UTC', () {
        final before = make();
        final before2026 = DateTime.utc(2026, 1, 1);
        final stale = DailyAttempts(
          used: 4,
          max: 5,
          lastResetDate: before2026,
        );
        final after = stale.reset();
        final now = DateTime.now().toUtc();
        expect(after.lastResetDate.year, equals(now.year));
        expect(after.lastResetDate.month, equals(now.month));
        expect(after.lastResetDate.day, equals(now.day));
        // suppress unused variable warning
        expect(before.max, isNonNegative);
      });
    });

    group('toJson / fromJson', () {
      test('round-trips through JSON without data loss', () {
        final original = make(used: 3, max: 5);
        final json = original.toJson();
        final restored = DailyAttempts.fromJson(json);
        expect(restored.used, equals(original.used));
        expect(restored.max, equals(original.max));
        expect(
          restored.lastResetDate.toIso8601String(),
          equals(original.lastResetDate.toIso8601String()),
        );
      });

      test('fromJson uses default max of 5 when key is absent', () {
        final json = {
          'used': 1,
          'lastResetDate': baseDate.toIso8601String(),
        };
        final result = DailyAttempts.fromJson(json);
        expect(result.max, equals(5));
      });
    });

    group('fresh() factory', () {
      test('creates instance with used=0 and max=5', () {
        final fresh = DailyAttempts.fresh();
        expect(fresh.used, equals(0));
        expect(fresh.max, equals(5));
      });
    });
  });
}
