import 'package:dio/dio.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('AiErrorMapper');

class AiErrorMapper {
  const AiErrorMapper._();

  static Failure map(DioException e, StackTrace s, String context) {
    final status = e.response?.statusCode;
    _logger.severe('$context: DioException status=$status', e, s);
    return switch (status) {
      400 ||
      401 ||
      403 ||
      404 => const Failure.server('Error. Please enter a valid message.'),
      429 => const Failure.rateLimit(
        retryAfterSeconds: 0,
        message:
            'You have reached your message limit for today. Come back to Bizzie AI tomorrow.',
      ),
      503 => const Failure.server(
        'Bizzie AI is having some troubles. Please try again later.',
      ),
      _ => const Failure.server(
        'Something went wrong generating a response. Please try again.',
      ),
    };
  }
}
