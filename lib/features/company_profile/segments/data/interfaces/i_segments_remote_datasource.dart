import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';

abstract class ISegmentsRemoteDataSource {
  Future<List<RevenueSegmentationDto>> getProductSegmentation(
    String ticker, {
    required SegmentPeriod period,
  });
  Future<List<RevenueSegmentationDto>> getGeographicSegmentation(
    String ticker, {
    required SegmentPeriod period,
  });
}
