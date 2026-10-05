import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';
import 'package:star_shooter/core/widgets/star_rating.dart';

/// Level selection grid for a given world.
///
/// Receives [worldId] from the route path parameter (e.g. `/levels/2`).
/// Displays 20 placeholder levels; only level 1 of world 1 is unlocked in the
/// placeholder state.
class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key, required this.worldId});

  final String worldId;

  static const int _levelCount = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('World $worldId'),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [AppColors.surfaceHighlight, AppColors.background],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Text(
                    'Select a Level',
                    style: AppTextStyles.headlineLarge,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _levelCount,
                    itemBuilder: (context, index) {
                      final levelNumber = index + 1;
                      final levelId =
                          '${worldId}_$levelNumber';
                      // Only first level of first world is unlocked
                      final isUnlocked =
                          worldId == '1' && levelNumber == 1;
                      const starsEarned = 0;

                      return _LevelTile(
                        levelNumber: levelNumber,
                        isUnlocked: isUnlocked,
                        starsEarned: starsEarned,
                        onTap: isUnlocked
                            ? () => context.push(
                                  AppRoutes.gameplayPath(levelId),
                                )
                            : null,
                      );
                    },
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

// ── Level tile ────────────────────────────────────────────────────────────────

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.levelNumber,
    required this.isUnlocked,
    required this.starsEarned,
    this.onTap,
  });

  final int levelNumber;
  final bool isUnlocked;
  final int starsEarned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CosmicCard(
        glow: isUnlocked,
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isUnlocked) ...[
              Text(
                '$levelNumber',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              StarRating(rating: starsEarned, size: 12, spacing: 1),
            ] else ...[
              const Icon(
                Icons.lock_rounded,
                color: AppColors.textDisabled,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                '$levelNumber',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
