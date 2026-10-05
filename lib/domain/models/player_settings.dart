import 'package:equatable/equatable.dart';

class PlayerSettings extends Equatable {
  const PlayerSettings({
    required this.musicEnabled,
    required this.sfxEnabled,
    required this.hapticsEnabled,
  });

  final bool musicEnabled;
  final bool sfxEnabled;
  final bool hapticsEnabled;

  /// Returns a [PlayerSettings] instance with all options enabled.
  factory PlayerSettings.defaults() => const PlayerSettings(
        musicEnabled: true,
        sfxEnabled: true,
        hapticsEnabled: true,
      );

  PlayerSettings copyWith({
    bool? musicEnabled,
    bool? sfxEnabled,
    bool? hapticsEnabled,
  }) =>
      PlayerSettings(
        musicEnabled: musicEnabled ?? this.musicEnabled,
        sfxEnabled: sfxEnabled ?? this.sfxEnabled,
        hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      );

  Map<String, dynamic> toJson() => {
        'musicEnabled': musicEnabled,
        'sfxEnabled': sfxEnabled,
        'hapticsEnabled': hapticsEnabled,
      };

  factory PlayerSettings.fromJson(Map<String, dynamic> json) => PlayerSettings(
        musicEnabled: json['musicEnabled'] as bool? ?? true,
        sfxEnabled: json['sfxEnabled'] as bool? ?? true,
        hapticsEnabled: json['hapticsEnabled'] as bool? ?? true,
      );

  @override
  List<Object?> get props => [musicEnabled, sfxEnabled, hapticsEnabled];
}
