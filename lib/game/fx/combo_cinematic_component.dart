import 'dart:math' show pi, cos, sin, Random;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/rendering.dart';

/// Displays a cinematic combo announcement overlay that appears briefly when
/// the player achieves a cascade combo.
///
/// Intensity scales with [comboLevel]:
///   x2 — small pulse + score pop
///   x3 — stronger glow + larger text + subtle shake
///   x4 — energy ring + particles + text
///   x5+ — cinematic burst + large typography + energy wave
///
/// Duration: ~0.9–1.4 s depending on combo level. Self-removes when done.
class ComboCinematicComponent extends PositionComponent {
  final int _comboLevel;
  final Color _color;
  double _elapsed = 0;
  bool _done = false;
  late final double _duration;
  late final List<_ComboParticle> _comboParticles;

  // Cached paints
  final _ringPaint = Paint()..style = PaintingStyle.stroke;
  final _wavePaint = Paint()..style = PaintingStyle.stroke;
  final _glowPaint = Paint()..style = PaintingStyle.fill;
  final _particlePaint = Paint()..style = PaintingStyle.fill;

  ComboCinematicComponent({
    required Vector2 position,
    required int comboLevel,
    Color color = const Color(0xFFFFBF00),
    int seed = 0,
  })  : _comboLevel = comboLevel.clamp(2, 10),
        _color = color,
        super(
          position: position,
          anchor: Anchor.center,
          priority: 20,
          // Size covers full screen area for wave effects at high combo
          size: Vector2.all(comboLevel >= 5 ? 600.0 : 300.0),
        ) {
    _duration = _computeDuration(comboLevel);
    final rng = Random(seed);
    _comboParticles = _buildParticles(rng, comboLevel);
  }

  double _computeDuration(int level) {
    if (level >= 5) return 1.4;
    if (level == 4) return 1.2;
    if (level == 3) return 1.0;
    return 0.85;
  }

  List<_ComboParticle> _buildParticles(Random rng, int level) {
    final count = level >= 5 ? 24 : (level >= 4 ? 16 : (level >= 3 ? 10 : 0));
    final bright = Color.lerp(_color, const Color(0xFFFFFFFF), 0.5)!;
    return List.generate(count, (i) {
      final angle = (i / count) * 2 * pi + rng.nextDouble() * 0.4;
      final speed = 80.0 + rng.nextDouble() * (level >= 5 ? 200.0 : 140.0);
      return _ComboParticle(
        angle: angle,
        speed: speed,
        radius: 2.5 + rng.nextDouble() * 3.5,
        color: rng.nextDouble() > 0.4 ? _color : bright,
      );
    });
  }

  @override
  void update(double dt) {
    if (_done) return;
    _elapsed += dt;
    for (final p in _comboParticles) {
      p.pos += p.vel * dt;
      p.vel *= (1.0 - dt * 1.8);
    }
    if (_elapsed >= _duration) {
      _done = true;
      removeFromParent();
    }
  }

  @override
  void render(ui.Canvas canvas) {
    if (_done) return;
    final t = (_elapsed / _duration).clamp(0.0, 1.0);

    if (_comboLevel >= 2) _renderPulse(canvas, t);
    if (_comboLevel >= 3) _renderGlowAura(canvas, t);
    if (_comboLevel >= 4) _renderEnergyRing(canvas, t);
    if (_comboLevel >= 5) _renderCosmicWave(canvas, t);

    _renderComboText(canvas, t);
    _renderParticles(canvas, t);
  }

  void _renderPulse(ui.Canvas canvas, double t) {
    // Short pulse: scale 0→1.2→0.8 over first 30% of duration
    if (t > 0.6) return;
    final pt = t / 0.6;
    final pulseR = 22.0 * (pt < 0.4 ? pt / 0.4 * 1.2 : 1.2 - (pt - 0.4) / 0.6 * 0.4);
    final alpha = (1.0 - pt * 0.7) * 0.5;
    _glowPaint
      ..color = _color.withValues(alpha: alpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    canvas.drawCircle(Offset.zero, pulseR, _glowPaint);
  }

  void _renderGlowAura(ui.Canvas canvas, double t) {
    // Sustained aura that fades out in second half
    final alpha = t < 0.5 ? 0.4 : (1.0 - (t - 0.5) / 0.5) * 0.4;
    _glowPaint
      ..color = _color.withValues(alpha: alpha * (_comboLevel >= 5 ? 1.5 : 1.0).clamp(0.0, 0.6))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);
    canvas.drawCircle(Offset.zero, 40.0, _glowPaint);
  }

