import 'package:equatable/equatable.dart';

class LevelProgress extends Equatable {
  const LevelProgress({
    required this.levelId,
    required this.isCompleted,
    required this.stars,
    required this.bestScore,
    this.bestCombo = 0,
    this.bestRemainingShots = 0,
    this.attemptCount = 0,
  });

  final int levelId;
  final bool isCompleted;
  final int stars; // 0-3
  final int bestScore;

  /// Highest combo chain achieved across all attempts.
  final int bestCombo;

  /// Most shots remaining when the level was completed.
  final int bestRemainingShots;

  /// Total number of times this level has been attempted.
  final int attemptCount;

  LevelProgress copyWith({
    int? levelId,
    bool? isCompleted,
    int? stars,
    int? bestScore,
    int? bestCombo,
    int? bestRemainingShots,
    int? attemptCount,
  }) =>
      LevelProgress(
        levelId: levelId ?? this.levelId,
        isCompleted: isCompleted ?? this.isCompleted,
        stars: stars ?? this.stars,
        bestScore: bestScore ?? this.bestScore,
        bestCombo: bestCombo ?? this.bestCombo,
        bestRemainingShots: bestRemainingShots ?? this.bestRemainingShots,
        attemptCount: attemptCount ?? this.attemptCount,
      );

  Map<String, dynamic> toJson() => {
        'levelId': levelId,
        'isCompleted': isCompleted,
        'stars': stars,
        'bestScore': bestScore,
        'bestCombo': bestCombo,
        'bestRemainingShots': bestRemainingShots,
        'attemptCount': attemptCount,
      };

  factory LevelProgress.fromJson(Map<String, dynamic> json) => LevelProgress(
        levelId: json['levelId'] as int,
        isCompleted: json['isCompleted'] as bool,
        stars: json['stars'] as int,
        bestScore: json['bestScore'] as int,
        bestCombo: json['bestCombo'] as int? ?? 0,
        bestRemainingShots: json['bestRemainingShots'] as int? ?? 0,
        attemptCount: json['attemptCount'] as int? ?? 0,
      );

  factory LevelProgress.empty(int levelId) => LevelProgress(
        levelId: levelId,
        isCompleted: false,
        stars: 0,
        bestScore: 0,
      );

  @override
  List<Object?> get props => [
        levelId,
        isCompleted,
        stars,
        bestScore,
        bestCombo,
        bestRemainingShots,
        attemptCount,
      ];
}
