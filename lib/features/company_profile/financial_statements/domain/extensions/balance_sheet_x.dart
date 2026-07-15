import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';

extension BalanceSheetRatiosX on BalanceSheet {
  double get currentRatio => totalCurrentLiabilities != 0
      ? totalCurrentAssets / totalCurrentLiabilities
      : 0.0;

  double get debtToEquity =>
      totalEquity != 0 ? (longTermDebt + shortTermDebt) / totalEquity : 0.0;
}
