import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_quote_state.freezed.dart';

@freezed
abstract class SecurityQuoteState with _$SecurityQuoteState {
  const factory SecurityQuoteState.initial() = _Initial;
  const factory SecurityQuoteState.loading() = _Loading;
  const factory SecurityQuoteState.loaded(SecurityQuote quote) =
      SecurityQuoteLoaded;
  const factory SecurityQuoteState.unavailable() = _Unavailable;
  const factory SecurityQuoteState.failure(Failure failure) = _Failure;
}
