import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/business/data/dtos/governance_dtos.dart';

abstract class BusinessFirestoreDataSource {
  Future<result.CacheResult<(GovernanceDto, List<ExecutiveDto>)>>
  syncGovernance(
    String ticker, {
    required Future<(GovernanceDto, List<ExecutiveDto>)> Function()
    remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<double>> syncExchangeRate(
    String pair, {
    required Future<double> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<(GovernanceDto, CompanyProfileDataOrigin)?> getCachedGovernance(
    String ticker,
  );
  Future<(List<ExecutiveDto>, CompanyProfileDataOrigin)?> getCachedExecutives(
    String ticker,
  );
  Future<(double, CompanyProfileDataOrigin)?> getCachedExchangeRate(
    String pair,
  );

  Future<void> cacheProxyUrl(String ticker, String? url);
  Future<(String?, CompanyProfileDataOrigin)?> getCachedProxyUrl(String ticker);
}

@LazySingleton(as: BusinessFirestoreDataSource)
class BusinessFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements BusinessFirestoreDataSource {
  BusinessFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'BusinessFirestoreDataSource');

  @override
  Future<result.CacheResult<(GovernanceDto, List<ExecutiveDto>)>>
  syncGovernance(
    String ticker, {
    required Future<(GovernanceDto, List<ExecutiveDto>)> Function()
    remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<(GovernanceDto, List<ExecutiveDto>)>(
      docRef: _governanceRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<double>> syncExchangeRate(
    String pair, {
    required Future<double> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<double>(
      docRef: _exchangeRateRef(pair),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
      fallbackTtl: const Duration(hours: 24),
    );
  }

  @override
  Future<(GovernanceDto, CompanyProfileDataOrigin)?> getCachedGovernance(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(_governanceRef(ticker));
    if (res is result.CacheSuccess<(GovernanceDto, List<ExecutiveDto>)>) {
      return (res.data.$1, res.origin);
    }
    return null;
  }

  @override
  Future<(List<ExecutiveDto>, CompanyProfileDataOrigin)?> getCachedExecutives(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(_governanceRef(ticker));
    if (res is result.CacheSuccess<(GovernanceDto, List<ExecutiveDto>)>) {
      return (res.data.$2, res.origin);
    }
    return null;
  }

  @override
  Future<(double, CompanyProfileDataOrigin)?> getCachedExchangeRate(
    String pair,
  ) async {
    final res = await fetchWithCacheFirst(
      _exchangeRateRef(pair),
      fallbackTtl: const Duration(hours: 24),
    );
    if (res is result.CacheSuccess<double>) {
      return (res.data, res.origin);
    }
    return null;
  }

  @override
  Future<void> cacheProxyUrl(String ticker, String? url) async {
    await saveToCache(
      getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'proxy',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
      {'url': url},
    );
  }

  @override
  Future<(String?, CompanyProfileDataOrigin)?> getCachedProxyUrl(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst<Map<String, dynamic>>(
      getDocRef<Map<String, dynamic>>(
        ticker,
        'info',
        'proxy',
        (json) => json as Map<String, dynamic>,
        (data) => data,
      ),
    );
    if (res is result.CacheSuccess<Map<String, dynamic>>) {
      return (res.data['url'] as String?, res.origin);
    }
    return null;
  }

  DocumentReference<FirestoreCacheEntry<(GovernanceDto, List<ExecutiveDto>)>>
  _governanceRef(String ticker) =>
      getDocRef<(GovernanceDto, List<ExecutiveDto>)>(
        ticker,
        'info',
        'governance',
        (json) {
          final map = json as Map<String, dynamic>;
          final gov = GovernanceDto.fromJson(map['governance']);
          final execs = (map['executives'] as List)
              .map((e) => ExecutiveDto.fromJson(e))
              .toList();
          return (gov, execs);
        },
        (data) => {
          'governance': data.$1.toJson(),
          'executives': data.$2.map((e) => e.toJson()).toList(),
        },
      );

  DocumentReference<FirestoreCacheEntry<double>> _exchangeRateRef(
    String pair,
  ) => getDocRef<double>(
    pair,
    'market',
    'price',
    (json) => (json as num).toDouble(),
    (data) => data,
  );
}
