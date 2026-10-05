import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';
import 'package:star_shooter/domain/repositories/premium_entitlement_repository.dart';

/// Default production implementation — always returns the free entitlement.
///
/// This remains the production default until M10 connects Google Play Billing.
class LocalPremiumEntitlementRepository
    implements PremiumEntitlementRepository {
  const LocalPremiumEntitlementRepository();

  @override
  Future<Result<PremiumEntitlement>> getEntitlement() async {
    return Result.success(PremiumEntitlement.free);
  }
}

/// Used in tests ONLY — not in production DI.
///
/// Allows tests to exercise both free and premium paths without touching
/// real billing infrastructure.
class TestPremiumEntitlementRepository implements PremiumEntitlementRepository {
  const TestPremiumEntitlementRepository({required this.isPremium});

  final bool isPremium;

  @override
  Future<Result<PremiumEntitlement>> getEntitlement() async =>
      Result.success(PremiumEntitlement(isPremium: isPremium));
}
