import 'dart:convert';

class StreakState {
  const StreakState({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCompletedDate,
    required this.totalDaysCompleted,
  });

  final int currentStreak;
  final int longestStreak;
  final String lastCompletedDate; // 'YYYY-MM-DD' or '' if never
  final int totalDaysCompleted;

  static const empty = StreakState(
    currentStreak: 0,
    longestStreak: 0,
    lastCompletedDate: '',
    totalDaysCompleted: 0,
  );

  StreakState copyWith({
    int? currentStreak,
    int? longestStreak,
    String? lastCompletedDate,
    int? totalDaysCompleted,
  }) =>
      StreakState(
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
        totalDaysCompleted: totalDaysCompleted ?? this.totalDaysCompleted,
      );

  Map<String, dynamic> toJson() => {
        'currentStreak': currentStreak,
        'longestStreak': longestStreak,
        'lastCompletedDate': lastCompletedDate,
        'totalDaysCompleted': totalDaysCompleted,
      };

  factory StreakState.fromJson(Map<String, dynamic> json) => StreakState(
        currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
        longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
        lastCompletedDate: json['lastCompletedDate'] as String? ?? '',
        totalDaysCompleted: (json['totalDaysCompleted'] as num?)?.toInt() ?? 0,
      );

  String encode() => jsonEncode(toJson());

  static StreakState decode(String raw) {
    try {
      return StreakState.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return StreakState.empty;
    }
  }
}
