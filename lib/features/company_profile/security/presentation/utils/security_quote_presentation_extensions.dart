import 'package:bizzie/features/company_profile/security/domain/models/security_quote.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';

extension SecurityQuotePresentationX on SecurityQuote {
  bool get hasPositiveChange => (changePercent ?? 0) >= 0;

  String get priceFormatted => CurrencyFormatter.format(price, null);

  String get changeFormatted {
    final change = this.change;
    final percent = changePercent;
    if (change == null || percent == null) return '--';
    final sign = hasPositiveChange ? '+' : '';
    return '$sign${CurrencyFormatter.format(change, null)} '
        '($sign${percent.toStringAsFixed(2)}%)';
  }
}
