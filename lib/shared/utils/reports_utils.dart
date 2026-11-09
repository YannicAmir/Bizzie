import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:intl/intl.dart';

String formatReportCurrency(double value, String currencyCode) {
  return CurrencyFormatter.formatCompact(value, currencyCode);
}

String formatReportPercentage(double value) {
  final formatter = NumberFormat.decimalPattern();
  formatter.minimumFractionDigits = 2;
  formatter.maximumFractionDigits = 2;

  final formatted = formatter.format(value.abs());
  final sign = value >= 0 ? '+' : '-';
  return '$sign$formatted%';
}
