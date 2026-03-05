import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import '../interfaces/i_financial_statements_repository.dart';
import '../models/balance_sheet.dart';
import '../models/get_financial_statement_params.dart';

@lazySingleton
class GetBalanceSheetsUseCase
    implements
        UseCase<
          Either<Failure, (List<BalanceSheet>, CompanyProfileDataOrigin)>,
          GetFinancialStatementParams
        > {
  final IFinancialStatementsRepository _repository;

  GetBalanceSheetsUseCase(this._repository);

  @override
  Future<Either<Failure, (List<BalanceSheet>, CompanyProfileDataOrigin)>> call(
    GetFinancialStatementParams params,
  ) {
    return _repository.getBalanceSheets(params.ticker, period: params.period);
  }
}
