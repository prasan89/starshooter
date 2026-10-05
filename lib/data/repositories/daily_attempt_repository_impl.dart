import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/date_helper.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';

/// Local-storage-backed implementation of [DailyAttemptRepository].
///
/// State is stored as a JSON string under [_kState].
/// The config is injected at construction time; defaults to
/// [DailyAttemptConfig.defaultConfig].
class LocalDailyAttemptRepository implements DailyAttemptRepository {
  LocalDailyAttemptRepository({
    required LocalStorage storage,
    DailyAttemptConfig config = DailyAttemptConfig.defaultConfig,
  })  : _storage = storage,
        _config = config;

  final LocalStorage _storage;
  final DailyAttemptConfig _config;

  static const _kState = 'daily_attempt_state_v1';

  @override
  DailyAttemptConfig get config => _config;

  @override
  Future<Result<DailyAttemptState>> getState() async {
    try {
      final raw = _storage.getString(_kState);
      if (raw == null || raw.isEmpty) {
        return Result.success(
          DailyAttemptState.fresh(DateHelper.todayLocalDate()),
        );
      }
      return Result.success(DailyAttemptState.decode(raw));
    } catch (e) {
      return Result.failure(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<DailyAttemptState>> consumeAttempt(String todayDate) async {
    try {
      final stateResult = await getState();
      final current = stateResult.when(
        onSuccess: (s) => s,
        onFailure: (_) => DailyAttemptState.fresh(todayDate),
      );
      // Use today's date in case it changed during the session.
      final updated = current.copyWith(
        attemptsUsed: current.attemptsUsed + 1,
        lastResetDate: todayDate,
      );
      await _storage.setString(_kState, updated.encode());
      return Result.success(updated);
    } catch (e) {
      return Result.failure(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<DailyAttemptState>> resetForNewDay(String todayDate) async {
    try {
      final fresh = DailyAttemptState.fresh(todayDate);
      await _storage.setString(_kState, fresh.encode());
      return Result.success(fresh);
    } catch (e) {
      return Result.failure(StorageFailure(e.toString()));
    }
  }
}
