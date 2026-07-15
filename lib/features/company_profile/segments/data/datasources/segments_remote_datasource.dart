import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_remote_datasource.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

final _logger = BizzieLogger('SegmentsRemoteDataSource');

@Injectable(as: ISegmentsRemoteDataSource)
class SegmentsRemoteDataSourceImpl implements ISegmentsRemoteDataSource {
  static const String _flatStructure = 'flat';

  final Dio _dio;
  final IConfigService _configService;

  SegmentsRemoteDataSourceImpl(
    @Named('FmpDio') this._dio,
    this._configService,
  );

  String _sanitize(String ticker) => ticker.replaceAll('.', '-');

  String _removeTrailingSlash(String url) =>
      url.endsWith('/') ? url.substring(0, url.length - 1) : url;

  String get _baseUrl => _removeTrailingSlash(_configService.fmpConfig.baseUrl);

  @override
  Future<List<RevenueSegmentationDto>> getProductSegmentation(
    String ticker, {
    required SegmentPeriod period,
  }) {
    return _getSegmentation(
      '$_baseUrl/revenue-product-segmentation',
      ticker,
      period,
    );
  }

  @override
  Future<List<RevenueSegmentationDto>> getGeographicSegmentation(
    String ticker, {
    required SegmentPeriod period,
  }) {
    return _getSegmentation(
      '$_baseUrl/revenue-geographic-segmentation',
      ticker,
      period,
    );
  }

  Future<List<RevenueSegmentationDto>> _getSegmentation(
    String endpoint,
    String ticker,
    SegmentPeriod period,
  ) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: {
          'symbol': _sanitize(ticker),
          'period': period.apiValue,
          'structure': _flatStructure,
        },
      );
      return (response.data as List)
          .map((e) => RevenueSegmentationDto.fromJson(e))
          .toList();
    } on Exception catch (e) {
      _logger.severe('Failed to fetch revenue segmentation for $ticker', e);
      rethrow;
    }
  }
}
