import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_dtos.freezed.dart';
part 'market_dtos.g.dart';

// Dividends
@freezed
abstract class DividendDto with _$DividendDto {
  const factory DividendDto({
    required String date,
    double? dividend,
    double? adjDividend,
    String? recordDate,
    String? paymentDate,
    String? declarationDate,
    double? yield,
    String? frequency,
  }) = _DividendDto;

  factory DividendDto.fromJson(Map<String, dynamic> json) =>
      _$DividendDtoFromJson(json);
}

// News
@freezed
abstract class NewsDto with _$NewsDto {
  const factory NewsDto({
    required String symbol,
    required String publishedDate,
    required String title,
    String? image,
    required String site,
    required String url,
    String? text,
  }) = _NewsDto;

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
}

// Historical Price
@freezed
abstract class HistoricalPriceDto with _$HistoricalPriceDto {
  const factory HistoricalPriceDto({
    required String date,
    double? price,
    double? close,
    double? volume,
  }) = _HistoricalPriceDto;

  factory HistoricalPriceDto.fromJson(Map<String, dynamic> json) =>
      _$HistoricalPriceDtoFromJson(json);
}
