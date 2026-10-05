import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/features/daily_challenge/domain/models/challenge_history_entry.dart';

abstract interface class DailyChallengeRepository {
  /// Returns the completion state for today's challenge.
  Result<bool> getTodayCompleted(String todayDate);

  /// Persists today's completion.
  Future<void> markTodayCompleted(String todayDate);

  /// Returns history entries, most recent first. Max 30 entries.
  List<ChallengeHistoryEntry> getHistory();

  /// Upserts a history entry for the given date.
  Future<void> saveHistoryEntry(ChallengeHistoryEntry entry);
}
