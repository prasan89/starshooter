import 'dart:math' show pi, sin;

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/game/models/star_model.dart';

/// A Flame [PositionComponent] that renders a single [StarModel] on the board.
///
/// The component is centred on its [position]; set that to the pixel centre
/// returned by [BoardGrid.gridToPixel] before adding to the scene.
///
/// Visual features (M4):
///   - Idle breathing animation: gentle scale oscillation over ~2 s cycle.
///   - Shimmer arc: a bright arc that sweeps around the sphere periodically.
///   - Rich 3D-sphere: radial gradient bright top-left → darker bottom-right.
///   - Outer glow halo with soft blur.
///   - Inner specular highlight (white dot, top-left).
///   - Rim-light arc at bottom for depth.
///
/// All animations are time-based via [update(dt)] — no Flutter AnimationController.
class StarComponent extends PositionComponent {
  StarModel model;

  static const double _radius = 22.0;
  static const double _breathePeriod = 2.2; // seconds per full breathe cycle
  static const double _shimmerPeriod = 3.5; // seconds per shimmer sweep
  static const double _breatheAmplitude = 0.05; // ±5 % scale

  double _breatheT = 0.0; // [0, _breathePeriod)
  double _shimmerT = 0.0; // [0, _shimmerPeriod)

  StarComponent(this.model) : super(anchor: Anchor.center, priority: 1);

  @override
  void update(double dt) {
    _breatheT = (_breatheT + dt) % _breathePeriod;
    _shimmerT = (_shimmerT + dt) % _shimmerPeriod;
  }

  @override
  void render(Canvas canvas) {
    final color = model.type.color;

    // Breathing scale: oscillates between (1 - amp) and (1 + amp).
    final breathePhase = (_breatheT / _breathePeriod) * 2 * pi;
    final scale = 1.0 + sin(breathePhase) * _breatheAmplitude;
    final r = _radius * scale;

    // 1. Outer glow halo.
    canvas.drawCircle(
      Offset.zero,
      r * 1.5,
      Paint()
        ..color = color.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // 2. Main sphere with radial gradient (bright top-left, darker bottom-right).
    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.35)!;
    final darkColor = Color.lerp(color, const Color(0xFF000000), 0.25)!;
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.4),
          colors: [brightColor, color, darkColor],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: r)),
    );

    // 3. Outline.
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..color = color.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 4. Rim light at bottom (subtle arc).
    final rimPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.88),
      0.5 * pi, // bottom arc
      pi,
      false,
      rimPaint,
    );

    // 5. Primary specular highlight (top-left white dot).
    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.22,
      Paint()..color = const Color(0x77FFFFFF),
    );

    // 6. Shimmer arc — a bright arc that sweeps around the sphere.
    final shimmerPhase = (_shimmerT / _shimmerPeriod) * 2 * pi;
    final shimmerPaint = Paint()
      ..color = const Color(0x55FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.65),
      shimmerPhase,
      0.6, // arc length in radians
      false,
      shimmerPaint,
    );
  }
}
