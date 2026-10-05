import 'package:equatable/equatable.dart';

class PlayerProfile extends Equatable {
  const PlayerProfile({
    required this.name,
    required this.currentLevel,
    required this.totalStars,
    required this.premiumEntitlement,
    required this.createdAt,
  });

  /// Display name chosen by the player.
  final String name;

  /// 1-indexed level the player is currently on.
  final int currentLevel;

  /// Cumulative stars collected across all completed levels.
  final int totalStars;

  /// Whether the player has unlocked the premium tier.
  final bool premiumEntitlement;

  /// UTC timestamp when the profile was first created.
  final DateTime createdAt;

  PlayerProfile copyWith({
    String? name,
    int? currentLevel,
    int? totalStars,
    bool? premiumEntitlement,
    DateTime? createdAt,
  }) =>
      PlayerProfile(
        name: name ?? this.name,
        currentLevel: currentLevel ?? this.currentLevel,
        totalStars: totalStars ?? this.totalStars,
        premiumEntitlement: premiumEntitlement ?? this.premiumEntitlement,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'currentLevel': currentLevel,
        'totalStars': totalStars,
        'premiumEntitlement': premiumEntitlement,
        'createdAt': createdAt.toIso8601String(),
      };

  factory PlayerProfile.fromJson(Map<String, dynamic> json) => PlayerProfile(
        name: json['name'] as String,
        currentLevel: json['currentLevel'] as int,
        totalStars: json['totalStars'] as int,
        premiumEntitlement: json['premiumEntitlement'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [
        name,
        currentLevel,
        totalStars,
        premiumEntitlement,
        createdAt,
      ];
}
