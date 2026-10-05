/// Discrete difficulty bands displayed to the player.
enum DifficultyCategory { easy, medium, hard, expert }

class DifficultyModel {
  final DifficultyCategory category;
  final double difficultyScore; // 0.0 – 1.0 normalised
  final double estimatedCompletionRate; // 0.0 – 1.0
  final int estimatedMinimumShots;
  final int estimatedAverageShots;
  final double specialStarComplexity; // 0.0 – 1.0
  final double boardComplexity; // 0.0 – 1.0

  const DifficultyModel({
    required this.category,
    required this.difficultyScore,
    this.estimatedCompletionRate = 0.7,
    this.estimatedMinimumShots = 10,
    this.estimatedAverageShots = 15,
    this.specialStarComplexity = 0.0,
    this.boardComplexity = 0.5,
  });

  static DifficultyCategory categoryFromScore(double score) {
    if (score < 0.30) return DifficultyCategory.easy;
    if (score < 0.55) return DifficultyCategory.medium;
    if (score < 0.80) return DifficultyCategory.hard;
    return DifficultyCategory.expert;
  }

  Map<String, dynamic> toJson() => {
        'category': category.name,
        'difficultyScore': difficultyScore,
        'estimatedCompletionRate': estimatedCompletionRate,
        'estimatedMinimumShots': estimatedMinimumShots,
        'estimatedAverageShots': estimatedAverageShots,
        'specialStarComplexity': specialStarComplexity,
        'boardComplexity': boardComplexity,
      };

  factory DifficultyModel.fromJson(Map<String, dynamic> json) =>
      DifficultyModel(
        category: DifficultyCategory.values.byName(json['category'] as String),
        difficultyScore: (json['difficultyScore'] as num).toDouble(),
        estimatedCompletionRate:
            (json['estimatedCompletionRate'] as num? ?? 0.7).toDouble(),
        estimatedMinimumShots: json['estimatedMinimumShots'] as int? ?? 10,
        estimatedAverageShots: json['estimatedAverageShots'] as int? ?? 15,
        specialStarComplexity:
            (json['specialStarComplexity'] as num? ?? 0.0).toDouble(),
        boardComplexity: (json['boardComplexity'] as num? ?? 0.5).toDouble(),
      );

  static DifficultyModel placeholder(int levelId) {
    final score = (levelId / 50.0).clamp(0.05, 0.95);
    return DifficultyModel(
      category: categoryFromScore(score),
      difficultyScore: score,
    );
  }
}
