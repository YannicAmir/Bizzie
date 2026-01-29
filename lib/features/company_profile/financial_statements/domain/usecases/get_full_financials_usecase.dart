import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_financial_statements_repository.dart';
import '../models/full_financials.dart';

@lazySingleton
class GetFullFinancialsUseCase
    implements UseCase<Either<Failure, FullFinancials>, String> {
  final IFinancialStatementsRepository _repository;

  GetFullFinancialsUseCase(this._repository);

  @override
  Future<Either<Failure, FullFinancials>> call(String ticker) {
    return _repository.getFullFinancials(ticker);
  }
}
