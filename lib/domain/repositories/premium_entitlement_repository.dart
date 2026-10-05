import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/domain/models/premium_entitlement.dart';

abstract interface class PremiumEntitlementRepository {
  Future<Result<PremiumEntitlement>> getEntitlement();
}
