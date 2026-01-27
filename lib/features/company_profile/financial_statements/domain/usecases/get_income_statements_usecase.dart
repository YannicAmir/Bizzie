import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_financial_statements_repository.dart';
import '../models/income_statement.dart';
import '../models/get_financial_statement_params.dart';

@lazySingleton
class GetIncomeStatementsUseCase
    implements
        UseCase<
          Either<Failure, List<IncomeStatement>>,
          GetFinancialStatementParams
        > {
  final IFinancialStatementsRepository _repository;

  GetIncomeStatementsUseCase(this._repository);

  @override
  Future<Either<Failure, List<IncomeStatement>>> call(
    GetFinancialStatementParams params,
  ) {
    return _repository.getIncomeStatements(
      params.ticker,
      period: params.period,
    );
  }
}
