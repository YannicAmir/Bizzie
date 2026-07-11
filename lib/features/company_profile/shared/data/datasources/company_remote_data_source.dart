import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_company_remote_datasource.dart';

final _logger = BizzieLogger('CompanyRemoteDataSource');

@Injectable(as: ICompanyRemoteDataSource)
class CompanyRemoteDataSourceImpl implements ICompanyRemoteDataSource {
  final Dio _dio;
  final IConfigService _configService;

  CompanyRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<ProfileDto>> getProfile(String ticker) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/profile',
        queryParameters: {'symbol': _sanitize(ticker)},
      );
      return (response.data as List)
          .map((e) => ProfileDto.fromJson(e))
          .toList();
    } on Exception catch (e) {
      _logger.severe('Failed to fetch company profile for $ticker', e);
      rethrow;
    }
  }
}
