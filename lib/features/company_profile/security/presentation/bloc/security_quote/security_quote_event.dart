import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_quote_event.freezed.dart';

@freezed
sealed class SecurityQuoteEvent with _$SecurityQuoteEvent {
  const factory SecurityQuoteEvent.loadRequested(String ticker) = LoadRequested;

  const factory SecurityQuoteEvent.reset() = Reset;
}
