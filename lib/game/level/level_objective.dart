import 'package:star_shooter/game/models/star_type.dart';

/// The kind of goal a player must satisfy to complete a level.
enum ObjectiveType {
  scoreTarget, // reach a score total
  clearStars, // pop N stars of any type
  clearStarType, // pop N stars of a specific type
  clearSpecial, // remove N special obstacle stars (future hook)
}

class LevelObjective {
  final ObjectiveType type;
  final int target; // numeric goal
  final StarType? targetStarType; // only for clearStarType

  const LevelObjective({
    required this.type,
    required this.target,
    this.targetStarType,
  });

  const LevelObjective.scoreTarget(int score)
      : type = ObjectiveType.scoreTarget,
        target = score,
        targetStarType = null;

  const LevelObjective.clearStars(int count)
      : type = ObjectiveType.clearStars,
        target = count,
        targetStarType = null;

  const LevelObjective.clearStarType(int count, StarType starType)
      : type = ObjectiveType.clearStarType,
        target = count,
        targetStarType = starType;

  const LevelObjective.clearSpecial(int count)
      : type = ObjectiveType.clearSpecial,
        target = count,
        targetStarType = null;

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'target': target,
        if (targetStarType != null) 'targetStarType': targetStarType!.name,
      };

  factory LevelObjective.fromJson(Map<String, dynamic> json) {
    final type = ObjectiveType.values.byName(json['type'] as String);
    final target = json['target'] as int;
    final starTypeStr = json['targetStarType'] as String?;
    final starType =
        starTypeStr != null ? StarType.values.byName(starTypeStr) : null;
    return LevelObjective(type: type, target: target, targetStarType: starType);
  }

  String get displayText {
    switch (type) {
      case ObjectiveType.scoreTarget:
        return 'Score ${_formatNum(target)} points';
      case ObjectiveType.clearStars:
        return 'Clear $target stars';
      case ObjectiveType.clearStarType:
        return 'Clear $target ${targetStarType?.name ?? ''} stars';
      case ObjectiveType.clearSpecial:
        return 'Remove $target obstacles';
    }
  }

  static String _formatNum(int n) {
    if (n >= 1000) {
      return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}k';
    }
    return '$n';
  }
}
