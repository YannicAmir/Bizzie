import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_sheet_dto.freezed.dart';
part 'balance_sheet_dto.g.dart';

@freezed
abstract class BalanceSheetDto with _$BalanceSheetDto {
  const factory BalanceSheetDto({
    String? date,
    String? symbol,
    String? reportedCurrency,
    String? cik,
    String? fillingDate,
    String? acceptedDate,
    String? calendarYear,
    String? period,
    double? totalAssets,
    double? totalLiabilities,
    double? totalEquity,
    double? totalCurrentAssets,
    double? totalNonCurrentAssets,
    double? totalCurrentLiabilities,
    double? totalNonCurrentLiabilities,
    double? longTermDebt,
    double? shortTermDebt,
    double? cashAndShortTermInvestments,
    double? netDebt,
    double? totalDebt,
  }) = _BalanceSheetDto;

  const BalanceSheetDto._();

  factory BalanceSheetDto.fromJson(Map<String, dynamic> json) =>
      _$BalanceSheetDtoFromJson(json);

  BalanceSheet toDomain({double multiplier = 1.0, String? targetCurrency}) {
    return BalanceSheet(
      date: date ?? '',
      symbol: symbol ?? '',
      reportedCurrency: targetCurrency ?? reportedCurrency ?? '',
      period: period ?? '',
      totalAssets: (totalAssets ?? 0) * multiplier,
      totalLiabilities: (totalLiabilities ?? 0) * multiplier,
      totalEquity: (totalEquity ?? 0) * multiplier,
      cashAndShortTermInvestments:
          (cashAndShortTermInvestments ?? 0) * multiplier,
      totalDebt: (totalDebt ?? 0) * multiplier,
      totalCurrentAssets: (totalCurrentAssets ?? 0) * multiplier,
      totalNonCurrentAssets: (totalNonCurrentAssets ?? 0) * multiplier,
      totalCurrentLiabilities: (totalCurrentLiabilities ?? 0) * multiplier,
      totalNonCurrentLiabilities:
          (totalNonCurrentLiabilities ?? 0) * multiplier,
      longTermDebt: (longTermDebt ?? 0) * multiplier,
      shortTermDebt: (shortTermDebt ?? 0) * multiplier,
    );
  }
}
