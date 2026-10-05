/// A simple Result type that carries either a success value or a [Failure].
library;

import 'package:star_shooter/core/failures/failures.dart';

/// Represents the outcome of an operation that can either succeed or fail.
sealed class Result<T> {
  const Result();

  /// Returns true when this result is a [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns true when this result is a [Failure].
  bool get isFailure => this is ResultFailure<T>;

  /// Returns the value when this is a [Success], otherwise null.
  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        ResultFailure<T>() => null,
      };

  /// Returns the failure when this is a [ResultFailure], otherwise null.
  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        ResultFailure<T>(:final failure) => failure,
      };
}

/// Successful result holding a value of type [T].
final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

/// Failed result holding a [Failure] descriptor.
final class ResultFailure<T> extends Result<T> {
  const ResultFailure(this.failure);
  final Failure failure;
}
