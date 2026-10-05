import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:star_shooter/analytics/analytics_service.dart';
import 'package:star_shooter/data/billing/play_billing_entitlement_repository.dart';
import 'package:star_shooter/domain/config/billing_config.dart';
import 'package:star_shooter/domain/models/premium_product.dart';
import 'package:star_shooter/domain/models/purchase_state.dart';
import 'package:star_shooter/domain/repositories/billing_repository.dart';

enum BillingUiState {
  loading,
  available, // product loaded, can purchase
  alreadyOwned, // premium is active
  pending, // purchase in progress
  success, // just purchased
  restored, // just restored
  unavailable, // billing / product unavailable
  error,
}

class BillingNotifier extends ChangeNotifier {
  BillingNotifier({
    required BillingRepository billingRepository,
    required PlayBillingEntitlementRepository entitlementRepository,
    required BillingConfig config,
    required AnalyticsService analytics,
  })  : _billing = billingRepository,
        _entitlement = entitlementRepository,
        _config = config,
        _analytics = analytics;

  final BillingRepository _billing;
  final PlayBillingEntitlementRepository _entitlement;
  final BillingConfig _config;
  final AnalyticsService _analytics;

  BillingUiState _uiState = BillingUiState.loading;
  PremiumProduct? _product;
  String? _errorMessage;
  StreamSubscription<PurchaseResult>? _sub;
  bool _isPremium = false;

  BillingUiState get uiState => _uiState;
  PremiumProduct? get product => _product;
  String? get errorMessage => _errorMessage;
  bool get isPremium => _isPremium;

  Future<void> initialize() async {
    _uiState = BillingUiState.loading;
    notifyListeners();

    // Check local entitlement first
    final entResult = await _entitlement.getEntitlement();
    _isPremium = entResult.when(
      onSuccess: (e) => e.isPremium,
      onFailure: (_) => false,
    );
    if (_isPremium) {
      _uiState = BillingUiState.alreadyOwned;
      notifyListeners();
      return;
    }

    // Listen to purchase stream
    _sub = _billing.purchaseStream.listen(_onPurchaseResult);

    // Load product
    final productResult =
        await _billing.getProductDetails(_config.premiumProductId);
    productResult.when(
      onSuccess: (p) {
        _product = p;
        _uiState = BillingUiState.available;
      },
      onFailure: (f) {
        _uiState = BillingUiState.unavailable;
        _errorMessage = f.message;
      },
    );
    notifyListeners();
  }

  void _onPurchaseResult(PurchaseResult result) {
    switch (result.status) {
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        _isPremium = true;
        _uiState = result.status == PurchaseStatus.restored
            ? BillingUiState.restored
            : BillingUiState.success;
        _entitlement.grantPremium(
          source: result.status == PurchaseStatus.restored
              ? 'restored'
              : 'google_play',
        );
        // Analytics: fire purchase_completed or restore_completed
        final productId = result.productId ?? _config.premiumProductId;
        if (result.status == PurchaseStatus.restored) {
          _analytics.restoreCompleted(productId);
        } else {
          _analytics.purchaseCompleted(productId);
        }
        notifyListeners();
      case PurchaseStatus.pending:
        _uiState = BillingUiState.pending;
        notifyListeners();
      case PurchaseStatus.cancelled:
        // Cancellation is not a failure — no analytics event.
        if (_uiState == BillingUiState.pending) {
          _uiState = _product != null
              ? BillingUiState.available
              : BillingUiState.unavailable;
        }
        notifyListeners();
      case PurchaseStatus.error:
        _uiState = BillingUiState.error;
        _errorMessage = result.errorMessage ?? 'An unexpected error occurred.';
        _analytics.purchaseFailed(
          result.productId ?? _config.premiumProductId,
          'billing_error',
        );
        notifyListeners();
    }
  }

  Future<void> purchase() async {
    if (_uiState != BillingUiState.available) return;
    _uiState = BillingUiState.pending;
    notifyListeners();
    // Analytics: fire before the platform call so we capture intent even
    // if the app is backgrounded during the purchase flow.
    _analytics.purchaseStarted(_config.premiumProductId);
    final result = await _billing.initiatePurchase(_config.premiumProductId);
    result.when(
      onSuccess: (_) {},
      onFailure: (f) {
        _uiState = BillingUiState.error;
        _errorMessage = f.message;
        _analytics.purchaseFailed(_config.premiumProductId, 'initiate_failed');
        notifyListeners();
      },
    );
  }

  Future<void> restore() async {
    _uiState = BillingUiState.pending;
    notifyListeners();
    _analytics.restoreStarted();
    await _entitlement.refreshFromBilling();
    // Result arrives via purchaseStream listener — no direct state update here
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
