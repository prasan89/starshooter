import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/premium_product.dart';
import 'package:star_shooter/domain/models/purchase_state.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';

abstract interface class BillingRepository {
  /// Whether billing is available on this device.
  Future<bool> isBillingAvailable();

  /// Query product details for the premium product.
  Future<Result<PremiumProduct>> getProductDetails(String productId);

  /// Initiate a purchase. Returns immediately — result arrives via [purchaseStream].
  Future<Result<void>> initiatePurchase(String productId);

  /// Restore previously made purchases.
  Future<Result<PurchaseResult>> restorePurchases(String productId);

  /// Stream of purchase updates. Listeners should handle idempotency.
  Stream<PurchaseResult> get purchaseStream;

  /// Load the currently known entitlement state from local cache.
  Future<EntitlementState> loadCachedEntitlement();

  /// Persist entitlement state.
  Future<void> saveCachedEntitlement(EntitlementState state);

  /// Query Google Play for owned purchases and return whether premium is owned.
  Future<bool> verifyPremiumOwnership(String productId);

  /// Dispose resources.
  void dispose();
}
