import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart'
    show BlurStyle, Color, Colors, MaskFilter, Paint, PaintingStyle;
import 'package:star_shooter/game/models/star_type.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// The launcher component rendered at the bottom of the screen.
///
/// Displays the current star (large, glowing, centred) and a smaller
/// next-star preview to the top-right of the launcher area. A rotating
/// outer decorative ring with tick marks rings the current star.
///
/// Call [loadStars] whenever the active / upcoming star changes.
class ShooterComponent extends PositionComponent
    with HasGameReference<StarShooterGame> {
  StarType _currentType = StarType.normal;
  StarType _nextType = StarType.normal;

  /// World-space position of the launcher centre.
  Vector2 _launcherCenter = Vector2.zero();

  // _basePaint is reserved for a future platform-fill decoration.
  // ignore: unused_field
  late Paint _basePaint;
  late Paint _currentGlowPaint;
  late Paint _currentFillPaint;
  late Paint _nextPaint;
  late Paint _ringPaint;

  static const double _currentRadius = 26.0;
  static const double _nextRadius = 14.0;

  // ── Animated ring rotation ─────────────────────────────────────────────────
  double _ringAngle = 0.0;

  // ── Load-flash state ───────────────────────────────────────────────────────
  bool _justLoaded = false;
  double _loadFlashElapsed = 0.0;

  ShooterComponent() : super(priority: 5);

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _updateLayout();
    _updatePaints();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _updateLayout();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _ringAngle = (_ringAngle + dt * 0.3) % (2 * pi);
    if (_justLoaded) {
      _loadFlashElapsed += dt;
      if (_loadFlashElapsed > 0.3) {
        _justLoaded = false;
        _loadFlashElapsed = 0;
      }
    }
  }

  // ── Layout & paint helpers ─────────────────────────────────────────────────

  void _updateLayout() {
    final gs = game.size;
    // Launcher centre: horizontally centred, 82 % down the screen.
    _launcherCenter = Vector2(gs.x / 2, gs.y * 0.82);
    // Component covers full width, from 74 % to 92 % of height.
    position = Vector2(0, gs.y * 0.74);
    size = Vector2(gs.x, gs.y * 0.18);
  }

  void _updatePaints() {
    _basePaint = Paint()
      ..color = const Color(0xFF1A1E3A)
      ..style = PaintingStyle.fill;

    _currentGlowPaint = Paint()
      ..color = _currentType.color.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

    _currentFillPaint = Paint()
      ..color = _currentType.color
      ..style = PaintingStyle.fill;

    _nextPaint = Paint()
      ..color = _nextType.color
      ..style = PaintingStyle.fill;

    _ringPaint = Paint()
      ..color = const Color(0x884A90E2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
  }

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Update the displayed stars and trigger load flash effect.
  void loadStars(StarType current, StarType next) {
    _currentType = current;
    _nextType = next;
    _justLoaded = true;
    _loadFlashElapsed = 0.0;
    _updatePaints();
  }

  /// Local coords (relative to this component's [position]).
  Vector2 get launcherLocalCenter =>
      Vector2(_launcherCenter.x, _launcherCenter.y - position.y);

  /// World coords — use this when computing shot trajectories.
  Vector2 get launcherWorldCenter => _launcherCenter;

  // ── Rendering ──────────────────────────────────────────────────────────────

  @override
  void render(ui.Canvas canvas) {
    final lc = launcherLocalCenter;

    // Subtle platform ring.
    final platformPaint = Paint()
      ..color = const Color(0x33FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(
      ui.Offset(lc.x, lc.y),
      _currentRadius + 10,
      platformPaint,
    );

    // Outer accent ring (rotates with _ringAngle).
    canvas.drawCircle(
      ui.Offset(lc.x, lc.y),
      _currentRadius + 6,
      _ringPaint,
    );

    // Tick marks at 120° apart around the outer ring.
    for (int i = 0; i < 3; i++) {
      final angle = _ringAngle + i * (2 * pi / 3);
      const innerR = _currentRadius + 8;
      const outerR = _currentRadius + 14;
      canvas.drawLine(
        ui.Offset(lc.x + cos(angle) * innerR, lc.y + sin(angle) * innerR),
        ui.Offset(lc.x + cos(angle) * outerR, lc.y + sin(angle) * outerR),
        Paint()
          ..color = const Color(0x884A90E2)
          ..strokeWidth = 2.0,
      );
    }

    // Glow halo.
    canvas.drawCircle(
      ui.Offset(lc.x, lc.y),
      _currentRadius * 1.5,
      _currentGlowPaint,
    );

    // Current star — slightly larger during the load flash.
    final starRadius = _justLoaded
        ? _currentRadius * (1.0 + 0.2 * (1.0 - _loadFlashElapsed / 0.3))
        : _currentRadius.toDouble();

    // Extra glow during load flash.
    if (_justLoaded) {
      final flashGlow = Paint()
        ..color = _currentType.color
            .withValues(alpha: 0.55 * (1.0 - _loadFlashElapsed / 0.3))
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
      canvas.drawCircle(ui.Offset(lc.x, lc.y), starRadius * 1.6, flashGlow);
    }

    // Current star fill.
    canvas.drawCircle(
      ui.Offset(lc.x, lc.y),
      starRadius,
      _currentFillPaint,
    );

    // Highlight specular.
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      ui.Offset(
        lc.x - starRadius * 0.25,
        lc.y - starRadius * 0.25,
      ),
      starRadius * 0.28,
      highlightPaint,
    );

    // Next-star preview — top-right of the launcher.
    final nextX = lc.x + _currentRadius + 20;
    final nextY = lc.y - _currentRadius + 4;

    // "NEXT" label above the preview.
    final pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(fontSize: 9, textAlign: ui.TextAlign.center),
    )
      ..pushStyle(
        ui.TextStyle(color: const Color(0xAAFFFFFF)),
      )
      ..addText('NEXT');
    final para = pb.build()..layout(const ui.ParagraphConstraints(width: 40));
    canvas.drawParagraph(
      para,
      ui.Offset(nextX - 20, nextY - _nextRadius - 14),
    );

    final nextBgPaint = Paint()
      ..color = const Color(0x55FFFFFF)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      ui.Offset(nextX, nextY),
      _nextRadius + 3,
      nextBgPaint,
    );
    canvas.drawCircle(
      ui.Offset(nextX, nextY),
      _nextRadius,
      _nextPaint,
    );
  }
}
