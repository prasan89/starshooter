import 'dart:math' show sin, pi;

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// A Flame component that renders an animated deep-space backdrop.
///
/// Features:
/// - Deep space base fill
/// - Three nebula lobes at distinct positions with slow drift
/// - 150 deterministic stars (seeded LCG) that slowly twinkle
///
/// Performance: star pixel positions and nebula paint objects are cached and
/// only recomputed on resize. Per-frame work is minimal: 2 sin() calls for
/// drift + 150 alpha computations + mutating a single reused Paint.
class CosmicBackgroundComponent extends PositionComponent {
  CosmicBackgroundComponent() : super(priority: -10) {
    _generateStars();
  }

  static const int _starCount = 150;
  static const int _seed = 0xDEADBEEF;

  // Per-star data (normalized [0,1] fractions).
  final List<double> _starFracX = [];
  final List<double> _starFracY = [];
  final List<double> _starR = [];
  final List<double> _starBrightness = [];
  final List<double> _starTwinklePhase = [];

  // Cached pixel positions — rebuilt on resize.
  final List<double> _starPxX = [];
  final List<double> _starPxY = [];

  double _time = 0.0;

  // ── Cached paint objects ─────────────────────────────────────────────────

  final _bgPaint = Paint()..color = AppColors.background;
  final _starPaint = Paint();
  final _nebulaPaint1 = Paint();
  final _nebulaPaint2 = Paint();
  final _nebulaPaint3 = Paint();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  void _generateStars() {
    int state = _seed;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;

    for (int i = 0; i < _starCount; i++) {
      _starFracX.add(nf());
      _starFracY.add(nf());
      _starR.add(
        (next() % 6 == 0)
            ? 1.8
            : (next() % 3 == 0)
                ? 1.3
                : 0.8,
      );
      _starBrightness.add(0.4 + nf() * 0.6);
      _starTwinklePhase.add(nf() * 2 * pi);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size.clone();
    _rebuildStarPixels(size);
    _rebuildNebulaPaints(size);
  }

  void _rebuildStarPixels(Vector2 sz) {
    if (_starFracX.isEmpty) return;
    _starPxX.clear();
    _starPxY.clear();
    for (int i = 0; i < _starFracX.length; i++) {
      _starPxX.add(_starFracX[i] * sz.x);
      _starPxY.add(_starFracY[i] * sz.y);
    }
  }

  void _rebuildNebulaPaints(Vector2 sz) {
    // Nebulae use fixed-position shaders; drift is handled per-frame by
    // offsetting the draw center, so we just need an initial shader here.
    // We rebuild on resize to use correct circle radii.
    final c1 = Offset(sz.x * 0.75, sz.y * 0.85);
    _nebulaPaint1.shader = RadialGradient(
      colors: [
        const Color(0xFF2D1B69).withValues(alpha: 0.12),
        AppColors.background.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: c1, radius: sz.x * 0.6));

    final c2 = Offset(sz.x * 0.30, sz.y * 0.40);
    _nebulaPaint2.shader = RadialGradient(
      colors: [
        const Color(0xFF1A1E4A).withValues(alpha: 0.18),
        AppColors.background.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: c2, radius: sz.x * 0.5));

    final c3 = Offset(sz.x * 0.70, sz.y * 0.15);
    _nebulaPaint3.shader = RadialGradient(
      colors: [
        AppColors.secondary.withValues(alpha: 0.07),
        AppColors.background.withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: c3, radius: sz.x * 0.4));
  }

  @override
  void update(double dt) {
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    final sz = size;
    if (sz.x == 0 || sz.y == 0) return;

    final driftX = sin(_time * 0.04) * 0.02;
    final driftY = sin(_time * 0.03 + 1.0) * 0.02;

    // 1. Base fill.
    canvas.drawRect(Rect.fromLTWH(0, 0, sz.x, sz.y), _bgPaint);

    // 2. Nebulae (drift is small; shaders are pre-baked at rest positions).
    canvas.drawCircle(
      Offset(sz.x * (0.75 + driftX), sz.y * (0.85 + driftY)),
      sz.x * 0.6,
      _nebulaPaint1,
    );
    canvas.drawCircle(
      Offset(sz.x * (0.30 - driftX), sz.y * (0.40 - driftY)),
      sz.x * 0.5,
      _nebulaPaint2,
    );
    canvas.drawCircle(
      Offset(sz.x * (0.70 + driftX * 0.5), sz.y * (0.15 - driftY * 0.5)),
      sz.x * 0.4,
      _nebulaPaint3,
    );

    // 3. Stars — single reused Paint, color mutated per star.
    if (_starPxX.isEmpty) return;
    for (int i = 0; i < _starPxX.length; i++) {
      final phase = _starTwinklePhase[i] + _time * 0.7;
      final twinkle = 0.7 + sin(phase) * 0.3;
      final alpha = (_starBrightness[i] * twinkle).clamp(0.0, 1.0);
      _starPaint.color =
          Color.fromARGB((alpha * 230).round(), 255, 255, 255);
      canvas.drawCircle(
        Offset(_starPxX[i], _starPxY[i]),
        _starR[i],
        _starPaint,
      );
    }
  }
}
