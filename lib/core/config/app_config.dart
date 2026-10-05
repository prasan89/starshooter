/// App configuration values injected via `--dart-define` at build time.
class AppConfig {
  AppConfig._();

  /// The current environment: `dev`, `staging`, or `prod`.
  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  /// The display name for the application.
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Star Shooter',
  );

  /// `true` when running in the development environment.
  static bool get isDev => environment == 'dev';

  /// `true` when running in the staging environment.
  static bool get isStaging => environment == 'staging';

  /// `true` when running in the production environment.
  static bool get isProd => environment == 'prod';
}
