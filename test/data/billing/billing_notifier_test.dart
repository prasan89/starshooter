import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/analytics/analytics_event.dart';
import 'package:star_shooter/analytics/analytics_service.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/billing/billing_notifier.dart';
import 'package:star_shooter/data/billing/play_billing_entitlement_repository.dart';
import 'package:star_shooter/domain/config/billing_config.dart';
import 'package:star_shooter/domain/models/entitlement_state.dart';
import 'package:star_shooter/domain/models/premium_product.dart';
import 'package:star_shooter/domain/models/purchase_state.dart';
import 'package:star_shooter/domain/repositories/analytics_repository.dart';
import 'package:star_shooter/domain/repositories/billing_repository.dart';

// ---------------------------------------------------------------------------
// Fake AnalyticsRepository (no-op for billing tests)
// ---------------------------------------------------------------------------

class _NoOpAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<void> logEvent(AnalyticsEvent event) async {}
  @override
  Future<List<AnalyticsEvent>> getPendingEvents() async => [];
  @override
  Future<void> clearAllPendingEvents() async {}
  @override
  Future<Set<int>> getCompletedMilestones() async => {};
  @override
  Future<void> saveCompletedMilestones(Set<int> milestones) async {}
}

AnalyticsService _noOpAnalytics() =>
    AnalyticsService(_NoOpAnalyticsRepository());

// ---------------------------------------------------------------------------
// Fake BillingRepository
// ---------------------------------------------------------------------------

class FakeBillingRepository implements BillingRepository {
  FakeBillingRepository({
    this.available = true,
    PremiumProduct? product,
    this.ownedProductId,
  })  : _product = product,
        _purchaseController = StreamController<PurchaseResult>.broadcast();

  final bool available;
  final PremiumProduct? _product;
  final String? ownedProductId;
  final StreamController<PurchaseResult> _purchaseController;
  EntitlementState cachedState = EntitlementState.defaultFree;

  void emitPurchase(PurchaseResult result) => _purchaseController.add(result);

  @override
  Stream<PurchaseResult> get purchaseStream => _purchaseController.stream;

  @override
  Future<bool> isBillingAvailable() async => available;

  @override
  Future<Result<PremiumProduct>> getProductDetails(String id) async {
    if (!available) return Result.failure(const BillingFailure());
    if (_product == null) {
      return Result.failure(const ProductUnavailableFailure());
    }
    return Result.success(_product);
  }

  @override
  Future<Result<void>> initiatePurchase(String id) async {
    if (!available) return Result.failure(const BillingFailure());
    return Result.success(null);
  }

  @override
  Future<Result<PurchaseResult>> restorePurchases(String id) async {
    if (ownedProductId == id) {
      _purchaseController.add(
        PurchaseResult(
          status: PurchaseStatus.restored,
          productId: id,
        ),
      );
      return Result.success(
        PurchaseResult(status: PurchaseStatus.restored, productId: id),
      );
    }
    return Result.success(
      const PurchaseResult(status: PurchaseStatus.cancelled),
    );
  }

  @override
  Future<bool> verifyPremiumOwnership(String id) async => ownedProductId == id;

  @override
  Future<EntitlementState> loadCachedEntitlement() async => cachedState;

  @override
  Future<void> saveCachedEntitlement(EntitlementState s) async {
    cachedState = s;
  }

  @override
  void dispose() {
    _purchaseController.close();
  }
}

// ---------------------------------------------------------------------------
// Test fixtures
// ---------------------------------------------------------------------------

const testProduct = PremiumProduct(
  productId: 'star_shooter_premium_lifetime',
  title: 'Star Shooter Premium',
  description: 'Unlimited gameplay',
  localizedPrice: '₹499',
  currencyCode: 'INR',
);

