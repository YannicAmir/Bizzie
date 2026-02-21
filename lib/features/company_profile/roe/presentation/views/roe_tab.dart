import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../bloc/company_roe_bloc.dart';
import '../bloc/company_roe_event.dart';
import '../bloc/company_roe_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/metric_summary_card.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../extensions/roe_presentation_helper.dart';

class RoeTab extends StatefulWidget {
  final String ticker;

  const RoeTab({super.key, required this.ticker});

  @override
  State<RoeTab> createState() => _RoeTabState();
}

class _RoeTabState extends State<RoeTab> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyRoeBloc>().add(
      CompanyRoeEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyRoeBloc, CompanyRoeState>(
      builder: (context, state) {
        return state.when(
          initial: () =>
              const CompanyProfileLoadingState(message: 'Loading ROE'),
          loading: () =>
              const CompanyProfileLoadingState(message: 'Loading ROE'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading ROE',
            onRetry: () => context.read<CompanyRoeBloc>().add(
              CompanyRoeEvent.loadRequested(widget.ticker, forceRefresh: true),
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
                historyLimit,
                lastUpdated,
              ) => _RoeLoadedContent(
                dataPoints: dataPoints,
                chartData: chartData,
                currentValue: currentValue,
                growthPercentage: growthPercentage,
                absoluteDelta: absoluteDelta,
                isPositive: isPositive,
                referenceLabel: referenceLabel,
                historyLimit: historyLimit,
                ticker: widget.ticker,
              ),
        );
      },
    );
  }
}

class _RoeLoadedContent extends StatelessWidget {
  final List<FinancialDataPoint> dataPoints;
  final List<ChartDataPoint> chartData;
  final double currentValue;
  final double growthPercentage;
  final double absoluteDelta;
  final bool isPositive;
  final String referenceLabel;
  final int historyLimit;
  final String ticker;

  const _RoeLoadedContent({
    required this.dataPoints,
    required this.chartData,
    required this.currentValue,
    required this.growthPercentage,
    required this.absoluteDelta,
    required this.isPositive,
    required this.referenceLabel,
    required this.historyLimit,
    required this.ticker,
  });

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) {
      return SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: const BizzieEmptyState(
          mascotAsset: AppAssets.defaultMascot,
          message: 'No ROE data available',
        ),
      );
    }

    final summary = RoePresentationHelper.formatSummary(
      currentValue: currentValue,
      growthPercentage: growthPercentage,
      absoluteDelta: absoluteDelta,
      isPositive: isPositive,
      referenceLabel: referenceLabel,
    );

    final chartFormatter = RoePresentationHelper.chartFormatter;

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MetricSummaryCard(
            title: 'Return on Equity (ROE)',
            value: summary.valueStr,
            badgeText: summary.badgeText,
            badgeStyle: summary.badgeStyle,
            subtitle: summary.subtitle,
          ),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            key: ValueKey('roe_chart_${chartData.length}'),
            data: chartData
                .map((p) => BizzieChartData(p.label, p.value))
                .toList(),
            numberFormat: chartFormatter,
            visibleCount: historyLimit,
            thresholdCount: historyLimit,
            source: PaywallSource.company_profile,
          ),
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: dataPoints,
            metricLabel: 'ROE',
            currency: '',
            isPercentage: true,
            dateFormat: FinancialDateFormat.fullDate,
            onViewMore: () => _showAllHistory(context, dataPoints),
            limit: historyLimit,
            source: PaywallSource.company_profile,
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
      title: 'ROE History',
      header: const FinancialTableHeader(
        metricLabel: 'ROE',
        dateFormat: FinancialDateFormat.fullDate,
      ),
      data: sortedData,
      itemBuilder: (context, item, index) => FinancialTableRow(
        item: item,
        index: index,
        allData: sortedData,
        currency: '',
        isInverseGrowth: false,
        isPercentage: true,
        dateFormat: FinancialDateFormat.fullDate,
      ),
    );
  }
}
