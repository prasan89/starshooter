import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:star_shooter/game/components/cosmic_background_component.dart';
import 'package:star_shooter/game/components/game_board_component.dart';
import 'package:star_shooter/game/components/shooter_component.dart';

/// The root Flame game class for Star Shooter.
///
/// Milestone 1 sets up the camera, adds placeholder components for the
/// background, game board, and shooter. Collision detection and keyboard
/// handling mixins are included ready for M2.
class StarShooterGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  StarShooterGame();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Fix the camera anchor to the top-left so (0,0) is the top-left corner.
    camera.viewfinder.anchor = Anchor.topLeft;

    // Layer order (priority): background(-10) < board(0) < shooter(5).
    await add(CosmicBackgroundComponent());
    await add(GameBoardComponent());
    await add(ShooterComponent());
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // Components react to resize via their own onGameResize overrides.
    // Camera viewport is updated automatically by FlameGame.
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void onRemove() {
    super.onRemove();
    // Release any game-level resources here in future milestones.
  }

  // ── Pause / Resume ───────────────────────────────────────────────────────

  /// Pauses the game loop and all component updates.
  void pauseGame() => paused = true;

  /// Resumes the game loop.
  void resumeGame() => paused = false;
}
