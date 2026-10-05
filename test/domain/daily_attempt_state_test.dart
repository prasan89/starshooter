import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';

void main() {
  group('DailyAttemptState', () {
    test('fresh state has 0 attempts used', () {
      final s = DailyAttemptState.fresh('2024-10-05');
      expect(s.attemptsUsed, 0);
      expect(s.lastResetDate, '2024-10-05');
    });

    test('copyWith updates attemptsUsed', () {
      final s = DailyAttemptState.fresh('2024-10-05').copyWith(attemptsUsed: 3);
      expect(s.attemptsUsed, 3);
      expect(s.lastResetDate, '2024-10-05');
    });

    test('encode / decode roundtrip', () {
      const s = DailyAttemptState(attemptsUsed: 4, lastResetDate: '2024-10-05');
      final decoded = DailyAttemptState.decode(s.encode());
      expect(decoded.attemptsUsed, 4);
      expect(decoded.lastResetDate, '2024-10-05');
    });

    test('decode handles invalid json gracefully', () {
      final s = DailyAttemptState.decode('not-json');
      expect(s.attemptsUsed, 0);
    });
  });
}
