/// Domain-layer failure types used as typed error returns.
library;

/// Base class for all domain failures.
abstract class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Failure produced when local storage operations fail.
class StorageFailure extends Failure {
  const StorageFailure(super.message, {this.cause});

  /// The original exception that caused this failure, if available.
  final Object? cause;

  @override
  String toString() =>
      'StorageFailure: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Failure produced when data cannot be parsed or deserialized.
class ParseFailure extends Failure {
  const ParseFailure(super.message, {this.cause});
  final Object? cause;

  @override
  String toString() =>
      'ParseFailure: $message${cause != null ? ' (caused by: $cause)' : ''}';
}
