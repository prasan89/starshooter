import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/utils/date_utils.dart';

void main() {
  group('GameDateUtils', () {
    group('isNewDay', () {
      test('returns true when dates are on different calendar days', () {
        final day1 = DateTime(2026, 10, 4, 23, 59, 59);
        final day2 = DateTime(2026, 10, 5, 0, 0, 0);
        expect(GameDateUtils.isNewDay(day1, day2), isTrue);
      });

      test('returns true across month boundaries', () {
        final last = DateTime(2026, 9, 30, 12, 0, 0);
        final now = DateTime(2026, 10, 1, 0, 0, 0);
        expect(GameDateUtils.isNewDay(last, now), isTrue);
      });

      test('returns true across year boundaries', () {
        final last = DateTime(2025, 12, 31, 23, 59);
        final now = DateTime(2026, 1, 1, 0, 0);
        expect(GameDateUtils.isNewDay(last, now), isTrue);
      });

      test('returns false when both dates fall on the same calendar day', () {
        final morning = DateTime(2026, 10, 5, 8, 0, 0);
        final evening = DateTime(2026, 10, 5, 23, 59, 59);
        expect(GameDateUtils.isNewDay(morning, evening), isFalse);
      });

      test('returns false when last and now are identical', () {
        final dt = DateTime(2026, 10, 5, 12, 0);
        expect(GameDateUtils.isNewDay(dt, dt), isFalse);
      });
    });

    group('startOfDay', () {
      test('returns midnight for a mid-day timestamp', () {
        final input = DateTime(2026, 10, 5, 14, 30, 45, 123);
        final result = GameDateUtils.startOfDay(input);
        expect(result, equals(DateTime(2026, 10, 5)));
      });

      test('returns midnight unchanged when given midnight', () {
        final input = DateTime(2026, 10, 5, 0, 0, 0);
        final result = GameDateUtils.startOfDay(input);
        expect(result, equals(DateTime(2026, 10, 5)));
      });

      test('hour, minute, second and millisecond are all zero', () {
        final input = DateTime(2026, 6, 15, 23, 59, 59, 999);
        final result = GameDateUtils.startOfDay(input);
        expect(result.hour, isZero);
        expect(result.minute, isZero);
        expect(result.second, isZero);
        expect(result.millisecond, isZero);
      });
    });
  });
}
