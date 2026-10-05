import 'package:equatable/equatable.dart';

class LevelProgress extends Equatable {
  const LevelProgress({
    required this.levelId,
    required this.isCompleted,
    required this.stars,
    required this.bestScore,
  });

  final int levelId;
  final bool isCompleted;
  final int stars; // 0-3
  final int bestScore;

  LevelProgress copyWith({
    int? levelId,
    bool? isCompleted,
    int? stars,
    int? bestScore,
  }) =>
      LevelProgress(
        levelId: levelId ?? this.levelId,
        isCompleted: isCompleted ?? this.isCompleted,
        stars: stars ?? this.stars,
        bestScore: bestScore ?? this.bestScore,
      );

  Map<String, dynamic> toJson() => {
        'levelId': levelId,
        'isCompleted': isCompleted,
        'stars': stars,
        'bestScore': bestScore,
      };

  factory LevelProgress.fromJson(Map<String, dynamic> json) => LevelProgress(
        levelId: json['levelId'] as int,
        isCompleted: json['isCompleted'] as bool,
        stars: json['stars'] as int,
        bestScore: json['bestScore'] as int,
      );

  factory LevelProgress.empty(int levelId) => LevelProgress(
        levelId: levelId,
        isCompleted: false,
        stars: 0,
        bestScore: 0,
      );

  @override
  List<Object?> get props => [levelId, isCompleted, stars, bestScore];
}
