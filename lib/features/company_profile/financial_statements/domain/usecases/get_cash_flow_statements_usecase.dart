import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import '../interfaces/i_financial_statements_repository.dart';
import '../models/cash_flow_statement.dart';
import '../models/get_financial_statement_params.dart';

@lazySingleton
class GetCashFlowStatementsUseCase
    implements
        UseCase<
          Either<Failure, List<CashFlowStatement>>,
          GetFinancialStatementParams
        > {
  final IFinancialStatementsRepository _repository;

  GetCashFlowStatementsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CashFlowStatement>>> call(
    GetFinancialStatementParams params,
  ) {
    return _repository.getCashFlowStatements(
      params.ticker,
      period: params.period,
    );
  }
}
