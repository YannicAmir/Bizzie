import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/chart_data_point_list_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_switch.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyMetricTabContent extends StatelessWidget {
  final bool isAnnual;
  final List<ChartDataPoint> chartData;
  final List<FinancialDataPoint> annualData;
  final List<FinancialDataPoint> quarterlyData;
  final String currency;
  final int historyLimit;
  final String metricLabel;
  final String? modalMetricLabel;
  final String ttmTitle;
  final String chartKeyPrefix;
  final ValueChanged<bool> onPeriodChanged;
  final VoidCallback onChartAnalyticsTap;
  final VoidCallback onTableAnalyticsTap;

  const CurrencyMetricTabContent({
    super.key,
    required this.isAnnual,
    required this.chartData,
    required this.annualData,
    required this.quarterlyData,
    required this.currency,
    required this.historyLimit,
    required this.metricLabel,
    this.modalMetricLabel,
    required this.ttmTitle,
    required this.chartKeyPrefix,
    required this.onPeriodChanged,
    required this.onChartAnalyticsTap,
    required this.onTableAnalyticsTap,
  });

  @override
  Widget build(BuildContext context) {
    final data = isAnnual ? annualData : quarterlyData;
    final dateFormat = isAnnual
        ? FinancialDateFormat.monthYear
        : FinancialDateFormat.quarterShort;
    final periodHeaderLabel = isAnnual ? 'Year Ended' : 'Quarter Ended';

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PeriodSwitch(isAnnual: isAnnual, onPeriodChanged: onPeriodChanged),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            key: ValueKey('${chartKeyPrefix}_$isAnnual'),
            data: chartData.toBizzieChartData(),
            numberFormat: NumberFormat.compactSimpleCurrency(
              locale: Localizations.localeOf(context).toString(),
              name: currency,
            ),
            visibleCount: historyLimit,
            thresholdCount: historyLimit,
            source: PaywallSource.company_profile,
            onAnalyticsTap: onChartAnalyticsTap,
          ),
          AppConstants.mainSectionSpacing,
          FinancialHighlightsSection(
            annualData: annualData,
            quarterlyData: quarterlyData,
            ttmTitle: ttmTitle,
            currency: currency,
            isAnnual: isAnnual,
          ),
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: data,
            metricLabel: metricLabel,
            currency: currency,
            periodHeaderLabel: periodHeaderLabel,
            dateFormat: dateFormat,
            onAnalyticsTap: onTableAnalyticsTap,
            onViewMore: () => _showAllHistory(
              context,
              data: data,
              dateFormat: dateFormat,
              periodHeaderLabel: periodHeaderLabel,
            ),
            limit: historyLimit,
            source: PaywallSource.company_profile,
          ),
        ],
      ),
    );
  }

  void _showAllHistory(
    BuildContext context, {
    required List<FinancialDataPoint> data,
    required FinancialDateFormat dateFormat,
    required String periodHeaderLabel,
  }) {
    final sortedData = data.sortedByDateDescending();

    AppHistoryModalHelper.show<FinancialDataPoint>(
      context: context,
      title: isAnnual ? 'Yearly $metricLabel' : 'Quarterly $metricLabel',
      header: FinancialTableHeader(
        metricLabel: modalMetricLabel ?? metricLabel,
        dateFormat: dateFormat,
        periodHeaderLabel: periodHeaderLabel,
      ),
      data: sortedData,
      itemBuilder: (context, item, index) => FinancialTableRow(
        item: item,
        index: index,
        allData: sortedData,
        currency: currency,
        dateFormat: dateFormat,
      ),
    );
  }
}
