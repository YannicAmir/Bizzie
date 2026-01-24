import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/widgets/tables/bizzie_data_table.dart';
import 'package:bizzie/shared/utils/bizzie_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum FinancialDateFormat { period, fullDate, monthYear, quarterShort }

class FinancialDataTable extends StatelessWidget {
  final List<FinancialDataPoint> data;
  final String title;
  final String metricLabel;
  final String currency;
  final VoidCallback? onViewMore;
  final int? limit;
  final bool isInverseGrowth;
  final bool isPercentage;
  final bool isNeutralColor;
  final FinancialDateFormat dateFormat;
  final String? periodHeaderLabel;

  const FinancialDataTable({
    super.key,
    required this.data,
    this.title = 'Table',
    required this.metricLabel,
    required this.currency,
    this.onViewMore,
    this.limit = 5,
    this.isInverseGrowth = false,
    this.isPercentage = false,
    this.isNeutralColor = false,
    this.dateFormat = FinancialDateFormat.period,
    this.periodHeaderLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final sortedData = List<FinancialDataPoint>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));

    final displayData = limit != null
        ? sortedData.take(limit!).toList()
        : sortedData;

    return BizzieDataTable(
      title: title,
      header: FinancialTableHeader(
        metricLabel: metricLabel,
        dateFormat: dateFormat,
        periodHeaderLabel: periodHeaderLabel,
      ),
      onViewMore: (limit != null && sortedData.length > limit!)
          ? onViewMore
          : null,
      viewMoreLabel: 'View All',
      children: [
        for (final (index, item) in displayData.indexed)
          FinancialTableRow(
            item: item,
            index: index,
            allData: sortedData,
            currency: currency,
            isInverseGrowth: isInverseGrowth,
            isPercentage: isPercentage,
            isNeutralColor: isNeutralColor,
            dateFormat: dateFormat,
          ),
      ],
    );
  }

  static Widget _buildGrowthCell(
    double? growth,
    bool isInverseGrowth,
    bool isNeutralColor,
  ) {
    if (growth == null) {
      return Text(
        '-',
        textAlign: TextAlign.right,
        style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.slate500),
      );
    }

    final isPositive = growth > 0;
    final isNegative = growth < 0;

    final Color color;
    if (isNeutralColor) {
      color = AppColors.textPrimary;
    } else if (isInverseGrowth) {
      color = isPositive
          ? AppColors.red800
          : isNegative
          ? AppColors.green700
          : AppColors.textPrimary;
    } else {
      color = isPositive
          ? AppColors.green700
          : isNegative
          ? AppColors.red800
          : AppColors.textPrimary;
    }

    final sign = isPositive ? '+' : '';
    final percentVal = (growth * 100);
    final fmt = NumberFormat("0.0", "en_US");

    return Text(
      '$sign${fmt.format(percentVal)}%',
      textAlign: TextAlign.right,
      style: AppTextStyles.bodyMediumBold.copyWith(color: color),
    );
  }

  static String _formatCurrency(
    BuildContext context,
    double value,
    String currency,
    bool isPercentage,
  ) {
    if (isPercentage) {
      // Assuming value is 0.15 for 15%
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

    // If currency is empty, use compact pattern for simpler reading (e.g. 15.13B)
    if (currency.isEmpty) {
      final compactFmt = NumberFormat.compact(
        locale: Localizations.localeOf(context).toString(),
      );
      compactFmt.maximumFractionDigits = 2;
      return compactFmt.format(value);
    }

    return fmt.format(value);
  }

  static String _formatDate(
    String dateStr,
    FinancialDateFormat format,
    String? period,
  ) {
    try {
      final dt = DateTime.parse(dateStr);
      switch (format) {
        case FinancialDateFormat.fullDate:
          return BizzieDateFormatter.formatMonthYearFull(dateStr);
        case FinancialDateFormat.monthYear:
          return BizzieDateFormatter.formatMonthYearFull(dateStr);
        case FinancialDateFormat.quarterShort:
          String quarter = '';
          if (period != null && period.startsWith('Q')) {
            quarter = period;
          } else {
            int q = ((dt.month - 1) / 3).floor() + 1;
            quarter = 'Q$q';
          }
          return "$quarter | ${BizzieDateFormatter.formatMonthYearFull(dateStr)}";
        case FinancialDateFormat.period:
          return _formatPeriod(dateStr, period);
      }
    } catch (_) {
      return dateStr;
    }
  }

  static String _formatPeriod(String date, String? period) {
    try {
      final dt = DateTime.parse(date);
      if (period == 'FY' || period == 'annual') {
        return dt.year.toString();
      }
      if (period != null && period.startsWith('Q')) {
        return '$period ${dt.year}';
      }
      return dt.year.toString();
    } catch (_) {
      return date;
    }
  }
}

class FinancialTableHeader extends StatelessWidget {
  final String metricLabel;
  final FinancialDateFormat dateFormat;
  final String? periodHeaderLabel;

  const FinancialTableHeader({
    super.key,
    required this.metricLabel,
    required this.dateFormat,
    this.periodHeaderLabel,
  });

  @override
  Widget build(BuildContext context) {
    String periodTitle = periodHeaderLabel ?? 'Period';
    if (periodHeaderLabel == null &&
        dateFormat == FinancialDateFormat.fullDate) {
      periodTitle = 'Date';
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            periodTitle,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            metricLabel,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Change',
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
      ],
    );
  }
}

class FinancialTableRow extends StatelessWidget {
  final FinancialDataPoint item;
  final int index;
  final List<FinancialDataPoint> allData;
  final String currency;
  final bool isInverseGrowth;
  final bool isPercentage;
  final bool isNeutralColor;
  final FinancialDateFormat dateFormat;

  const FinancialTableRow({
    super.key,
    required this.item,
    required this.index,
    required this.allData,
    required this.currency,
    this.isInverseGrowth = false,
    this.isPercentage = false,
    this.isNeutralColor = false,
    this.dateFormat = FinancialDateFormat.period,
  });

  @override
  Widget build(BuildContext context) {
    double? growth;
    if (index + 1 < allData.length) {
      final prevItem = allData[index + 1];
      if (prevItem.value != 0) {
        growth = (item.value - prevItem.value) / prevItem.value.abs();
      }
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            FinancialDataTable._formatDate(item.date, dateFormat, item.period),
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            FinancialDataTable._formatCurrency(
              context,
              item.value,
              currency,
              isPercentage,
            ),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 2,
          child: FinancialDataTable._buildGrowthCell(
            growth,
            isInverseGrowth,
            isNeutralColor,
          ),
        ),
      ],
    );
  }
}
