/// Custom exception classes mirroring the [Failure] hierarchy.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType(message: $message)';
}

final class StorageException extends AppException {
  const StorageException([super.message = 'A storage error occurred.']);
}

final class NotFoundException extends AppException {
  const NotFoundException([super.message = 'The requested resource was not found.']);
}

final class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation failed.']);
}

/// Placeholder for future network operations.
final class NetworkException extends AppException {
  const NetworkException([super.message = 'A network error occurred.']);
}
