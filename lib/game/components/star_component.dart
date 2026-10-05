import 'dart:math' show pi, sin, cos;

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// A Flame [PositionComponent] that renders a single [StarModel] on the board.
///
/// Visual features:
///   - Idle breathing animation: gentle scale oscillation over ~2 s cycle.
///   - Shimmer arc: a bright arc that sweeps around the sphere periodically.
///   - Rich 3D-sphere: radial gradient bright top-left → darker bottom-right.
///   - Outer glow halo with soft blur.
///   - Inner specular highlight (white dot, top-left).
///   - Rim-light arc at bottom for depth.
///   - Type-specific rendering for each special star type.
///
/// All Paint objects are cached as instance fields to avoid per-frame heap
/// allocation. Gradient shaders are re-created only when the rendered radius
/// changes (breathing scale). All animations are time-based via [update(dt)].
class StarComponent extends PositionComponent {
  StarModel model;

  static const double _radius = 22.0;
  static const double _breathePeriod = 2.2;
  static const double _shimmerPeriod = 3.5;
  static const double _breatheAmplitude = 0.05;

  double _breatheT = 0.0;
  double _shimmerT = 0.0;
  double _rainbowAngle = 0.0;
  double _orbitAngle = 0.0;

  // ── Cached Paint objects ─────────────────────────────────────────────────

