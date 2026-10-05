import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/features/daily_challenge/domain/generators/daily_challenge_generator.dart';

void main() {
  const gen = DailyChallengeGenerator();

  group('DailyChallengeGenerator determinism', () {
    test('generateForDate returns identical result on two calls for 2024-10-05',
        () {
      const date = '2024-10-05';
      final c1 = gen.generateForDate(date);
      final c2 = gen.generateForDate(date);

      expect(c1.id, equals(c2.id));
      expect(c1.date, equals(c2.date));
      expect(c1.levelId, equals(c2.levelId));
      expect(c1.seed, equals(c2.seed));
      expect(c1.difficulty, equals(c2.difficulty));
      expect(c1.bonusMoveLimit, equals(c2.bonusMoveLimit));
      expect(c1.objective.type, equals(c2.objective.type));
      expect(c1.objective.target, equals(c2.objective.target));
    });

    test('different dates produce different seeds', () {
      final a = gen.generateForDate('2024-10-05');
      final b = gen.generateForDate('2024-10-06');
      expect(a.seed, isNot(equals(b.seed)));
    });

    test('generated challenge has a valid level id (1–50)', () {
      final c = gen.generateForDate('2024-10-05');
      expect(c.levelId, inInclusiveRange(1, 50));
    });

    test('bonusMoveLimit is within the allowed clamp range (8–60)', () {
      for (final date in [
        '2024-01-01',
        '2024-06-15',
        '2024-12-31',
        '2025-03-07',
      ]) {
        final c = gen.generateForDate(date);
        expect(
          c.bonusMoveLimit,
          inInclusiveRange(8, 60),
          reason: 'date $date produced out-of-range moveLimit',
        );
      }
    });
  });
}
