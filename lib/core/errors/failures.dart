/// Sealed class hierarchy for typed failures used throughout the app.
sealed class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType(message: $message)';
}

final class StorageFailure extends Failure {
  const StorageFailure([super.message = 'A storage error occurred.']);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([
    super.message = 'The requested resource was not found.',
  ]);
}

final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed.']);
}

/// Placeholder for future network operations.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'A network error occurred.']);
}

final class BillingFailure extends Failure {
  const BillingFailure([super.message = 'A billing error occurred.']);
}

final class ProductUnavailableFailure extends Failure {
  const ProductUnavailableFailure([
    super.message = 'Premium product is currently unavailable.',
  ]);
}

final class PurchaseFailure extends Failure {
  const PurchaseFailure([
    super.message = 'The purchase could not be completed.',
  ]);
}
