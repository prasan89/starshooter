import 'package:flutter_test/flutter_test.dart';
import 'package:star_shooter/core/errors/failures.dart';
import 'package:star_shooter/core/utils/result.dart';

void main() {
  group('Result<T>', () {
    group('Success', () {
      test('can be created via factory and value is accessible', () {
        final result = Result<int>.success(42);
        expect(result, isA<Success<int>>());
        expect((result as Success<int>).value, equals(42));
      });

      test('isSuccess returns true', () {
        final result = Result<String>.success('hello');
        expect(result.isSuccess, isTrue);
      });

      test('isFailure returns false', () {
        final result = Result<String>.success('hello');
        expect(result.isFailure, isFalse);
      });

      test('when() calls onSuccess with the value', () {
        final result = Result<int>.success(7);
        final output = result.when(
          onSuccess: (v) => 'got $v',
          onFailure: (_) => 'failed',
        );
        expect(output, equals('got 7'));
      });
    });

    group('ResultFailure', () {
      test('can be created via factory and error is accessible', () {
        const failure = StorageFailure('disk full');
        final result = Result<int>.failure(failure);
        expect(result, isA<ResultFailure<int>>());
        expect((result as ResultFailure<int>).error, equals(failure));
      });

      test('isFailure returns true', () {
        final result = Result<int>.failure(const StorageFailure('err'));
        expect(result.isFailure, isTrue);
      });

      test('isSuccess returns false', () {
        final result = Result<int>.failure(const StorageFailure('err'));
        expect(result.isSuccess, isFalse);
      });

      test('when() calls onFailure with the failure', () {
        const failure = StorageFailure('something went wrong');
        final result = Result<int>.failure(failure);
        final output = result.when(
          onSuccess: (_) => 'success',
          onFailure: (e) => e.message,
        );
        expect(output, equals('something went wrong'));
      });
    });

    group('Success toString', () {
      test('includes value in string representation', () {
        const result = Success<int>(99);
        expect(result.toString(), contains('99'));
      });
    });

    group('ResultFailure toString', () {
      test('includes failure message in string representation', () {
        const result = ResultFailure<int>(StorageFailure('oops'));
        expect(result.toString(), contains('oops'));
      });
    });
  });
}
