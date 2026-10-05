import 'package:intl/intl.dart';

/// Date utility functions used across the app.
class GameDateUtils {
  GameDateUtils._();

  /// Returns `true` if [now] falls on a different calendar day than [last].
  static bool isNewDay(DateTime last, DateTime now) {
    return startOfDay(last) != startOfDay(now);
  }

  /// Returns a [DateTime] representing midnight (00:00:00.000) of [dt]'s day.
  static DateTime startOfDay(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  /// Returns [dt] formatted as "MMM d, yyyy" (e.g. "Oct 5, 2026").
  static String formatDate(DateTime dt) {
    return DateFormat('MMM d, yyyy').format(dt);
  }
}
