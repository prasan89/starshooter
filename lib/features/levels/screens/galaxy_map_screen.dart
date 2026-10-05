import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';

/// Galaxy map screen showing all available worlds.
///
/// Each world tile taps through to [AppRoutes.levelSelection] parameterised
/// with the world's id.
class GalaxyMapScreen extends StatelessWidget {
  const GalaxyMapScreen({super.key});

  static const _worlds = [
    _WorldData(id: '1', name: 'Andromeda', subtitle: 'Beginner', levels: 20),
    _WorldData(id: '2', name: 'Nebula X', subtitle: 'Intermediate', levels: 20),
    _WorldData(id: '3', name: 'Dark Matter', subtitle: 'Advanced', levels: 20),
    _WorldData(id: '4', name: 'Pulsar Prime', subtitle: 'Expert', levels: 20),
    _WorldData(id: '5', name: 'Void Core', subtitle: 'Master', levels: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Galaxy Map'),
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
                colors: [Color(0xFF1A1E3A), AppColors.background],
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _worlds.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final world = _worlds[index];
                return _WorldTile(
                  world: world,
                  isLocked: index > 0,
                  onTap: index == 0
                      ? () => context.push(
                            AppRoutes.levelSelectionPath(world.id),
                          )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data ─────────────────────────────────────────────────────────────────────

class _WorldData {
  const _WorldData({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.levels,
  });

  final String id;
  final String name;
  final String subtitle;
  final int levels;
}

// ── Tile widget ───────────────────────────────────────────────────────────────

class _WorldTile extends StatelessWidget {
  const _WorldTile({
    required this.world,
    required this.isLocked,
    this.onTap,
  });

  final _WorldData world;
  final bool isLocked;
  final VoidCallback? onTap;

  static const _gradients = [
    [Color(0xFF4A90E2), Color(0xFF8B5CF6)],
    [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    [Color(0xFF06B6D4), Color(0xFF4A90E2)],
    [Color(0xFFEF4444), Color(0xFFF59E0B)],
    [Color(0xFF111827), Color(0xFF374151)],
  ];

  @override
  Widget build(BuildContext context) {
    final index = int.parse(world.id) - 1;
    final gradientColors = _gradients[index.clamp(0, _gradients.length - 1)];

    return GestureDetector(
      onTap: onTap,
      child: CosmicCard(
        glow: !isLocked,
        glowColor: gradientColors.first,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            // Gradient bar on the left edge
            Positioned.fill(
              child: Row(
                children: [
                  Container(
                    width: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: gradientColors,
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  const SizedBox(width: AppSpacing.sm),

                  // World number circle
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isLocked
                          ? const LinearGradient(
                              colors: [Color(0xFF374151), Color(0xFF374151)],
                            )
                          : LinearGradient(colors: gradientColors),
                    ),
                    child: Center(
                      child: isLocked
                          ? const Icon(
                              Icons.lock_rounded,
                              color: AppColors.textDisabled,
                              size: 20,
                            )
                          : Text(
                              world.id,
                              style: AppTextStyles.titleLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'World ${world.id}: ${world.name}',
                          style: AppTextStyles.titleLarge.copyWith(
                            color: isLocked
                                ? AppColors.textDisabled
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${world.subtitle} · ${world.levels} levels',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    isLocked
                        ? Icons.lock_rounded
                        : Icons.arrow_forward_ios_rounded,
                    color: isLocked
                        ? AppColors.textDisabled
                        : AppColors.textSecondary,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
