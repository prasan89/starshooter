import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// A Flame component that renders a static cosmic starfield background.
///
/// Stars are positioned deterministically using a simple LCG-style seed so the
/// layout is stable across frames without storing random state.
/// Parallax / animation is deferred to M2.
class CosmicBackgroundComponent extends PositionComponent {
  CosmicBackgroundComponent() : super(priority: -10);

  // Pre-computed normalised star positions (x, y) in the range [0, 1].
  // Generated once in onLoad via a seeded algorithm so they are deterministic.
  final List<Offset> _starPositions = [];
  final List<double> _starRadii = [];

  static const int _starCount = 120;
  static const int _seed = 0xDEADBEEF;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _generateStars();
  }

  /// Populates [_starPositions] using a cheap deterministic PRNG so the star
  /// field looks natural but is bit-for-bit reproducible.
  void _generateStars() {
    int state = _seed;
    int _next() {
      // LCG parameters from Numerical Recipes
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double _nextFloat() => (_next() & 0xFFFF) / 0xFFFF.toDouble();

    for (int i = 0; i < _starCount; i++) {
      _starPositions.add(Offset(_nextFloat(), _nextFloat()));
      // Most stars are tiny; a few are slightly larger (1-in-6 chance).
      _starRadii.add((_next() % 6 == 0) ? 1.8 : 0.9);
    }
  }

  @override
  void render(Canvas canvas) {
    final size = this.size;

    // Background fill — deep space colour.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      Paint()..color = AppColors.background,
    );

    // Draw a subtle radial nebula glow in the centre.
    canvas.drawCircle(
      Offset(size.x * 0.5, size.y * 0.3),
      size.x * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.secondary.withValues(alpha: 0.07),
            AppColors.primary.withValues(alpha: 0.03),
            AppColors.background.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromCircle(
            center: Offset(size.x * 0.5, size.y * 0.3),
            radius: size.x * 0.55,
          ),
        ),
    );

    // Draw stars.
    final starPaint = Paint()..color = AppColors.textPrimary.withValues(alpha: 0.85);
    for (int i = 0; i < _starPositions.length; i++) {
      final pos = _starPositions[i];
      canvas.drawCircle(
        Offset(pos.dx * size.x, pos.dy * size.y),
        _starRadii[i],
        starPaint,
      );
    }
  }

  /// Keep the background filling the whole game canvas on resize.
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size = gameSize.clone();
  }
}
