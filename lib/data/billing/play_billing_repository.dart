import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';
import 'package:star_shooter/domain/models/premium_product.dart';
import 'package:star_shooter/domain/models/purchase_state.dart' as ds;
import 'package:star_shooter/domain/repositories/billing_repository.dart';

class PlayBillingRepository implements BillingRepository {
  PlayBillingRepository({required LocalStorage storage}) : _storage = storage;

  final LocalStorage _storage;
  final InAppPurchase _iap = InAppPurchase.instance;
  static const _kEntitlementKey = 'premium_entitlement_state_v1';

  StreamController<ds.PurchaseResult>? _purchaseController;
  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  // One-time init guard
  bool _initialized = false;

  @override
  Stream<ds.PurchaseResult> get purchaseStream {
    _purchaseController ??= StreamController<ds.PurchaseResult>.broadcast();
    return _purchaseController!.stream;
  }

  /// Initialize the purchase listener. Safe to call multiple times.
  void initialize() {
    if (_initialized) return;
    if (kIsWeb) return; // in_app_purchase not supported on web
    _initialized = true;
    _purchaseController ??= StreamController<ds.PurchaseResult>.broadcast();
    _purchaseSubscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (Object err) {
        _purchaseController?.add(
          ds.PurchaseResult(
            status: ds.PurchaseStatus.error,
            errorMessage: err.toString(),
          ),
        );
      },
    );
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      _processPurchase(purchase);
    }
  }

  void _processPurchase(PurchaseDetails purchase) {
    ds.PurchaseStatus status;
    switch (purchase.status) {
      case PurchaseStatus.purchased:
        status = ds.PurchaseStatus.purchased;
      case PurchaseStatus.restored:
        status = ds.PurchaseStatus.restored;
      case PurchaseStatus.pending:
        status = ds.PurchaseStatus.pending;
      case PurchaseStatus.canceled:
        status = ds.PurchaseStatus.cancelled;
      case PurchaseStatus.error:
        status = ds.PurchaseStatus.error;
    }

    final result = ds.PurchaseResult(
      status: status,
      productId: purchase.productID,
      errorMessage: purchase.error?.message,
    );

    if (result.isOwned && purchase.pendingCompletePurchase) {
      _iap.completePurchase(purchase);
    }

    _purchaseController?.add(result);
  }

  @override
  Future<bool> isBillingAvailable() async {
    try {
      return await _iap.isAvailable();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Result<PremiumProduct>> getProductDetails(String productId) async {
    try {
      final available = await isBillingAvailable();
      if (!available) {
        return Result.failure(
          const BillingFailure('Google Play is not available on this device.'),
        );
      }
      final response = await _iap.queryProductDetails({productId});
      if (response.error != null) {
        return Result.failure(BillingFailure(response.error!.message));
      }
      if (response.productDetails.isEmpty) {
        return Result.failure(const ProductUnavailableFailure());
      }
      final pd = response.productDetails.first;
      return Result.success(
        PremiumProduct(
          productId: pd.id,
          title: pd.title,
          description: pd.description,
          localizedPrice: pd.price,
          currencyCode: pd.currencyCode,
        ),
      );
    } catch (e) {
      return Result.failure(BillingFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> initiatePurchase(String productId) async {
    try {
      final response = await _iap.queryProductDetails({productId});
      if (response.error != null) {
        return Result.failure(BillingFailure(response.error!.message));
      }
      if (response.productDetails.isEmpty) {
        return Result.failure(const ProductUnavailableFailure());
      }
      final iapProduct = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: iapProduct);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      return Result.success(null);
    } catch (e) {
      return Result.failure(PurchaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<ds.PurchaseResult>> restorePurchases(String productId) async {
    try {
      final available = await isBillingAvailable();
      if (!available) {
        return Result.failure(
          const BillingFailure('Google Play is not available.'),
        );
      }
      await _iap.restorePurchases();
      // The actual restore result comes via purchaseStream.
      // We return a pending placeholder — callers should listen to purchaseStream.
      return Result.success(
        ds.PurchaseResult(
          status: ds.PurchaseStatus.pending,
          productId: productId,
        ),
      );
    } catch (e) {
      return Result.failure(BillingFailure(e.toString()));
    }
  }

  @override
  Future<bool> verifyPremiumOwnership(String productId) async {
    try {
      await _iap.restorePurchases();
      // verifyPremiumOwnership is called during app init.
      // The actual ownership determination comes from the purchaseStream.
      // Return false here — the stream listener updates the entitlement cache.
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<EntitlementState> loadCachedEntitlement() async {
    try {
      final raw = _storage.getString(_kEntitlementKey);
      if (raw == null || raw.isEmpty) return EntitlementState.defaultFree;
      return EntitlementState.decode(raw);
    } catch (_) {
      return EntitlementState.defaultFree;
    }
  }

  @override
  Future<void> saveCachedEntitlement(EntitlementState state) async {
    try {
      await _storage.setString(_kEntitlementKey, state.encode());
    } catch (_) {}
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _purchaseController?.close();
    _initialized = false;
  }
}
