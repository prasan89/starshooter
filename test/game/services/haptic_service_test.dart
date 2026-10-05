import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/services/haptic_service.dart';

void main() {
  group('HapticService', () {
    test('enabled by default', () {
      expect(HapticService().enabled, isTrue);
    });

    test('can be disabled', () {
      final svc = HapticService()..setEnabled(false);
      expect(svc.enabled, isFalse);
    });

    test('can be re-enabled', () {
      final svc = HapticService()
        ..setEnabled(false)
        ..setEnabled(true);
      expect(svc.enabled, isTrue);
    });

    test('methods do not throw when disabled', () {
      final svc = HapticService()..setEnabled(false);
      expect(() => svc.onShoot(), returnsNormally);
      expect(() => svc.onMatch(), returnsNormally);
      expect(() => svc.onCascade(), returnsNormally);
      expect(() => svc.onHighCombo(), returnsNormally);
    });
  });
}
