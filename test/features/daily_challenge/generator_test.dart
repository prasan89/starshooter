import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/features/daily_challenge/domain/generators/daily_challenge_generator.dart';

void main() {
  const generator = DailyChallengeGenerator();

  group('DailyChallengeGenerator', () {
    test('same date produces same challenge', () {
      final a = generator.generateForDate('2024-10-05');
      final b = generator.generateForDate('2024-10-05');
      expect(a.id, b.id);
      expect(a.levelId, b.levelId);
      expect(a.seed, b.seed);
    });

    test('different dates produce different seeds', () {
      final a = generator.generateForDate('2024-10-05');
      final b = generator.generateForDate('2024-10-06');
      expect(a.seed, isNot(equals(b.seed)));
    });

    test('generates valid challenge for each day in October 2024', () {
      for (int day = 1; day <= 31; day++) {
        final date = '2024-10-${day.toString().padLeft(2, '0')}';
        final ch = generator.generateForDate(date);
        expect(ch.levelId, greaterThanOrEqualTo(1));
        expect(ch.levelId, lessThanOrEqualTo(50));
        expect(ch.effectiveMoveLimit, greaterThanOrEqualTo(8));
        expect(ch.effectiveMoveLimit, lessThanOrEqualTo(60));
      }
    });

    test('challenge id equals the date', () {
      final ch = generator.generateForDate('2024-11-15');
      expect(ch.id, '2024-11-15');
      expect(ch.date, '2024-11-15');
    });

    test('determinism survives generator recreation', () {
      const gen2 = DailyChallengeGenerator();
      final a = generator.generateForDate('2024-10-07');
      final b = gen2.generateForDate('2024-10-07');
      expect(a.levelId, b.levelId);
      expect(a.objective.type, b.objective.type);
      expect(a.objective.target, b.objective.target);
    });
  });
}
