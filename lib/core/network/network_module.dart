import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/env/app_env.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/network/fmp_api_interceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  FirebaseFunctions get firebaseFunctions => FirebaseFunctions.instance;

  @Named('FmpDio')
  @singleton
  Dio fmpDio(IConfigService configService, AppEnv env) {
    final dio = Dio(BaseOptions(baseUrl: configService.fmpConfig.baseUrl));
    dio.interceptors.add(FmpApiInterceptor(env));
    return dio;
  }

  @Named('FrankfurterDio')
  @singleton
  Dio frankfurterDio(IConfigService configService) {
    return Dio(
      BaseOptions(
        baseUrl: configService.frankfurterBaseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'User-Agent': 'Bizzie (https://getbizzie.io)'},
      ),
    );
  }
}
