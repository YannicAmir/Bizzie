import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_quote_dto.freezed.dart';
part 'security_quote_dto.g.dart';

@freezed
abstract class SecurityQuoteDto with _$SecurityQuoteDto {
  const factory SecurityQuoteDto({
    required String ticker,
    required double price,
    double? change,
    double? changePercent,
    required String sessionDate,
  }) = _SecurityQuoteDto;

  const SecurityQuoteDto._();

  factory SecurityQuoteDto.fromJson(Map<String, dynamic> json) =>
      _$SecurityQuoteDtoFromJson(json);

  SecurityQuote toDomain() {
    return SecurityQuote(
      ticker: ticker,
      price: price,
      change: change,
      changePercent: changePercent,
      sessionDate: sessionDate,
    );
  }
}
