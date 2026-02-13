import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/services/config_service.dart';

@module
abstract class NetworkModule {
  @singleton
  FirebaseFunctions get firebaseFunctions => FirebaseFunctions.instance;

  @Named('FmpDio')
  @singleton
  Dio fmpDio(ConfigService configService, AppEnv env) {
    final dio = Dio(BaseOptions(baseUrl: configService.fmpConfig.baseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['apikey'] = env.fmpApiKey;
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}
