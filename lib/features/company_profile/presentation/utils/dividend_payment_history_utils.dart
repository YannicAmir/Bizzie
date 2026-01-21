import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/dividend_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DividendPaymentHistoryUtils {
  static (String, Color) calculateChange(
    DividendEvent event,
    DividendEvent? previousEvent,
  ) {
    if (previousEvent == null || previousEvent.dividend <= 0) {
      return ('+0.0%', AppColors.goodText);
    }

    final change =
        ((event.dividend - previousEvent.dividend) / previousEvent.dividend) *
        100;
    final sign = change >= 0 ? '+' : '';
    final changeStr = '$sign${change.toStringAsFixed(1)}%';
    final changeColor = change >= 0
        ? AppColors.goodText
        : AppColors.criticalText;

    return (changeStr, changeColor);
  }

  static String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
