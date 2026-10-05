import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/widgets/cosmic_button.dart';

/// A friendly error state widget with a retry button.
///
/// Named [CosmicErrorWidget] to avoid shadowing Flutter's built-in
/// [ErrorWidget] class.
class CosmicErrorWidget extends StatelessWidget {
  const CosmicErrorWidget({
    super.key,
    this.message = 'Something went wrong.\nPlease try again.',
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  /// Human-readable error message shown to the user.
  final String message;

  /// Called when the user taps the retry button. When `null` the button
  /// is omitted.
  final VoidCallback? onRetry;

  /// Label for the retry button.
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              CosmicButton(
                label: retryLabel,
                onPressed: onRetry,
                variant: CosmicButtonVariant.secondary,
                icon: Icons.refresh_rounded,
                minWidth: 160,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
