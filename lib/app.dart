import 'package:flutter/material.dart';
import 'package:star_shooter/core/constants/app_constants.dart';
import 'package:star_shooter/core/navigation/app_router.dart';
import 'package:star_shooter/core/theme/app_theme.dart';

/// The root [MaterialApp] for Star Shooter.
///
/// Wires together the [AppTheme], [AppRouter], and global settings such as
/// the app title and debug-banner visibility.
class StarShooterApp extends StatelessWidget {
  const StarShooterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
