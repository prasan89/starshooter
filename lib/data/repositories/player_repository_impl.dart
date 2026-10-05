import 'dart:async' show unawaited;
import 'dart:developer' as dev;

import 'package:star_shooter/core/constants/storage_keys.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/models/daily_attempts.dart';
import 'package:star_shooter/domain/models/player_profile.dart';
import 'package:star_shooter/domain/models/player_settings.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Local-storage-backed implementation of [PlayerRepository].
///
/// Persists [PlayerProfile], [PlayerSettings], and [DailyAttempts] as JSON
/// objects in shared preferences.  Missing or corrupt data is replaced with
/// safe in-memory defaults so the game can always start cleanly.
class PlayerRepositoryImpl implements PlayerRepository {
  PlayerRepositoryImpl(this._storage);

  final LocalStorage _storage;

  // ---------------------------------------------------------------------------
  // PlayerProfile
  // ---------------------------------------------------------------------------

  @override
  Future<Result<PlayerProfile>> getProfile() async {
    try {
      final json = _storage.getJson(kKeyPlayerProfile);
      if (json == null) {
        return Result.success(
          PlayerProfile(
            name: 'Player',
            currentLevel: 1,
            totalStars: 0,
            premiumEntitlement: false,
            createdAt: DateTime.now().toUtc(),
          ),
        );
      }
      return Result.success(PlayerProfile.fromJson(json));
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.getProfile failed',
        error: e,
        stackTrace: st,
      );
      // Return a safe default so the caller never has to handle the error path
      // just to boot the game.
      return Result.failure(
        StorageFailure('Failed to load player profile: $e'),
      );
    }
  }

  @override
  Future<Result<void>> saveProfile(PlayerProfile profile) async {
    try {
      final ok = await _storage.setJson(kKeyPlayerProfile, profile.toJson());
      if (!ok) {
        return Result.failure(
          const StorageFailure('setJson returned false for player profile'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.saveProfile failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to save player profile: $e'),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // PlayerSettings
  // ---------------------------------------------------------------------------

  @override
  Future<Result<PlayerSettings>> getSettings() async {
    try {
      final json = _storage.getJson(kKeyPlayerSettings);
      if (json == null) return Result.success(PlayerSettings.defaults());
      return Result.success(PlayerSettings.fromJson(json));
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.getSettings failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to load player settings: $e'),
      );
    }
  }

  @override
  Future<Result<void>> saveSettings(PlayerSettings settings) async {
    try {
      final ok = await _storage.setJson(kKeyPlayerSettings, settings.toJson());
      if (!ok) {
        return Result.failure(
          const StorageFailure('setJson returned false for player settings'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.saveSettings failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to save player settings: $e'),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // DailyAttempts
  // ---------------------------------------------------------------------------

  @override
  Future<Result<DailyAttempts>> getDailyAttempts() async {
    try {
      final json = _storage.getJson(kKeyDailyAttempts);
      if (json == null) return Result.success(DailyAttempts.fresh());

      final attempts = DailyAttempts.fromJson(json);

      // Auto-reset when the stored record is from a previous calendar day.
      final now = DateTime.now().toUtc();
      final reset = attempts.lastResetDate;
      final isStale = reset.year != now.year ||
          reset.month != now.month ||
          reset.day != now.day;

      if (isStale) {
        final fresh = attempts.reset();
        // Fire-and-forget persist of the reset; ignore write failure here
        // because we return a fresh object regardless.
        unawaited(saveDailyAttempts(fresh));
        return Result.success(fresh);
      }

      return Result.success(attempts);
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.getDailyAttempts failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to load daily attempts: $e'),
      );
    }
  }

  @override
  Future<Result<void>> saveDailyAttempts(DailyAttempts attempts) async {
    try {
      final ok = await _storage.setJson(kKeyDailyAttempts, attempts.toJson());
      if (!ok) {
        return Result.failure(
          const StorageFailure('setJson returned false for daily attempts'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'PlayerRepositoryImpl.saveDailyAttempts failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to save daily attempts: $e'),
      );
    }
  }
}
