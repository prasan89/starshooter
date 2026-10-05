import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/services/audio_service.dart';

void main() {
  // Initialise the Flutter binding so platform channel calls (inside
  // AudioService.stopMusic) don't throw "Binding has not yet been initialized".
  // The try/catch in AudioService already swallows MissingPluginException; we
  // just need the binding to exist first.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AudioService', () {
    test('music can be toggled off', () {
      final svc = AudioService();
      svc.setMusicEnabled(false);
      expect(svc.musicEnabled, isFalse);
    });

    test('sfx can be toggled off', () {
      final svc = AudioService();
      svc.setSfxEnabled(false);
      expect(svc.sfxEnabled, isFalse);
    });

    test('music can be toggled back on', () {
      final svc = AudioService()
        ..setMusicEnabled(false)
        ..setMusicEnabled(true);
      expect(svc.musicEnabled, isTrue);
    });

    test('sfx can be toggled back on', () {
      final svc = AudioService()
        ..setSfxEnabled(false)
        ..setSfxEnabled(true);
      expect(svc.sfxEnabled, isTrue);
    });

    test('playing sfx when disabled does not throw', () async {
      final svc = AudioService()..setSfxEnabled(false);
      await svc.initialize();
      expect(() => svc.playShoot(), returnsNormally);
      expect(() => svc.playMatch(), returnsNormally);
    });
  });
}
