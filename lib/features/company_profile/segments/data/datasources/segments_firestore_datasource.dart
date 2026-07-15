import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:bizzie/features/company_profile/segments/data/dtos/revenue_segmentation_dto.dart';
import 'package:bizzie/features/company_profile/segments/data/interfaces/i_segments_firestore_datasource.dart';
import 'package:bizzie/features/company_profile/segments/domain/enums/segment_period.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ISegmentsFirestoreDataSource)
class SegmentsFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements ISegmentsFirestoreDataSource {
  SegmentsFirestoreDataSourceImpl(
    FirestoreService firestoreService,
    ITimeProvider timeProvider,
  ) : super(firestoreService, timeProvider, 'SegmentsFirestoreDataSource');

  @override
  Future<result.CacheResult<List<RevenueSegmentationDto>>>
  syncProductSegmentation(
    String ticker, {
    required SegmentPeriod period,
    required Future<List<RevenueSegmentationDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<RevenueSegmentationDto>>(
      docRef: _segmentationRef(
        ticker,
        FirestoreConstants.productSegmentationPrefix,
        period,
      ),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<List<RevenueSegmentationDto>>>
  syncGeographicSegmentation(
    String ticker, {
    required SegmentPeriod period,
    required Future<List<RevenueSegmentationDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<RevenueSegmentationDto>>(
      docRef: _segmentationRef(
        ticker,
        FirestoreConstants.geographicSegmentationPrefix,
        period,
      ),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  DocumentReference<FirestoreCacheEntry<List<RevenueSegmentationDto>>>
  _segmentationRef(String ticker, String prefix, SegmentPeriod period) =>
      getDocRef<List<RevenueSegmentationDto>>(
        ticker,
        FirestoreConstants.financials,
        '${prefix}_${period.apiValue}',
        (json) => (json as List)
            .map((e) => RevenueSegmentationDto.fromJson(e))
            .toList(),
        (data) => data.map((e) => e.toJson()).toList(),
      );
}
