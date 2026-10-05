import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/services/combo_system.dart';

void main() {
  group('ComboSystem', () {
    test('initial combo level is 0', () {
      expect(ComboSystem().comboLevel, 0);
    });

    test('beginResolution sets combo to 1', () {
      final c = ComboSystem()..beginResolution();
      expect(c.comboLevel, 1);
    });

    test('recordMatch increments combo and adds score', () {
      final c = ComboSystem()..beginResolution();
      final score = c.recordMatch(3);
      expect(score, greaterThan(0));
      expect(c.comboLevel, 2);
    });

    test('hasActiveCombo is true after first cascade', () {
      final c = ComboSystem()
        ..beginResolution()
        ..recordMatch(3)
        ..recordMatch(3);
      expect(c.hasActiveCombo, isTrue);
    });

    test('resetCombo zeroes combo but preserves totalScore', () {
      final c = ComboSystem()
        ..beginResolution()
        ..recordMatch(3);
      final before = c.totalScore;
      c.resetCombo();
      expect(c.comboLevel, 0);
      expect(c.totalScore, equals(before));
    });

    test('reset() clears everything', () {
      final c = ComboSystem()
        ..beginResolution()
        ..recordMatch(3);
      c.reset();
      expect(c.comboLevel, 0);
      expect(c.totalScore, 0);
    });
  });
}
