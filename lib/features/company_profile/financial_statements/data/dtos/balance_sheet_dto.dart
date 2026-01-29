import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_sheet_dto.freezed.dart';
part 'balance_sheet_dto.g.dart';

@freezed
abstract class BalanceSheetDto with _$BalanceSheetDto {
  const factory BalanceSheetDto({
    required String date,
    required String symbol,
    required String reportedCurrency,
    required String? cik,
    required String? fillingDate,
    required String? acceptedDate,
    required String? calendarYear,
    required String? period,
    required double? totalAssets,
    required double? totalLiabilities,
    required double? totalEquity,
    required double? totalCurrentAssets,
    required double? totalNonCurrentAssets,
    required double? totalCurrentLiabilities,
    required double? totalNonCurrentLiabilities,
    required double? longTermDebt,
    required double? shortTermDebt,
    required double? cashAndShortTermInvestments,
    required double? netDebt,
    required double? totalDebt,
  }) = _BalanceSheetDto;

  const BalanceSheetDto._();

  factory BalanceSheetDto.fromJson(Map<String, dynamic> json) =>
      _$BalanceSheetDtoFromJson(json);

  BalanceSheet toDomain({double multiplier = 1.0, String? targetCurrency}) {
    return BalanceSheet(
      date: date,
      symbol: symbol,
      reportedCurrency: targetCurrency ?? reportedCurrency,
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
