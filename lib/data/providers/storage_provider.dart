import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/data/repositories/entitlement_repository_impl.dart';
import 'package:star_shooter/data/repositories/level_repository_impl.dart';
import 'package:star_shooter/data/repositories/player_repository_impl.dart';
import 'package:star_shooter/domain/repositories/entitlement_repository.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

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
  ];
}
