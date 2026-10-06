import 'dart:math' show pi, cos, sin, Random;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

/// Variant type for star destruction animations.
enum _ExplosionVariant { energyBurst, fragmentExplosion, cosmicImplosion }

/// Premium star explosion effect that replaces the flat PopAnimationComponent.
///
/// Three variants are randomly chosen, each ~0.5–0.7 seconds:
///
/// 1. ENERGY BURST — bright core flash → expanding ring → radial energy particles
/// 2. FRAGMENT EXPLOSION — star shatters into 8–12 distinct fragments that fly out
/// 3. COSMIC IMPLOSION — first implodes (draws inward), then bursts outward
///
/// The [intensityScale] parameter (0.5–3.0) allows cascades to drive
/// stronger visuals: comboLevel 1=1.0, comboLevel 4+=2.5.
class StarExplosionEffect extends PositionComponent {
  final Color _color;
  final double _intensityScale;
  final _ExplosionVariant _variant;
  double _elapsed = 0;
  bool _done = false;

  late final List<_Particle> _particles;
  late final double _duration;

  // Cached paints — never allocated in render()
  final _corePaint = Paint();
  final _glowPaint = Paint();
  final _ringPaint = Paint()..style = PaintingStyle.stroke;
  final _particlePaint = Paint();
  final _fragPaint = Paint();

  StarExplosionEffect({
    required Vector2 position,
    required Color color,
    double intensityScale = 1.0,
    int seed = 0,
  })  : _color = color,
        _intensityScale = intensityScale.clamp(0.5, 3.0),
        _variant = _chooseVariant(seed),
        super(
          position: position,
          anchor: Anchor.center,
          size: Vector2.all(80.0 * intensityScale.clamp(0.5, 3.0)),
          priority: 10,
        ) {
    _duration = 0.55 + intensityScale * 0.08;
    final rng = Random(seed);
    _particles = _buildParticles(rng, intensityScale, _variant);
  }

  static _ExplosionVariant _chooseVariant(int seed) {
    final r = Random(seed).nextInt(3);
    return _ExplosionVariant.values[r];
  }

  List<_Particle> _buildParticles(
    Random rng,
    double scale,
    _ExplosionVariant variant,
  ) {
    final count = variant == _ExplosionVariant.fragmentExplosion
        ? (10 + (scale * 4).round()).clamp(10, 20)
        : (8 + (scale * 5).round()).clamp(8, 18);

    final bright = Color.lerp(_color, const Color(0xFFFFFFFF), 0.45)!;

    return List.generate(count, (i) {
      final angle = (i / count) * 2 * pi + rng.nextDouble() * 0.35;
      double speed;
      switch (variant) {
        case _ExplosionVariant.energyBurst:
          speed = (100.0 + rng.nextDouble() * 200.0) * scale;
        case _ExplosionVariant.fragmentExplosion:
          speed = (80.0 + rng.nextDouble() * 180.0) * scale;
        case _ExplosionVariant.cosmicImplosion:
          speed = (60.0 + rng.nextDouble() * 160.0) * scale;
      }
      final radius = 2.5 + rng.nextDouble() * 4.0 * scale.clamp(1.0, 2.0);
      final startDelay = variant == _ExplosionVariant.cosmicImplosion
          ? 0.12 + rng.nextDouble() * 0.06
          : rng.nextDouble() * 0.04;
      return _Particle(
        angle: angle,
        speed: speed,
        radius: radius,
        color: rng.nextDouble() > 0.35 ? _color : bright,
        startDelay: startDelay,
        isFragment: variant == _ExplosionVariant.fragmentExplosion,
      );
    });
  }

  @override
  void update(double dt) {
    if (_done) return;
    _elapsed += dt;

    for (final p in _particles) {
      final t = _elapsed - p.startDelay;
      if (t <= 0) continue;
      p.pos += p.vel * dt;
      p.vel *= (1.0 - dt * 2.8);
    }

    if (_elapsed >= _duration) {
      _done = true;
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_done) return;

    switch (_variant) {
      case _ExplosionVariant.energyBurst:
        _renderEnergyBurst(canvas);
      case _ExplosionVariant.fragmentExplosion:
        _renderFragmentExplosion(canvas);
      case _ExplosionVariant.cosmicImplosion:
        _renderCosmicImplosion(canvas);
    }
  }

