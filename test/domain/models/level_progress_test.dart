import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/level_progress.dart';

void main() {
  group('LevelProgress', () {
    const base = LevelProgress(
      levelId: 3,
      isCompleted: true,
      stars: 2,
      bestScore: 500,
    );

    group('copyWith', () {
      test('returns an identical copy when no fields are overridden', () {
        expect(base.copyWith(), equals(base));
      });

      test('overrides only the specified field', () {
        final updated = base.copyWith(stars: 3);
        expect(updated.levelId, equals(base.levelId));
        expect(updated.isCompleted, equals(base.isCompleted));
        expect(updated.bestScore, equals(base.bestScore));
        expect(updated.stars, equals(3));
      });

      test('can override all fields at once', () {
        final updated = base.copyWith(
          levelId: 10,
          isCompleted: false,
          stars: 0,
          bestScore: 0,
        );
        expect(updated.levelId, equals(10));
        expect(updated.isCompleted, isFalse);
        expect(updated.stars, equals(0));
        expect(updated.bestScore, equals(0));
      });
    });

    group('toJson / fromJson', () {
      test('round-trips through JSON without data loss', () {
        final json = base.toJson();
        final restored = LevelProgress.fromJson(json);
        expect(restored, equals(base));
      });

      test('toJson contains expected keys', () {
        final json = base.toJson();
        expect(json.containsKey('levelId'), isTrue);
        expect(json.containsKey('isCompleted'), isTrue);
        expect(json.containsKey('stars'), isTrue);
        expect(json.containsKey('bestScore'), isTrue);
      });

      test('fromJson deserialises values correctly', () {
        final json = {
          'levelId': 7,
          'isCompleted': false,
          'stars': 1,
          'bestScore': 150,
        };
        final progress = LevelProgress.fromJson(json);
        expect(progress.levelId, equals(7));
        expect(progress.isCompleted, isFalse);
        expect(progress.stars, equals(1));
        expect(progress.bestScore, equals(150));
      });
    });

    group('empty() factory', () {
      test('returns correct defaults for the given levelId', () {
        final empty = LevelProgress.empty(5);
        expect(empty.levelId, equals(5));
        expect(empty.isCompleted, isFalse);
        expect(empty.stars, equals(0));
        expect(empty.bestScore, equals(0));
      });
    });

    group('Equatable equality', () {
      test('two instances with the same data are equal', () {
        const a = LevelProgress(
          levelId: 1,
          isCompleted: true,
          stars: 3,
          bestScore: 999,
        );
        const b = LevelProgress(
          levelId: 1,
          isCompleted: true,
          stars: 3,
          bestScore: 999,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('instances with different levelId are not equal', () {
        final a = LevelProgress.empty(1);
        final b = LevelProgress.empty(2);
        expect(a, isNot(equals(b)));
      });

      test('instances with different stars are not equal', () {
        const a = LevelProgress(
          levelId: 1,
          isCompleted: true,
          stars: 2,
          bestScore: 100,
        );
        const b = LevelProgress(
          levelId: 1,
          isCompleted: true,
          stars: 3,
          bestScore: 100,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
