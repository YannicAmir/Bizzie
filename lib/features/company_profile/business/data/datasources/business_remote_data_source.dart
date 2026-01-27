import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/profile_dtos.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';

abstract class BusinessRemoteDataSource {
  Future<List<ProfileDto>> getProfile(String ticker);
  Future<List<QuoteDto>> getQuote(String ticker);
  Future<List<GovernanceDto>> getGovernance(String ticker);
  Future<List<ExecutiveDto>> getExecutives(String ticker);
  Future<double?> getExchangeRate(String pair);
}

@LazySingleton(as: BusinessRemoteDataSource)
class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final Dio _dio;
  final ConfigService _configService;

  BusinessRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

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

  @override
  Future<List<QuoteDto>> getQuote(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/quote',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List).map((e) => QuoteDto.fromJson(e)).toList();
  }

  @override
  Future<List<GovernanceDto>> getGovernance(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/governance-executive-compensation',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List)
        .map((e) => GovernanceDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<ExecutiveDto>> getExecutives(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/key-executives/${_sanitize(ticker)}',
    );
    return (response.data as List)
        .map((e) => ExecutiveDto.fromJson(e))
        .toList();
  }

  @override
  Future<double?> getExchangeRate(String pair) async {
    final response = await _dio.get(
      '$_baseUrl/quote',
      queryParameters: {'symbol': pair},
    );
    final list = response.data as List;
    if (list.isNotEmpty) {
      return list.first['price'] as double?;
    }
    return null;
  }
}
