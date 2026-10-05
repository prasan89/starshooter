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

/// No-op implementation — analytics SDK to be connected in M14.
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
