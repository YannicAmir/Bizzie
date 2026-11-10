import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/features/company_profile/security/presentation/models/security_price_summary.dart';
import 'package:bizzie/features/company_profile/security/presentation/utils/security_quote_presentation_extensions.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';

extension SecurityQuotePriceSummaryX on SecurityQuote {
  SecurityPriceSummary toPriceSummary() => SecurityPriceSummary(
    priceFormatted: priceFormatted,
    price: price,
    changeFormatted: changeFormatted,
    isPositiveChange: hasPositiveChange,
    sessionDate: sessionDate,
  );
}

extension HistoricalPriceEodPriceSummaryX on List<HistoricalPriceEod> {
  SecurityPriceSummary toPriceSummary() {
    final latestPrice = firstOrNull?.price;
    return SecurityPriceSummary(
      priceFormatted: latestPrice == null
          ? '--'
          : CurrencyFormatter.format(latestPrice, null),
      price: latestPrice,
      changeFormatted: _changeFormatted,
      isPositiveChange: _isPositiveChange,
      sessionDate: firstOrNull?.date ?? '',
    );
  }

  String get _changeFormatted {
    if (length < 2) return '--';
    final latest = this[0];
    final previous = this[1];
    final change = latest.price - previous.price;
    final percent = (change / previous.price) * 100;
    final isPositive = change >= 0;
    final sign = isPositive ? '+' : '';
    final formattedChange = CurrencyFormatter.format(change, null);
    return '$sign$formattedChange ($sign${percent.toStringAsFixed(2)}%)';
  }

  bool get _isPositiveChange {
    if (length < 2) return true;
    return (this[0].price - this[1].price) >= 0;
  }
}
