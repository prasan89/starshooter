import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/domain/models/game_session.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/domain/usecases/complete_level_usecase.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/game/managers/game_manager.dart';
import 'package:star_shooter/game/screens/game_hud_overlay.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// The Flutter widget that hosts the Flame game for a specific level.
///
/// Responsibilities:
/// - Creates and owns the [StarShooterGame] instance.
/// - Embeds it via [GameWidget] so Flame drives the render loop.
/// - Overlays [GameHudOverlay] on top of the Flame canvas.
/// - Listens to [GameManager] state changes to handle level completion and
///   game-over flows, persisting results and navigating back to the map.
class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key, required this.levelId});

  final int levelId;

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late StarShooterGame _game;
  bool _completionHandled = false;

  @override
  void initState() {
    super.initState();
    _game = StarShooterGame();
    _game.gameManager.addListener(_onGameStateChanged);
  }

  @override
  void dispose() {
    _game.gameManager.removeListener(_onGameStateChanged);
    _game.onRemove();
    super.dispose();
  }

  void _onGameStateChanged() async {
    final gm = _game.gameManager;
    if (gm.state == GameState.levelComplete && !_completionHandled) {
      _completionHandled = true;
      await _handleLevelComplete();
    } else if (gm.state == GameState.gameOver && !_completionHandled) {
      _completionHandled = true;
      _handleGameOver();
    }
  }

  Future<void> _handleLevelComplete() async {
    final gm = _game.gameManager;
    final session = GameSession(
      levelId: widget.levelId,
      startedAt: DateTime.now().toUtc(),
      score: gm.score,
      starsEarned: gm.stars,
      isCompleted: true,
    );
    final shotsUsed = gm.movesTotal - gm.movesRemaining;

    // Run CompleteLevelUseCase
    final useCase = CompleteLevelUseCase(
      levelRepository: context.read<LevelRepository>(),
      playerRepository: context.read<PlayerRepository>(),
    );
    await useCase(session, shotsUsed: shotsUsed, comboLevel: gm.comboLevel);

    // Refresh galaxy map notifier so the map shows updated progress
    if (mounted) {
      await context.read<GalaxyMapNotifier>().refresh();
    }

    // Show a brief completion overlay then navigate back
    if (mounted) {
      _showCompletionBanner(session.score, gm.stars);
    }
  }

  void _handleGameOver() {
    if (!mounted) return;
    // Show failure banner then pop
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No shots remaining — try again!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1A0A2E),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.pop();
    });
  }

  void _showCompletionBanner(int score, int stars) {
    // Overlay a premium completion animation for 2 seconds then pop
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => _LevelCompleteOverlay(score: score, stars: stars),
    ).then((_) {
      if (mounted) context.pop();
    });
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

// ── Level complete overlay ────────────────────────────────────────────────────

class _LevelCompleteOverlay extends StatefulWidget {
  final int score;
  final int stars;

  const _LevelCompleteOverlay({required this.score, required this.stars});

  @override
  State<_LevelCompleteOverlay> createState() => _LevelCompleteOverlayState();
}

class _LevelCompleteOverlayState extends State<_LevelCompleteOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
    // Auto-dismiss after 2.2s
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF141828),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF4A90E2).withAlpha(80),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withAlpha(60),
                blurRadius: 32,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'LEVEL COMPLETE',
                style: TextStyle(
                  color: Color(0xFFFBBF24),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Icon(
                      Icons.star_rounded,
                      color: i < widget.stars
                          ? const Color(0xFFFBBF24)
                          : const Color(0xFF374151),
                      size: 36,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.score}',
                style: const TextStyle(
                  color: Color(0xFFF9FAFB),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'SCORE',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
