import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// A short-lived component that renders a floating score popup (e.g. "+100 x2")
/// that rises upward and fades out over [_duration] seconds.
///
/// Enhanced version with:
///  - Scale 1.0→1.3→1.0 pop animation
///  - Stronger outer glow for large scores (>= 300 pts)
///  - Combo multiplier shown with golden accent
///  - Crisp white text with colored drop shadow
class FloatingScoreComponent extends PositionComponent {
  final String _text;
  final Color _color;
  final bool _isLargeScore;
  final bool _hasCombo;
  double _elapsed = 0;
  static const double _duration = 1.4;
  static const double _riseSpeed = 55.0;

  // Cached layout dimensions — set in onLoad.
  double _textWidth = 0;
  double _textHeight = 0;

  FloatingScoreComponent({
    required Vector2 position,
    required int score,
    int comboLevel = 1,
    Color color = const Color(0xFFFFBF00),
  })  : _text = comboLevel > 1 ? '+$score  x$comboLevel' : '+$score',
        _color = color,
        _isLargeScore = score >= 300,
        _hasCombo = comboLevel > 1,
        super(
          position: position,
          anchor: Anchor.center,
          priority: 15,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Measure once — text and size never change.
    final tp = TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    _textWidth = tp.width;
    _textHeight = tp.height;
  }

  double get _fontSize => _isLargeScore ? 22.0 : (_hasCombo ? 20.0 : 18.0);

  @override
  void update(double dt) {
    _elapsed += dt;
    position.y -= _riseSpeed * dt;
    if (_elapsed >= _duration) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final t = (_elapsed / _duration).clamp(0.0, 1.0);
    final alpha = (1.0 - t).clamp(0.0, 1.0);

    // Scale: 0→0.3s pop up, 0.3→1.0 gentle scale-down
    final double scale;
    if (t < 0.08) {
      scale = 0.7 + (t / 0.08) * 0.6; // 0.7 → 1.3
    } else if (t < 0.18) {
      scale = 1.3 - ((t - 0.08) / 0.10) * 0.3; // 1.3 → 1.0
    } else {
      scale = 1.0 - (t - 0.18) * 0.2; // gentle shrink
    }

    canvas.save();
    canvas.scale(scale.clamp(0.1, 1.5), scale.clamp(0.1, 1.5));

    final dx = -_textWidth / 2;
    final dy = -_textHeight / 2;
    final fs = _fontSize;

    // Large-score glow halo underneath text
    if (_isLargeScore && alpha > 0.1) {
      final glowPaint = Paint()
        ..color = _color.withValues(alpha: alpha * 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: const Offset(0, 0),
            width: _textWidth + 20,
            height: _textHeight + 10,
          ),
          const Radius.circular(8),
        ),
        glowPaint,
      );
    }

    // Drop shadow
    final shadow = TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(
          color: Colors.black.withValues(alpha: alpha * 0.65),
          fontSize: fs,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    shadow.paint(canvas, Offset(dx + 1.5, dy + 1.5));

    // Main text with glow shadow
    final painter = TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: alpha),
          fontSize: fs,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: _color.withValues(alpha: alpha * 0.9),
              blurRadius: _isLargeScore ? 14 : 8,
            ),
            Shadow(
              color: _color.withValues(alpha: alpha * 0.5),
              blurRadius: 4,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset(dx, dy));

    canvas.restore();
  }
}
