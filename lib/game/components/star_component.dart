import 'dart:math' show pi, sin, cos;

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/game/models/star_model.dart';
import 'package:star_shooter/game/models/star_type.dart';

/// A Flame [PositionComponent] that renders a single [StarModel] on the board.
///
/// The component is centred on its [position]; set that to the pixel centre
/// returned by [BoardGrid.gridToPixel] before adding to the scene.
///
/// Visual features (M5):
///   - Idle breathing animation: gentle scale oscillation over ~2 s cycle.
///   - Shimmer arc: a bright arc that sweeps around the sphere periodically.
///   - Rich 3D-sphere: radial gradient bright top-left → darker bottom-right.
///   - Outer glow halo with soft blur.
///   - Inner specular highlight (white dot, top-left).
///   - Rim-light arc at bottom for depth.
///   - Type-specific rendering for each special star type.
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

  // Per-type animation state.
  double _rainbowAngle = 0.0;
  double _orbitAngle = 0.0;

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

    // Breathing scale: oscillates between (1 - amp) and (1 + amp).
    final breathePhase = (_breatheT / _breathePeriod) * 2 * pi;
    final scale = 1.0 + sin(breathePhase) * _breatheAmplitude;
    final r = _radius * scale;

    switch (model.type) {
      case StarType.normal:
        _renderNormal(canvas, r, color);
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

  // ---------------------------------------------------------------------------
  // Normal star
  // ---------------------------------------------------------------------------

  void _renderNormal(Canvas canvas, double r, Color color) {
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

  // ---------------------------------------------------------------------------
  // Meteor star — orange-red, elongated, fire tail dots
  // ---------------------------------------------------------------------------

  void _renderMeteor(Canvas canvas, double r, Color color) {
    const tailColor = Color(0xFFFF4500);
    const coreColor = Color(0xFFFFD700);

    // Outer glow halo (orange tint).
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: r * 1.5 * 1.2,
        height: r * 1.5,
      ),
      Paint()
        ..color = color.withValues(alpha: 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Main elongated oval body (1.2x horizontal stretch).
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: r * 2 * 1.2,
        height: r * 2,
      ),
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: [coreColor, color, tailColor],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(
          Rect.fromCenter(
            center: Offset.zero,
            width: r * 2 * 1.2,
            height: r * 2,
          ),
        ),
    );

    // Outline.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: r * 2 * 1.2,
        height: r * 2,
      ),
      Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Fire tail: 3 trailing dots behind the star (to the right / positive x).
    final tailOffsets = [
      Offset(r * 1.4, 0.0),
      Offset(r * 1.9, -r * 0.2),
      Offset(r * 2.3, r * 0.15),
    ];
    final tailAlphas = [0.75, 0.55, 0.35];
    final tailRadii = [r * 0.20, r * 0.14, r * 0.10];

    for (int i = 0; i < 3; i++) {
      canvas.drawCircle(
        tailOffsets[i],
        tailRadii[i],
        Paint()
          ..color = tailColor.withValues(alpha: tailAlphas[i])
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }

    // Specular highlight.
    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.20,
      Paint()..color = const Color(0x66FFFFFF),
    );
  }

  // ---------------------------------------------------------------------------
  // Rainbow star — concentric colored rings, slowly rotating
  // ---------------------------------------------------------------------------

  void _renderRainbow(Canvas canvas, double r) {
    // Rainbow ring colors (5 of 7).
    const ringColors = [
      Color(0xFFFF0040), // red
      Color(0xFFFF9900), // orange
      Color(0xFFFFFF00), // yellow
      Color(0xFF00FF80), // green
      Color(0xFF00D4FF), // cyan
    ];

    // Outer glow halo.
    canvas.drawCircle(
      Offset.zero,
      r * 1.6,
      Paint()
        ..color = const Color(0xFF00D4FF).withValues(alpha: 0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Draw concentric rings from largest to smallest.
    for (int i = 0; i < ringColors.length; i++) {
      final fraction = 1.0 - (i / ringColors.length);
      final ringR = r * fraction;
      final alpha = 0.35 +
          (i / ringColors.length) * 0.55; // outer transparent → inner opaque
      canvas.drawCircle(
        Offset.zero,
        ringR,
        Paint()
          ..color = ringColors[i].withValues(alpha: alpha)
          ..style = PaintingStyle.fill,
      );
    }

    // Rotating outline ring.
    final rotatePaint = Paint()
      ..color = const Color(0xAAFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawArc(
      Rect.fromCircle(center: Offset.zero, radius: r * 1.05),
      _rainbowAngle,
      1.2,
      false,
      rotatePaint,
    );

    // Specular.
    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.18,
      Paint()..color = const Color(0x66FFFFFF),
    );
  }

  // ---------------------------------------------------------------------------
  // Supernova star — hot pink, aggressive breathe, 6 radiating spikes
  // ---------------------------------------------------------------------------

  void _renderSupernova(
      Canvas canvas, double r, Color color, double breathePhase,) {
    const supernovaAmplitude = 0.15;
    final superScale = 1.0 + sin(breathePhase) * supernovaAmplitude;
    final sr = r * superScale;

    // Intense outer glow.
    canvas.drawCircle(
      Offset.zero,
      sr * 1.7,
      Paint()
        ..color = color.withValues(alpha: 0.22)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );

    // Main sphere.
    final brightColor = Color.lerp(color, const Color(0xFFFFFFFF), 0.45)!;
    final darkColor = Color.lerp(color, const Color(0xFF000000), 0.20)!;
    canvas.drawCircle(
      Offset.zero,
      sr,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: [brightColor, color, darkColor],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: sr)),
    );

    // 6 radiating spikes at 60° intervals.
    final spikeLength = sr * (1.3 + sin(breathePhase) * 0.2);
    final spikePaint = Paint()
      ..color = color.withValues(alpha: 0.80)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    for (int i = 0; i < 6; i++) {
      final angle = i * (pi / 3);
      canvas.drawLine(
        Offset.zero,
        Offset(cos(angle) * spikeLength, sin(angle) * spikeLength),
        spikePaint,
      );
    }

    // Outline.
    canvas.drawCircle(
      Offset.zero,
      sr,
      Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Specular.
    canvas.drawCircle(
      Offset(-sr * 0.28, -sr * 0.28),
      sr * 0.22,
      Paint()..color = const Color(0x77FFFFFF),
    );
  }

  // ---------------------------------------------------------------------------
  // Black hole — dark core, bright event horizon, orbiting dot
  // ---------------------------------------------------------------------------

  void _renderBlackHole(Canvas canvas, double r) {
    const coreColor = Color(0xFF0A0020);
    const horizonColor = Color(0xFF9B59FF);
    const orbitColor = Color(0xFFD4AAFF);

    // Dark core with very subtle gradient.
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.2, -0.2),
          colors: [
            Color(0xFF1A0A40),
            coreColor,
            Color(0xFF000000),
          ],
          stops: [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: r)),
    );

    // Bright event horizon ring with glow.
    canvas.drawCircle(
      Offset.zero,
      r * 1.05,
      Paint()
        ..color = horizonColor.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(
      Offset.zero,
      r * 1.05,
      Paint()
        ..color = horizonColor.withValues(alpha: 0.50)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Outer accretion glow.
    canvas.drawCircle(
      Offset.zero,
      r * 1.5,
      Paint()
        ..color = horizonColor.withValues(alpha: 0.10)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Orbiting dot.
    final orbitRadius = r * 1.45;
    final orbitX = cos(_orbitAngle) * orbitRadius;
    final orbitY = sin(_orbitAngle) * orbitRadius;
    canvas.drawCircle(
      Offset(orbitX, orbitY),
      r * 0.12,
      Paint()
        ..color = orbitColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );
    canvas.drawCircle(
      Offset(orbitX, orbitY),
      r * 0.08,
      Paint()..color = orbitColor,
    );

    // No specular highlight — black holes don't reflect light.
  }

  // ---------------------------------------------------------------------------
  // Frozen star — snowflake spikes, crystalline, crack overlay when frozen
  // ---------------------------------------------------------------------------

  void _renderFrozenStar(Canvas canvas, double r) {
    // If fully thawed, render as a normal-looking star with frozen color.
    if (model.isThawed) {
      _renderNormal(canvas, r, model.type.color);
      return;
    }

    const iceWhite = Color(0xFFE8F4FF);
    const iceCyan = Color(0xFF87CEEB);

    // Outer glow.
    canvas.drawCircle(
      Offset.zero,
      r * 1.5,
      Paint()
        ..color = iceCyan.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Main sphere — crystalline, mostly white with slight blue.
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.35, -0.35),
          colors: [iceWhite, iceCyan, Color(0xFF5BA3CC)],
          stops: [0.0, 0.55, 1.0],
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: r)),
    );

    // Outline.
    canvas.drawCircle(
      Offset.zero,
      r,
      Paint()
        ..color = iceWhite.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Snowflake: 6 crystal spikes at 60° intervals.
    final spikePaint = Paint()
      ..color = iceWhite.withValues(alpha: 0.90)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 6; i++) {
      final angle = i * (pi / 3);
      canvas.drawLine(
        Offset.zero,
        Offset(cos(angle) * r, sin(angle) * r),
        spikePaint,
      );
    }

    // Specular.
    canvas.drawCircle(
      Offset(-r * 0.28, -r * 0.28),
      r * 0.22,
      Paint()..color = const Color(0x88FFFFFF),
    );

    // Crack overlay when frozen (frozenHitsRemaining > 0).
    if (model.isFrozen) {
      // More hits remaining → fewer cracks (star is more intact).
      // Fewer hits remaining → more cracks (nearly thawed).
      final hits = model.frozenHitsRemaining;
      final maxHits =
          hits + 1; // approximate max; cracks shown = maxHits - hits
      final cracksVisible = (maxHits - hits).clamp(1, 4);

      final crackPaint = Paint()
        ..color = const Color(0xFF1A3A5C).withValues(alpha: 0.55)
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Predetermined crack line endpoints (relative to radius).
      final crackLines = [
        [Offset(-r * 0.1, -r * 0.3), Offset(r * 0.35, r * 0.10)],
        [Offset(r * 0.05, r * 0.2), Offset(-r * 0.40, r * 0.50)],
        [Offset(-r * 0.30, r * 0.05), Offset(r * 0.20, -r * 0.45)],
        [Offset(r * 0.20, -r * 0.10), Offset(-r * 0.15, r * 0.55)],
      ];

      for (int i = 0; i < cracksVisible && i < crackLines.length; i++) {
        canvas.drawLine(crackLines[i][0], crackLines[i][1], crackPaint);
      }
    }
  }
}
