import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/constants/app_constants.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_card.dart';

/// Settings screen with toggles for audio and haptics.
///
/// State is kept locally for now; a future iteration will use a Provider /
/// repository that persists via [SharedPreferences].
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _musicEnabled = true;
  bool _sfxEnabled = true;
  bool _hapticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // ── Sound ────────────────────────────────────────────────────
            _SectionHeader(title: 'Sound'),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _ToggleRow(
                    icon: Icons.music_note_rounded,
                    label: 'Music',
                    value: _musicEnabled,
                    onChanged: (v) => setState(() => _musicEnabled = v),
                  ),
                  const Divider(
                    color: Color(0xFF1E2538),
                    height: 1,
                    indent: AppSpacing.md,
                    endIndent: AppSpacing.md,
                  ),
                  _ToggleRow(
                    icon: Icons.volume_up_rounded,
                    label: 'Sound Effects',
                    value: _sfxEnabled,
                    onChanged: (v) => setState(() => _sfxEnabled = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Haptics ──────────────────────────────────────────────────
            _SectionHeader(title: 'Haptics'),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              padding: EdgeInsets.zero,
              child: _ToggleRow(
                icon: Icons.vibration_rounded,
                label: 'Vibration',
                value: _hapticsEnabled,
                onChanged: (v) => setState(() => _hapticsEnabled = v),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Purchases ────────────────────────────────────────────────
            _SectionHeader(title: 'Purchases'),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              padding: EdgeInsets.zero,
              child: _ActionRow(
                icon: Icons.refresh_rounded,
                label: 'Restore Purchases',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No purchases to restore.'),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Legal ────────────────────────────────────────────────────
            _SectionHeader(title: 'Legal'),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              padding: EdgeInsets.zero,
              child: _ActionRow(
                icon: Icons.privacy_tip_rounded,
                label: 'Privacy Policy',
                onTap: () {
                  // TODO: Open privacy policy URL
                },
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── About ────────────────────────────────────────────────────
            _SectionHeader(title: 'About'),
            const SizedBox(height: AppSpacing.sm),
            CosmicCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('App Name', style: AppTextStyles.bodyMedium),
                      const Spacer(),
                      Text(
                        kAppName,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.tag_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text('Version', style: AppTextStyles.bodyMedium),
                      const Spacer(),
                      Text(
                        kAppVersion,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
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

// ── Private sub-widgets ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.textSecondary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(label, style: AppTextStyles.bodyMedium),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(label, style: AppTextStyles.bodyMedium),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