  void _renderEnergyBurst(Canvas canvas) {
    final t = (_elapsed / _duration).clamp(0.0, 1.0);
    final s = _intensityScale;

    // Phase 1: Core flash (0–0.25)
    if (t < 0.25) {
      final ft = t / 0.25;
      final coreR = (16.0 + ft * 12.0) * s;
      final coreAlpha = 1.0 - ft;
      final coreColor = Color.lerp(_color, const Color(0xFFFFFFFF), 0.6)!;
      _corePaint
        ..color = coreColor.withValues(alpha: coreAlpha)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 * s)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, coreR, _corePaint);
      _corePaint
        ..color = const Color(0xFFFFFFFF).withValues(alpha: coreAlpha * 0.5)
        ..maskFilter = null;
      canvas.drawCircle(Offset.zero, 7.0 * s, _corePaint);
    }

    // Outer glow
    _glowPaint
      ..color = _color.withValues(alpha: (1.0 - t) * 0.35 * s.clamp(0.0, 1.5))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20 * s)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 28.0 * s, _glowPaint);

    // Expanding ring
    if (t < 0.7) {
      final ringR = 8.0 + t * 38.0 * s;
      final ringAlpha = (0.9 - t * 1.2).clamp(0.0, 1.0);
      _ringPaint
        ..color = _color.withValues(alpha: ringAlpha)
        ..strokeWidth = (3.5 * (1.0 - t)).clamp(0.5, 3.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset.zero, ringR, _ringPaint);
    }

    // Particles
    for (final p in _particles) {
      final pt = _elapsed - p.startDelay;
      if (pt <= 0) continue;
      final palpha = (1.0 - pt / (_duration - p.startDelay)).clamp(0.0, 1.0);
      _particlePaint
        ..color = p.color.withValues(alpha: palpha * 0.85)
        ..maskFilter = null
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(p.pos.x, p.pos.y), p.radius, _particlePaint);
    }
  }

  void _renderFragmentExplosion(Canvas canvas) {
    final t = (_elapsed / _duration).clamp(0.0, 1.0);
    final s = _intensityScale;

    // Initial flash
    if (t < 0.2) {
      final ft = t / 0.2;
      _corePaint
        ..color = Color.lerp(_color, const Color(0xFFFFFFFF), 0.5)!
            .withValues(alpha: (1.0 - ft) * 0.8)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12 * s)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, (18.0 + ft * 8.0) * s, _corePaint);
    }

    // Outer glow
    _glowPaint
      ..color = _color.withValues(alpha: (1.0 - t) * 0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18 * s)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 24.0 * s, _glowPaint);

    // Fragment particles (use diamond shapes for fragments)
    for (final p in _particles) {
      final pt = _elapsed - p.startDelay;
      if (pt <= 0) continue;
      final pd = _duration - p.startDelay;
      final palpha = (1.0 - pt / pd).clamp(0.0, 1.0);

      _fragPaint
        ..color = p.color.withValues(alpha: palpha * 0.9)
        ..maskFilter = null
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(p.pos.x, p.pos.y);
      canvas.rotate(p.angle + pt * 3.0);
      // Diamond shape
      final fr = p.radius;
      final path = Path()
        ..moveTo(0, -fr)
        ..lineTo(fr * 0.6, 0)
        ..lineTo(0, fr)
        ..lineTo(-fr * 0.6, 0)
        ..close();
      canvas.drawPath(path, _fragPaint);
      canvas.restore();
    }
  }

  void _renderCosmicImplosion(Canvas canvas) {
    final t = (_elapsed / _duration).clamp(0.0, 1.0);
    final s = _intensityScale;
    const implodeEnd = 0.22; // implosion phase ends here

    // Phase 1: Implosion — star brightens and contracts
    if (t < implodeEnd) {
      final it = t / implodeEnd;
      final implodeR = (20.0 * (1.0 - it * 0.7)) * s;
      final implodeAlpha = 0.5 + it * 0.5;
      final brightColor = Color.lerp(_color, const Color(0xFFFFFFFF), it * 0.7)!;
      _corePaint
        ..color = brightColor.withValues(alpha: implodeAlpha)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 * s * it)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, implodeR, _corePaint);

      // Inward energy arcs
      _ringPaint
        ..color = _color.withValues(alpha: it * 0.5)
        ..strokeWidth = 2.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(Offset.zero, implodeR * 1.6, _ringPaint);
    }

    // Phase 2: Burst — explosion after implosion
    if (t >= implodeEnd) {
      final bt = (t - implodeEnd) / (1.0 - implodeEnd);

      // Bright core burst
      if (bt < 0.3) {
        final coreAlpha = 1.0 - bt / 0.3;
        _corePaint
          ..color = const Color(0xFFFFFFFF).withValues(alpha: coreAlpha * 0.9)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12 * s)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset.zero, (10.0 + bt * 20.0) * s, _corePaint);
      }

      // Outer bloom
      _glowPaint
        ..color = _color.withValues(alpha: (1.0 - bt) * 0.5 * s.clamp(0.0, 1.8))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 22 * s)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset.zero, 30.0 * s, _glowPaint);

      // Expanding shockwave ring
      if (bt < 0.75) {
        final ringR = 5.0 + bt * 45.0 * s;
        _ringPaint
          ..color = _color.withValues(alpha: (1.0 - bt) * 0.8)
          ..strokeWidth = (4.0 * (1.0 - bt)).clamp(0.5, 4.0)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(Offset.zero, ringR, _ringPaint);
      }

      // Burst particles
      for (final p in _particles) {
        final pt = _elapsed - p.startDelay;
        if (pt <= 0) continue;
        final pd = _duration - p.startDelay;
        final palpha = (1.0 - pt / pd).clamp(0.0, 1.0);
        _particlePaint
          ..color = p.color.withValues(alpha: palpha * 0.9)
          ..maskFilter = null
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(p.pos.x, p.pos.y), p.radius, _particlePaint);
      }
    }
  }
}

class _Particle {
  final double angle;
  final double speed;
  final double radius;
  final Color color;
  final double startDelay;
  final bool isFragment;
  Vector2 pos = Vector2.zero();
  late Vector2 vel;

  _Particle({
    required this.angle,
    required this.speed,
    required this.radius,
    required this.color,
    required this.startDelay,
    required this.isFragment,
  }) {
    vel = Vector2(cos(angle) * speed, sin(angle) * speed);
  }
}
