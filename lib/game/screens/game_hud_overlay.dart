import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/features/gameplay/widgets/pause_overlay.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// A Flutter widget HUD overlay rendered on top of the Flame game canvas.
///
/// Shows a semi-transparent top bar with the level name, live score, remaining
/// shots, and a pause button. Score and combo values are driven by
/// [StarShooterGame.gameManager] via [ListenableBuilder] so the HUD rebuilds
/// automatically whenever the manager notifies.
class GameHudOverlay extends StatelessWidget {
  const GameHudOverlay({
    super.key,
    required this.levelId,
    required this.game,
    this.onRestart,
  });

  final int levelId;
  final StarShooterGame game;

  /// Optional callback invoked when the player confirms a restart from the
  /// pause overlay. When null, the restart button is still shown but the
  /// action has no effect beyond closing the overlay.
  final VoidCallback? onRestart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _TopBar(levelId: levelId, game: game, onRestart: onRestart),
          _ObjectiveRow(game: game),
          const Spacer(),
        ],
      ),
    );
  }
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.levelId,
    required this.game,
    this.onRestart,
  });

  final int levelId;
  final VoidCallback? onRestart;
  final StarShooterGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background.withValues(alpha: 0.88),
            AppColors.background.withValues(alpha: 0.0),
          ],
          stops: const [0.55, 1.0],
        ),
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
            width: 0,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 12),
      child: ListenableBuilder(
        listenable: game.gameManager,
        builder: (context, _) {
          final manager = game.gameManager;
          return Row(
            children: [
              // Level name
              Expanded(
                child: Text(
                  'Level $levelId',
                  style: AppTextStyles.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Animated score display
              _AnimatedScore(score: manager.score),

              const SizedBox(width: 12),

              // Combo indicator — visible only when combo > 1
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: manager.hasActiveCombo
                    ? Padding(
                        key: ValueKey(manager.comboLevel),
                        padding: const EdgeInsets.only(right: 12),
                        child: _ComboChip(comboLevel: manager.comboLevel),
                      )
                    : const SizedBox.shrink(key: ValueKey(0)),
              ),

              // Moves remaining
              _MovesChip(
                remaining: manager.movesRemaining,
                total: manager.movesTotal,
              ),

              const SizedBox(width: 4),

              // Pause button
              IconButton(
                icon: const Icon(
                  Icons.pause_circle_outline_rounded,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
                tooltip: 'Pause',
                onPressed: () {
                  game.pauseGame();
                  _showPauseDialog(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (ctx, anim1, anim2) => PauseOverlay(
        levelId: levelId,
        game: game,
        onResume: () {
          Navigator.of(ctx).pop();
          game.resumeGame();
        },
        onRestart: () {
          Navigator.of(ctx).pop();
          if (onRestart != null) onRestart!();
        },
        onQuit: () {
          Navigator.of(ctx).pop();
          context.go(AppRoutes.galaxyMap);
        },
      ),
    );
  }
}

// ── Animated score display ────────────────────────────────────────────────────

class _AnimatedScore extends StatefulWidget {
  const _AnimatedScore({required this.score});

  final int score;

  @override
  State<_AnimatedScore> createState() => _AnimatedScoreState();
}

class _AnimatedScoreState extends State<_AnimatedScore>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.28), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.28, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _colorAnim = ColorTween(
      begin: AppColors.textPrimary,
      end: AppColors.starFilled,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AnimatedScore old) {
    super.didUpdateWidget(old);
    if (old.score != widget.score) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Score',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.starFilled, size: 18),
          const SizedBox(width: 3),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Transform.scale(
              scale: _scaleAnim.value,
              child: Text(
                widget.score.toString(),
                style: AppTextStyles.labelLarge.copyWith(
                  color: _colorAnim.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Moves remaining chip ──────────────────────────────────────────────────────

class _MovesChip extends StatelessWidget {
  const _MovesChip({required this.remaining, required this.total});

  final int remaining;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = total > 0 ? remaining / total : 0.0;
    final barColor = fraction > 0.4
        ? AppColors.secondary
        : fraction > 0.2
            ? const Color(0xFFF59E0B)
            : AppColors.error;

    return Tooltip(
      message: 'Moves remaining',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_outline_rounded, color: barColor, size: 16),
              const SizedBox(width: 3),
              Text(
                'Moves: $remaining',
                style: AppTextStyles.labelLarge.copyWith(color: barColor),
              ),
            ],
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 56,
            height: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: fraction.clamp(0.0, 1.0),
                backgroundColor: AppColors.textDisabled.withValues(alpha: 0.4),
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
                minHeight: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Objective progress row ────────────────────────────────────────────────────

class _ObjectiveRow extends StatelessWidget {
  const _ObjectiveRow({required this.game});

  final StarShooterGame game;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameManager,
      builder: (context, _) {
        final manager = game.gameManager;
        final displayText = manager.objectiveDisplayText;
        final fraction = manager.objectiveProgressFraction;

        // Hide the row when there is no active objective.
        if (displayText.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '★ $displayText',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: 160,
                height: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: fraction.clamp(0.0, 1.0),
                    backgroundColor:
                        AppColors.textDisabled.withValues(alpha: 0.4),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                    minHeight: 3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Combo chip ────────────────────────────────────────────────────────────────

class _ComboChip extends StatefulWidget {
  const _ComboChip({required this.comboLevel});

  final int comboLevel;

  @override
  State<_ComboChip> createState() => _ComboChipState();
}

class _ComboChipState extends State<_ComboChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _baseColor {
    if (widget.comboLevel >= 4) return const Color(0xFFFFD700); // gold
    if (widget.comboLevel == 3) return const Color(0xFFFF1493); // pink
    return const Color(0xFFFF6B35); // orange (level 2)
  }

  Color get _glowColor => _baseColor.withValues(alpha: 0.55);

  List<Color> get _gradientColors {
    if (widget.comboLevel >= 4) {
      return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
    }
    if (widget.comboLevel == 3) {
      return [const Color(0xFFFF1493), const Color(0xFF8B5CF6)];
    }
    return [const Color(0xFFFF6B35), const Color(0xFFFF1493)];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, child) => Transform.scale(
        scale: _pulseAnim.value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: _gradientColors),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _glowColor,
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
            border: Border.all(
              color: _baseColor.withValues(alpha: 0.8),
              width: 1.0,
            ),
          ),
          child: Text(
            'x${widget.comboLevel} COMBO',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
