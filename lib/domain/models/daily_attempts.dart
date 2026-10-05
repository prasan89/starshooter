class DailyAttempts {
  const DailyAttempts({
    required this.used,
    required this.max,
    required this.lastResetDate,
  });

  /// Number of attempts already used today.
  final int used;

  /// Maximum number of attempts allowed per day.
  final int max;

  /// The UTC date on which [used] was last reset to zero.
  final DateTime lastResetDate;

  /// Whether the player still has attempts remaining.
  bool get hasAttemptsLeft => remaining > 0;

  /// Number of attempts the player may still use today.
  int get remaining => (max - used).clamp(0, max);

  /// Returns a new [DailyAttempts] reset to zero used attempts with today's UTC date.
  DailyAttempts reset() => DailyAttempts(
        used: 0,
        max: max,
        lastResetDate: DateTime.now().toUtc(),
      );

  /// Returns a new [DailyAttempts] with [used] incremented by one.
  /// Does not guard against exceeding [max]; callers should check
  /// [hasAttemptsLeft] first.
  DailyAttempts useOne() => DailyAttempts(
        used: used + 1,
        max: max,
        lastResetDate: lastResetDate,
      );

  Map<String, dynamic> toJson() => {
        'used': used,
        'max': max,
        'lastResetDate': lastResetDate.toIso8601String(),
      };

  factory DailyAttempts.fromJson(Map<String, dynamic> json) => DailyAttempts(
        used: json['used'] as int,
        max: json['max'] as int? ?? 5,
        lastResetDate: DateTime.parse(json['lastResetDate'] as String),
      );

  /// Returns a fresh [DailyAttempts] with default values for today.
  factory DailyAttempts.fresh() => DailyAttempts(
        used: 0,
        max: 5,
        lastResetDate: DateTime.now().toUtc(),
      );

  @override
  String toString() =>
      'DailyAttempts(used: $used, max: $max, lastResetDate: $lastResetDate)';
}
