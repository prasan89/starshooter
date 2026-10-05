import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/daily_attempt_repository_impl.dart';
import 'package:star_shooter/data/repositories/entitlement_repository_impl.dart';
import 'package:star_shooter/data/repositories/level_repository_impl.dart';
import 'package:star_shooter/data/repositories/player_repository_impl.dart';
import 'package:star_shooter/data/repositories/premium_entitlement_repository_impl.dart';
import 'package:star_shooter/domain/config/daily_attempt_config.dart';
import 'package:star_shooter/domain/repositories/daily_attempt_repository.dart';
import 'package:star_shooter/domain/repositories/entitlement_repository.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';
import 'package:star_shooter/domain/usecases/complete_level_usecase.dart';
import 'package:star_shooter/domain/usecases/get_attempts_usecase.dart';
import 'package:star_shooter/domain/usecases/get_world_progress_usecase.dart';
import 'package:star_shooter/domain/usecases/start_level_usecase.dart';
import 'package:star_shooter/features/galaxy/state/galaxy_map_notifier.dart';

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

    Provider<PremiumEntitlementRepository>(
      create: (_) => const LocalPremiumEntitlementRepository(),
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
  ];
}
