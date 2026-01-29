import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/business/domain/interfaces/i_business_repository.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';

@lazySingleton
class GetBusinessProfileUseCase
    implements UseCase<Either<Failure, BusinessProfile>, String> {
  final IBusinessRepository _repository;

  GetBusinessProfileUseCase(this._repository);

  @override
  Future<Either<Failure, BusinessProfile>> call(String ticker) {
    return _repository.getBusinessProfile(ticker);
  }
}
