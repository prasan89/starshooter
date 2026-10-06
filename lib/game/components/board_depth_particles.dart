import 'dart:math' show Random, sin;
import 'dart:ui';

import 'package:flame/components.dart';

/// 25 tiny cosmic dust particles that drift very slowly within the board area,
/// giving empty space some life. Extremely subtle — alpha 0.06–0.18 only.
class BoardDepthParticles extends PositionComponent {
  final double _boardWidth;
  final double _boardHeight;
  late final List<_DustParticle> _particles;

  final _paint = Paint()..style = PaintingStyle.fill;

  BoardDepthParticles({
    required double boardWidth,
    required double boardHeight,
  })  : _boardWidth = boardWidth,
        _boardHeight = boardHeight,
        super(priority: 1);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final rng = Random(0xDEADBEEF);
    _particles = List.generate(25, (i) {
      final speed = 2.0 + rng.nextDouble() * 6.0;
      return _DustParticle(
        x: rng.nextDouble() * _boardWidth,
        y: rng.nextDouble() * _boardHeight,
        vx: speed * (rng.nextDouble() - 0.5) * 0.4,
        vy: speed * (rng.nextDouble() - 0.5) * 0.4 - 0.5,
        radius: 0.4 + rng.nextDouble() * 0.8,
        baseAlpha: 0.06 + rng.nextDouble() * 0.12,
        twinkleSpeed: 0.4 + rng.nextDouble() * 1.2,
        twinklePhase: rng.nextDouble() * 2 * 3.1415926535,
        // Blue-white tint
        color: rng.nextDouble() > 0.5
            ? const Color(0xFFB8D4FF)
            : const Color(0xFFFFFFFF),
      );
    });
  }

  @override
  void update(double dt) {
    for (final p in _particles) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.twinkleT += dt * p.twinkleSpeed;
      // Wrap at edges
      if (p.x < 0) p.x += _boardWidth;
      if (p.x > _boardWidth) p.x -= _boardWidth;
      if (p.y < 0) p.y += _boardHeight;
      if (p.y > _boardHeight) p.y -= _boardHeight;
    }
  }

  @override
  void render(Canvas canvas) {
    for (final p in _particles) {
      final twinkle = 0.5 + 0.5 * sin(p.twinkleT);
      final alpha = (p.baseAlpha * (0.6 + 0.4 * twinkle)).clamp(0.0, 1.0);
      _paint.color = p.color.withValues(alpha: alpha);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, _paint);
    }
  }
}

class _DustParticle {
  double x, y, vx, vy;
  final double radius, baseAlpha, twinkleSpeed, twinklePhase;
  final Color color;
  double twinkleT;

  _DustParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.baseAlpha,
    required this.twinkleSpeed,
    required this.twinklePhase,
    required this.color,
  }) : twinkleT = twinklePhase;
}
