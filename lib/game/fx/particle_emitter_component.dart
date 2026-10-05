import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/fx/particle_config.dart';

// ---------------------------------------------------------------------------
// Internal data class — one live particle.
// ---------------------------------------------------------------------------

class _ParticleData {
  Vector2 pos;
  Vector2 vel;
  double radius;
  double alpha;
  double lifetime;
  double elapsed;

  _ParticleData({
    required this.pos,
    required this.vel,
    required this.radius,
    required this.lifetime,
  })  : alpha = 1.0,
        elapsed = 0.0;
}

// ---------------------------------------------------------------------------
// ParticleEmitterComponent
// ---------------------------------------------------------------------------

/// A one-shot burst emitter.
///
/// Add it to any [Component] tree at the world position of the effect.
/// It spawns [config.count] particles that fly outward, drag-slow, and fade,
/// then removes itself automatically when all particles have expired.
///
/// Usage:
/// ```dart
/// game.add(ParticleEmitterComponent(
///   position: hitWorldPos,
///   color: StarType.meteor.color,
///   config: ParticleConfig.impact,
/// ));
/// ```
class ParticleEmitterComponent extends PositionComponent {
  final Color _color;
  final ParticleConfig _config;
  final List<_ParticleData> _particles = [];
  bool _allDone = false;
  final Random _rng;

  ParticleEmitterComponent({
    required Vector2 position,
    required Color color,
    ParticleConfig config = ParticleConfig.popSmall,
    int seed = 0,
  })  : _color = color,
        _config = config,
        _rng = Random(seed),
        super(
          position: position,
          size: Vector2.zero(),
          anchor: Anchor.center,
          priority: 9,
        );

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spawnParticles();
  }

  // ── Spawn ───────────────────────────────────────────────────────────────────

  void _spawnParticles() {
    for (int i = 0; i < _config.count; i++) {
      final angle = _rng.nextDouble() * 2 * pi;
      final speed = _config.minSpeed +
          _rng.nextDouble() * (_config.maxSpeed - _config.minSpeed);
      final radius = _config.minRadius +
          _rng.nextDouble() * (_config.maxRadius - _config.minRadius);
      final lifetime = _config.lifetime * (0.7 + _rng.nextDouble() * 0.6);

      _particles.add(
        _ParticleData(
          pos: Vector2.zero(),
          vel: Vector2(cos(angle) * speed, sin(angle) * speed),
          radius: radius,
          lifetime: lifetime,
        ),
      );
    }
  }

  // ── Update ──────────────────────────────────────────────────────────────────

  @override
  void update(double dt) {
    bool anyAlive = false;

    for (final p in _particles) {
      p.elapsed += dt;
      if (p.elapsed >= p.lifetime) {
        p.alpha = 0;
        continue;
      }
      anyAlive = true;
      p.pos += p.vel * dt;
      p.vel *= (1.0 - dt * 2.5); // drag
      p.alpha = (1.0 - p.elapsed / p.lifetime).clamp(0.0, 1.0);
    }

    if (!anyAlive) {
      _allDone = true;
      removeFromParent();
    }
  }

  // ── Render ──────────────────────────────────────────────────────────────────

  @override
  void render(Canvas canvas) {
    if (_allDone) return;

    for (final p in _particles) {
      if (p.alpha <= 0) continue;

      final col = _color.withValues(alpha: p.alpha);

      if (_config.hasGlow) {
        canvas.drawCircle(
          Offset(p.pos.x, p.pos.y),
          p.radius * 1.8,
          Paint()
            ..color = col.withValues(alpha: p.alpha * 0.3)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, _config.glowBlur),
        );
      }

      canvas.drawCircle(
        Offset(p.pos.x, p.pos.y),
        p.radius,
        Paint()
          ..color = col
          ..style = PaintingStyle.fill,
      );
    }
  }
}
