import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const int _maxFractionDigits = 2;
const int _monthsPerQuarter = 3;
const int _percentMultiplier = 100;
const String _growthPercentPattern = '0.0';

extension FinancialDataPointPresentationX on FinancialDataPoint {
  String formatCurrency({
    required BuildContext context,
    required String currency,
    required bool isPercentage,
  }) {
    if (isPercentage) {
      final percentFormat = NumberFormat.percentPattern(
        Localizations.localeOf(context).toString(),
      );
      percentFormat.maximumFractionDigits = _maxFractionDigits;
      return percentFormat.format(value);
    }

    if (currency.isEmpty) {
      final compactFormat = NumberFormat.compact(
        locale: Localizations.localeOf(context).toString(),
      );
      compactFormat.maximumFractionDigits = _maxFractionDigits;
      return compactFormat.format(value);
    }

    return CurrencyFormatter.formatCompactFixed(
      value,
      currency,
      locale: Localizations.localeOf(context).toString(),
    );
  }

  String formatDate(FinancialDateFormat format) {
    try {
      final parsedDate = DateTime.parse(date);
      switch (format) {
        case FinancialDateFormat.fullDate:
        case FinancialDateFormat.monthYear:
          return BizzieDateFormatter.formatMonthYearFull(date);
        case FinancialDateFormat.quarterShort:
          final quarter = period.isNotEmpty && period.startsWith('Q')
              ? period
              : 'Q${((parsedDate.month - 1) / _monthsPerQuarter).floor() + 1}';
          return '$quarter | ${BizzieDateFormatter.formatMonthYearFull(date)}';
        case FinancialDateFormat.period:
          return _formatPeriod();
      }
    } on FormatException catch (_) {
      return date;
    }
  }

  String _formatPeriod() {
    try {
      final parsedDate = DateTime.parse(date);
      if (period == 'FY' || period == 'annual') {
        return parsedDate.year.toString();
      }
      if (period.isNotEmpty && period.startsWith('Q')) {
        return '$period ${parsedDate.year}';
      }
      return parsedDate.year.toString();
    } on FormatException catch (_) {
      return date;
    }
  }
}

enum GrowthOutcome {
  none,
  numeric,
  turnedPositive,
  turnedNegative,
  notMeaningful,
}

class QuarterlyGrowth {
  final GrowthOutcome outcome;
  final double? percent;

  const QuarterlyGrowth._(this.outcome, [this.percent]);

  static const none = QuarterlyGrowth._(GrowthOutcome.none);
  static const turnedPositive =
      QuarterlyGrowth._(GrowthOutcome.turnedPositive);
  static const turnedNegative =
      QuarterlyGrowth._(GrowthOutcome.turnedNegative);
  static const notMeaningful =
      QuarterlyGrowth._(GrowthOutcome.notMeaningful);

  factory QuarterlyGrowth.numeric(double percent) =>
      QuarterlyGrowth._(GrowthOutcome.numeric, percent);
}

extension FinancialDataPointListPresentationX on List<FinancialDataPoint> {
  QuarterlyGrowth calculateGrowthAtIndex(int index) {
    if (index + 1 >= length) return QuarterlyGrowth.none;

    final current = this[index].value;
    final previous = this[index + 1].value;

    if (previous == 0) return QuarterlyGrowth.none;

    final previousIsProfit = previous > 0;
    final currentIsProfit = current >= 0;

    if (previousIsProfit && currentIsProfit) {
      return QuarterlyGrowth.numeric((current - previous) / previous);
    }
    if (previousIsProfit && !currentIsProfit) {
      return QuarterlyGrowth.turnedNegative;
    }
    if (!previousIsProfit && currentIsProfit) {
      return QuarterlyGrowth.turnedPositive;
    }
    return QuarterlyGrowth.notMeaningful;
  }
}

extension GrowthPresentationX on QuarterlyGrowth {
  String formattedPercent(BuildContext context) {
    switch (outcome) {
      case GrowthOutcome.none:
        return '-';
      case GrowthOutcome.numeric:
        final percentValue = percent;
        if (percentValue == null) return '-';
        final scaledPercent = percentValue * _percentMultiplier;
        final sign = scaledPercent > 0 ? '+' : '';
        final format = NumberFormat(
          _growthPercentPattern,
          Localizations.localeOf(context).toString(),
        );
        return '$sign${format.format(scaledPercent)}%';
      case GrowthOutcome.turnedPositive:
        return 'Pos.';
      case GrowthOutcome.turnedNegative:
        return 'Neg.';
      case GrowthOutcome.notMeaningful:
        return 'N/M';
    }
  }

  Color getGrowthColor({
    required BuildContext context,
    required bool isInverse,
    required bool isNeutral,
  }) {
    switch (outcome) {
      case GrowthOutcome.none:
        return AppColors.slate500;
      case GrowthOutcome.notMeaningful:
        return AppColors.textSecondary;
      case GrowthOutcome.numeric:
        final value = percent;
        if (value == null) return AppColors.textPrimary;
        if (isNeutral || value == 0) return AppColors.textPrimary;
        final isPositive = value > 0;
        if (isInverse) {
          return isPositive ? AppColors.criticalText : AppColors.goodText;
        }
        return isPositive ? AppColors.goodText : AppColors.criticalText;
      case GrowthOutcome.turnedPositive:
        if (isNeutral) return AppColors.textPrimary;
        return isInverse ? AppColors.criticalText : AppColors.goodText;
      case GrowthOutcome.turnedNegative:
        if (isNeutral) return AppColors.textPrimary;
        return isInverse ? AppColors.goodText : AppColors.criticalText;
    }
  }
}
