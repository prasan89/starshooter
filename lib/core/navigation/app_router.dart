import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/navigation/app_routes.dart';
import 'package:star_shooter/core/theme/app_colors.dart';
import 'package:star_shooter/core/widgets/error_widget.dart';
import 'package:star_shooter/features/gameplay/screens/gameplay_screen.dart';
import 'package:star_shooter/features/home/screens/home_screen.dart';
import 'package:star_shooter/features/home/screens/splash_screen.dart';
import 'package:star_shooter/features/levels/screens/galaxy_map_screen.dart';
import 'package:star_shooter/features/levels/screens/level_selection_screen.dart';
import 'package:star_shooter/features/premium/screens/premium_screen.dart';
import 'package:star_shooter/features/profile/screens/profile_screen.dart';
import 'package:star_shooter/features/settings/screens/settings_screen.dart';

/// Application router configuration using GoRouter.
///
/// Routes:
///  `/`               → [SplashScreen]  (initial)
///  `/home`           → [HomeScreen]
///  `/galaxy-map`     → [GalaxyMapScreen]
///  `/levels/:worldId`→ [LevelSelectionScreen]
///  `/play/:levelId`  → [GameplayScreen]
///  `/settings`       → [SettingsScreen]
///  `/premium`        → [PremiumScreen]
///  `/profile`        → [ProfileScreen]
abstract final class AppRouter {
  AppRouter._();

  /// The singleton [GoRouter] instance.  Pass to [MaterialApp.router].
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    errorBuilder: (context, state) =>
        _RouterErrorScreen(error: state.error),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.galaxyMap,
        name: AppRoutes.galaxyMapName,
        builder: (context, state) => const GalaxyMapScreen(),
      ),
      GoRoute(
        path: AppRoutes.levelSelection,
        name: AppRoutes.levelSelectionName,
        builder: (context, state) {
          final worldId = state.pathParameters['worldId'] ?? '1';
          return LevelSelectionScreen(worldId: worldId);
        },
      ),
      GoRoute(
        path: AppRoutes.gameplay,
        name: AppRoutes.gameplayName,
        builder: (context, state) {
          final levelId = state.pathParameters['levelId'] ?? '1_1';
          return GameplayScreen(levelId: levelId);
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settingsName,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.premium,
        name: AppRoutes.premiumName,
        builder: (context, state) => const PremiumScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profileName,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}

// Keep the old top-level symbol as a convenience alias so existing call-sites
// (if any) continue to compile without modification.
// ignore: non_constant_identifier_names
GoRouter get appRouter => AppRouter.router;

// ── Error screen ──────────────────────────────────────────────────────────────

/// Scaffold-wrapped error screen shown by GoRouter when navigation fails.
///
/// Wraps [CosmicErrorWidget] and adds a "Go Home" button so users can
/// always recover.
class _RouterErrorScreen extends StatelessWidget {
  const _RouterErrorScreen({this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CosmicErrorWidget(
        message: error?.toString() ?? 'Page not found.',
        retryLabel: 'Go Home',
        onRetry: () => context.go(AppRoutes.home),
      ),
    );
  }
}
