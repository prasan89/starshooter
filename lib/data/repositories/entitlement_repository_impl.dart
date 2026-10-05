import 'dart:developer' as dev;

import 'package:star_shooter/core/constants/storage_keys.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';
import 'package:star_shooter/data/local/local_storage.dart';
import 'package:star_shooter/domain/repositories/entitlement_repository.dart';

/// Local-storage-backed implementation of [EntitlementRepository].
///
/// This is a placeholder that stores the entitlement flag in shared
/// preferences.  Real billing integration (e.g. Google Play Billing) is
/// deferred to milestone M3.  [restorePurchases] is a no-op that logs a debug
/// message and returns a successful result immediately.
class EntitlementRepositoryImpl implements EntitlementRepository {
  EntitlementRepositoryImpl(this._storage);

  final LocalStorage _storage;

  // ---------------------------------------------------------------------------
  // isPremium
  // ---------------------------------------------------------------------------

  @override
  Future<Result<bool>> isPremium() async {
    try {
      final value = _storage.getBool(kKeyEntitlement);
      return Result.success(value ?? false);
    } catch (e, st) {
      dev.log(
        'EntitlementRepositoryImpl.isPremium failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to read entitlement flag: $e'),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // setPremium
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void>> setPremium(bool value) async {
    try {
      final ok = await _storage.setBool(kKeyEntitlement, value);
      if (!ok) {
        return Result.failure(
          const StorageFailure('setBool returned false for entitlement flag'),
        );
      }
      return Result.success(null);
    } catch (e, st) {
      dev.log(
        'EntitlementRepositoryImpl.setPremium failed',
        error: e,
        stackTrace: st,
      );
      return Result.failure(
        StorageFailure('Failed to write entitlement flag: $e'),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // restorePurchases — local placeholder until M3
  // ---------------------------------------------------------------------------

  @override
  Future<Result<void>> restorePurchases() async {
    dev.log(
      'EntitlementRepositoryImpl.restorePurchases: '
      'no-op placeholder — real billing integration deferred to M3.',
    );
    return Result.success(null);
  }
}
