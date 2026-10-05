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
    final boardTop = game.board.boardRect.top;
    final leftWall = _dotHalfSize;
    final rightWall = screenSize.x - _dotHalfSize;

    // IMPORTANT: this simulation is entirely local to render(). The previous
    // implementation mutated _startPos while painting, which caused the
    // trajectory to drift every frame and made the preview disagree with the
    // projectile.
    var cursor = _startPos.clone();
    var currentDir = _direction.normalized();

    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < _maxDots; i++) {
      var remaining = _dotSpacing;

      // Advance exactly one dot spacing, reflecting at the side walls as
      // needed. This is the same basic movement model used by the projectile.
      while (remaining > 0) {
        if (currentDir.x.abs() < 0.0001) {
          cursor += currentDir * remaining;
          remaining = 0;
          continue;
        }

        final distanceToWall = currentDir.x > 0
            ? (rightWall - cursor.x) / currentDir.x
            : (leftWall - cursor.x) / currentDir.x;

        if (distanceToWall > 0 && distanceToWall < remaining) {
          cursor += currentDir * distanceToWall;
          cursor.x = currentDir.x > 0 ? rightWall : leftWall;
          currentDir = Vector2(-currentDir.x, currentDir.y);
          remaining -= distanceToWall;
        } else {
          cursor += currentDir * remaining;
          remaining = 0;
        }
      }

      // Stop at the actual board ceiling, not the screen top. The shooter
      // cannot land above the playable board.
      if (cursor.y <= boardTop) break;

      final scale = 0.85 + math.sin(_time * 3.0 + i * 0.5) * 0.15;
      final grad = i / _maxDots;

      final nearColor = Color.fromARGB(
        (0.9 * 255).round(),
        (_tintColor.r * 255.0).round().clamp(0, 255),
        (_tintColor.g * 255.0).round().clamp(0, 255),
        (_tintColor.b * 255.0).round().clamp(0, 255),
      );
      final farColor = Colors.white.withValues(alpha: 0.2);
      paint.color = Color.lerp(nearColor, farColor, grad)!;

      final half = _dotHalfSize * scale;
      canvas.save();
      canvas.translate(cursor.x, cursor.y);
      canvas.rotate(math.pi / 4);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: half * 2,
          height: half * 2,
        ),
        paint,
      );
      canvas.restore();
    }
  }
}
