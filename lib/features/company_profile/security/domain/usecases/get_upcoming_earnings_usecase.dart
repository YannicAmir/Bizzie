import 'package:bizzie/core/enums/data_origin.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';

@lazySingleton
class GetUpcomingEarningsUseCase
    implements
        UseCase<
          Either<Failure, (DateTime?, CompanyProfileDataOrigin)>,
          String
        > {
  final ISecurityRepository _repository;

  GetUpcomingEarningsUseCase(this._repository);

  @override
  Future<Either<Failure, (DateTime?, CompanyProfileDataOrigin)>> call(
    String params,
  ) async {
    return _repository.getUpcomingEarningsDate(params);
  }
}
