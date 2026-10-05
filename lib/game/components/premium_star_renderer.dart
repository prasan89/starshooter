import 'dart:math' show pi, sin, cos;
import 'dart:ui' show Color, MaskFilter, BlurStyle;

import 'package:flutter/painting.dart'
    show
        Alignment,
        Canvas,
        MaskFilter,
        BlurStyle,
        Offset,
        Paint,
        PaintingStyle,
        Path,
        RadialGradient,
        Rect,
        StrokeCap;

/// Color theme for a premium star.
class StarVisualStyle {
  const StarVisualStyle({
    required this.baseColor,
    required this.highlightColor,
    required this.shadowColor,
    required this.glowColor,
    required this.specularColor,
  });

  final Color baseColor;
  final Color highlightColor;
  final Color shadowColor;
  final Color glowColor;
  final Color specularColor;

  static const yellow = StarVisualStyle(
    baseColor: Color(0xFFFFCC00),
    highlightColor: Color(0xFFFFF5B0),
    shadowColor: Color(0xFFB87800),
    glowColor: Color(0xFFFFAA00),
    specularColor: Color(0xFFFFFFCC),
  );

  static const red = StarVisualStyle(
    baseColor: Color(0xFFFF2D2D),
    highlightColor: Color(0xFFFFBBBB),
    shadowColor: Color(0xFF8B0000),
    glowColor: Color(0xFFFF4444),
    specularColor: Color(0xFFFFEEEE),
  );

  static const green = StarVisualStyle(
    baseColor: Color(0xFF22CC44),
    highlightColor: Color(0xFFAAFFCC),
    shadowColor: Color(0xFF006620),
    glowColor: Color(0xFF33FF66),
    specularColor: Color(0xFFEEFFEE),
  );

  static const blue = StarVisualStyle(
    baseColor: Color(0xFF1E90FF),
    highlightColor: Color(0xFFAADDFF),
    shadowColor: Color(0xFF003399),
    glowColor: Color(0xFF44AAFF),
    specularColor: Color(0xFFEEF8FF),
  );

  static const purple = StarVisualStyle(
    baseColor: Color(0xFFAA44FF),
    highlightColor: Color(0xFFDDBBFF),
    shadowColor: Color(0xFF550088),
    glowColor: Color(0xFFBB66FF),
    specularColor: Color(0xFFF5EEFF),
  );
}

/// Builds a rounded, inflated 5-point star [Path] centered at [Offset.zero].
///
/// Cubic bezier curves through each tip and valley produce a soft, glossy shape
/// that reads as a premium collectible star rather than a harsh polygon.
Path buildPremiumStarPath(double r) {
  final outer = r;
  final inner = r * 0.44;
  final outerCtrl = r * 0.22;
  final innerCtrl = r * 0.10;

  final path = Path();

  for (int i = 0; i < 5; i++) {
    final tipAngle = (i * 2 * pi / 5) - pi / 2;
    final leftValleyAngle = tipAngle - pi / 5;
    final rightValleyAngle = tipAngle + pi / 5;

    final tip = Offset(cos(tipAngle) * outer, sin(tipAngle) * outer);
    final rightValley = Offset(cos(rightValleyAngle) * inner, sin(rightValleyAngle) * inner);

    final tipCtrlLeft = Offset(
      cos(tipAngle - 0.35) * (outer - outerCtrl),
      sin(tipAngle - 0.35) * (outer - outerCtrl),
    );
    final tipCtrlRight = Offset(
      cos(tipAngle + 0.35) * (outer - outerCtrl),
      sin(tipAngle + 0.35) * (outer - outerCtrl),
    );
    final leftValleyCtrl = Offset(
      cos(leftValleyAngle + 0.25) * (inner + innerCtrl),
      sin(leftValleyAngle + 0.25) * (inner + innerCtrl),
    );
    final rightValleyCtrl = Offset(
      cos(rightValleyAngle - 0.25) * (inner + innerCtrl),
      sin(rightValleyAngle - 0.25) * (inner + innerCtrl),
    );

    if (i == 0) {
      path.moveTo(tip.dx, tip.dy);
    } else {
      path.cubicTo(
        leftValleyCtrl.dx, leftValleyCtrl.dy,
        tipCtrlLeft.dx, tipCtrlLeft.dy,
        tip.dx, tip.dy,
      );
    }

    path.cubicTo(
      tipCtrlRight.dx, tipCtrlRight.dy,
      rightValleyCtrl.dx, rightValleyCtrl.dy,
      rightValley.dx, rightValley.dy,
    );
  }

  // Close back to tip 0 via the last left-valley.
  const firstTipAngle = -pi / 2;
  const lastValleyAngle = firstTipAngle - pi / 5;
  final firstTip = Offset(cos(firstTipAngle) * outer, sin(firstTipAngle) * outer);
  final lastValleyCtrl = Offset(
    cos(lastValleyAngle + 0.25) * (inner + innerCtrl),
    sin(lastValleyAngle + 0.25) * (inner + innerCtrl),
  );
  final firstTipCtrlLeft = Offset(
    cos(firstTipAngle - 0.35) * (outer - outerCtrl),
    sin(firstTipAngle - 0.35) * (outer - outerCtrl),
  );
  path.cubicTo(
    lastValleyCtrl.dx, lastValleyCtrl.dy,
    firstTipCtrlLeft.dx, firstTipCtrlLeft.dy,
    firstTip.dx, firstTip.dy,
  );

  path.close();
  return path;
}

