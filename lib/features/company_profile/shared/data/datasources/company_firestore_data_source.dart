import 'package:bizzie/core/constants/firestore_constants.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/data/datasources/base_firestore_cache_client.dart';
import 'package:bizzie/core/data/models/firestore_cache_entry.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';
import 'package:bizzie/features/company_profile/shared/data/interfaces/i_company_firestore_datasource.dart';
import 'package:bizzie/services/firestore_service.dart';

@Injectable(as: ICompanyFirestoreDataSource)
class CompanyFirestoreDataSourceImpl extends BaseFirestoreCacheClient
    implements ICompanyFirestoreDataSource {
  CompanyFirestoreDataSourceImpl(
    FirestoreService firestoreService,
    ITimeProvider timeProvider,
  ) : super(firestoreService, timeProvider, 'CompanyFirestoreDataSource');

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
      weekendThresholdHour: 17,
      strictMarketAware: true,
    );
  }

  @override
  Future<(ProfileDto, CompanyProfileDataOrigin)?> getCachedProfile(
    String ticker,
  ) async {
    final res = await fetchWithCacheFirst(
      _profileRef(ticker),
      weekendThresholdHour: 17,
      strictMarketAware: true,
    );
    if (res is result.CacheSuccess<ProfileDto>) return (res.data, res.origin);
    return null;
  }

  DocumentReference<FirestoreCacheEntry<ProfileDto>> _profileRef(
    String ticker,
  ) => getDocRef<ProfileDto>(
    ticker,
    FirestoreConstants.info,
    FirestoreConstants.profile,
    (json) => ProfileDto.fromJson(json as Map<String, dynamic>),
    (data) => data.toJson(),
  );
}
