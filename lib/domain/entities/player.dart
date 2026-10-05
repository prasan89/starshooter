/// Domain entities for player data.
library;

import 'package:equatable/equatable.dart';

/// Persistent profile information for the local player.
class PlayerProfile extends Equatable {
  const PlayerProfile({
    required this.displayName,
    required this.totalScore,
    required this.levelsCompleted,
    required this.createdAt,
  });

  final String displayName;
  final int totalScore;
  final int levelsCompleted;
  final DateTime createdAt;

  /// Returns a default/empty profile used when no data exists yet.
  factory PlayerProfile.empty() => PlayerProfile(
        displayName: 'Player',
        totalScore: 0,
        levelsCompleted: 0,
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'display_name': displayName,
        'total_score': totalScore,
        'levels_completed': levelsCompleted,
        'created_at': createdAt.toIso8601String(),
      };

  factory PlayerProfile.fromJson(Map<String, dynamic> json) => PlayerProfile(
        displayName: json['display_name'] as String? ?? 'Player',
        totalScore: json['total_score'] as int? ?? 0,
        levelsCompleted: json['levels_completed'] as int? ?? 0,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
            : DateTime.now(),
      );

  PlayerProfile copyWith({
    String? displayName,
    int? totalScore,
    int? levelsCompleted,
    DateTime? createdAt,
  }) =>
      PlayerProfile(
        displayName: displayName ?? this.displayName,
        totalScore: totalScore ?? this.totalScore,
        levelsCompleted: levelsCompleted ?? this.levelsCompleted,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props =>
      [displayName, totalScore, levelsCompleted, createdAt];
}

/// In-game settings persisted locally.
class PlayerSettings extends Equatable {
  const PlayerSettings({
    required this.sfxEnabled,
    required this.musicEnabled,
    required this.vibrationEnabled,
    required this.notificationsEnabled,
  });

  final bool sfxEnabled;
  final bool musicEnabled;
  final bool vibrationEnabled;
  final bool notificationsEnabled;

  factory PlayerSettings.defaults() => const PlayerSettings(
        sfxEnabled: true,
        musicEnabled: true,
        vibrationEnabled: true,
        notificationsEnabled: true,
      );

  Map<String, dynamic> toJson() => {
        'sfx_enabled': sfxEnabled,
        'music_enabled': musicEnabled,
        'vibration_enabled': vibrationEnabled,
        'notifications_enabled': notificationsEnabled,
      };

  factory PlayerSettings.fromJson(Map<String, dynamic> json) => PlayerSettings(
        sfxEnabled: json['sfx_enabled'] as bool? ?? true,
        musicEnabled: json['music_enabled'] as bool? ?? true,
        vibrationEnabled: json['vibration_enabled'] as bool? ?? true,
        notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
      );

  PlayerSettings copyWith({
    bool? sfxEnabled,
    bool? musicEnabled,
    bool? vibrationEnabled,
    bool? notificationsEnabled,
  }) =>
      PlayerSettings(
        sfxEnabled: sfxEnabled ?? this.sfxEnabled,
        musicEnabled: musicEnabled ?? this.musicEnabled,
        vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      );

  @override
  List<Object?> get props =>
      [sfxEnabled, musicEnabled, vibrationEnabled, notificationsEnabled];
}

/// Tracks daily attempt counts, gated by the day boundary.
class DailyAttempts extends Equatable {
  const DailyAttempts({
    required this.date,
    required this.attemptsUsed,
    required this.maxAttempts,
  });

  final DateTime date;
  final int attemptsUsed;
  final int maxAttempts;

  factory DailyAttempts.fresh({int maxAttempts = 5}) => DailyAttempts(
        date: DateTime.now(),
        attemptsUsed: 0,
        maxAttempts: maxAttempts,
      );

  bool get hasAttemptsRemaining => attemptsUsed < maxAttempts;
  int get remaining => (maxAttempts - attemptsUsed).clamp(0, maxAttempts);

  /// Returns true when [date] is a different calendar day than today.
  bool get isStale {
    final now = DateTime.now();
    return date.year != now.year ||
        date.month != now.month ||
        date.day != now.day;
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'attempts_used': attemptsUsed,
        'max_attempts': maxAttempts,
      };

  factory DailyAttempts.fromJson(Map<String, dynamic> json) => DailyAttempts(
        date: json['date'] != null
            ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
            : DateTime.now(),
        attemptsUsed: json['attempts_used'] as int? ?? 0,
        maxAttempts: json['max_attempts'] as int? ?? 5,
      );

  DailyAttempts copyWith({
    DateTime? date,
    int? attemptsUsed,
    int? maxAttempts,
  }) =>
      DailyAttempts(
        date: date ?? this.date,
        attemptsUsed: attemptsUsed ?? this.attemptsUsed,
        maxAttempts: maxAttempts ?? this.maxAttempts,
      );

  @override
  List<Object?> get props => [date, attemptsUsed, maxAttempts];
}
