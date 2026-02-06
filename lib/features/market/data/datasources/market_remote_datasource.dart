import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/market/data/dtos/sector_pe_dto.dart';
import 'package:bizzie/features/market/data/dtos/sector_performance_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketRemoteDataSource');

abstract class MarketRemoteDataSource {
  Future<List<SectorPeDto>> getSectorPeList();
  Future<List<SectorPerformanceDto>> getSectorPerformanceList();
}

@LazySingleton(as: MarketRemoteDataSource)
class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  final Dio _dio;
  final ConfigService _configService;

  MarketRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<SectorPeDto>> getSectorPeList() async {
    _logger.info('Fetching Sector PE Snapshots');
    final date = BizzieDateFormatter.formatApiDate(DateTime.now());
    final response = await _dio.get(
      '$_baseUrl/sector-pe-snapshot',
      queryParameters: {'date': date},
    );
    final list = response.data as List;
    _logger.info('Successfully fetched ${list.length} PE snapshots');
    return list
        .map((e) => SectorPeDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SectorPerformanceDto>> getSectorPerformanceList() async {
    _logger.info('Fetching Sector Performance Snapshots');
    final date = BizzieDateFormatter.formatApiDate(DateTime.now());
    final response = await _dio.get(
      '$_baseUrl/sector-performance-snapshot',
      queryParameters: {'date': date},
    );
    final list = response.data as List;
    _logger.info('Successfully fetched ${list.length} performance snapshots');
    return list
        .map((e) => SectorPerformanceDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
