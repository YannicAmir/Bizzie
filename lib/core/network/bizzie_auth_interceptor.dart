import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';

final _logger = BizzieLogger('BizzieAuthInterceptor');

class BizzieAuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        options.headers['Authorization'] = 'Bearer $token';
      } else {
        _logger.warning('BizzieAuthInterceptor: no current user — request sent without token');
      }
    } catch (e) {
      _logger.warning('BizzieAuthInterceptor: failed to fetch ID token — $e');
    }
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.severe(
      'Bizzie function request failed: ${err.requestOptions.path} '
      '[${err.type.name}] status=${err.response?.statusCode ?? 'no status'}',
    );
    handler.next(err);
  }
}
