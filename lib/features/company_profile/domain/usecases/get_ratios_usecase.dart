import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';

@lazySingleton
class GetRatiosUseCase
    implements UseCase<Either<Failure, List<CompanyRatios>>, String> {
  final IFinancialRepository _repository;

  GetRatiosUseCase(this._repository);

  @override
  Future<Either<Failure, List<CompanyRatios>>> call(String params) {
    return _repository.getRatios(params);
  }
}
