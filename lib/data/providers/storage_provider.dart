import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:star_shooter/analytics/analytics_service.dart';
import 'package:star_shooter/data/billing/billing_notifier.dart';
import 'package:star_shooter/data/billing/play_billing_entitlement_repository.dart';
import 'package:star_shooter/data/billing/play_billing_repository.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/analytics_repository_impl.dart';
import 'package:star_shooter/data/repositories/daily_attempt_repository_impl.dart';
import 'package:star_shooter/data/repositories/entitlement_repository_impl.dart';
import 'package:star_shooter/data/repositories/level_repository_impl.dart';
import 'package:star_shooter/data/repositories/player_repository_impl.dart';
import 'package:star_shooter/domain/config/billing_config.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/repositories/analytics_repository.dart';
import 'package:star_shooter/domain/repositories/billing_repository.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/entitlement_repository.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';
import 'package:star_shooter/domain/usecases/complete_level_usecase.dart';
import 'package:star_shooter/domain/usecases/get_attempts_usecase.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/domain/usecases/start_level_usecase.dart';
import 'package:star_shooter/features/daily_challenge/data/local_daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/data/local_streak_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/analytics/challenge_analytics.dart';
import 'package:star_shooter/features/daily_challenge/domain/generators/daily_challenge_generator.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/daily_challenge_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/repositories/streak_repository.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/complete_daily_challenge_usecase.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/get_streak_usecase.dart';
import 'package:star_shooter/features/daily_challenge/domain/usecases/get_today_challenge_usecase.dart';
import 'package:star_shooter/features/daily_challenge/presentation/state/daily_challenge_notifier.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';
import 'package:star_shooter/core/utils/game_clock.dart';

