import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Colors;

/// Animates a star falling off the board when floating clusters are removed.
///
/// Add an instance at the cluster's world position; the component removes
/// itself automatically once the fade-out is complete (~0.8 s).
class GravityDropComponent extends PositionComponent {
  final Color _color;
  final Vector2
      _velocity; // initial velocity (mostly downward + slight sideways)
  double _elapsed = 0;
  double _alpha = 1.0;
  double _rotAngle = 0.0;

  static const double _gravity = 800.0; // px/s²
  static const double _fadeDuration = 0.8;
  static const double _radius = 14.0; // smaller than board star

  GravityDropComponent({
    required Vector2 startPos,
    required Color color,
    double horizontalDrift = 0.0, // slight X drift, pixels/s
  })  : _color = color,
        _velocity = Vector2(horizontalDrift, -80.0), // slight upward then fall
        super(
          position: startPos,
          size: Vector2.all(_radius * 2),
          anchor: Anchor.center,
          priority: 8,
        );

  @override
  void update(double dt) {
    _elapsed += dt;
    _velocity.y += _gravity * dt;
    position += _velocity * dt;
    _rotAngle += dt * 3.0;
    _alpha = (1.0 - _elapsed / _fadeDuration).clamp(0.0, 1.0);
    if (_elapsed >= _fadeDuration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final col = _color.withValues(alpha: _alpha);

    // Glow
    canvas.drawCircle(
      Offset.zero,
      _radius * 1.4,
      Paint()
        ..color = col.withValues(alpha: _alpha * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Sphere with rotation hint (slightly deformed oval)
    canvas.save();
    canvas.rotate(_rotAngle);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: _radius * 2,
        height: _radius * 1.8,
      ),
      Paint()
        ..color = col
        ..style = PaintingStyle.fill,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: _radius * 2,
        height: _radius * 1.8,
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: _alpha * 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
    canvas.restore();
  }
}
