import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';

abstract class ICompanyFirestoreDataSource {
  Future<result.CacheResult<ProfileDto>> syncProfile(
    String ticker, {
    required Future<List<ProfileDto>> Function() remoteFetcher,
    bool forceRefresh,
  });

  Future<(ProfileDto, CompanyProfileDataOrigin)?> getCachedProfile(
    String ticker,
  );
}
