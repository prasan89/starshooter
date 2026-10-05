import 'dart:ui';

import 'package:flame/components.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// Draws the dotted trajectory preview line showing where the star will travel.
///
/// Add this component to the game and call [showTrajectory] / [hideTrajectory]
/// from the shooter whenever the player is aiming.
class AimTrajectoryComponent extends Component
    with HasGameReference<StarShooterGame> {
  Vector2 _startPos = Vector2.zero();
  Vector2 _direction = Vector2.zero();
  bool _visible = false;
  late Paint _dotPaint;

  static const double _dotRadius = 4.0;
  static const double _dotSpacing = 18.0;
  static const int _maxDots = 30;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dotPaint = Paint()
      ..color = const Color(0xCCFFFFFF)
      ..style = PaintingStyle.fill;
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
  void render(Canvas canvas) {
    if (!_visible || _direction.isZero()) return;

    double t = _dotSpacing;
    for (int i = 0; i < _maxDots; i++) {
      final pos = _startPos + _direction * t;

      // Stop once a dot would be drawn off-screen.
      final screenSize = game.size;
      if (pos.x < 0 ||
          pos.x > screenSize.x ||
          pos.y < 0 ||
          pos.y > screenSize.y) {
        break;
      }

      // Fade dots progressively toward the far end.
      final alpha = (1.0 - (i / _maxDots) * 0.7).clamp(0.0, 1.0);
      _dotPaint.color = Color.fromARGB(
        (alpha * 204).round(),
        255,
        255,
        255,
      );

      canvas.drawCircle(Offset(pos.x, pos.y), _dotRadius, _dotPaint);
      t += _dotSpacing;
    }
  }
}
