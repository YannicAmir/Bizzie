import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/extensions/financial_data_point_list_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import '../bloc/company_pe_ratio_bloc.dart';
import '../bloc/company_pe_ratio_event.dart';
import '../bloc/company_pe_ratio_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/metric_summary_presentation_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_table_footer.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/metric_summary_card.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/chart_data_point_list_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../extensions/pe_ratio_presentation_helper.dart';

class PeRatioTab extends StatefulWidget {
  final String ticker;

  const PeRatioTab({super.key, required this.ticker});

  @override
  State<PeRatioTab> createState() => _PeRatioTabState();
}

class _PeRatioTabState extends State<PeRatioTab> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyPeRatioBloc>().add(
      CompanyPeRatioEvent.stalenessCheckRequested(widget.ticker),
    );
  }

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
              CompanyPeRatioEvent.loadRequested(
                widget.ticker,
                forceRefresh: true,
              ),
            ),
          ),
          loaded:
              (
                ticker,
                dataPoints,
                chartData,
                currentValue,
                growthPercentage,
                absoluteDelta,
                isPositive,
                referenceLabel,
                historyLimit,
                dataOrigin,
                loadTimeMs,
                isSuccess,
                lastUpdated,
                analyticsState,
              ) => _PeRatioLoadedContent(
                dataPoints: dataPoints,
                chartData: chartData,
                currentValue: currentValue,
                growthPercentage: growthPercentage,
                absoluteDelta: absoluteDelta,
                isPositive: isPositive,
                referenceLabel: referenceLabel,
                historyLimit: historyLimit,
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
  final int historyLimit;
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
    required this.historyLimit,
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

    final summary = PeRatioPresentationHelper.formatSummary(
      dataPoints: dataPoints,
      currentValue: currentValue,
      growthPercentage: growthPercentage,
      absoluteDelta: absoluteDelta,
      isPositive: isPositive,
      referenceLabel: referenceLabel,
      lastUpdated: lastUpdated,
    );

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.peRatio.analyticsName,
      onTabShown: () => context.read<CompanyPeRatioBloc>().add(
        CompanyPeRatioEvent.tabShown(ticker),
      ),
      onTabHidden: () => context.read<CompanyPeRatioBloc>().add(
        const CompanyPeRatioEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyPeRatioBloc>().add(
        const CompanyPeRatioEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyPeRatioBloc>().add(
        const CompanyPeRatioEvent.appForegrounded(),
      ),
      child: SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MetricSummaryCard(
              title: 'P/E Ratio',
              value: summary.valueStr,
              badgeText: summary.badgeText,
              badgeStyle: summary.badgeStyle,
              subtitle: summary.subtitle,
            ),
            AppConstants.mainSectionSpacing,
            BizzieExpandableChart(
              key: ValueKey('pe_chart_${chartData.length}'),
              data: chartData.toBizzieChartData(),
              numberFormat: NumberFormat('#,##0.00', 'en_US'),
              visibleCount: historyLimit,
              thresholdCount: historyLimit,
              source: PaywallSource.company_profile,
              onAnalyticsTap: () => context.read<CompanyPeRatioBloc>().add(
                const CompanyPeRatioEvent.viewAllTapped(isChart: true),
              ),
            ),
            AppConstants.mainSectionSpacing,
            FinancialDataTable(
              data: dataPoints,
              metricLabel: 'P/E',
              currency: '',
              isNeutralColor: true,
              dateFormat: FinancialDateFormat.fullDate,
              onAnalyticsTap: () => context.read<CompanyPeRatioBloc>().add(
                const CompanyPeRatioEvent.viewAllTapped(isChart: false),
              ),
              onViewMore: () {
                _showAllHistory(context, dataPoints);
              },
              limit: historyLimit,
              source: PaywallSource.company_profile,
              footer: FinancialTableFooter(
                columns: [
                  FinancialTableFooterColumnData(
                    label: 'Avg. P/E Ratio',
                    value: dataPoints.averageValue.formattedRatioValue,
                  ),
                  if (summary.dynamicAvg != null)
                    FinancialTableFooterColumnData(
                      label: summary.dynamicAvg!.label,
                      value: summary.dynamicAvg!.value,
                    ),
                ],
              ),
            ),
          ],
        ),
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
