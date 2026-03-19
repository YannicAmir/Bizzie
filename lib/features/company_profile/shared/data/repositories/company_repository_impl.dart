import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_firestore_data_source.dart';
import 'package:bizzie/features/company_profile/shared/data/datasources/company_remote_data_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/interfaces/i_company_repository.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/company_profile.dart';
import 'package:bizzie/core/data/models/cache_result.dart' as result;
import 'package:bizzie/features/company_profile/shared/data/dtos/company_profile_dto.dart';

@LazySingleton(as: ICompanyRepository)
class CompanyRepositoryImpl implements ICompanyRepository {
  final CompanyRemoteDataSource _remoteDataSource;
  final CompanyFirestoreDataSource _localDataSource;

  CompanyRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, (CompanyProfile, CompanyProfileDataOrigin)>>
  getProfile(String ticker) async {
    final res = await _localDataSource.syncProfile(
      ticker,
      remoteFetcher: () => _remoteDataSource.getProfile(ticker),
    );

    if (res is result.CacheSuccess<ProfileDto>) {
      return right((res.data.toDomain(), res.origin));
    } else if (res is result.CacheFailure<ProfileDto>) {
      return left(res.failure);
    } else {
      return left(const Failure.server('Profile not found'));
    }
  }
}
