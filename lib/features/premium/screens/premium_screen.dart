import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';

/// Premium upsell / paywall screen.
///
/// All purchase calls are placeholders — IAP integration is not yet wired up.
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  static const _benefits = [
    (Icons.all_inclusive_rounded, 'Unlimited Attempts', 'Play as many levels as you want, any time.'),
    (Icons.block_rounded, 'No Ads', 'Enjoy a completely ad-free experience.'),
    (Icons.cloud_done_rounded, 'Cloud Sync', 'Sync your progress across all devices.'),
    (Icons.palette_rounded, 'Exclusive Themes', 'Unlock premium cosmic visual themes.'),
    (Icons.star_rounded, 'Bonus Stars', 'Earn 2× stars on every completed level.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Premium gradient background
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A0A2E),
                  AppColors.background,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.textSecondary,
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    children: [
                      // Header
                      _PremiumHeader(),

                      const SizedBox(height: AppSpacing.xl),

                      // Benefits list
                      ..._benefits.map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _BenefitRow(
                            icon: b.$1,
                            title: b.$2,
                            subtitle: b.$3,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Subscribe CTA (disabled — coming soon)
                      CosmicButton(
                        label: 'Coming Soon',
                        onPressed: null,
                        enabled: false,
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // Restore purchases
                      Center(
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No purchases to restore.'),
                              ),
                            );
                          },
                          child: Text(
                            'Restore Purchases',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _PremiumHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Crown icon with glow
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.shimmerBase,
            boxShadow: [
              BoxShadow(
                color: AppColors.starFilled.withAlpha(80),
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.starFilled,
            size: 44,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.starFilled, Color(0xFFF59E0B)],
          ).createShader(bounds),
          child: Text(
            'STAR SHOOTER\nPREMIUM',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              color: Colors.white,
              letterSpacing: 2,
              height: 1.1,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Unlock the full cosmic experience',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return CosmicCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.buttonGradientStart,
                  AppColors.buttonGradientEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20,
          ),
        ],
      ),
    );
  }
}
