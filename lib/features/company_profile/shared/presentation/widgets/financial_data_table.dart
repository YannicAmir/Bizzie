import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_data_table_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';
import 'package:bizzie/shared/widgets/tables/bizzie_data_table.dart';
import 'package:flutter/material.dart';

export 'package:bizzie/features/company_profile/shared/presentation/enums/financial_table_enums.dart';

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
  final Widget? footer;

  const FinancialDataTable({
    super.key,
    required this.data,
    this.title = 'Table',
    required this.metricLabel,
    required this.currency,
    this.onViewMore,
    required this.limit,
    this.isInverseGrowth = false,
    this.isPercentage = false,
    this.isNeutralColor = false,
    this.dateFormat = FinancialDateFormat.period,
    this.periodHeaderLabel,
    this.footer,
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
      footer: footer,
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
    final growth = allData.calculateGrowthAtIndex(index);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            item.formatDate(dateFormat),
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            item.formatCurrency(
              context: context,
              currency: currency,
              isPercentage: isPercentage,
            ),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 2,
          child: _GrowthCell(
            growth: growth,
            isInverseGrowth: isInverseGrowth,
            isNeutralColor: isNeutralColor,
          ),
        ),
      ],
    );
  }
}

class _GrowthCell extends StatelessWidget {
  final double? growth;
  final bool isInverseGrowth;
  final bool isNeutralColor;

  const _GrowthCell({
    required this.growth,
    required this.isInverseGrowth,
    required this.isNeutralColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      growth.formattedPercent,
      textAlign: TextAlign.right,
      style: AppTextStyles.bodyMediumBold.copyWith(
        color: growth.getGrowthColor(
          context: context,
          isInverse: isInverseGrowth,
          isNeutral: isNeutralColor,
        ),
      ),
    );
  }
}
