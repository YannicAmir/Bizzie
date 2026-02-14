import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market/data/dtos/market_data_snapshot.dart';
import 'package:bizzie/features/market/data/dtos/sector_pe_dto.dart';
import 'package:bizzie/features/market/data/dtos/sector_performance_dto.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('MarketRemoteDataSource');

abstract class MarketRemoteDataSource {
  Future<MarketDataSnapshot> getMarketDataSnapshot([DateTime? date]);
}

@LazySingleton(as: MarketRemoteDataSource)
class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  final Dio _dio;
  final IConfigService _configService;

  MarketRemoteDataSourceImpl(@Named('FmpDio') this._dio, this._configService);

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<MarketDataSnapshot> getMarketDataSnapshot([DateTime? date]) async {
    return _fetchWithFallback(date ?? DateTime.now());
  }

  Future<MarketDataSnapshot> _fetchWithFallback(
    DateTime startDate, [
    int attempts = 0,
  ]) async {
    if (attempts > 4) {
      throw const ServerFailure('Market data unavailable after 4 attempts');
    }

    final formattedDate = BizzieDateFormatter.formatApiDate(startDate);
    final snapshot = await _performSnapshotRequest(formattedDate);

    if (snapshot == null) {
      _logger.warning(
        'Empty market data for $formattedDate. Back-dating attempt ${attempts + 1}',
      );
      return _fetchWithFallback(
        startDate.subtract(const Duration(days: 1)),
        attempts + 1,
      );
    }

    return snapshot;
  }

  Future<MarketDataSnapshot?> _performSnapshotRequest(
    String formattedDate,
  ) async {
    try {
      _logger.info('Fetching Market Snapshot for date: $formattedDate');

      final responses = await Future.wait([
        _dio.get(
          '$_baseUrl/sector-pe-snapshot',
          queryParameters: {'date': formattedDate},
        ),
        _dio.get(
          '$_baseUrl/sector-performance-snapshot',
          queryParameters: {'date': formattedDate},
        ),
      ]);

      final peList = responses[0].data as List;
      final perfList = responses[1].data as List;

      if (peList.isEmpty || perfList.isEmpty) {
        return null;
      }

      _logger.info('Successfully fetched Market Snapshot for $formattedDate');

      return MarketDataSnapshot(
        date: formattedDate,
        peList: peList
            .map((e) => SectorPeDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        performanceList: perfList
            .map(
              (e) => SectorPerformanceDto.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        cacheTimestamp: DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      _logger.warning('Snapshot request failed for $formattedDate: $e');
      rethrow;
    }
  }
}
