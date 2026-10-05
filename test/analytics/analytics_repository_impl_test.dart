import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_shooter/analytics/analytics_event.dart';
import 'package:star_shooter/core/constants/storage_keys.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/analytics_repository_impl.dart';

void main() {
  late SharedPreferences prefs;
  late LocalStorage storage;
  late LocalAnalyticsRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
    repo = LocalAnalyticsRepository(storage);
  });

  group('LocalAnalyticsRepository — queue', () {
    test('logEvent stores event in queue', () async {
      const event = AnalyticsEvent('app_opened');
      await repo.logEvent(event);

      final pending = await repo.getPendingEvents();
      expect(pending.length, 1);
      expect(pending.first.name, 'app_opened');
    });

    test('logEvent appends multiple events', () async {
      await repo.logEvent(const AnalyticsEvent('a'));
      await repo.logEvent(const AnalyticsEvent('b'));
      await repo.logEvent(const AnalyticsEvent('c'));

      final pending = await repo.getPendingEvents();
      expect(pending.length, 3);
      expect(pending.map((e) => e.name).toList(), ['a', 'b', 'c']);
    });

    test('queue preserves params through serialization', () async {
      const event = AnalyticsEvent('level_started', {
        'level_id': 5,
        'world_id': 1,
        'is_premium': false,
      });
      await repo.logEvent(event);

      final pending = await repo.getPendingEvents();
      expect(pending.first.params['level_id'], 5);
      expect(pending.first.params['world_id'], 1);
    });

    test('queue is bounded at 200 events — oldest are dropped', () async {
      // Fill the queue with 200 'old' events.
      for (var i = 0; i < 200; i++) {
        await repo.logEvent(AnalyticsEvent('old', {'i': i}));
      }

      // Add one more — this should drop the oldest.
      await repo.logEvent(const AnalyticsEvent('new_event'));

      final pending = await repo.getPendingEvents();
      expect(pending.length, 200);
      expect(pending.last.name, 'new_event');
      // The first 'old' (i=0) was dropped; the next oldest is i=1.
      expect(pending.first.params['i'], 1);
    });

    test('queue persists across repository recreation', () async {
      await repo.logEvent(const AnalyticsEvent('persisted'));

      // Recreate with same prefs.
      final repo2 = LocalAnalyticsRepository(storage);
      final pending = await repo2.getPendingEvents();
      expect(pending.length, 1);
      expect(pending.first.name, 'persisted');
    });

    test('clearAllPendingEvents empties queue', () async {
      await repo.logEvent(const AnalyticsEvent('x'));
      await repo.logEvent(const AnalyticsEvent('y'));
      await repo.clearAllPendingEvents();

      final pending = await repo.getPendingEvents();
      expect(pending, isEmpty);
    });

    test('getPendingEvents returns empty list when queue is missing', () async {
      // Nothing stored — should not throw.
      final pending = await repo.getPendingEvents();
      expect(pending, isEmpty);
    });

    test('logEvent does not throw when storage is corrupt', () async {
      // Simulate corrupt queue by storing a non-list value.
      await prefs.setString(kKeyAnalyticsQueue, 'not_valid_json_list');
      // Should not throw.
      await expectLater(
        repo.logEvent(const AnalyticsEvent('test')),
        completes,
      );
    });
  });

  group('LocalAnalyticsRepository — milestones', () {
    test('getCompletedMilestones returns empty set when no data', () async {
      final milestones = await repo.getCompletedMilestones();
      expect(milestones, isEmpty);
    });

    test('saveCompletedMilestones and getCompletedMilestones roundtrip',
        () async {
      await repo.saveCompletedMilestones({5, 20, 50});
      final loaded = await repo.getCompletedMilestones();
      expect(loaded, containsAll([5, 20, 50]));
      expect(loaded.length, 3);
    });

    test('milestones persist across repository recreation', () async {
      await repo.saveCompletedMilestones({100, 125});
      final repo2 = LocalAnalyticsRepository(storage);
      final loaded = await repo2.getCompletedMilestones();
      expect(loaded, containsAll([100, 125]));
    });

    test('saves empty set without error', () async {
      await repo.saveCompletedMilestones({});
      final loaded = await repo.getCompletedMilestones();
      expect(loaded, isEmpty);
    });

    test('handles corrupt milestone string gracefully', () async {
      await prefs.setString(kKeyAnalyticsMilestones, 'abc,def,,5');
      final loaded = await repo.getCompletedMilestones();
      // 'abc', 'def', '' fail int.tryParse; only '5' is kept.
      expect(loaded, {5});
    });
  });
}
