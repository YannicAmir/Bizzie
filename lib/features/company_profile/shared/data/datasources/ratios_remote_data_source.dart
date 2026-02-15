import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_ttm_dto.dart';
import 'package:bizzie/features/company_profile/roe/data/dtos/key_metrics_dto.dart';

abstract class RatiosRemoteDataSource {
  Future<List<RatiosDto>> getRatios(String ticker);
  Future<List<RatiosTtmDto>> getRatiosTtm(String ticker);
  Future<List<KeyMetricsDto>> getKeyMetrics(String ticker);
}

@LazySingleton(as: RatiosRemoteDataSource)
class RatiosRemoteDataSourceImpl implements RatiosRemoteDataSource {
  static const int _defaultLimit = 1000;

  final Dio _dio;
  final IConfigService _configService;

  RatiosRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<RatiosDto>> getRatios(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/ratios',
      queryParameters: {'symbol': _sanitize(ticker), 'limit': _defaultLimit},
    );
    return (response.data as List).map((e) => RatiosDto.fromJson(e)).toList();
  }

  @override
  Future<List<RatiosTtmDto>> getRatiosTtm(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/ratios-ttm',
      queryParameters: {'symbol': _sanitize(ticker)},
    );

    return (response.data as List)
        .map((e) => RatiosTtmDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<KeyMetricsDto>> getKeyMetrics(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/key-metrics',
      queryParameters: {'symbol': _sanitize(ticker), 'limit': _defaultLimit},
    );
    return (response.data as List)
        .map((e) => KeyMetricsDto.fromJson(e))
        .toList();
  }
}
