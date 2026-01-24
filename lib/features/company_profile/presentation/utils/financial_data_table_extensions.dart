import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FinancialDataPointPresentationX on FinancialDataPoint {
  String formatCurrency({
    required BuildContext context,
    required String currency,
    required bool isPercentage,
  }) {
    if (isPercentage) {
      final fmt = NumberFormat.percentPattern(
        Localizations.localeOf(context).toString(),
      );
      fmt.maximumFractionDigits = 2;
      return fmt.format(value);
    }

    final fmt = NumberFormat.compactSimpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      name: currency,
    );
    fmt.maximumFractionDigits = 2;
    fmt.minimumFractionDigits = 2;

    if (currency.isEmpty) {
      final compactFmt = NumberFormat.compact(
        locale: Localizations.localeOf(context).toString(),
      );
      compactFmt.maximumFractionDigits = 2;
      return compactFmt.format(value);
    }

    return fmt.format(value);
  }

  String formatDate(FinancialDateFormat format) {
    try {
      final dt = DateTime.parse(date);
      switch (format) {
        case FinancialDateFormat.fullDate:
        case FinancialDateFormat.monthYear:
          return BizzieDateFormatter.formatMonthYearFull(date);
        case FinancialDateFormat.quarterShort:
          String quarterStr = '';
          if (period.isNotEmpty && period.startsWith('Q')) {
            quarterStr = period;
          } else {
            int q = ((dt.month - 1) / 3).floor() + 1;
            quarterStr = 'Q$q';
          }
          return "$quarterStr | ${BizzieDateFormatter.formatMonthYearFull(date)}";
        case FinancialDateFormat.period:
          return _formatPeriod();
      }
    } catch (_) {
      return date;
    }
  }

  String _formatPeriod() {
    try {
      final dt = DateTime.parse(date);
      if (period == 'FY' || period == 'annual') {
        return dt.year.toString();
      }
      if (period.isNotEmpty && period.startsWith('Q')) {
        return '$period ${dt.year}';
      }
      return dt.year.toString();
    } catch (_) {
      return date;
    }
  }
}

extension FinancialDataPointListPresentationX on List<FinancialDataPoint> {
  double? calculateGrowthAtIndex(int index) {
    if (index + 1 >= length) return null;
    final current = this[index];
    final previous = this[index + 1];
    if (previous.value == 0) return null;
    return (current.value - previous.value) / previous.value.abs();
  }
}

extension GrowthPresentationX on double? {
  String get formattedPercent {
    final value = this;
    if (value == null) return '-';
    final sign = value > 0 ? '+' : '';
    final percentVal = value * 100;
    final fmt = NumberFormat("0.0", "en_US");
    return '$sign${fmt.format(percentVal)}%';
  }

  Color getGrowthColor({
    required BuildContext context,
    required bool isInverse,
    required bool isNeutral,
  }) {
    final value = this;
    if (value == null) return AppColors.slate500;
    if (isNeutral || value == 0) return AppColors.textPrimary;

    final isPositive = value > 0;

    if (isInverse) {
      return isPositive ? AppColors.criticalText : AppColors.goodText;
    }
    return isPositive ? AppColors.goodText : AppColors.criticalText;
  }
}
