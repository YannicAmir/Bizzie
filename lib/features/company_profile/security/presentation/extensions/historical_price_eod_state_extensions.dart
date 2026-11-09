import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';

extension HistoricalPriceEodStateX on HistoricalPriceEodState {
  bool get isLoading =>
      maybeMap(initial: (_) => true, loading: (_) => true, orElse: () => false);

  List<HistoricalPriceEod> get prices => maybeMap(
    loaded: (state) => state.prices,
    orElse: () => const <HistoricalPriceEod>[],
  );
}
