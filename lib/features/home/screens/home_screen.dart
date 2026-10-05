import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';

/// Main home / lobby screen.
///
/// Displays the app title, player stats at a glance, and primary navigation
/// actions. All routes are driven by [GoRouter].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background gradient ─────────────────────────────────────────
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.4,
                colors: [
                  AppColors.surfaceHighlight,
                  AppColors.background,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Top bar ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      // Premium badge (top-left)
                      _PremiumBadge(
                        onTap: () => context.push(AppRoutes.premium),
                      ),

                      const Spacer(),

                      // Profile button (top-center-right area)
                      IconButton(
                        icon: const Icon(
                          Icons.person_rounded,
                          color: AppColors.textSecondary,
                        ),
                        tooltip: 'Profile',
                        onPressed: () => context.push(AppRoutes.profile),
                      ),

                      // Settings button (top-right)
                      IconButton(
                        icon: const Icon(
                          Icons.settings_rounded,
                          color: AppColors.textSecondary,
                        ),
                        tooltip: 'Settings',
                        onPressed: () => context.push(AppRoutes.settings),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // ── App title ─────────────────────────────────────────────
                _CosmicTitle(),

                const SizedBox(height: AppSpacing.xxl),

                // ── Primary action button ──────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  child: CosmicButton(
                    label: 'PLAY',
                    icon: Icons.rocket_launch_rounded,
                    onPressed: () => context.push(AppRoutes.galaxyMap),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                const Spacer(),

                // ── Player stats ──────────────────────────────────────────
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: _PlayerStatsRow(),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ─────────────────────────────────────────────────────

class _CosmicTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glowing star icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                AppColors.buttonGradientStart,
                AppColors.buttonGradientEnd,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(100),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.buttonGradientStart,
              AppColors.buttonGradientEnd,
            ],
          ).createShader(bounds),
          child: Text(
            'STAR SHOOTER',
            style: AppTextStyles.displayLarge.copyWith(
              color: Colors.white,
              letterSpacing: 4,
              shadows: [
                Shadow(
                  color: AppColors.primary.withAlpha(120),
                  blurRadius: 16,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        Text(
          'COSMIC ADVENTURE',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

class _PlayerStatsRow extends StatelessWidget {
  const _PlayerStatsRow();

  @override
  Widget build(BuildContext context) {
    return const CosmicCard(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.military_tech_rounded,
            label: 'Level',
            value: '1',
          ),
          _Divider(),
          _StatItem(
            icon: Icons.star_rounded,
            label: 'Stars',
            value: '0',
          ),
          _Divider(),
          _StatItem(
            icon: Icons.emoji_events_rounded,
            label: 'Worlds',
            value: '0 / 5',
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.starFilled, size: 20),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTextStyles.titleLarge),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 36,
      child: VerticalDivider(
        color: AppColors.shimmerBase,
        width: 1,
        thickness: 1,
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.starFilled,
              AppColors.starFilled,
            ],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bolt_rounded, color: Colors.black, size: 14),
            const SizedBox(width: 2),
            Text(
              'PREMIUM',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
