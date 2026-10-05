import 'package:star_shooter/analytics/analytics_service.dart';

abstract interface class ChallengeAnalytics {
  void logChallengeViewed(String date, int levelId);
  void logChallengeStarted(String date, int levelId);
  void logChallengeCompleted(String date, int levelId, int score, int stars);
  void logChallengeFailed(String date, int levelId, int score);
  void logChallengeReplayed(String date, int levelId);
  void logStreakStarted(int streak);
  void logStreakExtended(int streak);
  void logStreakMilestone(int streak);
}

/// No-op implementation — used in tests and as a fallback.
class NoOpChallengeAnalytics implements ChallengeAnalytics {
  const NoOpChallengeAnalytics();

  @override
  void logChallengeViewed(String date, int levelId) {}

  @override
  void logChallengeStarted(String date, int levelId) {}

  @override
  void logChallengeCompleted(String date, int levelId, int score, int stars) {}

  @override
  void logChallengeFailed(String date, int levelId, int score) {}

  @override
  void logChallengeReplayed(String date, int levelId) {}

  @override
  void logStreakStarted(int streak) {}

  @override
  void logStreakExtended(int streak) {}

  @override
  void logStreakMilestone(int streak) {}
}

/// Adapter that bridges [ChallengeAnalytics] calls to [AnalyticsService].
class AnalyticsServiceChallengeAdapter implements ChallengeAnalytics {
  const AnalyticsServiceChallengeAdapter(this._analytics);

  final AnalyticsService _analytics;

  static const Set<int> _streakMilestones = {3, 7, 14, 30};

  @override
  void logChallengeViewed(String date, int levelId) =>
      _analytics.dailyChallengeViewed(date, levelId);

  @override
  void logChallengeStarted(String date, int levelId) =>
      _analytics.dailyChallengeStarted(date, levelId);

  @override
  void logChallengeCompleted(String date, int levelId, int score, int stars) =>
      _analytics.dailyChallengeCompleted(date, levelId, score, stars);

  @override
  void logChallengeFailed(String date, int levelId, int score) =>
      _analytics.dailyChallengeFailed(date, levelId, score);

  @override
  void logChallengeReplayed(String date, int levelId) =>
      _analytics.dailyChallengeStarted(date, levelId);

  @override
  void logStreakStarted(int streak) =>
      _analytics.streakUpdated(streak, isMilestone: false);

  @override
  void logStreakExtended(int streak) => _analytics.streakUpdated(
        streak,
        isMilestone: _streakMilestones.contains(streak),
      );

  @override
  void logStreakMilestone(int streak) =>
      _analytics.streakUpdated(streak, isMilestone: true);
}
