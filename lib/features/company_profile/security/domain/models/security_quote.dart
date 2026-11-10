import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_quote.freezed.dart';

@freezed
abstract class SecurityQuote with _$SecurityQuote {
  const factory SecurityQuote({
    required String ticker,
    required double price,
    required double? change,
    required double? changePercent,
    required String sessionDate,
  }) = _SecurityQuote;
}
