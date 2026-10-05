/// Helper for calendar-date operations shared across use cases.
class DateHelper {
  DateHelper._();

  /// Returns today's local date as a 'YYYY-MM-DD' string.
  static String todayLocalDate() {
    final now = DateTime.now();
    final y = now.year.toString().padLeft(4, '0');
    final m = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
