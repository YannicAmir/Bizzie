import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';

extension IncomeStatementPresentationX on IncomeStatement {
  String get formattedPeriod {
    if (period.isNotEmpty) {
      return '$period | ${BizzieDateFormatter.formatMonthYearFull(date)}';
    }
    return BizzieDateFormatter.formatMonthYearFull(date);
  }
}

extension BalanceSheetPresentationX on BalanceSheet {
  String get formattedPeriod {
    if (period.isNotEmpty) {
      return '$period | ${BizzieDateFormatter.formatMonthYearFull(date)}';
    }
    return BizzieDateFormatter.formatMonthYearFull(date);
  }
}

extension CashFlowStatementPresentationX on CashFlowStatement {
  String get formattedPeriod {
    if (period.isNotEmpty) {
      return '$period | ${BizzieDateFormatter.formatMonthYearFull(date)}';
    }
    return BizzieDateFormatter.formatMonthYearFull(date);
  }
}
