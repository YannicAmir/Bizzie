import 'dart:ui';

class FinancialHistoryRowData {
  final String label;
  final String value1;
  final String value2;
  final String value3;
  final Color? value3Color;

  const FinancialHistoryRowData({
    required this.label,
    required this.value1,
    required this.value2,
    required this.value3,
    this.value3Color,
  });
}
