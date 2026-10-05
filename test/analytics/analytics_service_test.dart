import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/analytics/analytics_event.dart';
import 'package:star_shooter/analytics/analytics_service.dart';
import 'package:star_shooter/domain/repositories/analytics_repository.dart';

// ── Fake repository ────────────────────────────────────────────────────────────

class _FakeAnalyticsRepository implements AnalyticsRepository {
  final List<AnalyticsEvent> logged = [];
  Set<int> _milestones = {};
  bool throwOnLog = false;

  @override
  Future<void> logEvent(AnalyticsEvent event) async {
    if (throwOnLog) throw Exception('storage failure');
    logged.add(event);
  }

  @override
  Future<List<AnalyticsEvent>> getPendingEvents() async => List.from(logged);

  @override
  Future<void> clearAllPendingEvents() async => logged.clear();

  @override
  Future<Set<int>> getCompletedMilestones() async => Set.from(_milestones);

  @override
  Future<void> saveCompletedMilestones(Set<int> milestones) async {
    _milestones = Set.from(milestones);
  }
}

// ── Tests ──────────────────────────────────────────────────────────────────────

void main() {
  late _FakeAnalyticsRepository fakeRepo;
  late AnalyticsService service;

  setUp(() {
    fakeRepo = _FakeAnalyticsRepository();
    service = AnalyticsService(fakeRepo);
  });

  // Helper — wait for unawaited async work to settle.
  Future<void> pump() => Future.delayed(Duration.zero);

  group('AnalyticsService — lifecycle events', () {
    test('appOpened fires app_opened', () async {
      service.appOpened();
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'app_opened'), isTrue);
    });

    test('sessionStarted fires session_started', () async {
      service.sessionStarted();
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'session_started'), isTrue);
    });

    test('sessionEnded fires session_ended with duration', () async {
      service.sessionEnded(300);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'session_ended');
      expect(e.params['session_duration_s'], 300);
    });
  });

  group('AnalyticsService — level events', () {
    test('levelStarted fires with correct params', () async {
      service.levelStarted(5, 1, isPremium: true);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'level_started');
      expect(e.params['level_id'], 5);
      expect(e.params['is_premium'], true);
    });

    test('levelCompleted fires with correct params', () async {
      service.levelCompleted(10, 1, 500, 3, 20, 2);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'level_completed');
      expect(e.params['score'], 500);
      expect(e.params['stars'], 3);
      expect(e.params['shots_used'], 20);
      expect(e.params['combo'], 2);
    });

    test('levelFailed fires with correct params', () async {
      service.levelFailed(7, 1, 100, 30, failureReason: 'shots_exhausted');
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'level_failed');
      expect(e.params['failure_reason'], 'shots_exhausted');
    });

    test('levelRestarted fires with level id', () async {
      service.levelRestarted(3);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'level_restarted');
      expect(e.params['level_id'], 3);
    });
  });

  group('AnalyticsService — milestone deduplication', () {
    test('milestone fires on first completion of a milestone level', () async {
      service.levelCompleted(20, 1, 200, 2, 10, 1);
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'level_milestone'), isTrue);
      final m = fakeRepo.logged.firstWhere((e) => e.name == 'level_milestone');
      expect(m.params['level_id'], 20);
    });

    test('milestone fires only once for same level', () async {
      service.levelCompleted(20, 1, 200, 2, 10, 1);
      await pump();
      service.levelCompleted(20, 1, 210, 3, 9, 2);
      await pump();
      final milestones =
          fakeRepo.logged.where((e) => e.name == 'level_milestone').toList();
      expect(milestones.length, 1);
    });

    test('milestone does NOT fire for non-milestone levels', () async {
      service.levelCompleted(3, 1, 100, 1, 15, 0);
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'level_milestone'), isFalse);
    });

    test('all 10 milestone levels trigger the event', () async {
      const milestones = {5, 20, 50, 75, 100, 101, 125, 150, 175, 200};
      for (final id in milestones) {
        fakeRepo.logged.clear();
        fakeRepo._milestones = {}; // reset so each fires fresh
        service = AnalyticsService(fakeRepo);
        service.levelCompleted(id, 1, 100, 1, 10, 0);
        await pump();
        expect(
          fakeRepo.logged.any((e) => e.name == 'level_milestone'),
          isTrue,
          reason: 'Expected milestone for level $id',
        );
      }
    });
  });

  group('AnalyticsService — attempt and premium funnel', () {
    test('attemptConsumed fires with remaining count', () async {
      service.attemptConsumed(1, attemptsRemaining: 3, isPremium: false);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'attempt_consumed');
      expect(e.params['attempts_remaining'], 3);
    });

    test('dailyLimitReached fires with level id', () async {
      service.dailyLimitReached(5);
      await pump();
      final e =
          fakeRepo.logged.firstWhere((e) => e.name == 'daily_limit_reached');
      expect(e.params['level_id'], 5);
    });

    test('premiumScreenViewed fires correct event', () async {
      service.premiumScreenViewed();
      await pump();
      expect(
        fakeRepo.logged.any((e) => e.name == 'premium_screen_viewed'),
        isTrue,
      );
    });

    test('purchaseStarted fires with product id', () async {
      service.purchaseStarted('star_shooter_premium');
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'purchase_started');
      expect(e.params['product_id'], 'star_shooter_premium');
    });

    test('purchaseCompleted fires with product id', () async {
      service.purchaseCompleted('star_shooter_premium');
      await pump();
      expect(
        fakeRepo.logged.any((e) => e.name == 'purchase_completed'),
        isTrue,
      );
    });

    test('purchaseFailed fires with reason', () async {
      service.purchaseFailed('star_shooter_premium', 'billing_error');
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'purchase_failed');
      expect(e.params['reason'], 'billing_error');
    });

    test('restoreStarted fires correct event', () async {
      service.restoreStarted();
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'restore_started'), isTrue);
    });

    test('restoreCompleted fires with product id', () async {
      service.restoreCompleted('star_shooter_premium');
      await pump();
      expect(fakeRepo.logged.any((e) => e.name == 'restore_completed'), isTrue);
    });
  });

  group('AnalyticsService — exception safety', () {
    test('does not throw when repository throws on logEvent', () async {
      fakeRepo.throwOnLog = true;
      // All of these must NOT propagate exceptions.
      expect(() => service.appOpened(), returnsNormally);
      expect(() => service.levelStarted(1, 1), returnsNormally);
      expect(() => service.levelCompleted(1, 1, 0, 0, 0, 0), returnsNormally);
      expect(() => service.premiumScreenViewed(), returnsNormally);
      await pump();
    });

    test('milestone check does not throw when repository throws', () async {
      fakeRepo.throwOnLog = true;
      expect(
        () => service.levelCompleted(20, 1, 100, 2, 10, 1),
        returnsNormally,
      );
      await pump();
    });
  });

  group('AnalyticsService — daily challenge events', () {
    test('dailyChallengeViewed fires with date and level', () async {
      service.dailyChallengeViewed('2026-10-05', 42);
      await pump();
      final e =
          fakeRepo.logged.firstWhere((e) => e.name == 'daily_challenge_viewed');
      expect(e.params['date'], '2026-10-05');
      expect(e.params['level_id'], 42);
    });

    test('streakUpdated fires with milestone flag', () async {
      service.streakUpdated(7, isMilestone: true);
      await pump();
      final e = fakeRepo.logged.firstWhere((e) => e.name == 'streak_updated');
      expect(e.params['streak'], 7);
      expect(e.params['milestone'], true);
    });
  });
}
