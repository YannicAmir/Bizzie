import 'package:dio/dio.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('FunctionAppErrorMapper');

class FunctionAppErrorMapper {
  const FunctionAppErrorMapper._();

  static Failure map(DioException e, StackTrace s, String context) {
    final status = e.response?.statusCode;
    switch (status) {
      case 401:
        _logger.warning('$context: 401 authentication failure');
        return const Failure.permission(
          'Authentication failed — please sign in again',
        );
      case 403:
        _logger.warning('$context: 403 forbidden');
        return const Failure.permission(
          'You do not have permission to perform this action',
        );
      case 404:
        _logger.warning('$context: 404 user not found');
        return const Failure.userNotFound();
      case 429:
        final data = e.response?.data;
        final retryAfterSeconds =
            (data is Map) ? (data['retryAfterSeconds'] as int? ?? 0) : 0;
        _logger.warning(
          '$context: 429 rate limited — retryAfterSeconds=$retryAfterSeconds',
        );
        return Failure.rateLimit(retryAfterSeconds: retryAfterSeconds);
      case 503:
        _logger.warning('$context: 503 service unavailable');
        return const Failure.server(
          'The service is temporarily unavailable. Please try again shortly.',
        );
      default:
        _logger.severe('$context: DioException status=$status', e, s);
        return Failure.server(e.message ?? e.toString());
    }
  }
}
