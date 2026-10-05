class ChallengeHistoryEntry {
  const ChallengeHistoryEntry({
    required this.date,
    required this.levelId,
    required this.completed,
    required this.score,
    required this.stars,
  });

  final String date; // 'YYYY-MM-DD'
  final int levelId;
  final bool completed;
  final int score;
  final int stars;

  Map<String, dynamic> toJson() => {
        'date': date,
        'levelId': levelId,
        'completed': completed,
        'score': score,
        'stars': stars,
      };

  factory ChallengeHistoryEntry.fromJson(Map<String, dynamic> json) =>
      ChallengeHistoryEntry(
        date: json['date'] as String? ?? '',
        levelId: (json['levelId'] as num?)?.toInt() ?? 0,
        completed: json['completed'] as bool? ?? false,
        score: (json['score'] as num?)?.toInt() ?? 0,
        stars: (json['stars'] as num?)?.toInt() ?? 0,
      );
}
