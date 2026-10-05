import 'dart:math' show sin, pi;

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';
import 'package:star_shooter/core/theme/app_colors.dart';

/// A Flame component that renders an animated deep-space backdrop.
///
/// Features:
/// - Deep space base fill
/// - Three nebula lobes at distinct positions (bottom-right, centre-left, top)
/// - 150 deterministic stars (seeded LCG) that slowly twinkle
/// - Very slow time-based drift on nebula centres (parallax feel, no input)
class CosmicBackgroundComponent extends PositionComponent {
  CosmicBackgroundComponent() : super(priority: -10);

  static const int _starCount = 150;
  static const int _seed = 0xDEADBEEF;

  // Per-star data
  final List<Offset> _starPos = [];
  final List<double> _starR = [];
  final List<double> _starBrightness = []; // base brightness [0.4, 1.0]
  final List<double> _starTwinklePhase = []; // phase offset for twinkle

  double _time = 0.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _generateStars();
  }

  void _generateStars() {
    int state = _seed;
    int next() {
      state = (state * 1664525 + 1013904223) & 0xFFFFFFFF;
      return state;
    }

    double nf() => (next() & 0xFFFF) / 65535.0;

    for (int i = 0; i < _starCount; i++) {
      _starPos.add(Offset(nf(), nf()));
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
  }

  @override
  void update(double dt) {
    _time += dt;
  }

  @override
  void render(Canvas canvas) {
    final sz = size;

    // Very slow parallax drift — nebula centres shift subtly over time.
    final driftX = sin(_time * 0.04) * 0.02; // ±2 % of width
    final driftY = sin(_time * 0.03 + 1.0) * 0.02; // ±2 % of height

    // 1. Base deep space fill
    canvas.drawRect(
      Rect.fromLTWH(0, 0, sz.x, sz.y),
      Paint()..color = AppColors.background,
    );

    // 2. Bottom nebula — warm purple at bottom-right
    final nebula1Center = Offset(
      sz.x * (0.75 + driftX),
      sz.y * (0.85 + driftY),
    );
    canvas.drawCircle(
      nebula1Center,
      sz.x * 0.6,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF2D1B69).withValues(alpha: 0.12),
            AppColors.background.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromCircle(center: nebula1Center, radius: sz.x * 0.6),
        ),
    );

    // 3. Mid nebula — cosmic blue centre-left
    final nebula2Center = Offset(
      sz.x * (0.3 - driftX),
      sz.y * (0.4 - driftY),
    );
    canvas.drawCircle(
      nebula2Center,
      sz.x * 0.5,
      Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF1A1E4A).withValues(alpha: 0.18),
            AppColors.background.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromCircle(center: nebula2Center, radius: sz.x * 0.5),
        ),
    );

    // 4. Top nebula — slight pink/purple
    final nebula3Center = Offset(
      sz.x * (0.7 + driftX * 0.5),
      sz.y * (0.15 - driftY * 0.5),
    );
    canvas.drawCircle(
      nebula3Center,
      sz.x * 0.4,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.secondary.withValues(alpha: 0.07),
            AppColors.background.withValues(alpha: 0.0),
          ],
        ).createShader(
          Rect.fromCircle(center: nebula3Center, radius: sz.x * 0.4),
        ),
    );

    // 5. Stars with twinkle
    for (int i = 0; i < _starPos.length; i++) {
      final phase = _starTwinklePhase[i] + _time * 0.7;
      final twinkle = 0.7 + sin(phase) * 0.3;
      final alpha = (_starBrightness[i] * twinkle).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(_starPos[i].dx * sz.x, _starPos[i].dy * sz.y),
        _starR[i],
        Paint()..color = Color.fromARGB((alpha * 230).round(), 255, 255, 255),
      );
    }
  }
}
