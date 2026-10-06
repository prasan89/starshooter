import 'dart:math' show pi, cos, sin, Random, atan2;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

/// A brief fading-glow trail mark left in the projectile's wake.
///
/// Spawn one at the projectile's current world position on each update tick
/// (or at fixed intervals). The component manages its own lifespan: it fades
/// over [_duration] seconds and removes itself when done.
///
/// Upgraded to premium quality: larger glow bloom, bright energy core,
/// 3 detaching micro-particles, and an optional wall-bounce burst variant.
class ShootingTrailComponent extends PositionComponent {
  final Color _color;
  double _alpha = 0.9;
  static const double _duration = 0.30;
  double _elapsed = 0;
  static const double _radius = 9.0;

  // Three micro-particles that detach and drift
  late final List<_MicroParticle> _microParticles;

  // Cached paints
  final _outerGlowPaint = Paint();
  final _innerGlowPaint = Paint();
  final _corePaint = Paint();
  final _particlePaint = Paint();
  final _bouncePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  /// Direction of travel — used to elongate the outer glow oval.
  final Vector2 _direction;

  /// Set to true for a wall-bounce energy burst (larger, brighter, shorter)
  final bool _isBounce;

  ShootingTrailComponent({
    required Vector2 position,
    required Color color,
    bool isBounce = false,
    Vector2? direction,
    int seed = 0,
  })  : _color = color,
        _isBounce = isBounce,
        _direction = direction?.normalized() ?? Vector2(0, -1),
        super(
          position: position,
          anchor: Anchor.center,
          priority: 3,
          size: Vector2.all(isBounce ? _radius * 8 : _radius * 5),
        ) {
    final rng = Random(seed);
    // Base particle drift angle biased opposite to direction of travel
    final backAngle = atan2(-_direction.y, -_direction.x);
    _microParticles = List.generate(
      isBounce ? 5 : 3,
      (i) {
        final spread = isBounce ? pi : pi * 0.6;
        final angle = backAngle + (rng.nextDouble() - 0.5) * spread;
        final speed = isBounce
            ? 60.0 + rng.nextDouble() * 80.0
            : 15.0 + rng.nextDouble() * 35.0;
        return _MicroParticle(
          vel: Vector2(cos(angle) * speed, sin(angle) * speed),
          radius: 1.5 + rng.nextDouble() * 2.5,
        );
      },
    );
  }

  @override
  void update(double dt) {
    _elapsed += dt;
    final duration = _isBounce ? 0.18 : _duration;
    _alpha = (0.9 * (1.0 - _elapsed / duration)).clamp(0.0, 1.0);
    for (final p in _microParticles) {
      p.pos += p.vel * dt;
      p.vel *= (1.0 - dt * 3.5); // drag
    }
    if (_elapsed >= duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final scale = _isBounce ? 1.8 : 1.0;
    final r = _radius * scale;

    // Outer glow — elongated oval aligned to direction of travel (2:1 ratio)
    _outerGlowPaint
      ..color = _color.withValues(alpha: _alpha * 0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.9);
    final travelAngle = atan2(_direction.y, _direction.x);
    canvas.save();
    canvas.rotate(travelAngle + pi / 2); // align long axis to travel direction
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: r * 1.8,
        height: r * 3.2, // 2:1 elongated in travel direction
      ),
      _outerGlowPaint,
    );
    canvas.restore();

    // Inner glow
    _innerGlowPaint
      ..color = _color.withValues(alpha: _alpha * 0.45)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.4);
    canvas.drawCircle(Offset.zero, r * 0.9, _innerGlowPaint);

    // Bright energy core
    final brightCore = Color.lerp(_color, const Color(0xFFFFFFFF), 0.5)!;
    _corePaint
      ..color = brightCore.withValues(alpha: _alpha * 0.85)
      ..maskFilter = null
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, r * 0.38, _corePaint);

    // Micro-particles drifting backward
    for (final p in _microParticles) {
      final pAlpha = _alpha * 0.7;
      _particlePaint
        ..color = _color.withValues(alpha: pAlpha)
        ..maskFilter = null;
      canvas.drawCircle(Offset(p.pos.x, p.pos.y), p.radius * _alpha, _particlePaint);
    }

    // Extra ring flash for bounce
    if (_isBounce && _elapsed < 0.08) {
      final ringProgress = _elapsed / 0.08;
      final ringR = r * (1.0 + ringProgress * 2.0);
      _bouncePaint
        ..color = _color.withValues(alpha: (1.0 - ringProgress) * 0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset.zero, ringR, _bouncePaint);
    }
  }
}

class _MicroParticle {
  Vector2 pos;
  Vector2 vel;
  final double radius;
  _MicroParticle({required this.vel, required this.radius}) : pos = Vector2.zero();
}
