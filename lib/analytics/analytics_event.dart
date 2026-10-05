import 'dart:convert';

/// A single analytics event with a snake_case [name] and optional [params].
///
/// Keep params minimal — only data that drives product or business decisions.
/// No personal information, no device identifiers.
class AnalyticsEvent {
  const AnalyticsEvent(this.name, [this.params = const {}]);

  final String name;
  final Map<String, Object> params;

  Map<String, dynamic> toJson() => {
        'name': name,
        'params': params,
        'ts': DateTime.now().millisecondsSinceEpoch,
      };

  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) {
    final rawParams = json['params'];
    final params = <String, Object>{};
    if (rawParams is Map) {
      for (final entry in rawParams.entries) {
        if (entry.value is Object) {
          params[entry.key.toString()] = entry.value as Object;
        }
      }
    }
    return AnalyticsEvent(json['name'] as String, params);
  }

  String toJsonString() => jsonEncode(toJson());

  @override
  String toString() => 'AnalyticsEvent($name, $params)';
}

// ── Event factory methods ──────────────────────────────────────────────────────

/// Factories kept as top-level functions so callers don't need to import
/// individual event subclasses. All params use snake_case keys.
class AnalyticsEvents {
  AnalyticsEvents._();

  // Lifecycle
  static AnalyticsEvent appOpened() => const AnalyticsEvent('app_opened');
  static AnalyticsEvent sessionStarted() =>
      const AnalyticsEvent('session_started');
  static AnalyticsEvent sessionEnded(int durationSeconds) =>
      AnalyticsEvent('session_ended', {'session_duration_s': durationSeconds});

  // Level
  static AnalyticsEvent levelStarted(
    int levelId,
    int worldId, {
    bool isPremium = false,
  }) =>
      AnalyticsEvent('level_started', {
        'level_id': levelId,
        'world_id': worldId,
        'is_premium': isPremium,
      });

  static AnalyticsEvent levelCompleted(
    int levelId,
    int worldId,
    int score,
    int stars,
    int shotsUsed,
    int combo,
  ) =>
      AnalyticsEvent('level_completed', {
        'level_id': levelId,
        'world_id': worldId,
        'score': score,
        'stars': stars,
        'shots_used': shotsUsed,
        'combo': combo,
      });

  static AnalyticsEvent levelFailed(
    int levelId,
    int worldId,
    int score,
    int shotsUsed,
    String failureReason,
  ) =>
      AnalyticsEvent('level_failed', {
        'level_id': levelId,
        'world_id': worldId,
        'score': score,
        'shots_used': shotsUsed,
        'failure_reason': failureReason,
      });

  static AnalyticsEvent levelRestarted(int levelId) =>
      AnalyticsEvent('level_restarted', {'level_id': levelId});

  static AnalyticsEvent levelMilestone(int levelId) =>
      AnalyticsEvent('level_milestone', {'level_id': levelId});

  // Attempts
  static AnalyticsEvent attemptConsumed(
    int levelId, {
    bool isPremium = false,
    int attemptsRemaining = 0,
  }) =>
      AnalyticsEvent('attempt_consumed', {
        'level_id': levelId,
        'is_premium': isPremium,
        'attempts_remaining': attemptsRemaining,
      });

  static AnalyticsEvent dailyLimitReached(
    int levelId, {
    bool isPremium = false,
  }) =>
      AnalyticsEvent('daily_limit_reached', {
        'level_id': levelId,
        'is_premium': isPremium,
      });

  // Premium funnel
  static AnalyticsEvent premiumScreenViewed() =>
      const AnalyticsEvent('premium_screen_viewed');
  static AnalyticsEvent purchaseStarted(String productId) =>
      AnalyticsEvent('purchase_started', {'product_id': productId});
  static AnalyticsEvent purchaseCompleted(String productId) =>
      AnalyticsEvent('purchase_completed', {'product_id': productId});
  static AnalyticsEvent purchaseFailed(String productId, String reason) =>
      AnalyticsEvent('purchase_failed', {
        'product_id': productId,
        'reason': reason,
      });
  static AnalyticsEvent restoreStarted() =>
      const AnalyticsEvent('restore_started');
  static AnalyticsEvent restoreCompleted(String productId) =>
      AnalyticsEvent('restore_completed', {'product_id': productId});

  // Daily challenge
  static AnalyticsEvent dailyChallengeViewed(String date, int levelId) =>
      AnalyticsEvent('daily_challenge_viewed', {
        'date': date,
        'level_id': levelId,
      });
  static AnalyticsEvent dailyChallengeStarted(String date, int levelId) =>
      AnalyticsEvent('daily_challenge_started', {
        'date': date,
        'level_id': levelId,
      });
  static AnalyticsEvent dailyChallengeCompleted(
    String date,
    int levelId,
    int score,
    int stars,
  ) =>
      AnalyticsEvent('daily_challenge_completed', {
        'date': date,
        'level_id': levelId,
        'score': score,
        'stars': stars,
      });
  static AnalyticsEvent dailyChallengeFailed(
    String date,
    int levelId,
    int score,
  ) =>
      AnalyticsEvent('daily_challenge_failed', {
        'date': date,
        'level_id': levelId,
        'score': score,
      });
  static AnalyticsEvent streakUpdated(int streak, {bool isMilestone = false}) =>
      AnalyticsEvent('streak_updated', {
        'streak': streak,
        'milestone': isMilestone,
      });
}
