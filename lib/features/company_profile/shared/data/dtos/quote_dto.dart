import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_dto.freezed.dart';
part 'quote_dto.g.dart';

@freezed
abstract class QuoteDto with _$QuoteDto {
  const factory QuoteDto({
    required String symbol,
    required String name,
    double? price,
    double? change,
    double? changesPercentage,
    double? marketCap,
    double? pe,
    double? eps,
    double? volume,
    double? sharesOutstanding,
  }) = _QuoteDto;

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);
}
