import 'dart:math' show pi, cos, sin, Random;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

/// Plays a 150–200ms impact effect when the projectile hits another star.
///
/// Sequence:
///  0–40 ms  : bright core flash + radial shockwave ring expanding outward
///  40–120 ms: 8–12 particle burst radiating outward
///  40–200 ms: flash fades, ring fades, particles drag-slow and fade
///
/// Designed to look like physical contact: the ring gives "shockwave" feel
/// and the particles give "energy release" feel.
class ImpactFlashEffect extends PositionComponent {
  final Color _color;
  double _elapsed = 0;
  static const double _duration = 0.20;
  static const double _ringMaxRadius = 36.0;
  static const int _particleCount = 10;

  late final List<_ImpactParticle> _particles;

  final _flashPaint = Paint();
  final _ringPaint = Paint()..style = PaintingStyle.stroke;
  final _particlePaint = Paint();
  final _glowPaint = Paint();

  ImpactFlashEffect({
    required Vector2 position,
    required Color color,
    int seed = 0,
  })  : _color = color,
        super(
          position: position,
          anchor: Anchor.center,
          size: Vector2.all(_ringMaxRadius * 2.5),
          priority: 10,
        ) {
    final rng = Random(seed);
    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.4)!;
    _particles = List.generate(_particleCount, (i) {
      final angle = (i / _particleCount) * 2 * pi + rng.nextDouble() * 0.4;
      final speed = 120.0 + rng.nextDouble() * 160.0;
      return _ImpactParticle(
        vel: Vector2(cos(angle) * speed, sin(angle) * speed),
        radius: 2.0 + rng.nextDouble() * 3.0,
        color: rng.nextDouble() > 0.4 ? color : brightColor,
      );
    });
  }

  @override
  void update(double dt) {
    _elapsed += dt;
    for (final p in _particles) {
      p.pos += p.vel * dt;
      p.vel *= (1.0 - dt * 4.0); // drag
    }
    if (_elapsed >= _duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final t = (_elapsed / _duration).clamp(0.0, 1.0);

    // Core flash — bright white-tinted center, fades quickly
    if (t < 0.35) {
      final flashAlpha = (1.0 - t / 0.35) * 0.9;
      final flashR = 14.0 * (1.0 + t * 0.6);
      _flashPaint
        ..color = Color.lerp(_color, const Color(0xFFFFFFFF), 0.55)!
            .withValues(alpha: flashAlpha)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, flashR, _flashPaint);

      // Pure white hotspot
      _flashPaint
        ..color = const Color(0xFFFFFFFF).withValues(alpha: flashAlpha * 0.6)
        ..maskFilter = null;
      canvas.drawCircle(Offset.zero, 6.0, _flashPaint);
    }

    // Outer glow bloom
    final glowAlpha = (1.0 - t) * 0.3;
    _glowPaint
      ..color = _color.withValues(alpha: glowAlpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, _ringMaxRadius * 0.5, _glowPaint);

    // Expanding shockwave ring
    final ringRadius = _ringMaxRadius * (0.1 + t * 0.9);
    final ringAlpha = (1.0 - t * 1.2).clamp(0.0, 1.0) * 0.85;
    _ringPaint
      ..color = _color.withValues(alpha: ringAlpha)
      ..strokeWidth = (3.0 * (1.0 - t)).clamp(0.5, 3.0)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset.zero, ringRadius, _ringPaint);

    // Thinner secondary ring slightly behind
    if (t < 0.6) {
      final ring2Radius = _ringMaxRadius * (0.05 + t * 0.7);
      _ringPaint
        ..color = const Color(0xFFFFFFFF).withValues(alpha: ringAlpha * 0.3)
        ..strokeWidth = 1.0
        ..maskFilter = null;
      canvas.drawCircle(Offset.zero, ring2Radius, _ringPaint);
    }

    // Impact particles
    final particleAlpha = t < 0.15
        ? (t / 0.15)
        : (1.0 - (t - 0.15) / 0.85).clamp(0.0, 1.0);
    for (final p in _particles) {
      _particlePaint
        ..color = p.color.withValues(alpha: particleAlpha * 0.9)
        ..maskFilter = null
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(p.pos.x, p.pos.y), p.radius, _particlePaint);
    }
  }
}

class _ImpactParticle {
  Vector2 pos;
  Vector2 vel;
  final double radius;
  final Color color;
  _ImpactParticle({
    required this.vel,
    required this.radius,
    required this.color,
  }) : pos = Vector2.zero();
}
