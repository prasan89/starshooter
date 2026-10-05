/// String extensions used throughout the game.
extension StringExtensions on String {
  /// Returns `true` if the string is not empty after trimming whitespace.
  bool get isNotBlank => trim().isNotEmpty;

  /// Returns `true` if the string is empty or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Capitalises the first character of the string.
  String get capitalised {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalises the first character of every word.
  String get titleCase {
    return split(' ').map((word) => word.capitalised).join(' ');
  }

  /// Truncates the string to [maxLength] characters, appending [ellipsis] when cut.
  String truncate(int maxLength, {String ellipsis = '…'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}
