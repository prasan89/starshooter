import 'dart:async';

import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/config/billing_config.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';
import 'package:star_shooter/domain/models/purchase_state.dart' as ds;
import 'package:star_shooter/domain/repositories/billing_repository.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';

class PlayBillingEntitlementRepository implements PremiumEntitlementRepository {
  PlayBillingEntitlementRepository({
    required BillingRepository billingRepository,
    required BillingConfig config,
  })  : _billing = billingRepository,
        _config = config;

  final BillingRepository _billing;
  final BillingConfig _config;

  // In-memory cache for the current session — updated by purchase events.
  EntitlementState? _sessionCache;

  StreamSubscription<ds.PurchaseResult>? _purchaseSubscription;

  /// Subscribe to purchase stream and update entitlement cache on valid purchases.
  void initializePurchaseListener() {
    _purchaseSubscription = _billing.purchaseStream.listen((result) async {
      if (result.productId == _config.premiumProductId) {
        if (result.isOwned) {
          final state = EntitlementState(
            isPremium: true,
            lastVerifiedAt: DateTime.now().toUtc().toIso8601String(),
            source: result.status == ds.PurchaseStatus.restored
                ? 'restored'
                : 'google_play',
          );
          _sessionCache = state;
          await _billing.saveCachedEntitlement(state);
        }
      }
    });
  }

  @override
  Future<Result<PremiumEntitlement>> getEntitlement() async {
    // 1. Session cache (fastest)
    if (_sessionCache != null) {
      return Result.success(
        PremiumEntitlement(isPremium: _sessionCache!.isPremium),
      );
    }

    // 2. Local persisted cache (offline-first)
    final cached = await _billing.loadCachedEntitlement();
    _sessionCache = cached;
    return Result.success(PremiumEntitlement(isPremium: cached.isPremium));
  }

  /// Call during app initialization — refreshes entitlement from Google Play.
  /// Non-blocking: if billing is unavailable, local cache is honored.
  Future<void> refreshFromBilling() async {
    try {
      final available = await _billing.isBillingAvailable();
      if (!available) return;
      // restorePurchases() triggers the purchaseStream listener
      // which will update the cache if purchases are found.
      await _billing.restorePurchases(_config.premiumProductId);
    } catch (_) {
      // Ignore — local cache remains authoritative offline
    }
  }

  /// Directly update entitlement from outside (e.g., after successful purchase UI flow).
  Future<void> grantPremium({required String source}) async {
    final state = EntitlementState(
      isPremium: true,
      lastVerifiedAt: DateTime.now().toUtc().toIso8601String(),
      source: source,
    );
    _sessionCache = state;
    await _billing.saveCachedEntitlement(state);
  }

  void dispose() {
    _purchaseSubscription?.cancel();
  }
}
