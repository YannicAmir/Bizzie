import 'package:dio/dio.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/env/app_env.dart';

final _logger = BizzieLogger('FmpApiInterceptor');

class FmpApiInterceptor extends Interceptor {
  final AppEnv _env;

  FmpApiInterceptor(this._env);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters['apikey'] = _env.fmpApiKey;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;

    if (data is Map<String, dynamic> && data.containsKey('Error Message')) {
      final message = data['Error Message']?.toString() ?? 'Unknown FMP error';
      _logger.severe(
        'FMP API returned error for ${response.requestOptions.path}: $message',
      );

      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: message,
        ),
      );
      return;
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe(
      'FMP API request failed: ${err.requestOptions.path} '
      '[${err.type.name}] ${err.message}',
    );
    handler.next(err);
  }
}
