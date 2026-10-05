import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/theme/app_theme.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/level_progress.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
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

void main() {
  Widget buildHomeApp({void Function(String location)? navigatedTo}) {
    final repo = _StubLevelRepository();
    final notifier = GalaxyMapNotifier(
      levelRepository: repo,
      worldProgressUseCase: GetWorldProgressUseCase(repo),
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

    return ChangeNotifierProvider<GalaxyMapNotifier>.value(
      value: notifier,
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  group('HomeScreen', () {
    testWidgets('pumps without errors', (tester) async {
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
    });

    testWidgets('"STAR SHOOTER" title text is present', (tester) async {
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
      expect(find.text('STAR SHOOTER'), findsOneWidget);
    });

    testWidgets('"CONTINUE" button is present', (tester) async {
      await tester.pumpWidget(buildHomeApp());
      await tester.pumpAndSettle();
      expect(find.text('CONTINUE'), findsOneWidget);
    });

    testWidgets('tapping "GALAXY MAP" triggers navigation to /galaxy-map',
        (tester) async {
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
