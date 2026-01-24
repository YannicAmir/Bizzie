import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
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

class PfcfRatioTab extends StatelessWidget {
  final String ticker;

  const PfcfRatioTab({super.key, required this.ticker});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      builder: (context, state) {
        return state.when(
          initial: () =>
              const CompanyProfileLoadingState(message: 'Loading P/FCF ratio'),
          loading: () =>
              const CompanyProfileLoadingState(message: 'Loading P/FCF ratio'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading P/FCF ratio',
            onRetry: () => context.read<CompanyPfcfRatioBloc>().add(
              CompanyPfcfRatioEvent.loadRequested(ticker, forceRefresh: true),
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
              ) => _PfcfRatioLoadedContent(
                dataPoints: dataPoints,
                chartData: chartData,
                currentValue: currentValue,
                growthPercentage: growthPercentage,
                absoluteDelta: absoluteDelta,
                isPositive: isPositive,
                referenceLabel: referenceLabel,
                ticker: ticker,
              ),
        );
      },
    );
  }
}

class _PfcfRatioLoadedContent extends StatelessWidget {
  final List<FinancialDataPoint> dataPoints;
  final List<ChartDataPoint> chartData;
  final double currentValue;
  final double growthPercentage;
  final double absoluteDelta;
  final bool isPositive;
  final String referenceLabel;
  final String ticker;

  const _PfcfRatioLoadedContent({
    required this.dataPoints,
    required this.chartData,
    required this.currentValue,
    required this.growthPercentage,
    required this.absoluteDelta,
    required this.isPositive,
    required this.referenceLabel,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: const BizzieEmptyState(
          mascotAsset: AppAssets.defaultMascot,
          message: 'No P/FCF ratio data available',
        ),
      );
    }
    final valueStr = currentValue.toStringAsFixed(2);
    final badgeText =
        '${growthPercentage > 0 ? '+' : ''}${growthPercentage.toStringAsFixed(1)}%';
    const badgeStyle = AppBadgeStyle.neutral;
    final subtitle =
        '${isPositive ? 'Increased' : 'Decreased'} by ${absoluteDelta.toStringAsFixed(2)} since $referenceLabel';

    final chartFormatter = NumberFormat('#,##0.00', 'en_US');

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MetricSummaryCard(
            title: 'P/FCF Ratio',
            value: valueStr,
            badgeText: badgeText,
            badgeStyle: badgeStyle,
            subtitle: subtitle,
          ),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            key: ValueKey('pfcf_chart_${chartData.length}'),
            data: chartData
                .map((p) => BizzieChartData(p.label, p.value))
                .toList(),
            numberFormat: chartFormatter,
          ),
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: dataPoints,
            metricLabel: 'P/FCF',
            currency: '',
            isNeutralColor: true,
            dateFormat: FinancialDateFormat.fullDate,
            onViewMore: () => _showAllHistory(context, dataPoints),
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
      title: 'P/FCF Ratio History',
      header: const FinancialTableHeader(
        metricLabel: 'P/FCF',
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
