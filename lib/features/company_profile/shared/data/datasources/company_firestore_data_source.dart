import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/quote_dto.dart';

abstract class CompanyFirestoreDataSource {
  Future<result.CacheResult<ProfileDto>> syncProfile(
    String ticker, {
    required Future<List<ProfileDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<result.CacheResult<QuoteDto>> syncQuote(
    String ticker, {
    required Future<List<QuoteDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<(ProfileDto, CompanyProfileDataOrigin)?> getCachedProfile(
    String ticker,
  );
  Future<(QuoteDto, CompanyProfileDataOrigin)?> getCachedQuote(String ticker);
}

@LazySingleton(as: CompanyFirestoreDataSource)
class CompanyFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements CompanyFirestoreDataSource {
  CompanyFirestoreDataSourceImpl(
    FirebaseFirestore firestore,
    ITimeProvider timeProvider,
  ) : super(firestore, timeProvider, 'CompanyFirestoreDataSource');

  @override
  Future<result.CacheResult<ProfileDto>> syncProfile(
    String ticker, {
    required Future<List<ProfileDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<ProfileDto>(
      docRef: _profileRef(ticker),
      remoteFetcher: () async {
        final results = await remoteFetcher();
        if (results.isEmpty) throw Exception('Profile not found for $ticker');
        return results.first;
      },
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<result.CacheResult<QuoteDto>> syncQuote(
    String ticker, {
    required Future<List<QuoteDto>> Function() remoteFetcher,
    bool forceRefresh = false,
  }) async {
    return syncOrFetch<QuoteDto>(
      docRef: _quoteRef(ticker),
      remoteFetcher: () async {
        final results = await remoteFetcher();
        if (results.isEmpty) throw Exception('Quote not found for $ticker');
        return results.first;
      },
      fallbackTtl: const Duration(minutes: 5),
      forceRefresh: forceRefresh,
    );
  }

  @override
  Future<(ProfileDto, CompanyProfileDataOrigin)?> getCachedProfile(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(_profileRef(ticker));
    if (res is result.CacheSuccess<ProfileDto>) return (res.data, res.origin);
    return null;
  }

  @override
  Future<(QuoteDto, CompanyProfileDataOrigin)?> getCachedQuote(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(
      _quoteRef(ticker),
      fallbackTtl: const Duration(minutes: 5),
    );
    if (res is result.CacheSuccess<QuoteDto>) return (res.data, res.origin);
    return null;
  }

  DocumentReference<FirestoreCacheEntry<ProfileDto>> _profileRef(
    String ticker,
  ) => getDocRef<ProfileDto>(
    ticker,
    'info',
    'profile',
    (json) => ProfileDto.fromJson(json as Map<String, dynamic>),
    (data) => data.toJson(),
  );

  DocumentReference<FirestoreCacheEntry<QuoteDto>> _quoteRef(String ticker) =>
      getDocRef<QuoteDto>(
        ticker,
        'market',
        'quote',
        (json) => QuoteDto.fromJson(json as Map<String, dynamic>),
        (data) => data.toJson(),
      );
}
