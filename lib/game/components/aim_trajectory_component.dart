import 'dart:math' as math;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:star_shooter/game/star_shooter_game.dart';

/// Draws the dotted trajectory preview line showing where the star will travel.
///
/// Dots are diamond-shaped (rotated squares), pulse in scale over time,
/// are tinted to match the current star type, and the line fades from bright
/// near the launcher to dim white at the far end.
///
/// Wall bounce prediction is supported: if a dot position would exceed the
/// left/right wall boundary the direction is reflected and the remaining dots
/// continue from the bounce point.
class AimTrajectoryComponent extends Component
    with HasGameReference<StarShooterGame> {
  Vector2 _startPos = Vector2.zero();
  Vector2 _direction = Vector2.zero();
  bool _visible = false;

  static const double _dotHalfSize = 5.0;
  static const double _dotSpacing = 18.0;
  static const int _maxDots = 30;

  double _time = 0.0;
  Color _tintColor = const Color(0xFFFFBF00); // default normal star color

  /// Updates the tint color to match the currently loaded star type.
  void setTintColor(Color color) {
    _tintColor = color;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = 3;
  }

  /// Shows the trajectory line starting at [from] travelling in [direction].
  ///
  /// [direction] does not need to be normalised — it is normalised internally.
  void showTrajectory({required Vector2 from, required Vector2 direction}) {
    _startPos = from.clone();
    _direction = direction.normalized();
    _visible = true;
  }

  /// Hides the trajectory line.
  void hideTrajectory() {
    _visible = false;
  }

  /// Whether the trajectory line is currently visible.
  bool get isVisible => _visible;

  @override
  void update(double dt) {
    _time = (_time + dt) % 10.0;
  }

  @override
  void render(Canvas canvas) {
    if (!_visible || _direction.isZero()) return;

    final screenSize = game.size;
    const leftWall = 0.0;
    final rightWall = screenSize.x;

    // Current dot travel state — may reflect off walls.
    Vector2 currentDir = _direction.clone();
    double t = _dotSpacing;

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < _maxDots; i++) {
      // Compute dot position by accumulating spacing along current direction.
      // We need to account for potential wall bounces per segment rather than
      // a single linear step.
      final rawPos = _startPos + currentDir * t;

      // Check if a bounce happened between previous position and rawPos.
      Vector2 pos;
      if (rawPos.x < leftWall) {
        // Reflect: flip X direction and recompute.
        currentDir = Vector2(-currentDir.x, currentDir.y);
        final overShoot = leftWall - rawPos.x;
        pos = Vector2(leftWall + overShoot, rawPos.y);
        // Recalibrate t so next dot continues correctly.
        t = _dotSpacing;
        _startPos = pos.clone();
      } else if (rawPos.x > rightWall) {
        currentDir = Vector2(-currentDir.x, currentDir.y);
        final overShoot = rawPos.x - rightWall;
        pos = Vector2(rightWall - overShoot, rawPos.y);
        t = _dotSpacing;
        _startPos = pos.clone();
      } else {
        pos = rawPos;
      }

      // Stop once dot would be drawn above the top or below the bottom.
      if (pos.y < 0 || pos.y > screenSize.y) break;

      // --- Visual attributes ---

      // Scale pulse: gentle throb, each dot offset in phase.
      final scale = 0.85 + math.sin(_time * 3.0 + i * 0.5) * 0.15;

      // Gradient factor: 0.0 at launcher end, 1.0 at far end.
      final grad = i / _maxDots;

      // Color: lerp from tinted (near) to near-white dim (far).
      final nearColor = Color.fromARGB(
        (0.9 * 255).round(),
        (_tintColor.r * 255.0).round().clamp(0, 255),
        (_tintColor.g * 255.0).round().clamp(0, 255),
        (_tintColor.b * 255.0).round().clamp(0, 255),
      );
      final farColor = Colors.white.withValues(alpha: 0.2);
      final dotColor = Color.lerp(nearColor, farColor, grad)!;

      paint.color = dotColor;

      // Draw a diamond (rotated square).
      final half = _dotHalfSize * scale;
      canvas.save();
      canvas.translate(pos.x, pos.y);
      canvas.rotate(math.pi / 4); // 45° → diamond
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: half * 2, height: half * 2),
        paint,
      );
      canvas.restore();

      t += _dotSpacing;
    }
  }
}
