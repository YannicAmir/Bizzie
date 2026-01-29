import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';
import '../models/full_financials.dart';
import '../models/income_statement.dart';
import '../models/balance_sheet.dart';
import '../models/cash_flow_statement.dart';

abstract class IFinancialStatementsRepository {
  Future<Either<Failure, FullFinancials>> getFullFinancials(String ticker);

  Future<Either<Failure, List<IncomeStatement>>> getIncomeStatements(
    String ticker, {
    String period = 'annual',
  });

  Future<Either<Failure, List<BalanceSheet>>> getBalanceSheets(
    String ticker, {
    String period = 'annual',
  });

  Future<Either<Failure, List<CashFlowStatement>>> getCashFlowStatements(
    String ticker, {
    String period = 'annual',
  });
}
