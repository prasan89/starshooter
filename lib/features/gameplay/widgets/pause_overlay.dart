import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/features/settings/screens/settings_screen.dart';
import 'package:star_shooter/game/star_shooter_game.dart';

/// Full-screen pause overlay shown via [showGeneralDialog].
///
/// Replaces the simple [AlertDialog] that was previously shown from
/// [GameHudOverlay]. Includes inline restart and quit confirmation rows
/// so no nested dialogs are required.
class PauseOverlay extends StatefulWidget {
  const PauseOverlay({
    super.key,
    required this.levelId,
    required this.game,
    required this.onResume,
    required this.onRestart,
    required this.onQuit,
  });

  final int levelId;
  final StarShooterGame game;
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onQuit;

  @override
  State<PauseOverlay> createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  /// Whether the inline restart confirmation row is visible.
  bool _showRestartConfirm = false;

  /// Whether the inline quit confirmation row is visible.
  bool _showQuitConfirm = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  void _dismissConfirms() {
    setState(() {
      _showRestartConfirm = false;
      _showQuitConfirm = false;
    });
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SettingsScreen(),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48).clamp(0.0, 320.0);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) widget.onResume();
      },
      child: Material(
        color: Colors.black54,
        child: Center(
          child: AnimatedBuilder(
            animation: _entryController,
            builder: (context, child) => FadeTransition(
              opacity: _fadeAnim,
              child: Transform.scale(
                scale: _scaleAnim.value,
                child: child,
              ),
            ),
            child: SizedBox(
              width: cardWidth,
              child: _PauseCard(
                levelId: widget.levelId,
                game: widget.game,
                showRestartConfirm: _showRestartConfirm,
                showQuitConfirm: _showQuitConfirm,
                onResume: widget.onResume,
                onRestartTap: () {
                  setState(() {
                    _showRestartConfirm = true;
                    _showQuitConfirm = false;
                  });
                },
                onRestartConfirm: widget.onRestart,
                onRestartCancel: _dismissConfirms,
                onSettingsTap: _openSettings,
                onQuitTap: () {
                  setState(() {
                    _showQuitConfirm = true;
                    _showRestartConfirm = false;
                  });
                },
                onQuitConfirm: widget.onQuit,
                onQuitCancel: _dismissConfirms,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Card ──────────────────────────────────────────────────────────────────────

class _PauseCard extends StatelessWidget {
  const _PauseCard({
    required this.levelId,
    required this.game,
    required this.showRestartConfirm,
    required this.showQuitConfirm,
    required this.onResume,
    required this.onRestartTap,
    required this.onRestartConfirm,
    required this.onRestartCancel,
    required this.onSettingsTap,
    required this.onQuitTap,
    required this.onQuitConfirm,
    required this.onQuitCancel,
  });

  final int levelId;
  final StarShooterGame game;
  final bool showRestartConfirm;
  final bool showQuitConfirm;
  final VoidCallback onResume;
  final VoidCallback onRestartTap;
  final VoidCallback onRestartConfirm;
  final VoidCallback onRestartCancel;
  final VoidCallback onSettingsTap;
  final VoidCallback onQuitTap;
  final VoidCallback onQuitConfirm;
  final VoidCallback onQuitCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF141828),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.shimmerBase,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(50),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Title ──────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.pause_circle_outline_rounded,
                color: AppColors.primary,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'PAUSED',
                style: AppTextStyles.headlineLarge.copyWith(
                  letterSpacing: 2.0,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          // ── Level subtitle ─────────────────────────────────────────────────
          Center(
            child: Text(
              'Level $levelId',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Stats ──────────────────────────────────────────────────────────
          ListenableBuilder(
            listenable: game.gameManager,
            builder: (context, _) {
              final manager = game.gameManager;
              return _StatsRow(
                score: manager.score,
                movesRemaining: manager.movesRemaining,
              );
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Divider ────────────────────────────────────────────────────────
          Container(
            height: 1,
            color: AppColors.shimmerBase,
          ),

          const SizedBox(height: AppSpacing.lg),

          // ── Buttons ────────────────────────────────────────────────────────
          CosmicButton(
            label: 'RESUME',
            icon: Icons.play_arrow_rounded,
            onPressed: onResume,
          ),

          const SizedBox(height: AppSpacing.sm),

          if (showRestartConfirm)
            _ConfirmRow(
              message: 'Restart this level?',
              onCancel: onRestartCancel,
              onConfirm: onRestartConfirm,
            )
          else
            CosmicButton(
              label: 'RESTART',
              icon: Icons.refresh_rounded,
              variant: CosmicButtonVariant.secondary,
              onPressed: onRestartTap,
            ),

          const SizedBox(height: AppSpacing.sm),

          CosmicButton(
            label: 'SETTINGS',
            icon: Icons.settings_rounded,
            variant: CosmicButtonVariant.secondary,
            onPressed: onSettingsTap,
          ),

          const SizedBox(height: AppSpacing.sm),

          if (showQuitConfirm)
            _ConfirmRow(
              message: 'Return to Galaxy Map?',
              onCancel: onQuitCancel,
              onConfirm: onQuitConfirm,
            )
          else
            CosmicButton(
              label: 'GALAXY MAP',
              icon: Icons.map_outlined,
              variant: CosmicButtonVariant.text,
              onPressed: onQuitTap,
            ),
        ],
      ),
    );
  }
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.score,
    required this.movesRemaining,
  });

  final int score;
  final int movesRemaining;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatCell(
          icon: Icons.star_rounded,
          iconColor: AppColors.starFilled,
          label: 'Score',
          value: score.toString(),
        ),
        Container(width: 1, height: 36, color: AppColors.shimmerBase),
        _StatCell(
          icon: Icons.star_outline_rounded,
          iconColor: AppColors.secondary,
          label: 'Shots',
          value: '$movesRemaining remaining',
        ),
      ],
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.labelLarge,
        ),
      ],
    );
  }
}

// ── Inline confirmation row ───────────────────────────────────────────────────

class _ConfirmRow extends StatelessWidget {
  const _ConfirmRow({
    required this.message,
    required this.onCancel,
    required this.onConfirm,
  });

  final String message;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            message,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: CosmicButton(
                label: 'Cancel',
                variant: CosmicButtonVariant.secondary,
                onPressed: onCancel,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: CosmicButton(
                label: 'Confirm',
                variant: CosmicButtonVariant.primary,
                onPressed: onConfirm,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
