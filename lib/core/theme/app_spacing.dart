/// Spacing and border-radius constants for Star Shooter.
///
/// All values are expressed as `static const double` so they can be
/// used in `const` widget constructors.
abstract final class AppSpacing {
  AppSpacing._();

  // ── Spacing scale ─────────────────────────────────────────────────────────
  /// 4 dp
  static const double xs = 4;

  /// 8 dp
  static const double sm = 8;

  /// 16 dp
  static const double md = 16;

  /// 24 dp
  static const double lg = 24;

  /// 32 dp
  static const double xl = 32;

  /// 48 dp
  static const double xxl = 48;

  /// 64 dp
  static const double xxxl = 64;

  // ── Border-radius scale ───────────────────────────────────────────────────
  /// 8 dp corner radius
  static const double radiusSm = 8;

  /// 12 dp corner radius
  static const double radiusMd = 12;

  /// 16 dp corner radius
  static const double radiusLg = 16;

  /// 24 dp corner radius
  static const double radiusXl = 24;

  /// 100 dp corner radius — effectively a pill / circle.
  static const double radiusFull = 100;
}
