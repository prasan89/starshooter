/// Named route path constants for GoRouter.
///
/// Use these when calling [GoRouter.go] / [GoRouter.push] so that
/// route paths are never hard-coded as raw strings in feature code.
abstract final class AppRoutes {
  AppRoutes._();

  // ── Path constants ─────────────────────────────────────────────────────────

  static const String splash = '/';
  static const String home = '/home';
  static const String galaxyMap = '/galaxy-map';

  /// Path template; use [levelSelectionPath] to build a concrete URL.
  static const String levelSelection = '/levels/:worldId';

  /// Path template; use [gameplayPath] to build a concrete URL.
  static const String gameplay = '/play/:levelId';

  static const String settings = '/settings';
  static const String premium = '/premium';
  static const String profile = '/profile';

  // ── Named-route identifiers ────────────────────────────────────────────────

  static const String splashName = 'splash';
  static const String homeName = 'home';
  static const String galaxyMapName = 'galaxy-map';
  static const String levelSelectionName = 'level-selection';
  static const String gameplayName = 'gameplay';
  static const String settingsName = 'settings';
  static const String premiumName = 'premium';
  static const String profileName = 'profile';

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Returns the concrete level-selection path for [worldId].
  static String levelSelectionPath(String worldId) => '/levels/$worldId';

  /// Returns the concrete gameplay path for [levelId].
  static String gameplayPath(String levelId) => '/play/$levelId';
}
