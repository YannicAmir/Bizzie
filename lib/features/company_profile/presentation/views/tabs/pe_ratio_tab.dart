import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_state.dart';
import 'package:bizzie/features/company_profile/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_table_footer.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/metric_summary_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PeRatioTab extends StatelessWidget {
  final String ticker;

  const PeRatioTab({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyPeRatioBloc, CompanyPeRatioState>(
      builder: (context, state) {
        return state.when(
          initial: () =>
              const CompanyProfileLoadingState(message: 'Loading P/E ratio'),
          loading: () =>
              const CompanyProfileLoadingState(message: 'Loading P/E ratio'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading P/E ratio',
            onRetry: () => context.read<CompanyPeRatioBloc>().add(
              CompanyPeRatioEvent.loadRequested(ticker, forceRefresh: true),
            ),
          ),
          loaded:
              (
                dataPoints,
                chartData,
                currentValue,
                growthPercentage,
                absoluteDelta,
                isPositive,
                referenceLabel,
                lastUpdated,
              ) => _PeRatioLoadedContent(
                dataPoints: dataPoints,
                chartData: chartData,
                currentValue: currentValue,
                growthPercentage: growthPercentage,
                absoluteDelta: absoluteDelta,
                isPositive: isPositive,
                referenceLabel: referenceLabel,
                ticker: ticker,
                lastUpdated: lastUpdated,
              ),
        );
      },
    );
  }
}

class _PeRatioLoadedContent extends StatelessWidget {
  final List<FinancialDataPoint> dataPoints;
  final List<ChartDataPoint> chartData;
  final double currentValue;
  final double growthPercentage;
  final double absoluteDelta;
  final bool isPositive;
  final String referenceLabel;
  final String ticker;
  final DateTime? lastUpdated;

  const _PeRatioLoadedContent({
    required this.dataPoints,
    required this.chartData,
    required this.currentValue,
    required this.growthPercentage,
    required this.absoluteDelta,
    required this.isPositive,
    required this.referenceLabel,
    required this.ticker,
    this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: const BizzieEmptyState(
          mascotAsset: AppAssets.defaultMascot,
          message: 'No P/E ratio data available',
        ),
      );
    }

    final asOfPrefix = dataPoints.getAsOfPrefix(lastUpdated);
    final dynamicAvg = dataPoints.getDynamicAverageColumn('P/E Ratio');

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MetricSummaryCard(
            title: 'P/E Ratio',
            value: currentValue.formattedRatioValue,
            badgeText: growthPercentage.formattedRatioBadge,
            badgeStyle: AppBadgeStyle.neutral,
            subtitle: MetricSummarySubtitleHelper.getSubtitle(
              asOfPrefix: asOfPrefix,
              isPositive: isPositive,
              absoluteDelta: absoluteDelta,
              referenceLabel: referenceLabel,
            ),
          ),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            key: ValueKey('pe_chart_${chartData.length}'),
            data: chartData
                .map((p) => BizzieChartData(p.label, p.value))
                .toList(),
            numberFormat: NumberFormat('#,##0.00', 'en_US'),
          ),
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: dataPoints,
            metricLabel: 'P/E',
            currency: '',
            isNeutralColor: true,
            dateFormat: FinancialDateFormat.fullDate,
            onViewMore: () => _showAllHistory(context, dataPoints),
            footer: FinancialTableFooter(
              columns: [
                FinancialTableFooterColumnData(
                  label: 'Avg. P/E Ratio',
                  value: dataPoints.averageValue.formattedRatioValue,
                ),
                if (dynamicAvg != null)
                  FinancialTableFooterColumnData(
                    label: dynamicAvg.label,
                    value: dynamicAvg.value,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAllHistory(BuildContext context, List<FinancialDataPoint> data) {
    final sortedData = List<FinancialDataPoint>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));

    AppHistoryModalHelper.show<FinancialDataPoint>(
      context: context,
      title: 'P/E Ratio History',
      header: const FinancialTableHeader(
        metricLabel: 'P/E',
        dateFormat: FinancialDateFormat.fullDate,
      ),
      data: sortedData,
      itemBuilder: (context, item, index) => FinancialTableRow(
        item: item,
        index: index,
        allData: sortedData,
        currency: '',
        isInverseGrowth: false,
        isNeutralColor: true,
        dateFormat: FinancialDateFormat.fullDate,
      ),
    );
  }
}
