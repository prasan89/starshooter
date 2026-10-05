import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/game/fx/particle_config.dart';

void main() {
  group('ParticleConfig', () {
    test('popSmall has fewer particles than popLarge', () {
      expect(
        ParticleConfig.popSmall.count,
        lessThan(ParticleConfig.popLarge.count),
      );
    });

    test('cascade has more particles than popLarge', () {
      expect(
        ParticleConfig.cascade.count,
        greaterThanOrEqualTo(ParticleConfig.popLarge.count),
      );
    });

    test('trail has no glow', () {
      expect(ParticleConfig.trail.hasGlow, isFalse);
    });

    test('combo has glow', () {
      expect(ParticleConfig.combo.hasGlow, isTrue);
    });
  });
}
