import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:equatable/equatable.dart';

class FullFinancials extends Equatable {
  final List<IncomeStatement> annualIncomeStatements;
  final List<IncomeStatement> quarterlyIncomeStatements;
  final List<BalanceSheet> annualBalanceSheets;
  final List<BalanceSheet> quarterlyBalanceSheets;
  final List<CashFlowStatement> annualCashFlows;
  final List<CashFlowStatement> quarterlyCashFlows;

  const FullFinancials({
    required this.annualIncomeStatements,
    required this.quarterlyIncomeStatements,
    required this.annualBalanceSheets,
    required this.quarterlyBalanceSheets,
    required this.annualCashFlows,
    required this.quarterlyCashFlows,
  });

  @override
  List<Object?> get props => [
    annualIncomeStatements,
    quarterlyIncomeStatements,
    annualBalanceSheets,
    quarterlyBalanceSheets,
    annualCashFlows,
    quarterlyCashFlows,
  ];
}
