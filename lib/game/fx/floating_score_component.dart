import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// A short-lived component that renders a floating score popup (e.g. "+100 x2")
/// that rises upward and fades out over [_duration] seconds.
///
/// Add this component at the world position where the match occurred. It removes
/// itself automatically when the animation finishes.
class FloatingScoreComponent extends PositionComponent {
  final String _text;
  final Color _color;
  double _elapsed = 0;
  static const double _duration = 1.2;
  static const double _riseSpeed = 60.0; // pixels per second upward

  FloatingScoreComponent({
    required Vector2 position,
    required int score,
    int comboLevel = 1,
    Color color = const Color(0xFFFFBF00),
  })  : _text = comboLevel > 1 ? '+$score  x$comboLevel' : '+$score',
        _color = color,
        super(
          position: position,
          anchor: Anchor.center,
          priority: 15,
        );

  @override
  void update(double dt) {
    _elapsed += dt;
    position.y -= _riseSpeed * dt;
    if (_elapsed >= _duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final alpha = (1.0 - _elapsed / _duration).clamp(0.0, 1.0);
    final scale = (_elapsed < 0.1)
        ? (1.0 + (_elapsed / 0.1) * 0.3) // quick scale-up entrance
        : 1.3 - (_elapsed / _duration) * 0.3; // slight shrink while rising

    canvas.save();
    canvas.scale(scale, scale);

    // Drop shadow — rendered first, offset by 1 px.
    final shadow = TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(
          color: Colors.black.withValues(alpha: alpha * 0.7),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    shadow.paint(
      canvas,
      Offset(-shadow.width / 2 + 1, -shadow.height / 2 + 1),
    );

    // Main label with glow shadow.
    final painter = TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(
          color: _color.withValues(alpha: alpha),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: _color.withValues(alpha: alpha * 0.5),
              blurRadius: 8,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));

    canvas.restore();
  }
}
