import 'package:dartz/dartz.dart';
import 'package:bizzie/core/error/failures.dart';

import 'package:bizzie/features/company_profile/domain/models/full_financials.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';

abstract class IFinancialRepository {
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
