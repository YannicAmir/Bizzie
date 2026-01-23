import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';

extension IncomeStatementPresentationX on IncomeStatement {
  String get formattedPeriod {
    final dateObj = DateTime.tryParse(date);
    if (period.isNotEmpty) {
      return dateObj != null ? '$period | ${dateObj.year}' : period;
    }
    return dateObj?.year.toString() ?? date;
  }
}

extension BalanceSheetPresentationX on BalanceSheet {
  String get formattedPeriod {
    final dateObj = DateTime.tryParse(date);
    if (period.isNotEmpty) {
      return dateObj != null ? '$period | ${dateObj.year}' : period;
    }
    return dateObj?.year.toString() ?? date;
  }
}

extension CashFlowStatementPresentationX on CashFlowStatement {
  String get formattedPeriod {
    final dateObj = DateTime.tryParse(date);
    if (period.isNotEmpty) {
      return dateObj != null ? '$period | ${dateObj.year}' : period;
    }
    return dateObj?.year.toString() ?? date;
  }
}
