import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/earnings_report_dto.dart';
import 'package:bizzie/features/company_profile/security/data/dtos/historical_price_eod_dto.dart';

import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SecurityFirestoreDataSource {
  Future<result.CacheResult<List<HistoricalPriceDto>>> syncPrices(
    String ticker, {
    required Future<List<HistoricalPriceDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<HistoricalPriceDto>, CompanyProfileDataOrigin)?> getCachedPrices(
    String ticker,
  );

  Future<result.CacheResult<List<HistoricalPriceEodDto>>>
  syncHistoricalEodPrices(
    String ticker, {
    required Future<List<HistoricalPriceEodDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<HistoricalPriceEodDto>, CompanyProfileDataOrigin)?>
  getCachedHistoricalEodPrices(String ticker);

  Future<result.CacheResult<List<EarningsReportDto>>> syncEarningsReports(
    String ticker, {
    required Future<List<EarningsReportDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<EarningsReportDto>, CompanyProfileDataOrigin)?>
  getCachedEarningsReports(String ticker);
}

@LazySingleton(as: SecurityFirestoreDataSource)
class SecurityFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements SecurityFirestoreDataSource {
  SecurityFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'SecurityFirestoreDataSource');

  @override
  Future<result.CacheResult<List<HistoricalPriceDto>>> syncPrices(
    String ticker, {
    required Future<List<HistoricalPriceDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<HistoricalPriceDto>>(
      docRef: _pricesRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(List<HistoricalPriceDto>, CompanyProfileDataOrigin)?> getCachedPrices(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(_pricesRef(ticker));
    if (res is result.CacheSuccess<List<HistoricalPriceDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<result.CacheResult<List<HistoricalPriceEodDto>>>
  syncHistoricalEodPrices(
    String ticker, {
    required Future<List<HistoricalPriceEodDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<HistoricalPriceEodDto>>(
      docRef: _eodPricesRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
      weekendThresholdHour: 17,
      strictMarketAware: true,
      fallbackTtl: const Duration(hours: 24),
    );
  }

  @override
  Future<(List<HistoricalPriceEodDto>, CompanyProfileDataOrigin)?>
  getCachedHistoricalEodPrices(String ticker) async {
    final res = await fetchWithCacheFirst(
      _eodPricesRef(ticker),
      weekendThresholdHour: 17,
      strictMarketAware: true,
      fallbackTtl: const Duration(hours: 24),
    );
    if (res is result.CacheSuccess<List<HistoricalPriceEodDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<result.CacheResult<List<EarningsReportDto>>> syncEarningsReports(
    String ticker, {
    required Future<List<EarningsReportDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<EarningsReportDto>>(
      docRef: _earningsRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(List<EarningsReportDto>, CompanyProfileDataOrigin)?>
  getCachedEarningsReports(String ticker) async {
    final res = await fetchWithCacheFirst(_earningsRef(ticker));
    if (res is result.CacheSuccess<List<EarningsReportDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  DocumentReference<FirestoreCacheEntry<List<HistoricalPriceDto>>> _pricesRef(
    String ticker,
  ) => getDocRef<List<HistoricalPriceDto>>(
    ticker,
    'market',
    'prices_history',
    (json) =>
        (json as List).map((e) => HistoricalPriceDto.fromJson(e)).toList(),
    (data) => data.map((e) => e.toJson()).toList(),
  );

  DocumentReference<FirestoreCacheEntry<List<HistoricalPriceEodDto>>>
  _eodPricesRef(String ticker) => getDocRef<List<HistoricalPriceEodDto>>(
    ticker,
    'market',
    'prices_eod',
    (json) =>
        (json as List).map((e) => HistoricalPriceEodDto.fromJson(e)).toList(),
    (data) => data.map((e) => e.toJson()).toList(),
  );

  DocumentReference<FirestoreCacheEntry<List<EarningsReportDto>>> _earningsRef(
    String ticker,
  ) => getDocRef<List<EarningsReportDto>>(
    ticker,
    'financials',
    'earnings_reports',
    (json) => (json as List).map((e) => EarningsReportDto.fromJson(e)).toList(),
    (data) => data.map((e) => e.toJson()).toList(),
  );
}
