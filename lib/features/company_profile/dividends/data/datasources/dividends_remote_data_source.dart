import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';

abstract class DividendsRemoteDataSource {
  Future<List<DividendDto>> getDividends(String ticker);
}

@LazySingleton(as: DividendsRemoteDataSource)
class DividendsRemoteDataSourceImpl implements DividendsRemoteDataSource {
  final Dio _dio;
  final IConfigService _configService;

  DividendsRemoteDataSourceImpl(
    @Named('FmpDio') this._dio,
    this._configService,
  );

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<DividendDto>> getDividends(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/dividends',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    if (response.data is Map && response.data['historical'] != null) {
      return (response.data['historical'] as List)
          .map((e) => DividendDto.fromJson(e))
          .toList();
    }
    return (response.data as List).map((e) => DividendDto.fromJson(e)).toList();
  }
}
