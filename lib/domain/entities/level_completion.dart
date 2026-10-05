/// Domain entities for level progression.
library;

import 'package:equatable/equatable.dart';

/// Records the completion data for a single level.
class LevelCompletion extends Equatable {
  const LevelCompletion({
    required this.levelId,
    required this.stars,
    required this.bestScore,
    required this.completedAt,
  });

  final int levelId;

  /// Stars earned (0–3).
  final int stars;

  final int bestScore;
  final DateTime completedAt;

  Map<String, dynamic> toJson() => {
        'level_id': levelId,
        'stars': stars,
        'best_score': bestScore,
        'completed_at': completedAt.toIso8601String(),
      };

  factory LevelCompletion.fromJson(Map<String, dynamic> json) =>
      LevelCompletion(
        levelId: json['level_id'] as int,
        stars: json['stars'] as int,
        bestScore: json['best_score'] as int,
        completedAt: DateTime.parse(json['completed_at'] as String),
      );

  @override
  List<Object?> get props => [levelId, stars, bestScore, completedAt];
}