BillingNotifier _buildNotifier({
  bool available = true,
  PremiumProduct? product = testProduct,
  String? ownedProductId,
  bool cachedPremium = false,
}) {
  final billing = FakeBillingRepository(
    available: available,
    product: product,
    ownedProductId: ownedProductId,
  );
  if (cachedPremium) {
    billing.cachedState = const EntitlementState(
      isPremium: true,
      lastVerifiedAt: '2024-10-05T00:00:00Z',
      source: 'google_play',
    );
  }
  final entRepo = PlayBillingEntitlementRepository(
    billingRepository: billing,
    config: const BillingConfig(),
  );
  entRepo.initializePurchaseListener();
  return BillingNotifier(
    billingRepository: billing,
    entitlementRepository: entRepo,
    config: const BillingConfig(),
    analytics: _noOpAnalytics(),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('BillingNotifier', () {
    test('starts in loading state', () {
      final notifier = _buildNotifier();
      expect(notifier.uiState, BillingUiState.loading);
    });

    test('available product transitions to available state', () async {
      final notifier = _buildNotifier();
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.available);
      expect(notifier.product?.localizedPrice, '₹499');
    });

    test('billing unavailable transitions to unavailable state', () async {
      final notifier = _buildNotifier(available: false);
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.unavailable);
    });

    test('product unavailable (null) transitions to unavailable', () async {
      final notifier = _buildNotifier(product: null);
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.unavailable);
    });

    test('cached premium transitions to alreadyOwned', () async {
      final notifier = _buildNotifier(cachedPremium: true);
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.alreadyOwned);
      expect(notifier.isPremium, isTrue);
    });

    test('successful purchase grants premium and sets success state', () async {
      final billing = FakeBillingRepository(product: testProduct);
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.available);

      // Simulate successful purchase from Google Play
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.purchased,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 50));
      expect(notifier.isPremium, isTrue);
      expect(notifier.uiState, BillingUiState.success);
    });

    test('pending purchase does NOT grant premium', () async {
      final billing = FakeBillingRepository(product: testProduct);
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.pending,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 50));
      expect(notifier.isPremium, isFalse);
      expect(notifier.uiState, BillingUiState.pending);
    });

    test('cancelled purchase returns to available state', () async {
      final billing = FakeBillingRepository(product: testProduct);
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      expect(notifier.uiState, BillingUiState.available);
      // Set pending first (purchase attempted)
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.pending,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 20));
      expect(notifier.uiState, BillingUiState.pending);
      // Then cancel
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.cancelled,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 50));
      expect(notifier.isPremium, isFalse);
      expect(notifier.uiState, BillingUiState.available);
    });

    test('restore owned purchase grants premium', () async {
      final billing = FakeBillingRepository(
        product: testProduct,
        ownedProductId: 'star_shooter_premium_lifetime',
      );
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      await notifier.restore();
      await Future.delayed(const Duration(milliseconds: 100));
      expect(notifier.isPremium, isTrue);
      expect(notifier.uiState, BillingUiState.restored);
    });

    test('restore no-owned-purchase keeps free', () async {
      final billing = FakeBillingRepository(product: testProduct);
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      await notifier.restore();
      await Future.delayed(const Duration(milliseconds: 100));
      expect(notifier.isPremium, isFalse);
    });

    test('duplicate purchase events do not duplicate entitlement grant',
        () async {
      final billing = FakeBillingRepository(product: testProduct);
      final entRepo = PlayBillingEntitlementRepository(
        billingRepository: billing,
        config: const BillingConfig(),
      );
      entRepo.initializePurchaseListener();
      final notifier = BillingNotifier(
        billingRepository: billing,
        entitlementRepository: entRepo,
        config: const BillingConfig(),
        analytics: _noOpAnalytics(),
      );
      await notifier.initialize();
      // Emit purchased twice
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.purchased,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      billing.emitPurchase(
        const PurchaseResult(
          status: PurchaseStatus.purchased,
          productId: 'star_shooter_premium_lifetime',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 100));
      // isPremium should be true but not "double-granted" (idempotent)
      expect(notifier.isPremium, isTrue);
      expect(notifier.uiState, BillingUiState.success);
    });
  });
}
