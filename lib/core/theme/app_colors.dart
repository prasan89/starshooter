import 'package:flutter/material.dart';

/// The cosmic color palette for Star Shooter.
///
/// All colors are `static const` and reference the deep-space design language.
abstract final class AppColors {
  // ── Backgrounds ──────────────────────────────────────────────────────────
  /// Main scaffold background — deep space.
  static const Color background = Color(0xFF0A0E1A);

  /// Card / surface layer — slightly lighter than background.
  static const Color surface = Color(0xFF141828);

  /// Surface highlight — used for gradients and hover states.
  static const Color surfaceHighlight = Color(0xFF1A1E3A);

  /// Deep premium background — very dark for premium/special screens.
  static const Color deepBackground = Color(0xFF1A0A2E);

  // ── Accents ───────────────────────────────────────────────────────────────
  /// Primary accent — cosmic blue.
  static const Color primary = Color(0xFF4A90E2);

  /// Secondary accent — nebula purple.
  static const Color secondary = Color(0xFF8B5CF6);

  // ── Game-specific ─────────────────────────────────────────────────────────
  /// Filled star — golden.
  static const Color starFilled = Color(0xFFFBBF24);

  /// Empty / unfilled star.
  static const Color starEmpty = Color(0xFF374151);

  // ── Semantic ──────────────────────────────────────────────────────────────
  /// Success / positive feedback — emerald.
  static const Color success = Color(0xFF10B981);

  /// Error / destructive — vivid red.
  static const Color error = Color(0xFFEF4444);

  // ── Text ──────────────────────────────────────────────────────────────────
  /// High-emphasis text — near white.
  static const Color textPrimary = Color(0xFFF9FAFB);

  /// Medium-emphasis text.
  static const Color textSecondary = Color(0xFF9CA3AF);

  /// Disabled / placeholder text.
  static const Color textDisabled = Color(0xFF4B5563);

  // ── Button gradient ───────────────────────────────────────────────────────
  /// Gradient start colour for primary buttons (cosmic blue).
  static const Color buttonGradientStart = Color(0xFF4A90E2);

  /// Gradient end colour for primary buttons (nebula purple).
  static const Color buttonGradientEnd = Color(0xFF8B5CF6);

  // ── World palette ─────────────────────────────────────────────────────────
  /// World 2 gradient end — nebula pink.
  static const Color world2GradientEnd = Color(0xFFEC4899);

  /// World 3 gradient start — cyan.
  static const Color world3GradientStart = Color(0xFF06B6D4);

  /// World 4 gradient start — red.
  static const Color world4GradientStart = Color(0xFFEF4444);

  /// World 4 gradient end — amber.
  static const Color world4GradientEnd = Color(0xFFF59E0B);

  /// World 5 (locked) gradient start — dark navy.
  static const Color world5GradientStart = Color(0xFF111827);

  // ── Shimmer ───────────────────────────────────────────────────────────────
  /// Base colour for shimmer loading effect.
  static const Color shimmerBase = Color(0xFF1E2538);

  /// Highlight colour for shimmer loading effect.
  static const Color shimmerHighlight = Color(0xFF2D3552);
}
