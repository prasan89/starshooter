import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/theme/app_theme.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/billing/billing_notifier.dart';
import 'package:star_shooter/data/billing/play_billing_entitlement_repository.dart';
import 'package:star_shooter/domain/config/billing_config.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/models/daily_attempt_state.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';
import 'package:star_shooter/domain/models/premium_product.dart';
import 'package:star_shooter/domain/models/purchase_state.dart';
import 'package:star_shooter/domain/repositories/billing_repository.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';
import 'package:star_shooter/domain/usecases/get_attempts_usecase.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/features/home/screens/home_screen.dart';
import 'package:star_shooter/game/level/level_validation_result.dart';
import 'package:star_shooter/game/models/level_definition.dart';

class _StubLevelRepository implements LevelRepository {
  @override
  Future<Result<LevelProgress>> getLevelProgress(int levelId) async =>
      Result.success(LevelProgress.empty(levelId));

  @override
  Future<Result<List<LevelProgress>>> getAllLevelProgress() async =>
      Result.success([]);

  @override
  Future<Result<void>> saveLevelProgress(LevelProgress progress) async =>
      Result.success(null);

  @override
  Future<Result<int>> getCurrentLevel() async => Result.success(1);

  @override
  Future<Result<void>> setCurrentLevel(int level) async => Result.success(null);

  @override
  Future<Result<LevelDefinition>> getLevel(int id) async =>
      Result.failure(const NotFoundFailure());

  @override
  Future<Result<List<LevelDefinition>>> getLevels(int worldId) async =>
      Result.success([]);

  @override
  Future<Result<LevelDefinition>> getNextLevel() async =>
      Result.failure(const NotFoundFailure());

  @override
  Future<Result<LevelValidationResult>> validateLevel(int id) async =>
      Result.failure(const NotFoundFailure());

  @override
  Future<Result<int>> getHighestUnlockedLevel() async => Result.success(1);

  @override
  Future<Result<void>> setHighestUnlockedLevel(int levelId) async =>
      Result.success(null);
}

class _StubDailyAttemptRepository implements DailyAttemptRepository {
  static const _config = DailyAttemptConfig(freeDailyLimit: 5);

  @override
  DailyAttemptConfig get config => _config;

  @override
  Future<Result<DailyAttemptState>> getState() async =>
      Result.success(DailyAttemptState.fresh('2026-10-05'));

  @override
  Future<Result<DailyAttemptState>> consumeAttempt(String todayDate) async =>
      Result.success(DailyAttemptState.fresh(todayDate));

  @override
  Future<Result<DailyAttemptState>> resetForNewDay(String todayDate) async =>
      Result.success(DailyAttemptState.fresh(todayDate));
}

class _StubPremiumEntitlementRepository
    implements PremiumEntitlementRepository {
  @override
  Future<Result<PremiumEntitlement>> getEntitlement() async =>
      Result.success(const PremiumEntitlement(isPremium: false));
}

class _StubBillingRepository implements BillingRepository {
  _StubBillingRepository()
      : _controller = StreamController<PurchaseResult>.broadcast();

  final StreamController<PurchaseResult> _controller;

  @override
  Stream<PurchaseResult> get purchaseStream => _controller.stream;

  @override
  Future<bool> isBillingAvailable() async => false;

  @override
  Future<Result<PremiumProduct>> getProductDetails(String id) async =>
      Result.failure(const BillingFailure());

  @override
  Future<Result<void>> initiatePurchase(String id) async =>
      Result.failure(const BillingFailure());

  @override
  Future<Result<PurchaseResult>> restorePurchases(String id) async =>
      Result.success(const PurchaseResult(status: PurchaseStatus.cancelled));

  @override
  Future<bool> verifyPremiumOwnership(String id) async => false;

  @override
  Future<EntitlementState> loadCachedEntitlement() async =>
      EntitlementState.defaultFree;

  @override
  Future<void> saveCachedEntitlement(EntitlementState s) async {}

  @override
  void dispose() => _controller.close();
}

BillingNotifier _stubBillingNotifier() {
  final billing = _StubBillingRepository();
  final entRepo = PlayBillingEntitlementRepository(
    billingRepository: billing,
    config: const BillingConfig(),
  );
  return BillingNotifier(
    billingRepository: billing,
    entitlementRepository: entRepo,
    config: const BillingConfig(),
  );
}

void main() {
  Widget buildHomeApp({void Function(String location)? navigatedTo}) {
    final repo = _StubLevelRepository();
    final notifier = GalaxyMapNotifier(
      levelRepository: repo,
      worldProgressUseCase: GetWorldProgressUseCase(repo),
    );

    final getAttemptsUseCase = GetAttemptsUseCase(
      dailyAttemptRepository: _StubDailyAttemptRepository(),
      premiumEntitlementRepository: _StubPremiumEntitlementRepository(),
    );

    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: '/galaxy-map',
          builder: (context, state) {
            navigatedTo?.call('/galaxy-map');
            return const Scaffold(
              body: Center(child: Text('Galaxy Map')),
            );
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            navigatedTo?.call('/settings');
            return const Scaffold(
              body: Center(child: Text('Settings')),
            );
          },
        ),
        GoRoute(
          path: '/premium',
          builder: (_, __) =>
              const Scaffold(body: Center(child: Text('Premium'))),
        ),
        GoRoute(
          path: '/profile',
          builder: (_, __) =>
              const Scaffold(body: Center(child: Text('Profile'))),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GalaxyMapNotifier>.value(value: notifier),
        Provider<GetAttemptsUseCase>.value(value: getAttemptsUseCase),
        ChangeNotifierProvider<BillingNotifier>(
          create: (_) => _stubBillingNotifier(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets('pumps without errors', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
    });

    testWidgets('"STAR SHOOTER" title text is present', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
      expect(find.text('STAR SHOOTER'), findsOneWidget);
    });

    testWidgets('"CONTINUE" button is present', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
      expect(find.text('CONTINUE'), findsOneWidget);
    });

    testWidgets('tapping "GALAXY MAP" triggers navigation to /galaxy-map',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      String? navigated;
      await tester.pumpWidget(
        buildHomeApp(
          navigatedTo: (loc) {
            navigated = loc;
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('GALAXY MAP'));
      await tester.pumpAndSettle();

      expect(navigated, equals('/galaxy-map'));
    });
  });
}
