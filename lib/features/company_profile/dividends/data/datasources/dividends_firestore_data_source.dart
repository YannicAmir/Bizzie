import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/dividends/data/dtos/dividend_dto.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DividendsFirestoreDataSource {
  Future<result.CacheResult<List<DividendDto>>> syncDividends(
    String ticker, {
    required Future<List<DividendDto>> Function() remoteFetcher,
    bool forceRefresh,
  });
  Future<(List<DividendDto>, CompanyProfileDataOrigin)?> getCachedDividends(
    String ticker,
  );
}

@LazySingleton(as: DividendsFirestoreDataSource)
class DividendsFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements DividendsFirestoreDataSource {
  DividendsFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'DividendsFirestoreDataSource');

  @override
  Future<result.CacheResult<List<DividendDto>>> syncDividends(
    String ticker, {
    required Future<List<DividendDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<DividendDto>>(
      docRef: _divRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(List<DividendDto>, CompanyProfileDataOrigin)?> getCachedDividends(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(_divRef(ticker));
    if (res is result.CacheSuccess<List<DividendDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  DocumentReference<FirestoreCacheEntry<List<DividendDto>>> _divRef(
    String ticker,
  ) => getDocRef<List<DividendDto>>(
    ticker,
    'market',
    'dividends',
    (json) => (json as List).map((e) => DividendDto.fromJson(e)).toList(),
    (data) => data.map((e) => e.toJson()).toList(),
  );
}
