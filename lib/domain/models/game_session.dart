class GameSession {
  const GameSession({
    required this.levelId,
    required this.startedAt,
    required this.score,
    required this.starsEarned,
    required this.isCompleted,
  });

  final int levelId;
  final DateTime startedAt;
  final int score;
  final int starsEarned;
  final bool isCompleted;

  /// Creates a new in-progress [GameSession] for the given [levelId].
  factory GameSession.start(int levelId) => GameSession(
        levelId: levelId,
        startedAt: DateTime.now().toUtc(),
        score: 0,
        starsEarned: 0,
        isCompleted: false,
      );

  /// Returns a completed copy of this session with the supplied [score] and [stars].
  GameSession complete({required int score, required int stars}) => GameSession(
        levelId: levelId,
        startedAt: startedAt,
        score: score,
        starsEarned: stars,
        isCompleted: true,
      );

  Map<String, dynamic> toJson() => {
        'levelId': levelId,
        'startedAt': startedAt.toIso8601String(),
        'score': score,
        'starsEarned': starsEarned,
        'isCompleted': isCompleted,
      };

  factory GameSession.fromJson(Map<String, dynamic> json) => GameSession(
        levelId: json['levelId'] as int,
        startedAt: DateTime.parse(json['startedAt'] as String),
        score: json['score'] as int,
        starsEarned: json['starsEarned'] as int,
        isCompleted: json['isCompleted'] as bool,
      );

  @override
  String toString() => 'GameSession(levelId: $levelId, score: $score, '
      'starsEarned: $starsEarned, isCompleted: $isCompleted)';
}
