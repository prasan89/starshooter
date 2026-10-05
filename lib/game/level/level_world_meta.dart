/// Metadata describing which world/galaxy a level belongs to.
class LevelWorldMeta {
  final int worldId; // 1-based world number
  final int levelNumber; // 1-based position within the world
  final String worldName;
  final bool isUnlocked;
  final int unlockRequirement; // number of prior levels that must be completed

  const LevelWorldMeta({
    required this.worldId,
    required this.levelNumber,
    required this.worldName,
    this.isUnlocked = false,
    this.unlockRequirement = 0,
  });

  Map<String, dynamic> toJson() => {
        'worldId': worldId,
        'levelNumber': levelNumber,
        'worldName': worldName,
        'isUnlocked': isUnlocked,
        'unlockRequirement': unlockRequirement,
      };

  factory LevelWorldMeta.fromJson(Map<String, dynamic> json) => LevelWorldMeta(
        worldId: json['worldId'] as int,
        levelNumber: json['levelNumber'] as int,
        worldName: json['worldName'] as String,
        isUnlocked: json['isUnlocked'] as bool? ?? false,
        unlockRequirement: json['unlockRequirement'] as int? ?? 0,
      );
}
