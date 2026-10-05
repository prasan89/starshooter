import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';

/// A card container with cosmic/space styling.
///
/// Wraps [child] in a rounded container with a semi-transparent dark
/// background, a subtle border, and an optional glow effect.
class CosmicCard extends StatelessWidget {
  const CosmicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderColor,
    this.backgroundColor,
    this.glow = false,
    this.glowColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final Color? backgroundColor;

  /// When true, adds a soft glow matching [glowColor] (defaults to primary).
  final bool glow;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = glowColor ?? AppColors.primary;

    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: borderColor ?? AppColors.shimmerBase,
          width: 1,
        ),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: effectiveGlowColor.withAlpha(60),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
