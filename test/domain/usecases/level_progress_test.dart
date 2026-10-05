import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/level_progress.dart';

void main() {
  group('LevelProgress', () {
    test('empty() creates zeroed progress', () {
      final p = LevelProgress.empty(5);
      expect(p.levelId, 5);
      expect(p.isCompleted, isFalse);
      expect(p.stars, 0);
      expect(p.bestScore, 0);
      expect(p.bestCombo, 0);
      expect(p.bestRemainingShots, 0);
      expect(p.attemptCount, 0);
    });

    test('serialises and deserialises correctly', () {
      const p = LevelProgress(
        levelId: 3,
        isCompleted: true,
        stars: 2,
        bestScore: 1500,
        bestCombo: 4,
        bestRemainingShots: 5,
        attemptCount: 3,
      );
      final json = p.toJson();
      final restored = LevelProgress.fromJson(json);
      expect(restored.levelId, p.levelId);
      expect(restored.bestCombo, p.bestCombo);
      expect(restored.bestRemainingShots, p.bestRemainingShots);
      expect(restored.attemptCount, p.attemptCount);
    });

    test('fromJson handles missing new fields gracefully', () {
      final oldJson = <String, dynamic>{
        'levelId': 7,
        'isCompleted': true,
        'stars': 1,
        'bestScore': 800,
        // No bestCombo / bestRemainingShots / attemptCount
      };
      final p = LevelProgress.fromJson(oldJson);
      expect(p.bestCombo, 0);
      expect(p.bestRemainingShots, 0);
      expect(p.attemptCount, 0);
    });
  });
}
