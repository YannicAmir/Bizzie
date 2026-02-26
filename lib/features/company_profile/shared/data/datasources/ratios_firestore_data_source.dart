import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/ratios_dto.dart';
import 'package:bizzie/features/company_profile/roe/data/dtos/key_metrics_dto.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RatiosFirestoreDataSource {
  Future<result.CacheResult<List<RatiosDto>>> syncRatios(
    String ticker, {
    required bool isTtm,
    required Future<List<RatiosDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<RatiosDto>, CompanyProfileDataOrigin)?> getCachedRatios(
    String ticker, {
    required bool isTtm,
  });

  Future<result.CacheResult<List<KeyMetricsDto>>> syncKeyMetrics(
    String ticker, {
    required bool isTtm,
    required Future<List<KeyMetricsDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<KeyMetricsDto>, CompanyProfileDataOrigin)?> getCachedKeyMetrics(
    String ticker, {
    required bool isTtm,
  });
}

@LazySingleton(as: RatiosFirestoreDataSource)
class RatiosFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements RatiosFirestoreDataSource {
  RatiosFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'RatiosFirestoreDataSource');

  @override
  Future<result.CacheResult<List<RatiosDto>>> syncRatios(
    String ticker, {
    required bool isTtm,
    required Future<List<RatiosDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<RatiosDto>>(
      docRef: _ratiosRef(ticker, isTtm),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(List<RatiosDto>, CompanyProfileDataOrigin)?> getCachedRatios(
    String ticker, {
    required bool isTtm,
  }) async {
    final res = await fetchWithCacheFirst(_ratiosRef(ticker, isTtm));
    if (res is result.CacheSuccess<List<RatiosDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<result.CacheResult<List<KeyMetricsDto>>> syncKeyMetrics(
    String ticker, {
    required bool isTtm,
    required Future<List<KeyMetricsDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<KeyMetricsDto>>(
      docRef: _metricsRef(ticker, isTtm),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(List<KeyMetricsDto>, CompanyProfileDataOrigin)?> getCachedKeyMetrics(
    String ticker, {
    required bool isTtm,
  }) async {
    final res = await fetchWithCacheFirst(_metricsRef(ticker, isTtm));
    if (res is result.CacheSuccess<List<KeyMetricsDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  DocumentReference<FirestoreCacheEntry<List<RatiosDto>>> _ratiosRef(
    String ticker,
    bool isTtm,
  ) {
    final docId = isTtm ? 'ratios_ttm' : 'ratios_annual';
    return getDocRef<List<RatiosDto>>(
      ticker,
      'financials',
      docId,
      (json) => (json as List).map((e) => RatiosDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    );
  }

  DocumentReference<FirestoreCacheEntry<List<KeyMetricsDto>>> _metricsRef(
    String ticker,
    bool isTtm,
  ) {
    final docId = isTtm ? 'key_metrics_ttm' : 'key_metrics_annual';
    return getDocRef<List<KeyMetricsDto>>(
      ticker,
      'financials',
      docId,
      (json) => (json as List).map((e) => KeyMetricsDto.fromJson(e)).toList(),
      (data) => data.map((e) => e.toJson()).toList(),
    );
  }
}
