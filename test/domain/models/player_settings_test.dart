import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/domain/models/player_settings.dart';

void main() {
  group('PlayerSettings', () {
    group('defaults() factory', () {
      test('musicEnabled is true', () {
        expect(PlayerSettings.defaults().musicEnabled, isTrue);
      });

      test('sfxEnabled is true', () {
        expect(PlayerSettings.defaults().sfxEnabled, isTrue);
      });

      test('hapticsEnabled is true', () {
        expect(PlayerSettings.defaults().hapticsEnabled, isTrue);
      });
    });

    group('copyWith', () {
      const base = PlayerSettings(
        musicEnabled: true,
        sfxEnabled: true,
        hapticsEnabled: true,
      );

      test('returns equal instance when no fields are overridden', () {
        expect(base.copyWith(), equals(base));
      });

      test('overrides only musicEnabled', () {
        final updated = base.copyWith(musicEnabled: false);
        expect(updated.musicEnabled, isFalse);
        expect(updated.sfxEnabled, isTrue);
        expect(updated.hapticsEnabled, isTrue);
      });

      test('overrides only sfxEnabled', () {
        final updated = base.copyWith(sfxEnabled: false);
        expect(updated.musicEnabled, isTrue);
        expect(updated.sfxEnabled, isFalse);
        expect(updated.hapticsEnabled, isTrue);
      });

      test('overrides only hapticsEnabled', () {
        final updated = base.copyWith(hapticsEnabled: false);
        expect(updated.musicEnabled, isTrue);
        expect(updated.sfxEnabled, isTrue);
        expect(updated.hapticsEnabled, isFalse);
      });
    });

    group('toJson / fromJson', () {
      test('round-trips through JSON without data loss', () {
        const original = PlayerSettings(
          musicEnabled: false,
          sfxEnabled: true,
          hapticsEnabled: false,
        );
        final json = original.toJson();
        final restored = PlayerSettings.fromJson(json);
        expect(restored, equals(original));
      });

      test('fromJson falls back to true when keys are absent', () {
        final settings = PlayerSettings.fromJson(const {});
        expect(settings.musicEnabled, isTrue);
        expect(settings.sfxEnabled, isTrue);
        expect(settings.hapticsEnabled, isTrue);
      });

      test('toJson contains the three expected keys', () {
        final json = PlayerSettings.defaults().toJson();
        expect(json.containsKey('musicEnabled'), isTrue);
        expect(json.containsKey('sfxEnabled'), isTrue);
        expect(json.containsKey('hapticsEnabled'), isTrue);
      });
    });

    group('Equatable equality', () {
      test('two instances with identical values are equal', () {
        const a = PlayerSettings(
          musicEnabled: true,
          sfxEnabled: false,
          hapticsEnabled: true,
        );
        const b = PlayerSettings(
          musicEnabled: true,
          sfxEnabled: false,
          hapticsEnabled: true,
        );
        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('instances differing in sfxEnabled are not equal', () {
        const a = PlayerSettings(
          musicEnabled: true,
          sfxEnabled: true,
          hapticsEnabled: true,
        );
        const b = PlayerSettings(
          musicEnabled: true,
          sfxEnabled: false,
          hapticsEnabled: true,
        );
        expect(a, isNot(equals(b)));
      });
    });
  });
}
