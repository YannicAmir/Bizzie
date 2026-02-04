import 'dart:async';
import 'package:bizzie/core/utils/retry_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTask extends Mock {
  Future<String> call();
}

void main() {
  late MockTask mockTask;

  setUp(() {
    mockTask = MockTask();
  });

  group('RetryUtil', () {
    group('retry', () {
      test('retry_successOnFirstAttempt_returnsValue', () async {
        // arrange
        const tResult = 'success';
        when(() => mockTask.call()).thenAnswer((_) async => tResult);

        // act
        final result = await RetryUtil.retry(task: mockTask.call);

        // assert
        expect(result, tResult);
        verify(() => mockTask.call()).called(1);
      });

      test('retry_successAfterOneRetry_returnsValue', () async {
        // arrange
        const tResult = 'success';
        int attempts = 0;
        when(() => mockTask.call()).thenAnswer((_) async {
          attempts++;
          if (attempts == 1) throw Exception('network error');
          return tResult;
        });

        // act
        final result = await RetryUtil.retry(
          task: mockTask.call,
          initialDelay: const Duration(milliseconds: 10),
        );

        // assert
        expect(result, tResult);
        verify(() => mockTask.call()).called(2);
      });

      test('retry_failureAfterMaxRetries_throwsException', () async {
        // arrange
        when(() => mockTask.call()).thenThrow(Exception('network error'));

        // act & assert
        expect(
          () => RetryUtil.retry(
            task: mockTask.call,
            maxRetries: 2,
            initialDelay: const Duration(milliseconds: 10),
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('retry_nonRetryableError_stopsRetrying', () async {
        // arrange
        when(() => mockTask.call()).thenThrow(Exception('permanent error'));

        // act & assert
        expect(
          () => RetryUtil.retry(
            task: mockTask.call,
            maxRetries: 5,
            initialDelay: const Duration(milliseconds: 10),
            retryIf: (e) => e.toString().contains('network'),
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('retry_isCancelled_abortsExecutionBeforeFirstAttempt', () async {
        // arrange
        when(() => mockTask.call()).thenAnswer((_) async => 'success');

        // act & assert
        expect(
          () => RetryUtil.retry(task: mockTask.call, isCancelled: () => true),
          throwsA(
            isA<TimeoutException>().having(
              (e) => e.message,
              'message',
              'Task cancelled',
            ),
          ),
        );
        verifyNever(() => mockTask.call());
      });

      test('retry_timeout_throwsTimeoutException', () async {
        // arrange
        when(() => mockTask.call()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return 'success';
        });

        // act & assert
        expect(
          () => RetryUtil.retry(
            task: mockTask.call,
            timeout: const Duration(milliseconds: 10),
            maxRetries: 0,
          ),
          throwsA(isA<TimeoutException>()),
        );
      });
    });
  });
}