  // Shared / reusable paints.
  final _glowPaint = Paint();
  final _spherePaint = Paint();
  final _outlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  final _rimPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
  final _specularPaint = Paint()
    ..color = const Color(0x77FFFFFF);
  final _shimmerPaint = Paint()
    ..color = const Color(0x55FFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5
    ..strokeCap = StrokeCap.round
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
  final _spikePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.8
    ..strokeCap = StrokeCap.round
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

  // Black hole specific.
  final _horizonGlowPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
  final _horizonLinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  final _accretionPaint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
  final _orbitGlowPaint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
  final _orbitCorePaint = Paint()
    ..color = const Color(0xFFD4AAFF);

  // Frozen star specific.
  final _iceGlowPaint = Paint()
    ..color = const Color(0xFF87CEEB).withValues(alpha: 0.15)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
  final _iceSpikePaint = Paint()
    ..color = const Color(0xFFE8F4FF).withValues(alpha: 0.90)
    ..strokeWidth = 1.5
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;
  final _iceSpecularPaint = Paint()
    ..color = const Color(0x88FFFFFF);
  final _crackPaint = Paint()
    ..color = const Color(0xFF1A3A5C).withValues(alpha: 0.55)
    ..strokeWidth = 1.2
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  // Rainbow specific.
  final _rainbowGlowPaint = Paint()
    ..color = const Color(0xFF00D4FF).withValues(alpha: 0.12)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
  final _rotatePaint = Paint()
    ..color = const Color(0xAAFFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5;
  final _rainbowSpecularPaint = Paint()
    ..color = const Color(0x66FFFFFF);

  // Meteor specific.
  final _meteorGlowPaint = Paint()
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
  final _meteorBodyPaint = Paint();
  final _meteorOutlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  final _meteorSpecularPaint = Paint()
    ..color = const Color(0x66FFFFFF);
  final List<Paint> _tailPaints = [
    Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
  ];

  // Black hole core paint with shader.
  final _bhCorePaint = Paint();

  // Gradient shader cache — recomputed only when radius changes.
  double _lastR = 0.0;

  StarComponent(this.model) : super(anchor: Anchor.center, priority: 1);

  @override
  void update(double dt) {
    _breatheT = (_breatheT + dt) % _breathePeriod;
    _shimmerT = (_shimmerT + dt) % _shimmerPeriod;
    _rainbowAngle += dt * 0.5;
    _orbitAngle += dt * 2.0;
  }

  @override
  void render(Canvas canvas) {
    final color = model.type.color;
    final breathePhase = (_breatheT / _breathePeriod) * 2 * pi;
    final scale = 1.0 + sin(breathePhase) * _breatheAmplitude;
    final r = _radius * scale;

    // Only rebuild gradient shaders when radius changes by more than 0.1px.
    if ((r - _lastR).abs() > 0.1) {
      _rebuildShaders(r, color);
      _lastR = r;
    }

    switch (model.type) {
      case StarType.normal:
        _renderNormal(canvas, r, color, breathePhase);
      case StarType.meteor:
        _renderMeteor(canvas, r, color);
      case StarType.rainbow:
        _renderRainbow(canvas, r);
      case StarType.supernova:
        _renderSupernova(canvas, r, color, breathePhase);
      case StarType.blackHole:
        _renderBlackHole(canvas, r);
      case StarType.frozenStar:
        _renderFrozenStar(canvas, r);
    }
  }

  void _rebuildShaders(double r, Color color) {
    final rect = Rect.fromCircle(center: Offset.zero, radius: r);
    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.35)!;
    final darkColor = Color.lerp(color, const Color(0xFF000000), 0.25)!;

    // Normal / supernova sphere gradient.
    _spherePaint.shader = RadialGradient(
      center: const Alignment(-0.4, -0.4),
      colors: [brightColor, color, darkColor],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(rect);

    // Black hole core gradient.
    _bhCorePaint.shader = const RadialGradient(
      center: Alignment(-0.2, -0.2),
      colors: [
        Color(0xFF1A0A40),
        Color(0xFF0A0020),
        Color(0xFF000000),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(rect);

    // Meteor body gradient (oval rect).
    final meteorRect = Rect.fromCenter(
      center: Offset.zero,
      width: r * 2 * 1.2,
      height: r * 2,
    );
    _meteorBodyPaint.shader = const RadialGradient(
      center: Alignment(-0.3, -0.3),
      colors: [Color(0xFFFFD700), Color(0xFFFF6600), Color(0xFFFF4500)],
      stops: [0.0, 0.45, 1.0],
    ).createShader(meteorRect);

    // Frozen star sphere gradient (constant colors so no color arg needed).
    // Recomputed here only because rect depends on r.
    _spherePaint.shader = RadialGradient(
      center: const Alignment(-0.4, -0.4),
      colors: [brightColor, color, darkColor],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(rect);
  }

  // ---------------------------------------------------------------------------
  // Normal star
  // ---------------------------------------------------------------------------

  void _renderNormal(Canvas canvas, double r, Color color, double breathePhase) {
    _glowPaint
      ..color = color.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(Offset.zero, r * 1.5, _glowPaint);

    // Rebuild sphere gradient for this specific color (type may change).
    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.35)!;
    final darkColor = Color.lerp(color, const Color(0xFF000000), 0.25)!;
    _spherePaint.shader = RadialGradient(
      center: const Alignment(-0.4, -0.4),
      colors: [brightColor, color, darkColor],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: r));
    canvas.drawCircle(Offset.zero, r, _spherePaint);

    _outlinePaint.color = color.withValues(alpha: 0.8);
    canvas.drawCircle(Offset.zero, r, _outlinePaint);

    _rimPaint.color = color.withValues(alpha: 0.35);
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.88),
      0.5 * pi,
      pi,
      false,
      _rimPaint,
    );

    canvas.drawCircle(Offset(-r * 0.28, -r * 0.28), r * 0.22, _specularPaint);

    final shimmerPhase = (_shimmerT / _shimmerPeriod) * 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 0.65),
      shimmerPhase,
      0.6,
      false,
      _shimmerPaint,
    );
  }

  // ---------------------------------------------------------------------------
  // Meteor star
  // ---------------------------------------------------------------------------

  void _renderMeteor(Canvas canvas, double r, Color color) {
    const tailColor = Color(0xFFFF4500);
    final meteorRect = Rect.fromCenter(
      center: Offset.zero,
      width: r * 2 * 1.2,
      height: r * 2,
    );

    _meteorGlowPaint.color = color.withValues(alpha: 0.2);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: r * 1.5 * 1.2,
        height: r * 1.5,
      ),
      _meteorGlowPaint,
    );

    _meteorBodyPaint.shader = const RadialGradient(
      center: Alignment(-0.3, -0.3),
      colors: [Color(0xFFFFD700), Color(0xFFFF6600), Color(0xFFFF4500)],
      stops: [0.0, 0.45, 1.0],
    ).createShader(meteorRect);
    canvas.drawOval(meteorRect, _meteorBodyPaint);

    _meteorOutlinePaint.color = color.withValues(alpha: 0.7);
    canvas.drawOval(meteorRect, _meteorOutlinePaint);

    final tailOffsets = [
      Offset(r * 1.4, 0.0),
      Offset(r * 1.9, -r * 0.2),
      Offset(r * 2.3, r * 0.15),
    ];
    final tailAlphas = [0.75, 0.55, 0.35];
    final tailRadii = [r * 0.20, r * 0.14, r * 0.10];

    for (int i = 0; i < 3; i++) {
      _tailPaints[i].color = tailColor.withValues(alpha: tailAlphas[i]);
      canvas.drawCircle(tailOffsets[i], tailRadii[i], _tailPaints[i]);
    }

    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.20,
      _meteorSpecularPaint,
    );
  }

  // ---------------------------------------------------------------------------
  // Rainbow star
  // ---------------------------------------------------------------------------

  void _renderRainbow(Canvas canvas, double r) {
    const ringColors = [
      Color(0xFFFF0040),
      Color(0xFFFF9900),
      Color(0xFFFFFF00),
      Color(0xFF00FF80),
      Color(0xFF00D4FF),
    ];

    canvas.drawCircle(Offset.zero, r * 1.6, _rainbowGlowPaint);

    for (int i = 0; i < ringColors.length; i++) {
      final fraction = 1.0 - (i / ringColors.length);
      final ringR = r * fraction;
      final alpha = 0.35 + (i / ringColors.length) * 0.55;
      _spherePaint.color = ringColors[i].withValues(alpha: alpha);
      _spherePaint.shader = null;
      _spherePaint.style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, ringR, _spherePaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 1.05),
      _rainbowAngle,
      1.2,
      false,
      _rotatePaint,
    );

    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.18,
      _rainbowSpecularPaint,
    );
  }

  // ---------------------------------------------------------------------------
  // Supernova star
  // ---------------------------------------------------------------------------

  void _renderSupernova(
    Canvas canvas,
    double r,
    Color color,
    double breathePhase,
  ) {
    const supernovaAmplitude = 0.15;
    final superScale = 1.0 + sin(breathePhase) * supernovaAmplitude;
    final sr = r * superScale;

    _glowPaint
      ..color = color.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawCircle(Offset.zero, sr * 1.7, _glowPaint);

    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.45)!;
    final darkColor = Color.lerp(color, const Color(0xFF000000), 0.20)!;
    _spherePaint.shader = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      colors: [brightColor, color, darkColor],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: sr));
    _spherePaint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, sr, _spherePaint);

    final spikeLength = sr * (1.3 + sin(breathePhase) * 0.2);
    _spikePaint.color = color.withValues(alpha: 0.80);
    for (int i = 0; i < 6; i++) {
      final angle = i * (pi / 3);
      canvas.drawLine(
        Offset.zero,
        Offset(cos(angle) * spikeLength, sin(angle) * spikeLength),
        _spikePaint,
      );
    }

    _outlinePaint.color = color.withValues(alpha: 0.7);
    canvas.drawCircle(Offset.zero, sr, _outlinePaint);

    canvas.drawCircle(Offset(-sr * 0.28, -sr * 0.28), sr * 0.22, _specularPaint);
  }

  // ---------------------------------------------------------------------------
  // Black hole
  // ---------------------------------------------------------------------------

  void _renderBlackHole(Canvas canvas, double r) {
    const horizonColor = Color(0xFF9B59FF);

    _bhCorePaint.shader = const RadialGradient(
      center: Alignment(-0.2, -0.2),
      colors: [
        Color(0xFF1A0A40),
        Color(0xFF0A0020),
        Color(0xFF000000),
      ],
      stops: [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: r));
    canvas.drawCircle(Offset.zero, r, _bhCorePaint);

    _horizonGlowPaint.color = horizonColor.withValues(alpha: 0.85);
    canvas.drawCircle(Offset.zero, r * 1.05, _horizonGlowPaint);

    _horizonLinePaint.color = horizonColor.withValues(alpha: 0.50);
    canvas.drawCircle(Offset.zero, r * 1.05, _horizonLinePaint);

    _accretionPaint.color = horizonColor.withValues(alpha: 0.10);
    canvas.drawCircle(Offset.zero, r * 1.5, _accretionPaint);

    final orbitRadius = r * 1.45;
    final orbitX = cos(_orbitAngle) * orbitRadius;
    final orbitY = sin(_orbitAngle) * orbitRadius;
    _orbitGlowPaint.color = const Color(0xFFD4AAFF);
    canvas.drawCircle(Offset(orbitX, orbitY), r * 0.12, _orbitGlowPaint);
    canvas.drawCircle(Offset(orbitX, orbitY), r * 0.08, _orbitCorePaint);
  }

  // ---------------------------------------------------------------------------
  // Frozen star
  // ---------------------------------------------------------------------------

  void _renderFrozenStar(Canvas canvas, double r) {
    if (model.isThawed) {
      _renderNormal(canvas, r, model.type.color, (_breatheT / _breathePeriod) * 2 * pi);
      return;
    }

    const iceWhite = Color(0xFFE8F4FF);
    const iceCyan = Color(0xFF87CEEB);

    canvas.drawCircle(Offset.zero, r * 1.5, _iceGlowPaint);

    _spherePaint.shader = const RadialGradient(
      center: Alignment(-0.35, -0.35),
      colors: [iceWhite, iceCyan, Color(0xFF5BA3CC)],
      stops: [0.0, 0.55, 1.0],
    ).createShader(Rect.fromCircle(center: Offset.zero, radius: r));
    _spherePaint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, r, _spherePaint);

    _outlinePaint.color = iceWhite.withValues(alpha: 0.8);
    canvas.drawCircle(Offset.zero, r, _outlinePaint);

    for (int i = 0; i < 6; i++) {
      final angle = i * (pi / 3);
      canvas.drawLine(
        Offset.zero,
        Offset(cos(angle) * r, sin(angle) * r),
        _iceSpikePaint,
      );
    }

    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.22,
      _iceSpecularPaint,
    );

    if (model.isFrozen) {
      final hits = model.frozenHitsRemaining;
      final maxHits = hits + 1;
      final cracksVisible = (maxHits - hits).clamp(1, 4);

      final crackLines = [
        [Offset(-r * 0.1, -r * 0.3), Offset(r * 0.35, r * 0.10)],
        [Offset(r * 0.05, r * 0.2), Offset(-r * 0.40, r * 0.50)],
        [Offset(-r * 0.30, r * 0.05), Offset(r * 0.20, -r * 0.45)],
        [Offset(r * 0.20, -r * 0.10), Offset(-r * 0.15, r * 0.55)],
      ];

      for (int i = 0; i < cracksVisible && i < crackLines.length; i++) {
        canvas.drawLine(crackLines[i][0], crackLines[i][1], _crackPaint);
      }
    }
  }
}
