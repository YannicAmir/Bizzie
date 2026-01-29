import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_sheet.freezed.dart';

@freezed
abstract class BalanceSheet with _$BalanceSheet {
  const factory BalanceSheet({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String period,
    required double totalAssets,
    required double totalLiabilities,
    required double totalEquity,
    required double cashAndShortTermInvestments,
    required double totalDebt,
    required double totalCurrentAssets,
    required double totalNonCurrentAssets,
    required double totalCurrentLiabilities,
    required double totalNonCurrentLiabilities,
    required double longTermDebt,
    required double shortTermDebt,
  }) = _BalanceSheet;
}
