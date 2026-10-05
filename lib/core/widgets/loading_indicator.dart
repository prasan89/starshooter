import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// A themed loading indicator with a cosmic spinning animation.
///
/// Renders a rotating arc in the app's primary gradient colors.
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 3.0,
  });

  /// Diameter of the indicator.
  final double size;

  /// Width of the arc stroke.
  final double strokeWidth;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _CosmicSpinnerPainter(
            progress: _controller.value,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class _CosmicSpinnerPainter extends CustomPainter {
  const _CosmicSpinnerPainter({
    required this.progress,
    required this.strokeWidth,
  });

  final double progress;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track
    final trackPaint = Paint()
      ..color = AppColors.shimmerBase
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Spinning arc
    final arcPaint = Paint()
      ..shader = const SweepGradient(
        colors: [AppColors.primary, AppColors.secondary, AppColors.primary],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const sweepAngle = math.pi * 1.2;
    final startAngle = progress * math.pi * 2 - math.pi / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CosmicSpinnerPainter old) =>
      old.progress != progress;
}
