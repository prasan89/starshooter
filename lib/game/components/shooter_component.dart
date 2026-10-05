import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// Placeholder Flame component for the bubble launcher / shooter.
///
/// Renders a glowing upward-pointing triangle at the bottom-centre of the
/// screen. Rotation, aiming, and shoot mechanics are added in M2.
class ShooterComponent extends PositionComponent {
  ShooterComponent() : super(priority: 5);

  // Triangl geometry — half-base and height in logical pixels.
  static const double _halfBase = 22.0;
  static const double _triangleHeight = 44.0;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // Anchor: bottom-centre of the screen, slightly above the edge.
    position = Vector2(
      size.x / 2,
      size.y - _triangleHeight - 24,
    );
  }

  @override
  void render(Canvas canvas) {
    // Build the triangle path (pointing upward, tip at y=0, base at y=height).
    final path = Path()
      ..moveTo(0, -_triangleHeight) // tip
      ..lineTo(-_halfBase, 0) // bottom-left
      ..lineTo(_halfBase, 0) // bottom-right
      ..close();

    // Glow / halo effect — a slightly larger blurred copy behind.
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Filled triangle — cosmic-blue gradient.
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.secondary],
        ).createShader(
          Rect.fromCenter(
            center: const Offset(0, -_triangleHeight / 2),
            width: _halfBase * 2,
            height: _triangleHeight,
          ),
        ),
    );

    // Outline.
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Small indicator circle at the barrel tip.
    canvas.drawCircle(
      const Offset(0, -_triangleHeight),
      4,
      Paint()..color = AppColors.starFilled,
    );

    // Dashed aim-line stub pointing straight up (3 dashes, purely decorative).
    _drawAimDashes(canvas);
  }

  void _drawAimDashes(Canvas canvas) {
    final dashPaint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double dashLen = 10.0;
    const double gap = 6.0;
    const int dashCount = 3;
    double y = -_triangleHeight - gap;
    for (int i = 0; i < dashCount; i++) {
      canvas.drawLine(
        Offset(0, y),
        Offset(0, y - dashLen),
        dashPaint,
      );
      y -= dashLen + gap;
    }
  }
}
