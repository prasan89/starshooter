import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

/// A brief fading-glow trail mark left in the projectile's wake.
///
/// Spawn one at the projectile's current world position on each update tick
/// (or at fixed intervals). The component manages its own lifespan: it fades
/// over [_duration] seconds and removes itself when done.
class ShootingTrailComponent extends PositionComponent {
  final Color _color;
  double _alpha = 0.8;
  static const double _duration = 0.25;
  double _elapsed = 0;
  static const double _radius = 8.0;

  ShootingTrailComponent({
    required Vector2 position,
    required Color color,
  })  : _color = color,
        super(
          position: position,
          anchor: Anchor.center,
          priority: 3,
          size: Vector2.all(_radius * 3),
        );

  @override
  void update(double dt) {
    _elapsed += dt;
    _alpha = (0.8 * (1.0 - _elapsed / _duration)).clamp(0.0, 1.0);
    if (_elapsed >= _duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      _radius,
      Paint()
        ..color = _color.withValues(alpha: _alpha * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawCircle(
      Offset.zero,
      _radius * 0.5,
      Paint()..color = _color.withValues(alpha: _alpha),
    );
  }
}
