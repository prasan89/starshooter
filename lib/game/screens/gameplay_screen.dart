import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:star_shooter/game/screens/game_hud_overlay.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// The Flutter widget that hosts the Flame game for a specific level.
///
/// Responsibilities:
/// - Creates and owns the [StarShooterGame] instance.
/// - Embeds it via [GameWidget] so Flame drives the render loop.
/// - Overlays [GameHudOverlay] on top of the Flame canvas.
class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key, required this.levelId});

  final int levelId;

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late StarShooterGame _game;

  @override
  void initState() {
    super.initState();
    _game = StarShooterGame();
  }

  @override
  void dispose() {
    _game.onRemove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove system chrome — the HUD provides all necessary UI.
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Flame game canvas fills the whole screen.
          GameWidget(game: _game),

          // HUD overlay rendered above the game canvas.
          GameHudOverlay(levelId: widget.levelId, game: _game),
        ],
      ),
    );
  }
}
