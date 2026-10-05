import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:star_shooter/app.dart';
import 'package:star_shooter/data/providers/storage_provider.dart';
import 'package:star_shooter/game/game_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Style the system UI overlay (transparent status bar, light icons).
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Initialise data layer (SharedPreferences + repositories).
  final dataProviders = await createDataProviders();

  runApp(
    MultiProvider(
      providers: [
        ...dataProviders,
        ChangeNotifierProvider(create: (_) => GameManager()),
      ],
      child: const StarShooterApp(),
    ),
  );
}
