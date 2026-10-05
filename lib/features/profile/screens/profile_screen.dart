import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';
import 'package:star_shooter/core/widgets/star_rating.dart';

/// Player profile screen.
///
/// Displays player stats and premium status. The player name field is
/// editable inline. All data is placeholder until a real repository is wired.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;
  bool _isEditing = false;

  // Placeholder values
  static const _playerName = 'Star Pilot';
  static const _totalStars = 0;
  static const _levelsCompleted = 0;
  static const _isPremium = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _playerName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check_rounded : Icons.edit_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => setState(() => _isEditing = !_isEditing),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // ── Avatar & name ─────────────────────────────────────────────
            _AvatarSection(
              nameController: _nameController,
              isEditing: _isEditing,
              isPremium: _isPremium,
            ),

            const SizedBox(height: AppSpacing.xl),

            // ── Stats ─────────────────────────────────────────────────────
            Text(
              'STATISTICS',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const CosmicCard(
              child: Column(
                children: [
                  _StatRow(
                    icon: Icons.star_rounded,
                    label: 'Stars Collected',
                    value: '$_totalStars',
                  ),
                  Divider(color: AppColors.shimmerBase, height: 24),
                  _StatRow(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Levels Completed',
                    value: '$_levelsCompleted',
                  ),
                  Divider(color: AppColors.shimmerBase, height: 24),
                  _StatRow(
                    icon: Icons.emoji_events_rounded,
                    label: 'Worlds Unlocked',
                    value: '0 / 5',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // ── Premium status ────────────────────────────────────────────
            Text(
              'MEMBERSHIP',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              glow: _isPremium,
              glowColor: AppColors.starFilled,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isPremium
                          ? AppColors.starFilled.withAlpha(30)
                          : AppColors.shimmerBase,
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: _isPremium
                          ? AppColors.starFilled
                          : AppColors.textDisabled,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isPremium ? 'Premium' : 'Free Tier',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: _isPremium
                                ? AppColors.starFilled
                                : AppColors.textPrimary,
                          ),
                        ),
                        const Text(
                          _isPremium
                              ? 'All features unlocked'
                              : 'Upgrade for unlimited access',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _AvatarSection extends StatelessWidget {
  const _AvatarSection({
    required this.nameController,
    required this.isEditing,
    required this.isPremium,
  });

  final TextEditingController nameController;
  final bool isEditing;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.buttonGradientStart,
                    AppColors.buttonGradientEnd,
                  ],
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),
            if (isPremium)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.starFilled,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.black,
                  size: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (isEditing)
          SizedBox(
            width: 200,
            child: TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineMedium,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          )
        else
          Text(nameController.text, style: AppTextStyles.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        const Text('Cosmic Explorer', style: AppTextStyles.bodySmall),
        const SizedBox(height: AppSpacing.sm),
        const StarRating(rating: 0, size: 16),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.starFilled, size: 20),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(label, style: AppTextStyles.bodyMedium),
        ),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
