import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/theme/app_theme.dart';
import 'package:star_shooter/features/home/screens/home_screen.dart';

/// Builds a minimal widget harness around [child] for testing.
///
/// Wraps in a [MaterialApp.router] that uses a [GoRouter] pointing at `/home`
/// and serving [child] at that path.  Pass [extraRoutes] to register additional
/// routes the widget under test may push to.
Widget buildTestWidget(
  Widget child, {
  List<GoRoute> extraRoutes = const [],
}) {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => child,
      ),
      ...extraRoutes,
    ],
  );

  return MaterialApp.router(
    routerConfig: router,
    theme: AppTheme.dark,
    debugShowCheckedModeBanner: false,
  );
}

/// Pumps [widget] inside [tester] and settles all animations.
Future<void> pumpAndSettle(
  WidgetTester tester,
  Widget widget, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  await tester.pumpWidget(widget);
  await tester.pumpAndSettle(timeout);
}

/// Resets SharedPreferences mock state to an empty map.
///
/// Call this in [setUp] for any test that exercises storage.
Future<void> setupMockSharedPreferences() async {
  // Import shared_preferences in the test file before calling this.
  // The actual call to setMockInitialValues happens at the test site to
  // keep the import dependency in the consuming test file.
}

// ---------------------------------------------------------------------------
// Convenience: a GoRouter that navigates nowhere (no-op push/pop)
// ---------------------------------------------------------------------------

/// Returns a [GoRouter] that starts at [initialLocation] and captures
/// navigation events via [navigatedTo].
GoRouter buildCapturingRouter({
  required Widget homePage,
  String initialLocation = '/home',
  void Function(String location)? navigatedTo,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => homePage,
      ),
      GoRoute(
        path: '/galaxy-map',
        builder: (context, state) {
          navigatedTo?.call('/galaxy-map');
          return const Scaffold(body: Center(child: Text('Galaxy Map')));
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) {
          navigatedTo?.call('/settings');
          return const Scaffold(body: Center(child: Text('Settings')));
        },
      ),
    ],
  );
}

/// A minimal [HomeScreen] widget harness that captures navigation.
Widget buildHomeScreenWithCapture({
  void Function(String location)? navigatedTo,
}) {
  final router = buildCapturingRouter(
    homePage: const HomeScreen(),
    navigatedTo: navigatedTo,
  );
  return MaterialApp.router(
    routerConfig: router,
    theme: AppTheme.dark,
    debugShowCheckedModeBanner: false,
  );
}
