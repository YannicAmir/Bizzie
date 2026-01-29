import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/company_profile/shared/domain/models/stock_quote.dart';

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

  const QuoteDto._();

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);

  StockQuote toDomain() {
    return StockQuote(
      symbol: symbol,
      name: name,
      price: price,
      change: change,
      changesPercentage: changesPercentage,
      marketCap: marketCap,
      pe: pe,
      eps: eps,
      volume: volume,
      sharesOutstanding: sharesOutstanding,
    );
  }
}
