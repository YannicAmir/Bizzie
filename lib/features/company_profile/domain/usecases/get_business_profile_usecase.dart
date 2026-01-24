import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/business_profile.dart';

@lazySingleton
class GetBusinessProfileUseCase
    implements UseCase<Either<Failure, BusinessProfile>, String> {
  final ISecurityRepository _repository;

  GetBusinessProfileUseCase(this._repository);

  @override
  Future<Either<Failure, BusinessProfile>> call(String ticker) {
    return _repository.getBusinessProfile(ticker);
  }
}
