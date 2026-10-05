import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';

/// Visual style variants for [CosmicButton].
enum CosmicButtonVariant {
  /// Gradient fill — the default call-to-action style.
  primary,

  /// Outlined / ghost style for secondary actions.
  secondary,

  /// Text-only style for tertiary / low-emphasis actions.
  text,
}

/// A themeable, gradient-capable action button with cosmic styling.
///
/// - [CosmicButtonVariant.primary] — fills with the brand gradient.
/// - [CosmicButtonVariant.secondary] — outlined border, transparent fill.
/// - [CosmicButtonVariant.text] — label only, no background or border.
///
/// When [enabled] is false or [onPressed] is null, the button is dimmed and
/// ignores taps.
class CosmicButton extends StatelessWidget {
  const CosmicButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
    this.isLoading = false,
    this.fullWidth = true,
    this.variant = CosmicButtonVariant.primary,
    this.minWidth,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool isLoading;
  final bool fullWidth;
  final CosmicButtonVariant variant;

  /// If set, the button will be at least [minWidth] wide even when
  /// [fullWidth] is false.
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final isActive = enabled && !isLoading && onPressed != null;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isActive ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: isActive ? onPressed : null,
        child: _buildContainer(isActive),
      ),
    );
  }

  Widget _buildContainer(bool isActive) {
    switch (variant) {
      case CosmicButtonVariant.primary:
        return Container(
          height: 52,
          width: fullWidth ? double.infinity : null,
          constraints: minWidth != null
              ? BoxConstraints(minWidth: minWidth!)
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [
                      AppColors.buttonGradientStart,
                      AppColors.buttonGradientEnd,
                    ],
                  )
                : const LinearGradient(
                    colors: [Color(0xFF374151), Color(0xFF374151)],
                  ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(80),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: _buildContent(Colors.white),
        );

      case CosmicButtonVariant.secondary:
        return Container(
          height: 52,
          width: fullWidth ? double.infinity : null,
          constraints: minWidth != null
              ? BoxConstraints(minWidth: minWidth!)
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.textDisabled,
              width: 1.5,
            ),
          ),
          child: _buildContent(
            isActive ? AppColors.primary : AppColors.textDisabled,
          ),
        );

      case CosmicButtonVariant.text:
        return Container(
          height: 52,
          width: fullWidth ? double.infinity : null,
          constraints: minWidth != null
              ? BoxConstraints(minWidth: minWidth!)
              : null,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: _buildContent(
            isActive ? AppColors.primary : AppColors.textDisabled,
          ),
        );
    }
  }

  Widget _buildContent(Color contentColor) {
    return Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: contentColor,
            ),
          )
        else ...[
          if (icon != null) ...[
            Icon(icon, color: contentColor, size: 20),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: contentColor,
              fontSize: 16,
            ),
          ),
        ],
      ],
    );
  }
}