/// Initialises the data layer and returns a list of [Provider]s that expose
/// the repository interfaces to the widget tree.
///
/// Call once during app startup, before [runApp], and pass the result to a
/// [MultiProvider]:
///
/// ```dart
/// final dataProviders = await createDataProviders();
/// runApp(MultiProvider(providers: dataProviders, child: const App()));
/// ```
Future<List<SingleChildWidget>> createDataProviders() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storage = LocalStorage(prefs);

  return [
    Provider<LevelRepository>(
      create: (_) => LevelRepositoryImpl(storage),
    ),
    Provider<PlayerRepository>(
      create: (_) => PlayerRepositoryImpl(storage),
    ),
    Provider<EntitlementRepository>(
      create: (_) => EntitlementRepositoryImpl(storage),
    ),

    // ── M14: Analytics ────────────────────────────────────────────────────────
    Provider<AnalyticsRepository>(
      create: (_) => LocalAnalyticsRepository(storage),
    ),
    ProxyProvider<AnalyticsRepository, AnalyticsService>(
      update: (_, repo, __) => AnalyticsService(repo),
    ),
    ProxyProvider<LevelRepository, GetWorldProgressUseCase>(
      create: (ctx) => GetWorldProgressUseCase(ctx.read<LevelRepository>()),
      update: (_, repo, __) => GetWorldProgressUseCase(repo),
    ),
    ChangeNotifierProxyProvider2<LevelRepository, GetWorldProgressUseCase,
        GalaxyMapNotifier>(
      create: (ctx) => GalaxyMapNotifier(
        levelRepository: ctx.read<LevelRepository>(),
        worldProgressUseCase: ctx.read<GetWorldProgressUseCase>(),
      ),
      update: (_, levelRepo, worldUseCase, previous) {
        return previous ??
            GalaxyMapNotifier(
              levelRepository: levelRepo,
              worldProgressUseCase: worldUseCase,
            );
      },
    ),
    ProxyProvider2<LevelRepository, PlayerRepository, CompleteLevelUseCase>(
      create: (ctx) => CompleteLevelUseCase(
        levelRepository: ctx.read<LevelRepository>(),
        playerRepository: ctx.read<PlayerRepository>(),
      ),
      update: (_, levelRepo, playerRepo, __) => CompleteLevelUseCase(
        levelRepository: levelRepo,
        playerRepository: playerRepo,
      ),
    ),

    // ── M9: Daily attempts ────────────────────────────────
    Provider<DailyAttemptRepository>(
      create: (ctx) => LocalDailyAttemptRepository(
        storage: storage,
        config: DailyAttemptConfig.defaultConfig,
      ),
    ),

    // ── M10: Billing ──────────────────────────────────────
    Provider<BillingRepository>(
      create: (_) {
        final repo = PlayBillingRepository(storage: storage);
        repo.initialize();
        return repo;
      },
    ),

    Provider<PlayBillingEntitlementRepository>(
      create: (ctx) {
        final repo = PlayBillingEntitlementRepository(
          billingRepository: ctx.read<BillingRepository>(),
          config: BillingConfig.defaultConfig,
        );
        repo.initializePurchaseListener();
        // Kick off background refresh (non-blocking)
        repo.refreshFromBilling();
        return repo;
      },
    ),

    // PremiumEntitlementRepository is now backed by billing
    ProxyProvider<PlayBillingEntitlementRepository,
        PremiumEntitlementRepository>(
      update: (_, billingEntRepo, __) => billingEntRepo,
    ),

    ChangeNotifierProxyProvider3<BillingRepository,
        PlayBillingEntitlementRepository, AnalyticsService, BillingNotifier>(
      create: (ctx) => BillingNotifier(
        billingRepository: ctx.read<BillingRepository>(),
        entitlementRepository: ctx.read<PlayBillingEntitlementRepository>(),
        config: BillingConfig.defaultConfig,
        analytics: ctx.read<AnalyticsService>(),
      ),
      update: (_, billingRepo, entRepo, analytics, previous) =>
          previous ??
          BillingNotifier(
            billingRepository: billingRepo,
            entitlementRepository: entRepo,
            config: BillingConfig.defaultConfig,
            analytics: analytics,
          ),
    ),

    ProxyProvider2<DailyAttemptRepository, PremiumEntitlementRepository,
        StartLevelUseCase>(
      update: (_, dailyAttemptRepo, premiumRepo, __) => StartLevelUseCase(
        dailyAttemptRepository: dailyAttemptRepo,
        premiumEntitlementRepository: premiumRepo,
      ),
    ),

    ProxyProvider2<DailyAttemptRepository, PremiumEntitlementRepository,
        GetAttemptsUseCase>(
      update: (_, dailyAttemptRepo, premiumRepo, __) => GetAttemptsUseCase(
        dailyAttemptRepository: dailyAttemptRepo,
        premiumEntitlementRepository: premiumRepo,
      ),
    ),

    // ── M11: Daily Challenge ─────────────────────────────────────────────────
    Provider<DailyChallengeGenerator>(
      create: (_) => const DailyChallengeGenerator(),
    ),

    Provider<DailyChallengeRepository>(
      create: (_) => LocalDailyChallengeRepository(storage: storage),
    ),

    Provider<StreakRepository>(
      create: (_) => LocalStreakRepository(storage: storage),
    ),

    Provider<GameClock>(
      create: (_) => const LocalGameClock(),
    ),

    ProxyProvider<AnalyticsService, ChallengeAnalytics>(
      update: (_, analytics, __) =>
          AnalyticsServiceChallengeAdapter(analytics),
    ),

    Provider<GetTodayChallengeUseCase>(
      create: (ctx) => GetTodayChallengeUseCase(
        generator: ctx.read<DailyChallengeGenerator>(),
        challengeRepository: ctx.read<DailyChallengeRepository>(),
        streakRepository: ctx.read<StreakRepository>(),
        clock: ctx.read<GameClock>(),
      ),
    ),

    Provider<CompleteDailyChallengeUseCase>(
      create: (ctx) => CompleteDailyChallengeUseCase(
        challengeRepository: ctx.read<DailyChallengeRepository>(),
        streakRepository: ctx.read<StreakRepository>(),
        clock: ctx.read<GameClock>(),
      ),
    ),

    Provider<GetStreakUseCase>(
      create: (ctx) => GetStreakUseCase(
        streakRepository: ctx.read<StreakRepository>(),
      ),
    ),

    ChangeNotifierProvider<DailyChallengeNotifier>(
      create: (_) => DailyChallengeNotifier(),
    ),
  ];
}
