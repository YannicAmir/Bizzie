import 'package:injectable/injectable.dart';
import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/news/data/dtos/news_dto.dart';
import 'package:bizzie/features/company_profile/news/data/interfaces/i_news_firestore_datasource.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bizzie/services/firestore_service.dart';

@Injectable(as: INewsFirestoreDataSource)
class NewsFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements INewsFirestoreDataSource {
  NewsFirestoreDataSourceImpl(
    FirestoreService firestoreService,
    ITimeProvider timeProvider,
  ) : super(firestoreService, timeProvider, 'NewsFirestoreDataSource');

  @override
  Future<result.CacheResult<List<NewsDto>>> syncStockNews(
    String ticker, {
    required Future<List<NewsDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<List<NewsDto>>(
      docRef: _newsRef(ticker),
      remoteFetcher: remoteFetcher,
      forceRefresh: forceRefresh,
      fallbackTtl: const Duration(minutes: 5),
    );
  }

  @override
  Future<(List<NewsDto>, CompanyProfileDataOrigin)?> getCachedStockNews(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(
      _newsRef(ticker),
      fallbackTtl: const Duration(minutes: 5),
    );
    if (res is result.CacheSuccess<List<NewsDto>>) {
      return (res.data, res.origin);
    }
    return null;
  }

  DocumentReference<FirestoreCacheEntry<List<NewsDto>>> _newsRef(
    String ticker,
  ) => getDocRef<List<NewsDto>>(
    ticker,
    FirestoreConstants.market,
    FirestoreConstants.news,
    (json) => (json as List).map((e) => NewsDto.fromJson(e)).toList(),
    (data) => data.map((e) => e.toJson()).toList(),
  );
}
