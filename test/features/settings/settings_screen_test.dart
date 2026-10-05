import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:star_shooter/core/theme/app_theme.dart';
import 'package:star_shooter/features/settings/screens/settings_screen.dart';

void main() {
  Widget buildSettingsApp() {
    final router = GoRouter(
      initialLocation: '/settings',
      routes: [
        GoRoute(
          path: '/settings',
          builder: (_, __) => const SettingsScreen(),
        ),
        // Back-navigation target
        GoRoute(
          path: '/home',
          builder: (_, __) =>
              const Scaffold(body: Center(child: Text('Home'))),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
    );
  }

  group('SettingsScreen', () {
    testWidgets('screen pumps without errors', (tester) async {
      await tester.pumpWidget(buildSettingsApp());
      await tester.pumpAndSettle();
    });

    testWidgets('Music toggle is present', (tester) async {
      await tester.pumpWidget(buildSettingsApp());
      await tester.pumpAndSettle();
      expect(find.text('Music'), findsOneWidget);
    });

    testWidgets('SFX toggle is present', (tester) async {
      await tester.pumpWidget(buildSettingsApp());
      await tester.pumpAndSettle();
      expect(find.text('Sound Effects'), findsOneWidget);
    });

    testWidgets('Music Switch widget is tappable and toggles state',
        (tester) async {
      await tester.pumpWidget(buildSettingsApp());
      await tester.pumpAndSettle();

      // Locate the Switch adjacent to the 'Music' label row.
      final musicRow = find.ancestor(
        of: find.text('Music'),
        matching: find.byType(Padding),
      );
      final musicSwitch = find.descendant(
        of: musicRow.first,
        matching: find.byType(Switch),
      );

      expect(musicSwitch, findsOneWidget);
      final switchWidget = tester.widget<Switch>(musicSwitch);
      expect(switchWidget.value, isTrue); // default on

      await tester.tap(musicSwitch);
      await tester.pumpAndSettle();

      final updatedSwitch = tester.widget<Switch>(musicSwitch);
      expect(updatedSwitch.value, isFalse);
    });

    testWidgets('SFX Switch widget is tappable and toggles state',
        (tester) async {
      await tester.pumpWidget(buildSettingsApp());
      await tester.pumpAndSettle();

      final sfxRow = find.ancestor(
        of: find.text('Sound Effects'),
        matching: find.byType(Padding),
      );
      final sfxSwitch = find.descendant(
        of: sfxRow.first,
        matching: find.byType(Switch),
      );

      expect(sfxSwitch, findsOneWidget);
      final initial = tester.widget<Switch>(sfxSwitch);
      expect(initial.value, isTrue);

      await tester.tap(sfxSwitch);
      await tester.pumpAndSettle();

      final updated = tester.widget<Switch>(sfxSwitch);
      expect(updated.value, isFalse);
    });
  });
}
