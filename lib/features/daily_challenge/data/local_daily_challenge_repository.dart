import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/challenge_history_entry.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/daily_challenge_repository.dart';

class LocalDailyChallengeRepository implements DailyChallengeRepository {
  LocalDailyChallengeRepository({required LocalStorage storage})
      : _storage = storage;

  static const _kTodayCompleted = 'daily_challenge_completed_v1';
  static const _kHistory = 'daily_challenge_history_v1';

  final LocalStorage _storage;

  @override
  Result<bool> getTodayCompleted(String todayDate) {
    try {
      final json = _storage.getJson(_kTodayCompleted);
      if (json == null) return Result.success(false);
      final storedDate = json['date'] as String? ?? '';
      if (storedDate != todayDate) return Result.success(false);
      return Result.success((json['completed'] as bool?) ?? false);
    } catch (e) {
      return Result.failure(StorageFailure(e.toString()));
    }
  }

  @override
  Future<void> markTodayCompleted(String todayDate) async {
    await _storage.setJson(_kTodayCompleted, {
      'date': todayDate,
      'completed': true,
    });
  }

  @override
  List<ChallengeHistoryEntry> getHistory() {
    try {
      final list = _storage.getJsonList(_kHistory);
      if (list == null) return [];
      return list.map(ChallengeHistoryEntry.fromJson).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveHistoryEntry(ChallengeHistoryEntry entry) async {
    final history = getHistory();
    // Upsert: replace existing entry for same date, or prepend
    final updated = [
      entry,
      ...history.where((e) => e.date != entry.date),
    ];
    // Keep only 30 most recent
    final trimmed = updated.length > 30 ? updated.sublist(0, 30) : updated;
    await _storage.setJsonList(
      _kHistory,
      trimmed.map((e) => e.toJson()).toList(),
    );
  }
}
