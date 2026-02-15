import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';

abstract class SecurityRemoteDataSource {
  Future<List<HistoricalPriceDto>> getHistoricalPrice(String ticker);
  Future<List<HistoricalPriceEodDto>> getHistoricalEodPrices(String ticker);
  Future<List<EarningsReportDto>> getEarningsReports(String ticker);
}

@LazySingleton(as: SecurityRemoteDataSource)
class SecurityRemoteDataSourceImpl implements SecurityRemoteDataSource {
  static const int _companyEarningsLimit = 10;

  final Dio _dio;
  final IConfigService _configService;

  SecurityRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _formatDate(DateTime d) {
    return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
  }

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);
  String get _v3Url => _removeTrailingSlash(_configService.fmpConfig.v3Url);

  @override
  Future<List<HistoricalPriceDto>> getHistoricalPrice(String ticker) async {
    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));

    final response = await _dio.get(
      '$_v3Url/historical-price-full/${_sanitize(ticker)}',
      queryParameters: {
        'from': _formatDate(oneYearAgo),
        'to': _formatDate(now),
      },
    );
    final history = response.data['historical'] as List?;
    if (history == null) return [];
    return history.map((e) => HistoricalPriceDto.fromJson(e)).toList();
  }

  @override
  Future<List<HistoricalPriceEodDto>> getHistoricalEodPrices(
    String ticker,
  ) async {
    final response = await _dio.get(
      '$_baseUrl/historical-price-eod/light',
      queryParameters: {'symbol': _sanitize(ticker)},
    );
    return (response.data as List)
        .map((e) => HistoricalPriceEodDto.fromJson(e))
        .toList();
  }

  @override
  Future<List<EarningsReportDto>> getEarningsReports(String ticker) async {
    final response = await _dio.get(
      '$_baseUrl/earnings',
      queryParameters: {
        'symbol': _sanitize(ticker),
        'limit': _companyEarningsLimit,
      },
    );
    return (response.data as List)
        .map((e) => EarningsReportDto.fromJson(e))
        .toList();
  }
}
