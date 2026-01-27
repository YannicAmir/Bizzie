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

  factory BalanceSheetDto.fromJson(Map<String, dynamic> json) =>
      _$BalanceSheetDtoFromJson(json);
}
