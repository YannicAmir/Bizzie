import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';

abstract class CompanyRemoteDataSource {
  Future<List<ProfileDto>> getProfile(String ticker);
}

@LazySingleton(as: CompanyRemoteDataSource)
class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  final Dio _dio;
  final IConfigService _configService;

  CompanyRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<ProfileDto>> getProfile(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/profile',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List).map((e) => ProfileDto.fromJson(e)).toList();
  }
}
