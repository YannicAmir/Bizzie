import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/chart_data_point_list_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/currency_metric_labels.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_history_modal_helper.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_period_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_conversion_notice.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_switch.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyMetricTabContent extends StatelessWidget {
  final FinancialPeriod period;
  final List<ChartDataPoint> chartData;
  final List<FinancialDataPoint> annualData;
  final List<FinancialDataPoint> quarterlyData;
  final String currency;
  final String? originalCurrency;
  final int historyLimit;
  final CurrencyMetricLabels labels;
  final ValueChanged<FinancialPeriod> onPeriodChanged;
  final VoidCallback onChartAnalyticsTap;
  final VoidCallback onTableAnalyticsTap;
  final Widget Function(Widget child)? highlightsBuilder;

  const CurrencyMetricTabContent({
    super.key,
    required this.period,
    required this.chartData,
    required this.annualData,
    required this.quarterlyData,
    required this.currency,
    this.originalCurrency,
    required this.historyLimit,
    required this.labels,
    required this.onPeriodChanged,
    required this.onChartAnalyticsTap,
    required this.onTableAnalyticsTap,
    this.highlightsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final data = switch (period) {
      FinancialPeriod.annual => annualData,
      FinancialPeriod.quarterly => quarterlyData,
    };
    final highlights = FinancialHighlightsSection(
      annualData: annualData,
      quarterlyData: quarterlyData,
      ttmTitle: labels.ttmTitle,
      currency: currency,
      period: period,
    );

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PeriodSwitch(period: period, onPeriodChanged: onPeriodChanged),
          CurrencyConversionNotice(
            originalCurrency: originalCurrency,
            displayedCurrency: currency,
          ),
          BizzieExpandableChart(
            key: ValueKey('${labels.chartKeyPrefix}_${period.isAnnual}'),
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
          highlightsBuilder?.call(highlights) ?? highlights,
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: data,
            metricLabel: labels.metricLabel,
            currency: currency,
            periodHeaderLabel: period.tableHeaderLabel,
            dateFormat: period.tableDateFormat,
            onAnalyticsTap: onTableAnalyticsTap,
            onViewMore: () => FinancialHistoryModalHelper.show(
              context,
              title: period.historyTitle(labels.metricLabel),
              data: data,
              metricLabel: labels.modalMetricLabel ?? labels.metricLabel,
              currency: currency,
              period: period,
            ),
            limit: historyLimit,
            source: PaywallSource.company_profile,
          ),
        ],
      ),
    );
  }
}
