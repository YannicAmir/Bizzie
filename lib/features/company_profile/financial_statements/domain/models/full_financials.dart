import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'full_financials.freezed.dart';

@freezed
abstract class FullFinancials with _$FullFinancials {
  const factory FullFinancials({
    required List<IncomeStatement> annualIncomeStatements,
    required List<IncomeStatement> quarterlyIncomeStatements,
    required List<BalanceSheet> annualBalanceSheets,
    required List<BalanceSheet> quarterlyBalanceSheets,
    required List<CashFlowStatement> annualCashFlows,
    required List<CashFlowStatement> quarterlyCashFlows,
  }) = _FullFinancials;
}
