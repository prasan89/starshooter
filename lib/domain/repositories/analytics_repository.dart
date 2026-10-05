import 'package:star_shooter/analytics/analytics_event.dart';

/// Domain interface for analytics persistence and event dispatch.
///
/// The implementation queues events locally (offline-first) and dispatches
/// them to an analytics provider when possible. The provider can be a no-op,
/// a debug logger, or a real SDK without changing this interface.
abstract interface class AnalyticsRepository {
  /// Enqueues [event] to the local queue and attempts to dispatch it to
  /// the configured analytics provider. Must never throw.
  Future<void> logEvent(AnalyticsEvent event);

  /// Returns all events currently pending in the local queue.
  Future<List<AnalyticsEvent>> getPendingEvents();

  /// Clears all pending events from the local queue.
  Future<void> clearAllPendingEvents();

  /// Returns the set of level milestone IDs that have already been fired.
  Future<Set<int>> getCompletedMilestones();

  /// Persists the updated set of completed milestone level IDs.
  Future<void> saveCompletedMilestones(Set<int> milestones);
}
