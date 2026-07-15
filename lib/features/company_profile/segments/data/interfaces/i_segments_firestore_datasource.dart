import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';

abstract class ISegmentsFirestoreDataSource {
  Future<result.CacheResult<List<RevenueSegmentationDto>>>
  syncProductSegmentation(
    String ticker, {
    required SegmentPeriod period,
    required Future<List<RevenueSegmentationDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<List<RevenueSegmentationDto>>>
  syncGeographicSegmentation(
    String ticker, {
    required SegmentPeriod period,
    required Future<List<RevenueSegmentationDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
}
