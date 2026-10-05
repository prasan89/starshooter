/// Abstraction over DateTime.now() for testability and future server-time
/// validation.
abstract interface class GameClock {
  DateTime now();

  /// Returns today's local date as 'YYYY-MM-DD'.
  String todayLocalDate();
}

class LocalGameClock implements GameClock {
  const LocalGameClock();

  @override
  DateTime now() => DateTime.now();

  @override
  String todayLocalDate() {
    final d = now();
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }
}
