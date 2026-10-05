import 'dart:async';
import 'dart:developer' as dev;

import 'package:star_shooter/analytics/analytics_event.dart';
import 'package:star_shooter/domain/repositories/analytics_repository.dart';

/// Facade that exposes one strongly-typed method per analytics event.
///
/// All methods are synchronous from the caller's perspective — they fire
/// asynchronous work via [unawaited] and never throw into the caller.
///
/// This is the ONLY class that game/UI code imports for analytics.
/// The [AnalyticsRepository] dependency is swappable for testing.
class AnalyticsService {
  AnalyticsService(this._repository);

  final AnalyticsRepository _repository;

  // Milestone levels that trigger a [level_milestone] event the first time
  // a player completes them.
  static const Set<int> _milestoneLevels = {
    5,
    20,
    50,
    75,
    100,
    101,
    125,
    150,
    175,
    200,
  };

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  void appOpened() => _log(AnalyticsEvents.appOpened());
  void sessionStarted() => _log(AnalyticsEvents.sessionStarted());
  void sessionEnded(int durationSeconds) =>
      _log(AnalyticsEvents.sessionEnded(durationSeconds));

  // ── Level ────────────────────────────────────────────────────────────────────

  void levelStarted(
    int levelId,
    int worldId, {
    bool isPremium = false,
  }) =>
      _log(
        AnalyticsEvents.levelStarted(
          levelId,
          worldId,
          isPremium: isPremium,
        ),
      );

  void levelCompleted(
    int levelId,
    int worldId,
    int score,
    int stars,
    int shotsUsed,
    int combo,
  ) {
    _log(
      AnalyticsEvents.levelCompleted(
        levelId,
        worldId,
        score,
        stars,
        shotsUsed,
        combo,
      ),
    );
    checkAndFireMilestone(levelId);
  }

  void levelFailed(
    int levelId,
    int worldId,
    int score,
    int shotsUsed, {
    String failureReason = 'shots_exhausted',
  }) =>
      _log(
        AnalyticsEvents.levelFailed(
          levelId,
          worldId,
          score,
          shotsUsed,
          failureReason,
        ),
      );

  void levelRestarted(int levelId) =>
      _log(AnalyticsEvents.levelRestarted(levelId));

  /// Fires [level_milestone] the first time [levelId] is completed, if it is
  /// in the set of milestone levels. Deduplicates across sessions via storage.
  void checkAndFireMilestone(int levelId) {
    if (!_milestoneLevels.contains(levelId)) return;
    unawaited(_fireMilestoneIfNew(levelId));
  }

  // ── Attempts ─────────────────────────────────────────────────────────────────

  void attemptConsumed(
    int levelId, {
    bool isPremium = false,
    int attemptsRemaining = 0,
  }) =>
      _log(
        AnalyticsEvents.attemptConsumed(
          levelId,
          isPremium: isPremium,
          attemptsRemaining: attemptsRemaining,
        ),
      );

  void dailyLimitReached(int levelId, {bool isPremium = false}) =>
      _log(AnalyticsEvents.dailyLimitReached(levelId, isPremium: isPremium));

  // ── Premium funnel ───────────────────────────────────────────────────────────

  void premiumScreenViewed() => _log(AnalyticsEvents.premiumScreenViewed());
  void purchaseStarted(String productId) =>
      _log(AnalyticsEvents.purchaseStarted(productId));
  void purchaseCompleted(String productId) =>
      _log(AnalyticsEvents.purchaseCompleted(productId));
  void purchaseFailed(String productId, String reason) =>
      _log(AnalyticsEvents.purchaseFailed(productId, reason));
  void restoreStarted() => _log(AnalyticsEvents.restoreStarted());
  void restoreCompleted(String productId) =>
      _log(AnalyticsEvents.restoreCompleted(productId));

  // ── Daily challenge ──────────────────────────────────────────────────────────

  void dailyChallengeViewed(String date, int levelId) =>
      _log(AnalyticsEvents.dailyChallengeViewed(date, levelId));
  void dailyChallengeStarted(String date, int levelId) =>
      _log(AnalyticsEvents.dailyChallengeStarted(date, levelId));
  void dailyChallengeCompleted(
    String date,
    int levelId,
    int score,
    int stars,
  ) =>
      _log(
        AnalyticsEvents.dailyChallengeCompleted(
          date,
          levelId,
          score,
          stars,
        ),
      );
  void dailyChallengeFailed(String date, int levelId, int score) =>
      _log(AnalyticsEvents.dailyChallengeFailed(date, levelId, score));
  void streakUpdated(int streak, {bool isMilestone = false}) =>
      _log(AnalyticsEvents.streakUpdated(streak, isMilestone: isMilestone));

  // ── Internal ─────────────────────────────────────────────────────────────────

  void _log(AnalyticsEvent event) {
    _repository.logEvent(event).catchError((Object e, StackTrace st) {
      dev.log(
        'AnalyticsService._log failed',
        error: e,
        stackTrace: st,
        name: 'Analytics',
      );
    });
  }

  Future<void> _fireMilestoneIfNew(int levelId) async {
    try {
      final completed = await _repository.getCompletedMilestones();
      if (completed.contains(levelId)) return;
      final updated = {...completed, levelId};
      await _repository.saveCompletedMilestones(updated);
      await _repository.logEvent(AnalyticsEvents.levelMilestone(levelId));
    } catch (e, st) {
      dev.log(
        'AnalyticsService._fireMilestoneIfNew failed',
        error: e,
        stackTrace: st,
        name: 'Analytics',
      );
    }
  }
}
