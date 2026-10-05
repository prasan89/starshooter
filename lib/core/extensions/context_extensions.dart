import 'package:flutter/material.dart';

/// Convenience extensions on [BuildContext].
extension ContextExtensions on BuildContext {
  /// The current screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// `true` when the screen width is less than 360 logical pixels.
  bool get isSmallScreen => screenSize.width < 360;

  /// The current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// The current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Shows a standard [SnackBar] with [message].
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  /// Shows an error-styled [SnackBar] with [message].
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: colorScheme.error,
        ),
      );
  }
}
