import 'dart:math' show pi;
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
        RadialGradient,
        Rect,
        StrokeCap;

/// Color theme for a premium star rendered as a 3D energy sphere.
class StarVisualStyle {
  const StarVisualStyle({
    required this.baseColor,
    required this.highlightColor,
    required this.shadowColor,
    required this.glowColor,
    required this.specularColor,
    required this.rimColor,
  });

  final Color baseColor;
  final Color highlightColor;
  final Color shadowColor;
  final Color glowColor;
  final Color specularColor;
  final Color rimColor;

  static const yellow = StarVisualStyle(
    baseColor: Color(0xFFFFAA00),
    highlightColor: Color(0xFFFFF0A0),
    shadowColor: Color(0xFF7A4400),
    glowColor: Color(0xFFFF8800),
    specularColor: Color(0xFFFFFFE0),
    rimColor: Color(0xFFFFEE88),
  );

  static const red = StarVisualStyle(
    baseColor: Color(0xFFEE2222),
    highlightColor: Color(0xFFFFCCCC),
    shadowColor: Color(0xFF660000),
    glowColor: Color(0xFFFF3333),
    specularColor: Color(0xFFFFEEEE),
    rimColor: Color(0xFFFF8888),
  );

  static const green = StarVisualStyle(
    baseColor: Color(0xFF11BB33),
    highlightColor: Color(0xFFAAFFCC),
    shadowColor: Color(0xFF004411),
    glowColor: Color(0xFF22DD44),
    specularColor: Color(0xFFEEFFEE),
    rimColor: Color(0xFF55FF88),
  );

  static const blue = StarVisualStyle(
    baseColor: Color(0xFF1177EE),
    highlightColor: Color(0xFFAADDFF),
    shadowColor: Color(0xFF001166),
    glowColor: Color(0xFF2299FF),
    specularColor: Color(0xFFEEF8FF),
    rimColor: Color(0xFF66AAFF),
  );

  static const purple = StarVisualStyle(
    baseColor: Color(0xFF9922EE),
    highlightColor: Color(0xFFEEBBFF),
    shadowColor: Color(0xFF330066),
    glowColor: Color(0xFFBB44FF),
    specularColor: Color(0xFFF5EEFF),
    rimColor: Color(0xFFCC77FF),
  );
}

/// Renders a premium 3D energy sphere at canvas [Offset.zero] with radius [r].
///
/// Seven rendering layers (back to front):
///   1. Outer atmospheric glow bloom
///   2. Sphere body with 3-stop radial gradient (upper-left light source)
///   3. Rim light stroke — subtle colored edge
///   4. Inner energy swirl arc — animated, blurred
///   5. Specular highlight ellipse (upper-left, compressed vertically)
///   6. Hotspot dot — tiny bright flare
///   7. Shimmer sweep arc — animated specular sweep
class PremiumStarRenderer {
  PremiumStarRenderer(this.style);

  final StarVisualStyle style;

  // Cached paints — never allocated in render()
  final _outerGlowPaint = Paint()..style = PaintingStyle.fill;
  final _bodyPaint = Paint()..style = PaintingStyle.fill;
  final _rimPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.2
    ..strokeCap = StrokeCap.round;
  final _swirlPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);
  final _specularPaint = Paint()..style = PaintingStyle.fill;
  final _hotspotPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xB3FFFFFF);
  final _shimmerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8
    ..strokeCap = StrokeCap.round
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);

  double _lastBodyR = 0.0;

  void render(
    Canvas canvas,
    double r, {
    double shimmerT = 0.0,
    double glowAlphaScale = 1.0,
  }) {
    // ── Layer 1: Outer atmospheric glow ────────────────────────────────────
    _outerGlowPaint
      ..color = style.glowColor.withValues(alpha: 0.25 * glowAlphaScale)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawCircle(Offset.zero, r * 1.6, _outerGlowPaint);

    // ── Layer 2: Sphere body with upper-left light source ──────────────────
    if ((r - _lastBodyR).abs() > 0.2) {
      _bodyPaint.shader = RadialGradient(
        center: const Alignment(-0.4, -0.45),
        radius: 1.0,
        colors: [
          style.highlightColor,
          style.baseColor,
          style.shadowColor,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: r));
      _lastBodyR = r;
    }
    canvas.drawCircle(Offset.zero, r, _bodyPaint);

    // ── Layer 3: Rim stroke ────────────────────────────────────────────────
    _rimPaint.color = style.rimColor.withValues(alpha: 0.4);
    canvas.drawCircle(Offset.zero, r, _rimPaint);

    // ── Layer 4: Inner energy swirl arc ────────────────────────────────────
    _swirlPaint.color = style.highlightColor.withValues(alpha: 0.35);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.55),
      shimmerT * 1.3,
      1.1,
      false,
      _swirlPaint,
    );
    _swirlPaint.color = style.glowColor.withValues(alpha: 0.20);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.68),
      shimmerT * 1.3 + pi,
      0.9,
      false,
      _swirlPaint,
    );

    // ── Layer 5: Specular highlight ellipse (upper-left) ──────────────────
    canvas.save();
    canvas.translate(-r * 0.32, -r * 0.36);
    canvas.scale(1.0, 0.65);
    _specularPaint.shader = RadialGradient(
      colors: [
        style.specularColor.withValues(alpha: 0.88),
        style.specularColor.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: r * 0.28));
    canvas.drawCircle(Offset.zero, r * 0.28, _specularPaint);
    canvas.restore();
    _specularPaint.shader = null;

    // ── Layer 6: Hotspot dot ────────────────────────────────────────────────
    _hotspotPaint.color = const Color(0xB3FFFFFF);
    canvas.drawCircle(Offset(-r * 0.42, -r * 0.42), r * 0.07, _hotspotPaint);

    // ── Layer 7: Shimmer sweep arc ─────────────────────────────────────────
    _shimmerPaint.color = style.specularColor.withValues(alpha: 0.30);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.70),
      shimmerT,
      0.7,
      false,
      _shimmerPaint,
    );
  }
}
