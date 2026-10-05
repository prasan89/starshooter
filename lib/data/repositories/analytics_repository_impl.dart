import 'dart:async';
import 'dart:developer' as dev;

import 'package:star_shooter/analytics/analytics_event.dart';
import 'package:star_shooter/core/config/app_config.dart';
import 'package:star_shooter/core/constants/storage_keys.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/repositories/analytics_repository.dart';

/// SharedPreferences-backed implementation of [AnalyticsRepository].
///
/// Queue:
/// - Events are serialized as JSON and stored in a list under [kKeyAnalyticsQueue].
/// - The queue is bounded to [_maxQueueSize] events; oldest events are dropped
///   when the limit is reached.
/// - [logEvent] writes to the queue first (so events survive app restarts),
///   then attempts to dispatch to the provider.
///
/// Provider:
/// - In dev builds: emits `[Analytics] name {params}` via dart:developer.
/// - In non-dev builds: silently discards (no external SDK in M14).
///
/// Milestone deduplication:
/// - Completed milestone level IDs are stored as a comma-separated string
///   under [kKeyAnalyticsMilestones].
class LocalAnalyticsRepository implements AnalyticsRepository {
  LocalAnalyticsRepository(this._storage);

  final LocalStorage _storage;

  static const int _maxQueueSize = 200;

  // ── AnalyticsRepository ──────────────────────────────────────────────────────

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    try {
      await _enqueue(event);
      unawaited(_dispatch(event));
    } catch (e, st) {
      dev.log(
        'LocalAnalyticsRepository.logEvent failed',
        error: e,
        stackTrace: st,
        name: 'Analytics',
      );
    }
  }

  @override
  Future<List<AnalyticsEvent>> getPendingEvents() async {
    try {
      final raw = _storage.getJsonList(kKeyAnalyticsQueue) ?? [];
      return raw.map(AnalyticsEvent.fromJson).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> clearAllPendingEvents() async {
    try {
      await _storage.setJsonList(kKeyAnalyticsQueue, []);
    } catch (_) {}
  }

  @override
  Future<Set<int>> getCompletedMilestones() async {
    try {
      final raw = _storage.getString(kKeyAnalyticsMilestones) ?? '';
      if (raw.isEmpty) return {};
      return raw
          .split(',')
          .map(int.tryParse)
          .whereType<int>()
          .toSet();
    } catch (_) {
      return {};
    }
  }

  @override
  Future<void> saveCompletedMilestones(Set<int> milestones) async {
    try {
      await _storage.setString(
        kKeyAnalyticsMilestones,
        milestones.join(','),
      );
    } catch (_) {}
  }

  // ── Internal helpers ─────────────────────────────────────────────────────────

  Future<void> _enqueue(AnalyticsEvent event) async {
    final list = _storage.getJsonList(kKeyAnalyticsQueue) ?? [];
    final updated = list.length >= _maxQueueSize
        ? [...list.sublist(list.length - _maxQueueSize + 1), event.toJson()]
        : [...list, event.toJson()];
    await _storage.setJsonList(kKeyAnalyticsQueue, updated);
  }

  Future<void> _dispatch(AnalyticsEvent event) async {
    if (AppConfig.isDev) {
      dev.log(
        '[Analytics] ${event.name} ${event.params}',
        name: 'Analytics',
      );
    }
    // In M14, the provider is a no-op in production.
    // A real SDK (Firebase, Amplitude, etc.) can be plugged in here
    // by replacing this method without changing any other code.
  }
}
