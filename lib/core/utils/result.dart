import 'package:star_shooter/core/errors/failures.dart' as failures;

/// A simple Result<T> monad used across the domain and data layers.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  /// Convenience factory for a successful result.
  factory Result.success(T value) => Success<T>(value);

  /// Convenience factory for a failed result.
  factory Result.failure(failures.Failure error) => Failure<T>(error);

  /// Runs [onSuccess] if this is a [Success], or [onFailure] if [Failure].
  R when<R>({
    required R Function(T value) onSuccess,
    required R Function(failures.Failure error) onFailure,
  }) {
    return switch (this) {
      Success<T>(:final value) => onSuccess(value),
      Failure<T>(:final error) => onFailure(error),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;

  @override
  String toString() => 'Success($value)';
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final failures.Failure error;

  @override
  String toString() => 'Failure(${error.message})';
}