/// Renders a premium-quality star at canvas [Offset.zero] with outer radius [r].
///
/// Layers (back to front):
///   1. Outer soft glow bloom (two passes)
///   2. Star body with 3-stop radial gradient (bright top-left → base → shadow)
///   3. Inner shadow overlay (lower-right darkening)
///   4. Rim highlight stroke
///   5. Glossy specular ellipse (top-left)
///   6. Animated shimmer arc
class PremiumStarRenderer {
  PremiumStarRenderer(this.style);

  final StarVisualStyle style;

  Path? _cachedPath;
  double _cachedR = 0;

  Path _path(double r) {
    if (_cachedPath == null || (r - _cachedR).abs() > 0.2) {
      _cachedPath = buildPremiumStarPath(r);
      _cachedR = r;
    }
    return _cachedPath!;
  }

  final _glowPaint = Paint()..style = PaintingStyle.fill;
  final _bodyPaint = Paint()..style = PaintingStyle.fill;
  final _innerShadowPaint = Paint()..style = PaintingStyle.fill;
  final _rimPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round;
  final _specularPaint = Paint()
    ..style = PaintingStyle.fill
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
  final _shimmerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..strokeCap = StrokeCap.round
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5)
    ..color = const Color(0x00000000); // overwritten in render()

  double _lastBodyR = 0;

  void render(
    Canvas canvas,
    double r, {
    double shimmerT = 0.0,
    double glowAlphaScale = 1.0,
  }) {
    final path = _path(r);
    final rect = Rect.fromCircle(center: Offset.zero, radius: r);

    // ── Layer 1: Outer glow bloom ───────────────────────────────────────────
    _glowPaint
      ..color = style.glowColor.withValues(alpha: 0.28 * glowAlphaScale)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawPath(buildPremiumStarPath(r * 1.40), _glowPaint);

    _glowPaint
      ..color = style.glowColor.withValues(alpha: 0.18 * glowAlphaScale)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
    canvas.drawPath(buildPremiumStarPath(r * 1.15), _glowPaint);

    // ── Layer 2: Star body radial gradient ─────────────────────────────────
    if ((r - _lastBodyR).abs() > 0.2) {
      _bodyPaint.shader = RadialGradient(
        center: const Alignment(-0.35, -0.45),
        radius: 1.0,
        colors: [
          style.highlightColor,
          style.baseColor,
          style.shadowColor,
        ],
        stops: const [0.0, 0.52, 1.0],
      ).createShader(rect);
      _lastBodyR = r;
    }
    _glowPaint.maskFilter = null; // clear blur before body draw
    canvas.drawPath(path, _bodyPaint);

    // ── Layer 3: Inner shadow (lower-right darkening) ──────────────────────
    _innerShadowPaint.shader = RadialGradient(
      center: const Alignment(0.5, 0.55),
      radius: 0.8,
      colors: [
        style.shadowColor.withValues(alpha: 0.45),
        const Color(0x00000000),
      ],
      stops: const [0.0, 1.0],
    ).createShader(rect);
    canvas.drawPath(path, _innerShadowPaint);

    // ── Layer 4: Rim highlight stroke ──────────────────────────────────────
    _rimPaint.color = style.highlightColor.withValues(alpha: 0.55);
    canvas.drawPath(path, _rimPaint);

    // ── Layer 5: Glossy specular ellipse (top-left) ────────────────────────
    canvas.save();
    canvas.translate(-r * 0.20, -r * 0.28);
    canvas.scale(1.0, 0.65);
    _specularPaint.shader = RadialGradient(
      colors: [
        style.specularColor.withValues(alpha: 0.90),
        style.specularColor.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: r * 0.28));
    canvas.drawCircle(Offset.zero, r * 0.28, _specularPaint);
    canvas.restore();

    // Small secondary specular dot.
    _specularPaint
      ..shader = null
      ..color = style.specularColor.withValues(alpha: 0.55)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.drawCircle(Offset(-r * 0.30, -r * 0.34), r * 0.10, _specularPaint);

    // ── Layer 6: Animated shimmer arc ──────────────────────────────────────
    _shimmerPaint.color = style.specularColor.withValues(alpha: 0.38);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.62),
      shimmerT,
      0.7,
      false,
      _shimmerPaint,
    );
  }
}
