import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:intl/intl.dart';

extension HistoricalPriceEodStateX on HistoricalPriceEodState {
  bool get isLoading =>
      maybeMap(initial: (_) => true, loading: (_) => true, orElse: () => false);

  String get currentPriceFormatted => maybeMap(
    loaded: (state) => _formatPrice(state.prices.firstOrNull?.price),
    orElse: () => '--',
  );

  String get changeFormatted => maybeMap(
    loaded: (state) {
      if (state.prices.length < 2) return '--';
      final latest = state.prices[0];
      final previous = state.prices[1];
      final change = latest.price - previous.price;
      final percent = (change / previous.price) * 100;
      final isPositive = change >= 0;
      final sign = isPositive ? '+' : '';
      final currencyFormat = NumberFormat.simpleCurrency();
      return '$sign${currencyFormat.format(change)} ($sign${percent.toStringAsFixed(2)}%)';
    },
    orElse: () => '--',
  );

  bool get isPositiveChange => maybeMap(
    loaded: (state) {
      if (state.prices.length < 2) return true;
      return (state.prices[0].price - state.prices[1].price) >= 0;
    },
    orElse: () => true,
  );

  String get lastUpdatedDate => maybeMap(
    loaded: (state) => state.prices.firstOrNull?.date ?? '',
    orElse: () => '',
  );

  static String _formatPrice(double? price) {
    if (price == null) return '--';
    return NumberFormat.simpleCurrency().format(price);
  }
}
