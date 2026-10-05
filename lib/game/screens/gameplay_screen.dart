import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/game_session.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/domain/usecases/complete_level_usecase.dart';
import 'package:star_shooter/domain/usecases/start_level_usecase.dart';
import 'package:star_shooter/features/daily_challenge/domain/analytics/challenge_analytics.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/complete_daily_challenge_usecase.dart';
import 'package:star_shooter/features/daily_challenge/presentation/screens/daily_challenge_result_screen.dart';
import 'package:star_shooter/features/daily_challenge/presentation/state/daily_challenge_notifier.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/features/gameplay/screens/daily_limit_screen.dart';
import 'package:star_shooter/features/gameplay/screens/failure_screen.dart';
import 'package:star_shooter/features/gameplay/screens/victory_screen.dart';
import 'package:star_shooter/features/gameplay/widgets/pause_overlay.dart';
import 'package:star_shooter/game/level/level_catalog.dart';
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
///   game-over flows, persisting results and navigating to victory/failure screens.
/// - Handles Android back button by pausing (via [PopScope]).
/// - Supports restart by replacing the [StarShooterGame] instance via [setState].
class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key, required this.levelId});

  final int levelId;

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late StarShooterGame _game;

  /// True once an attempt has been granted and the game is initialised.
  bool _attemptGranted = false;

  /// Set to true the moment we start handling a terminal state so we never
  /// trigger the flow twice (e.g. two rapid notifications from GameManager).
  bool _completionHandled = false;

  /// True while an async navigation is in flight; suppresses any further
  /// state-change callbacks that could race with the push/replace.
  bool _navigatingAway = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndConsumeAttempt();
    });
  }

  Future<void> _checkAndConsumeAttempt() async {
    final useCase = context.read<StartLevelUseCase>();
    final result = await useCase(levelId: widget.levelId);
    if (!mounted) return;
    if (result.isAllowed) {
      _initGame();
      setState(() {
        _attemptGranted = true;
      });
    } else if (result.status == StartLevelStatus.dailyLimitReached) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, anim, __) => FadeTransition(
            opacity: anim,
            child: DailyLimitScreen(
              dailyLimit: DailyAttemptConfig.defaultConfig.freeDailyLimit,
            ),
          ),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } else {
      if (mounted) Navigator.of(context).pop();
    }
  }

  /// Creates a fresh [StarShooterGame] and wires the listener.
  /// Must only be called after the attempt is granted.
  void _initGame() {
    _game = StarShooterGame(levelId: widget.levelId);
    _game.gameManager.addListener(_onGameStateChanged);
    _completionHandled = false;
    _navigatingAway = false;
  }

  @override
  void dispose() {
    if (_attemptGranted) {
      _game.gameManager.removeListener(_onGameStateChanged);
      _game.onRemove();
    }
    super.dispose();
  }

  // ── State machine ───────────────────────────────────────────────────────────

  void _onGameStateChanged() {
    final gm = _game.gameManager;
    if (_completionHandled || _navigatingAway) return;

    if (gm.state == GameState.levelComplete) {
      _completionHandled = true;
      unawaited(_handleLevelComplete());
    } else if (gm.state == GameState.gameOver) {
      _completionHandled = true;
      unawaited(_handleGameOver());
    }
  }

  // ── Level complete flow ─────────────────────────────────────────────────────

  Future<void> _handleLevelComplete() async {
    if (!mounted) return;
    final gm = _game.gameManager;

    // Brief delay to let final animations settle.
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final session = GameSession(
      levelId: widget.levelId,
      startedAt: DateTime.now().toUtc(),
      score: gm.score,
      starsEarned: gm.stars,
      isCompleted: true,
    );
    final shotsUsed = gm.movesTotal - gm.movesRemaining;

    // Load existing progress to detect a new-best score.
    final repo = context.read<LevelRepository>();
    final playerRepo = context.read<PlayerRepository>();
    final existingResult = await repo.getLevelProgress(widget.levelId);
    final existing = existingResult.when(
      onSuccess: (p) => p,
      onFailure: (_) => LevelProgress.empty(widget.levelId),
    );
    final previousBestScore = existing.bestScore;

    // Persist session result.
    final useCase = CompleteLevelUseCase(
      levelRepository: repo,
      playerRepository: playerRepo,
    );
    final progressResult = await useCase(
      session,
      shotsUsed: shotsUsed,
      comboLevel: gm.comboLevel,
    );
    if (!mounted) return;

    final savedProgress = progressResult.when(
      onSuccess: (p) => p,
      onFailure: (_) => LevelProgress(
        levelId: widget.levelId,
        isCompleted: true,
        stars: gm.stars,
        bestScore: gm.score,
      ),
    );

    // Refresh galaxy map so it shows updated stars/completion.
    await context.read<GalaxyMapNotifier>().refresh();
    if (!mounted) return;

    final isNewBest = gm.score > previousBestScore;

    // M11: Daily challenge hook — if this game started from a daily challenge,
    // route to the challenge result screen instead of normal victory.
    final dcNotifier = context.read<DailyChallengeNotifier>();
    if (dcNotifier.startedFromDailyChallenge &&
        dcNotifier.activeDailyChallenge != null) {
      final challenge = dcNotifier.activeDailyChallenge!;
      final newStreak =
          await context.read<CompleteDailyChallengeUseCase>().call(
                challenge: challenge,
                score: gm.score,
                stars: savedProgress.stars,
                alreadyCompleted: false,
              );
      if (!mounted) return;
      context.read<ChallengeAnalytics>().logChallengeCompleted(
            challenge.date,
            challenge.levelId,
            gm.score,
            savedProgress.stars,
          );
      dcNotifier.clearActiveChallenge();
      if (!mounted) return;
      _navigatingAway = true;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, anim, __) => FadeTransition(
            opacity: anim,
            child: DailyChallengeResultScreen(
              challenge: challenge,
              score: gm.score,
              stars: savedProgress.stars,
              newStreak: newStreak,
            ),
          ),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
      return;
    }

    _navigatingAway = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, anim, __) => FadeTransition(
          opacity: anim,
          child: VictoryScreen(
            levelId: widget.levelId,
            score: gm.score,
            shotsUsed: shotsUsed,
            comboLevel: gm.comboLevel,
            starsEarned: savedProgress.stars,
            isNewBest: isNewBest,
            previousBestScore: previousBestScore,
            levelProgress: savedProgress,
          ),
        ),
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  // ── Game over flow ──────────────────────────────────────────────────────────

  Future<void> _handleGameOver() async {
    if (!mounted) return;
    final gm = _game.gameManager;

    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    // M11: Clear daily challenge context on failure.
    final dcNotifier = context.read<DailyChallengeNotifier>();
    if (dcNotifier.startedFromDailyChallenge) {
      final challenge = dcNotifier.activeDailyChallenge;
      if (challenge != null) {
        context.read<ChallengeAnalytics>().logChallengeFailed(
              challenge.date,
              challenge.levelId,
              gm.score,
            );
      }
      dcNotifier.clearActiveChallenge();
    }

    // Load existing best score for comparison in the failure screen.
    final repo = context.read<LevelRepository>();
    final existingResult = await repo.getLevelProgress(widget.levelId);
    final existing = existingResult.when(
      onSuccess: (p) => p,
      onFailure: (_) => LevelProgress.empty(widget.levelId),
    );

    final levelDef = LevelCatalog.getLevelById(widget.levelId);
    final objective = levelDef?.objective;

    _navigatingAway = true;
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, anim, __) => FadeTransition(
          opacity: anim,
          child: FailureScreen(
            levelId: widget.levelId,
            score: gm.score,
            objectiveProgress: gm.objectiveProgress,
            objectiveTarget: gm.objectiveTarget,
            objectiveDescription:
                objective?.displayText ?? 'Complete the objective',
            bestScore: existing.bestScore,
            shotsUsed: gm.movesTotal - gm.movesRemaining,
          ),
        ),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // ── Restart ─────────────────────────────────────────────────────────────────

  void _handleRestart() {
    _game.gameManager.removeListener(_onGameStateChanged);
    _game.onRemove();
    setState(_initGame);
  }

  // ── Back-button pause ───────────────────────────────────────────────────────

  void _showPauseFromBack(BuildContext context) {
    _game.pauseGame();
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) => PauseOverlay(
        levelId: widget.levelId,
        game: _game,
        onResume: () {
          Navigator.of(ctx).pop();
          _game.resumeGame();
        },
        onRestart: () {
          Navigator.of(ctx).pop();
          _handleRestart();
        },
        onQuit: () {
          Navigator.of(ctx).pop();
          _navigatingAway = true;
          context.go(AppRoutes.galaxyMap);
        },
      ),
    );
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (!_attemptGranted) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }
    return PopScope(
      // Intercept Android back — pause instead of popping.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && !_completionHandled) {
          _showPauseFromBack(context);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            GameWidget(game: _game),
            GameHudOverlay(
              levelId: widget.levelId,
              game: _game,
              onRestart: _handleRestart,
            ),
          ],
        ),
      ),
    );
  }
}
