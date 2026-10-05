import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// A short-lived [PositionComponent] that plays a pop/burst animation at a
/// given screen position when stars are removed.
///
/// Timeline (total ~0.45 seconds):
///   0.0–0.1 s : scale 1.0 → 1.6, opacity stays 1.0  (glow burst)
///   0.1–0.45 s: scale 1.6 → 0.0, opacity 1.0 → 0.0  (fade out)
///   0.45 s+   : auto-removes itself from the scene tree
///
/// Six particle dots expand outward and fade simultaneously.
class PopAnimationComponent extends PositionComponent {
  final Color _color;
  double _elapsed = 0;
  double _scale = 1.0;
  double _alpha = 1.0;
  bool _done = false;

  // 6 particles at evenly-spaced angles.
  static const int _particleCount = 6;
  final List<_Particle> _particles = [];

  static const double _burstDuration = 0.1;
  static const double _fadeDuration = 0.35;
  static const double _totalDuration = _burstDuration + _fadeDuration;
  static const double _baseRadius = 14.0;

  PopAnimationComponent({
    required Vector2 position,
    required Color color,
  })  : _color = color,
        super(
          position: position,
          size: Vector2.all(_baseRadius * 4),
          anchor: Anchor.center,
          priority: 10,
        ) {
    // Initialise particles at evenly-spaced angles.
    for (int i = 0; i < _particleCount; i++) {
      final angle = (i / _particleCount) * pi * 2;
      _particles.add(_Particle(angle: angle));
    }
  }

  @override
  void update(double dt) {
    if (_done) return;
    _elapsed += dt;

    if (_elapsed < _burstDuration) {
      // Burst phase: scale up.
      final t = _elapsed / _burstDuration;
      _scale = 1.0 + t * 0.6;
      _alpha = 1.0;
    } else {
      // Fade phase: scale down + fade out.
      final t = (_elapsed - _burstDuration) / _fadeDuration;
      _scale = (1.6 * (1.0 - t)).clamp(0.0, 2.0);
      _alpha = (1.0 - t).clamp(0.0, 1.0);
    }

    // Update particles.
    final tTotal = (_elapsed / _totalDuration).clamp(0.0, 1.0);
    for (final p in _particles) {
      p.distance = tTotal * _baseRadius * 2.5;
      p.alpha = (1.0 - tTotal).clamp(0.0, 1.0);
    }

    if (_elapsed >= _totalDuration) {
      _done = true;
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_done) return;

    final center = size / 2;
    final r = _baseRadius * _scale;

    // Glow.
    final glowPaint = Paint()
      ..color = _color.withValues(alpha: _alpha * 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center.toOffset(), r * 1.5, glowPaint);

    // Core circle.
    final fillPaint = Paint()
      ..color = _color.withValues(alpha: _alpha)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center.toOffset(), r, fillPaint);

    // Particles.
    for (final p in _particles) {
      final px = center.x + p.distance * cos(p.angle);
      final py = center.y + p.distance * sin(p.angle);
      final particlePaint = Paint()
        ..color = _color.withValues(alpha: p.alpha * 0.86)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(px, py), 4.0, particlePaint);
    }
  }
}

/// Internal state for a single particle dot.
class _Particle {
  final double angle;
  double distance = 0;
  double alpha = 1.0;

  _Particle({required this.angle});
}
