import 'dart:async';
import 'dart:math';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('RetryUtil');

class RetryUtil {
  static final Random _random = Random();

  /// Executes a [task] with retry logic.
  ///
  /// [maxRetries] is the number of times to retry after the initial failure.
  /// [initialDelay] is the base delay for exponential backoff.
  /// [maxDelay] is the maximum delay between retries.
  /// [timeout] is the maximum duration to wait for a single task execution.
  /// [retryIf] is an optional predicate to determine if a specific exception
  /// should trigger a retry.
  /// [isCancelled] is an optional function to check for cancellation.
  /// [onRetry] is called before each retry attempt.
  static Future<T> retry<T>({
    required Future<T> Function() task,
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
    Duration maxDelay = const Duration(seconds: 30),
    Duration timeout = const Duration(seconds: 30),
    bool Function(Object)? retryIf,
    bool Function()? isCancelled,
    void Function(Object, int)? onRetry,
  }) async {
    int attempts = 0;

    while (true) {
      if (isCancelled?.call() ?? false) {
        _logger.warning('Task cancelled before attempt #${attempts + 1}.');
        throw TimeoutException('Task cancelled');
      }

      attempts++;
      try {
        return await task().timeout(timeout);
      } catch (e, s) {
        if (isCancelled?.call() ?? false) {
          _logger.warning('Task cancelled after attempt #$attempts.');
          throw TimeoutException('Task cancelled');
        }

        final isRetryable = retryIf?.call(e) ?? _defaultRetryIf(e);

        if (attempts > maxRetries || !isRetryable) {
          _logger.severe(
            'Task failed after $attempts attempts. No more retries.',
            e,
            s,
          );
          rethrow;
        }

        final exponentialFactor = (1 << (attempts - 1));
        final baseDelayMillis = initialDelay.inMilliseconds * exponentialFactor;

        final jitterFactor = 0.85 + (_random.nextDouble() * 0.30);

        var nextDelayMillis = (baseDelayMillis * jitterFactor).toInt();

        if (nextDelayMillis > maxDelay.inMilliseconds) {
          nextDelayMillis = maxDelay.inMilliseconds;
        }

        final nextDelay = Duration(milliseconds: nextDelayMillis);

        _logger.warning(
          'Task failed (Attempt $attempts/$maxRetries). Retrying in ${nextDelay.inMilliseconds}ms...',
          e,
        );

        onRetry?.call(e, attempts);
        await Future.delayed(nextDelay);
      }
    }
  }

  static bool _defaultRetryIf(Object e) {
    if (e is TimeoutException) return true;

    final errorString = e.toString().toLowerCase();
    return errorString.contains('network') ||
        errorString.contains('socket') ||
        errorString.contains('connection') ||
        errorString.contains('503') ||
        errorString.contains('504');
  }
}
