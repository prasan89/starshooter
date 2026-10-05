import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// A component that drives camera shake and screen flash overlays.
///
/// Attach to the game at high priority (100) so it renders above everything
/// else. Callers invoke the public helpers ([shake], [flash], [onMatch], …) and
/// this component takes care of the rest each tick.
class ScreenEffectsComponent extends PositionComponent
    with HasGameReference<StarShooterGame> {
  // ── Camera shake ────────────────────────────────────────────────────────────
  double _shakeIntensity = 0;
  double _shakeDuration = 0;
  double _shakeElapsed = 0;
  Vector2 _shakeOffset = Vector2.zero();
  final Random _rng = Random();

  // ── Screen flash ────────────────────────────────────────────────────────────
  Color _flashColor = const Color(0x00FFFFFF);
  double _flashAlpha = 0;
  double _flashDuration = 0;
  double _flashElapsed = 0;

  ScreenEffectsComponent() : super(priority: 100);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size.clone();
    position = Vector2.zero();
  }

  // ── Public API ──────────────────────────────────────────────────────────────

  /// Shake the camera for [duration] seconds at [intensity] pixels.
  void shake({double intensity = 6.0, double duration = 0.25}) {
    _shakeIntensity = intensity;
    _shakeDuration = duration;
    _shakeElapsed = 0;
  }

  /// Flash the screen with [color] for [duration] seconds.
  void flash({
    required Color color,
    double duration = 0.15,
    double maxAlpha = 0.35,
  }) {
    _flashColor = color.withValues(alpha: maxAlpha);
    _flashAlpha = maxAlpha;
    _flashDuration = duration;
    _flashElapsed = 0;
  }

  /// Trigger effects for a small star match.
  void onMatch(Color starColor) {
    shake(intensity: 3.0, duration: 0.15);
    flash(color: starColor, duration: 0.12, maxAlpha: 0.12);
  }

  /// Trigger effects for a large star match.
  void onLargeMatch(Color starColor) {
    shake(intensity: 6.0, duration: 0.25);
    flash(color: starColor, duration: 0.18, maxAlpha: 0.22);
  }

  /// Trigger effects for a cascade combo at [cascadeLevel].
  void onCascade(int cascadeLevel, Color starColor) {
    final intensity = (3.0 + cascadeLevel * 1.5).clamp(0.0, 12.0);
    shake(intensity: intensity, duration: 0.2);
    flash(
      color: starColor,
      duration: 0.15,
      maxAlpha: (0.08 * cascadeLevel).clamp(0.0, 0.3),
    );
  }

  /// Trigger a small impact shake (projectile hits wall, etc.).
  void onImpact() {
    shake(intensity: 2.0, duration: 0.1);
  }

  // ── Update / render ─────────────────────────────────────────────────────────

  @override
  void update(double dt) {
    // Camera shake
    if (_shakeElapsed < _shakeDuration) {
      _shakeElapsed += dt;
      final progress = _shakeElapsed / _shakeDuration;
      final currentIntensity = _shakeIntensity * (1.0 - progress);
      _shakeOffset = Vector2(
        (_rng.nextDouble() * 2 - 1) * currentIntensity,
        (_rng.nextDouble() * 2 - 1) * currentIntensity,
      );
      game.camera.viewfinder.position = _shakeOffset;
    } else if (!_shakeOffset.isZero()) {
      _shakeOffset = Vector2.zero();
      game.camera.viewfinder.position = Vector2.zero();
    }

    // Flash fade
    if (_flashElapsed < _flashDuration) {
      _flashElapsed += dt;
      final progress = _flashElapsed / _flashDuration;
      _flashAlpha = _flashColor.a * (1.0 - progress);
    } else {
      _flashAlpha = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    if (_flashAlpha > 0.001) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()..color = _flashColor.withValues(alpha: _flashAlpha),
      );
    }
  }
}
