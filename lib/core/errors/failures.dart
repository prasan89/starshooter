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
  const NotFoundFailure([super.message = 'The requested resource was not found.']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed.']);
}

/// Placeholder for future network operations.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'A network error occurred.']);
}
