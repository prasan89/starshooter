import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/models/player_profile.dart';
import 'package:star_shooter/domain/models/player_settings.dart';

abstract interface class PlayerRepository {
  /// Returns the stored [PlayerProfile].
  Future<Result<PlayerProfile>> getProfile();

  /// Persists [profile] to the underlying storage.
  Future<Result<void>> saveProfile(PlayerProfile profile);

  /// Returns the stored [PlayerSettings].
  Future<Result<PlayerSettings>> getSettings();

  /// Persists [settings] to the underlying storage.
  Future<Result<void>> saveSettings(PlayerSettings settings);

  /// Returns today's [DailyAttempts], resetting them if a new day has started.
  Future<Result<DailyAttempts>> getDailyAttempts();

  /// Persists [attempts] to the underlying storage.
  Future<Result<void>> saveDailyAttempts(DailyAttempts attempts);
}
