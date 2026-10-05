import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/game/models/star_model.dart';

/// A Flame [PositionComponent] that renders a single [StarModel] on the board.
///
/// The component is centred on its [position]; set that to the pixel centre
/// returned by [BoardGrid.gridToPixel] before adding to the scene.
class StarComponent extends PositionComponent {
  StarModel model;

  StarComponent(this.model)
      : super(
          anchor: Anchor.center,
          priority: 1,
        );

  // Radius matches BoardConfig.starRadius default; kept local so StarComponent
  // has no hard dependency on BoardConfig.
  static const double _radius = 22.0;

  @override
  void render(Canvas canvas) {
    final color = model.type.color;

    // Glow halo.
    canvas.drawCircle(
      Offset.zero,
      _radius * 1.35,
      Paint()
        ..color = color.withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );

    // Filled star disc with a simple radial gradient.
    canvas.drawCircle(
      Offset.zero,
      _radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0.55)],
        ).createShader(
          Rect.fromCircle(center: Offset.zero, radius: _radius),
        ),
    );

    // Outline.
    canvas.drawCircle(
      Offset.zero,
      _radius,
      Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Central highlight dot to give a sense of depth.
    canvas.drawCircle(
      const Offset(-4, -4),
      4,
      Paint()..color = const Color(0x59FFFFFF),
    );
  }
}
