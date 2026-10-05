import 'package:flutter/material.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/theme/app_text_styles.dart';
import 'package:star_shooter/core/theme/app_spacing.dart';

/// [ThemeData] factory for Star Shooter.
abstract final class AppTheme {
  AppTheme._();

  /// The single dark theme used throughout the application.
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
          onPrimary: AppColors.textPrimary,
          onSecondary: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,
          onError: AppColors.textPrimary,
        ),
        textTheme: AppTextStyles.textTheme,
        cardTheme: const CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSpacing.radiusMd),
            ),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textPrimary,
            minimumSize: const Size(double.infinity, 52),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSpacing.radiusMd),
              ),
            ),
            textStyle: AppTextStyles.labelLarge,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: AppColors.primary),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSpacing.radiusMd),
              ),
            ),
            textStyle: AppTextStyles.labelLarge,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: AppTextStyles.labelLarge,
          ),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSpacing.radiusLg),
            ),
          ),
          titleTextStyle: AppTextStyles.headlineMedium,
          contentTextStyle: AppTextStyles.bodyMedium,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXl),
            ),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.surface,
          contentTextStyle: AppTextStyles.bodyMedium,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSpacing.radiusSm),
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.shimmerBase,
          space: 1,
          thickness: 1,
        ),
        iconTheme: const IconThemeData(color: AppColors.textSecondary),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.titleLarge,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
      );
}
