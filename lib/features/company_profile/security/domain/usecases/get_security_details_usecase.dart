import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/security/domain/interfaces/i_security_repository.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';

@lazySingleton
class GetSecurityDetailsUseCase
    implements UseCase<Either<Failure, SecurityDetails>, String> {
  final ISecurityRepository _repository;

  GetSecurityDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, SecurityDetails>> call(String ticker) {
    return _repository.getSecurityDetails(ticker);
  }
}
