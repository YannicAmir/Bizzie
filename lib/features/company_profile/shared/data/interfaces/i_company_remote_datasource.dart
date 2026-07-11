import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';

abstract class ICompanyRemoteDataSource {
  Future<List<ProfileDto>> getProfile(String ticker);
}
