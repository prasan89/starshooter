import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/analytics/analytics_event.dart';

void main() {
  group('AnalyticsEvent', () {
    test('stores name and params', () {
      const e = AnalyticsEvent('test_event', {'key': 42});
      expect(e.name, 'test_event');
      expect(e.params['key'], 42);
    });

    test('defaults to empty params', () {
      const e = AnalyticsEvent('no_params');
      expect(e.params, isEmpty);
    });

    test('serializes and deserializes', () {
      const e = AnalyticsEvent('level_started', {
        'level_id': 5,
        'world_id': 1,
        'is_premium': false,
      });
      final json = e.toJson();
      final restored = AnalyticsEvent.fromJson(json);
      expect(restored.name, e.name);
      expect(restored.params['level_id'], 5);
      expect(restored.params['world_id'], 1);
    });

    test('toJson includes timestamp', () {
      const e = AnalyticsEvent('app_opened');
      final json = e.toJson();
      expect(json['ts'], isA<int>());
      expect((json['ts'] as int) > 0, isTrue);
    });

    test('fromJson ignores non-Object values gracefully', () {
      final json = {
        'name': 'test',
        'params': {'valid': 'value', 'null_value': null},
        'ts': 0,
      };
      final e = AnalyticsEvent.fromJson(json);
      expect(e.name, 'test');
      expect(e.params['valid'], 'value');
      expect(e.params.containsKey('null_value'), isFalse);
    });
  });

  group('AnalyticsEvents factories', () {
    test('appOpened has correct name', () {
      expect(AnalyticsEvents.appOpened().name, 'app_opened');
    });

    test('sessionStarted has correct name', () {
      expect(AnalyticsEvents.sessionStarted().name, 'session_started');
    });

    test('sessionEnded includes duration', () {
      final e = AnalyticsEvents.sessionEnded(120);
      expect(e.name, 'session_ended');
      expect(e.params['session_duration_s'], 120);
    });

    test('levelStarted includes all required params', () {
      final e = AnalyticsEvents.levelStarted(5, 1, isPremium: true);
      expect(e.name, 'level_started');
      expect(e.params['level_id'], 5);
      expect(e.params['world_id'], 1);
      expect(e.params['is_premium'], true);
    });

    test('levelCompleted includes all required params', () {
      final e = AnalyticsEvents.levelCompleted(10, 1, 500, 3, 20, 2);
      expect(e.name, 'level_completed');
      expect(e.params['level_id'], 10);
      expect(e.params['score'], 500);
      expect(e.params['stars'], 3);
      expect(e.params['shots_used'], 20);
      expect(e.params['combo'], 2);
    });

    test('levelFailed includes failure reason', () {
      final e = AnalyticsEvents.levelFailed(7, 1, 100, 30, 'shots_exhausted');
      expect(e.name, 'level_failed');
      expect(e.params['failure_reason'], 'shots_exhausted');
    });

    test('levelRestarted includes level id', () {
      final e = AnalyticsEvents.levelRestarted(3);
      expect(e.name, 'level_restarted');
      expect(e.params['level_id'], 3);
    });

    test('levelMilestone includes level id', () {
      final e = AnalyticsEvents.levelMilestone(20);
      expect(e.name, 'level_milestone');
      expect(e.params['level_id'], 20);
    });

    test('attemptConsumed has correct params', () {
      final e = AnalyticsEvents.attemptConsumed(
        1,
        isPremium: false,
        attemptsRemaining: 3,
      );
      expect(e.name, 'attempt_consumed');
      expect(e.params['attempts_remaining'], 3);
    });

    test('dailyLimitReached has correct params', () {
      final e = AnalyticsEvents.dailyLimitReached(5);
      expect(e.name, 'daily_limit_reached');
      expect(e.params['level_id'], 5);
    });

    test('premiumScreenViewed has correct name', () {
      expect(
        AnalyticsEvents.premiumScreenViewed().name,
        'premium_screen_viewed',
      );
    });

    test('purchaseStarted includes product id', () {
      final e = AnalyticsEvents.purchaseStarted('star_shooter_premium');
      expect(e.name, 'purchase_started');
      expect(e.params['product_id'], 'star_shooter_premium');
    });

    test('purchaseCompleted includes product id', () {
      final e = AnalyticsEvents.purchaseCompleted('star_shooter_premium');
      expect(e.name, 'purchase_completed');
    });

    test('purchaseFailed includes product id and reason', () {
      final e = AnalyticsEvents.purchaseFailed(
        'star_shooter_premium',
        'billing_error',
      );
      expect(e.name, 'purchase_failed');
      expect(e.params['reason'], 'billing_error');
    });

    test('restoreStarted has correct name', () {
      expect(AnalyticsEvents.restoreStarted().name, 'restore_started');
    });

    test('restoreCompleted includes product id', () {
      final e = AnalyticsEvents.restoreCompleted('star_shooter_premium');
      expect(e.name, 'restore_completed');
      expect(e.params['product_id'], 'star_shooter_premium');
    });

    test('dailyChallengeViewed includes date and level', () {
      final e = AnalyticsEvents.dailyChallengeViewed('2026-10-05', 42);
      expect(e.name, 'daily_challenge_viewed');
      expect(e.params['date'], '2026-10-05');
      expect(e.params['level_id'], 42);
    });

    test('dailyChallengeCompleted includes score and stars', () {
      final e =
          AnalyticsEvents.dailyChallengeCompleted('2026-10-05', 42, 1200, 3);
      expect(e.name, 'daily_challenge_completed');
      expect(e.params['score'], 1200);
      expect(e.params['stars'], 3);
    });

    test('streakUpdated includes streak and milestone flag', () {
      final e = AnalyticsEvents.streakUpdated(7, isMilestone: true);
      expect(e.name, 'streak_updated');
      expect(e.params['streak'], 7);
      expect(e.params['milestone'], true);
    });
  });
}