  void _renderEnergyRing(ui.Canvas canvas, double t) {
    // Expanding ring that appears at the start
    if (t > 0.65) return;
    final rt = t / 0.65;
    final ringR = 10.0 + rt * 60.0;
    final ringAlpha = (1.0 - rt * 1.1).clamp(0.0, 0.9);
    _ringPaint
      ..color = _color.withValues(alpha: ringAlpha)
      ..strokeWidth = (3.0 * (1.0 - rt)).clamp(0.5, 3.0)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset.zero, ringR, _ringPaint);
  }

  void _renderCosmicWave(ui.Canvas canvas, double t) {
    // Screen-wide energy wave for x5+
    if (t > 0.55) return;
    final wt = t / 0.55;
    final waveR = wt * 220.0;
    final waveAlpha = (1.0 - wt) * 0.55;
    _wavePaint
      ..color = _color.withValues(alpha: waveAlpha)
      ..strokeWidth = (6.0 * (1.0 - wt)).clamp(0.5, 6.0)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(Offset.zero, waveR, _wavePaint);

    // Second wave slightly delayed
    if (t > 0.08) {
      final wt2 = (t - 0.08) / 0.47;
      final waveR2 = wt2 * 200.0;
      final waveAlpha2 = (1.0 - wt2) * 0.35;
      _wavePaint
        ..color = const Color(0xFFFFFFFF).withValues(alpha: waveAlpha2)
        ..strokeWidth = (3.0 * (1.0 - wt2)).clamp(0.3, 3.0)
        ..maskFilter = null;
      canvas.drawCircle(Offset.zero, waveR2, _wavePaint);
    }
  }

  void _renderComboText(ui.Canvas canvas, double t) {
    // Text appears quickly, stays, then fades
    final textAlpha = t < 0.15
        ? (t / 0.15)
        : t > 0.75
            ? (1.0 - (t - 0.75) / 0.25).clamp(0.0, 1.0)
            : 1.0;

    final textScale = t < 0.15
        ? 0.5 + (t / 0.15) * 0.6
        : t < 0.25
            ? 1.1 - (t - 0.15) / 0.1 * 0.1
            : 1.0;

    if (textAlpha < 0.01) return;

    final fontSize = _comboLevel >= 5 ? 28.0 : (_comboLevel >= 4 ? 22.0 : 18.0);
    final label = 'COMBO x$_comboLevel';
    final sublabel = _comboLevel >= 5 ? '✦ COSMIC BURST ✦' : null;

    canvas.save();
    canvas.scale(textScale, textScale);

    // Main combo text with glow
    final pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: fontSize,
        textAlign: ui.TextAlign.center,
        fontWeight: ui.FontWeight.w700,
      ),
    )
      ..pushStyle(ui.TextStyle(
        color: _color.withValues(alpha: textAlpha),
        shadows: [
          ui.Shadow(
            color: _color.withValues(alpha: textAlpha * 0.8),
            blurRadius: 12,
          ),
          ui.Shadow(
            color: const ui.Color(0xFFFFFFFF).withValues(alpha: textAlpha * 0.3),
            blurRadius: 4,
          ),
        ],
      ),)
      ..addText(label);
    final para = pb.build()
      ..layout(const ui.ParagraphConstraints(width: 200));
    canvas.drawParagraph(para, Offset(-100, -fontSize / 2));

    // Sub-label for x5+
    if (sublabel != null) {
      final pb2 = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize: 11,
          textAlign: ui.TextAlign.center,
        ),
      )
        ..pushStyle(ui.TextStyle(
          color: const Color(0xFFFFFFFF).withValues(alpha: textAlpha * 0.8),
          letterSpacing: 2.0,
        ),)
        ..addText(sublabel);
      final para2 = pb2.build()
        ..layout(const ui.ParagraphConstraints(width: 200));
      canvas.drawParagraph(para2, Offset(-100, fontSize / 2 + 4));
    }

    canvas.restore();
  }

  void _renderParticles(ui.Canvas canvas, double t) {
    for (final p in _comboParticles) {
      final palpha = (1.0 - t).clamp(0.0, 1.0) * 0.85;
      _particlePaint.color = p.color.withValues(alpha: palpha);
      canvas.drawCircle(Offset(p.pos.x, p.pos.y), p.radius * (1.0 - t * 0.5), _particlePaint);
    }
  }
}

class _ComboParticle {
  final double angle;
  final double radius;
  final Color color;
  Vector2 pos = Vector2.zero();
  late Vector2 vel;

  _ComboParticle({
    required this.angle,
    required double speed,
    required this.radius,
    required this.color,
  }) {
    vel = Vector2(cos(angle) * speed, sin(angle) * speed);
  }
}
