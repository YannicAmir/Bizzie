import 'package:intl/intl.dart';

String formatReportCurrency(double value, String currencyCode) {
  final simple = NumberFormat.simpleCurrency(name: currencyCode);
  final symbol = simple.currencySymbol;
  return NumberFormat.compactCurrency(symbol: symbol).format(value);
}

String formatReportPercentage(double value) {
  final formatter = NumberFormat.decimalPattern();
  formatter.minimumFractionDigits = 2;
  formatter.maximumFractionDigits = 2;

  final formatted = formatter.format(value.abs());
  final sign = value >= 0 ? '+' : '-';
  return '$sign$formatted%';
}
