import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/metric_summary_card.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SharesTab extends StatefulWidget {
  final String ticker;

  const SharesTab({super.key, required this.ticker});

  @override
  State<SharesTab> createState() => _SharesTabState();
}

class _SharesTabState extends State<SharesTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final numberFormat = NumberFormat.compact(
      locale: Localizations.localeOf(context).toString(),
    );
    numberFormat.maximumFractionDigits = 2;

    return BlocBuilder<CompanySharesBloc, CompanySharesState>(
      builder: (context, state) {
        return state.map(
          initial: (_) =>
              const CompanyProfileLoadingState(message: 'Loading shares'),
          loading: (_) =>
              const CompanyProfileLoadingState(message: 'Loading shares'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading shares',
            onRetry: () => context.read<CompanySharesBloc>().add(
              CompanySharesEvent.loadRequested(widget.ticker),
            ),
          ),
          loaded: (loadedState) {
            final stats = loadedState.shareStats;
            final isAnnual = _selectedIndex == 0;
            final chartData = isAnnual
                ? loadedState.annualChartData
                : loadedState.quarterlyChartData;
            final summary = isAnnual
                ? loadedState.annualSummary
                : loadedState.quarterlySummary;

            if (chartData.isEmpty) {
              return SingleChildScrollView(
                padding: AppConstants.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BizzieSwitch(
                      options: const ['Yearly', 'Quarterly'],
                      selectedIndex: _selectedIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                    AppConstants.emptyStateTopSpacing,
                    const BizzieEmptyState(
                      mascotAsset: AppAssets.defaultMascot,
                      message: 'No Share data available for this period.',
                    ),
                  ],
                ),
              );
            }

            final badgeStyle = summary.isPositive
                ? AppBadgeStyle.critical
                : AppBadgeStyle.good;
            final valueStr = numberFormat.format(summary.currentValue);
            final badgeText =
                '${summary.growthPercentage > 0 ? '+' : ''}${summary.growthPercentage.toStringAsFixed(1)}%';
            final subtitle =
                '${summary.isPositive ? 'Increased' : 'Decreased'} by ${numberFormat.format(summary.absoluteDelta)} since ${summary.referenceLabel}';

            return SingleChildScrollView(
              padding: AppConstants.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BizzieSwitch(
                    options: const ['Yearly', 'Quarterly'],
                    selectedIndex: _selectedIndex,
                    onChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                  AppConstants.mainSectionSpacing,
                  MetricSummaryCard(
                    title: 'Outstanding Shares',
                    value: valueStr,
                    badgeText: badgeText,
                    badgeStyle: badgeStyle,
                    subtitle: subtitle,
                  ),
                  AppConstants.mainSectionSpacing,
                  BizzieExpandableChart(
                    key: ValueKey(
                      'shares_chart_${isAnnual}_${chartData.length}',
                    ),
                    data: chartData
                        .map((p) => BizzieChartData(p.label, p.value))
                        .toList(),
                    numberFormat: numberFormat,
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialDataTable(
                    data: isAnnual
                        ? stats.annualWeightedAverageShares
                        : stats.quarterlyWeightedAverageShares,
                    metricLabel: 'Shares',
                    currency: '',
                    isInverseGrowth: true,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    onViewMore: () => _showAllHistory(
                      context,
                      isAnnual
                          ? stats.annualWeightedAverageShares
                          : stats.quarterlyWeightedAverageShares,
                      isAnnual ? 'Yearly Shares Data' : 'Quarterly Shares Data',
                      isAnnual,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAllHistory(
    BuildContext context,
    List<FinancialDataPoint> data,
    String title,
    bool isAnnual,
  ) {
    final sortedData = List<FinancialDataPoint>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));

    AppHistoryModalHelper.show<FinancialDataPoint>(
      context: context,
      title: title,
      header: FinancialTableHeader(
        metricLabel: 'Shares',
        dateFormat: isAnnual
            ? FinancialDateFormat.monthYear
            : FinancialDateFormat.quarterShort,
        periodHeaderLabel: isAnnual ? 'Year Ended' : 'Quarter Ended',
      ),
      data: sortedData,
      itemBuilder: (context, item, index) => FinancialTableRow(
        item: item,
        index: index,
        allData: sortedData,
        currency: '',
        isInverseGrowth: true,
        dateFormat: isAnnual
            ? FinancialDateFormat.monthYear
            : FinancialDateFormat.quarterShort,
      ),
    );
  }
}
