import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/security_quote/security_quote_state.dart';

extension SecurityQuoteStateX on SecurityQuoteState {
  SecurityQuote? get quote =>
      maybeMap(loaded: (state) => state.quote, orElse: () => null);
}
