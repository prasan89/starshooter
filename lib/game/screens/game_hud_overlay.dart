import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// A Flutter widget HUD overlay rendered on top of the Flame game canvas.
///
/// Milestone 1 shows a semi-transparent top bar with the level name,
/// placeholder score, remaining shots, and a pause button. Game logic
/// (real score, shot counter) is wired up in M2.
class GameHudOverlay extends StatelessWidget {
  const GameHudOverlay({
    super.key,
    required this.levelId,
    required this.game,
  });

  final int levelId;
  final StarShooterGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _TopBar(levelId: levelId, game: game),
          const Spacer(),
        ],
      ),
    );
  }
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.levelId, required this.game});

  final int levelId;
  final StarShooterGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.75),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFF4A90E2), // AppColors.primary
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Level name
          Expanded(
            child: Text(
              'Level $levelId',
              style: AppTextStyles.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Score placeholder
          _HudChip(
            icon: Icons.star_rounded,
            iconColor: AppColors.starFilled,
            label: '0',
            tooltip: 'Score',
          ),

          const SizedBox(width: 12),

          // Remaining shots placeholder
          _HudChip(
            icon: Icons.bubble_chart_rounded,
            iconColor: AppColors.secondary,
            label: '—',
            tooltip: 'Shots left',
          ),

          const SizedBox(width: 8),

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
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Paused', style: AppTextStyles.headlineMedium),
        content: Text(
          'Level $levelId',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              game.resumeGame();
            },
            child: const Text('Resume'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Quit',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Chip helper ───────────────────────────────────────────────────────────────

class _HudChip extends StatelessWidget {
  const _HudChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.tooltip,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 3),
          Text(label, style: AppTextStyles.labelLarge),
        ],
      ),
    );
  }
}
