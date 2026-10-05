import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';

/// Gameplay screen placeholder.
///
/// The Flame game canvas will be embedded here once the game module is wired
/// up. For now this screen shows the level id and a back button.
class GameplayScreen extends StatelessWidget {
  const GameplayScreen({super.key, required this.levelId});

  final String levelId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Starfield placeholder background
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  Color(0xFF0A1020),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // HUD top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.pause_circle_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: () => _showPauseDialog(context),
                      ),
                      const Spacer(),
                      Text(
                        'Level $levelId',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: const [
                          Icon(Icons.star_rounded,
                              color: AppColors.starFilled, size: 20),
                          Icon(Icons.star_outline_rounded,
                              color: AppColors.starEmpty, size: 20),
                          Icon(Icons.star_outline_rounded,
                              color: AppColors.starEmpty, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),

                // Game canvas placeholder
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.gamepad_rounded,
                          color: AppColors.textSecondary,
                          size: 64,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Flame Game Canvas',
                          style: AppTextStyles.headlineMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Level ID: $levelId',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Game integration coming soon',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPauseDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Paused', style: AppTextStyles.headlineMedium),
        content: Text(
          'Level $levelId',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Resume'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.pop();
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
