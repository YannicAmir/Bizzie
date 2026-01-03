import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/env/env.dart';
import 'package:bizzie/services/config_service.dart';

@module
abstract class NetworkModule {
  @Named('FmpDio')
  @singleton
  @Named('FmpDio')
  @singleton
  Dio fmpDio(ConfigService configService) {
    final dio = Dio(BaseOptions(baseUrl: configService.fmpConfig.baseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Appending the API key to every request query parameters
          options.queryParameters['apikey'] = Env.fmpApiKey;
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
