import 'package:star_shooter/core/utils/result.dart';

abstract interface class EntitlementRepository {
  /// Returns whether the player currently holds a premium entitlement.
  Future<Result<bool>> isPremium();

  /// Stores [value] as the player's premium status.
  Future<Result<void>> setPremium(bool value);

  /// Placeholder hook for restoring purchases from the billing platform.
  /// Full billing integration is deferred to M3.
  Future<Result<void>> restorePurchases();
}
