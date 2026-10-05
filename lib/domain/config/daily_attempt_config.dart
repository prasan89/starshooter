class DailyAttemptConfig {
  const DailyAttemptConfig({
    this.freeDailyLimit = 5,
  });

  final int freeDailyLimit;

  static const defaultConfig = DailyAttemptConfig();
}
