import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/domain/interfaces/i_financial_repository.dart';
import 'package:bizzie/features/company_profile/domain/models/full_financials.dart';

@lazySingleton
class GetFullFinancialsUseCase
    implements UseCase<Either<Failure, FullFinancials>, String> {
  final IFinancialRepository _repository;

  GetFullFinancialsUseCase(this._repository);

  @override
  Future<Either<Failure, FullFinancials>> call(String ticker) {
    return _repository.getFullFinancials(ticker);
  }
}
