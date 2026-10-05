import 'dart:convert';

class DailyAttemptState {
  const DailyAttemptState({
    required this.attemptsUsed,
    required this.lastResetDate,
  });

  final int attemptsUsed;
  final String lastResetDate; // 'YYYY-MM-DD' local calendar date

  static DailyAttemptState fresh(String todayDate) =>
      DailyAttemptState(attemptsUsed: 0, lastResetDate: todayDate);

  DailyAttemptState copyWith({
    int? attemptsUsed,
    String? lastResetDate,
  }) =>
      DailyAttemptState(
        attemptsUsed: attemptsUsed ?? this.attemptsUsed,
        lastResetDate: lastResetDate ?? this.lastResetDate,
      );

  Map<String, dynamic> toJson() => {
        'attemptsUsed': attemptsUsed,
        'lastResetDate': lastResetDate,
      };

  factory DailyAttemptState.fromJson(Map<String, dynamic> json) =>
      DailyAttemptState(
        attemptsUsed: (json['attemptsUsed'] as num?)?.toInt() ?? 0,
        lastResetDate: json['lastResetDate'] as String? ?? '',
      );

  String encode() => jsonEncode(toJson());

  static DailyAttemptState decode(String raw) {
    try {
      return DailyAttemptState.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return DailyAttemptState.fresh('');
    }
  }
}
