import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RevenueTab extends StatefulWidget {
  final String ticker;
  final String? companyName;

  const RevenueTab({super.key, required this.ticker, this.companyName});

  @override
  State<RevenueTab> createState() => _RevenueTabState();
}

class _RevenueTabState extends State<RevenueTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.revenue.name,
      onTabShown: () => context.read<CompanyRevenueBloc>().add(
        CompanyRevenueEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyRevenueBloc>().add(
        const CompanyRevenueEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyRevenueBloc>().add(
        const CompanyRevenueEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyRevenueBloc>().add(
        const CompanyRevenueEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyRevenueBloc, CompanyRevenueState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Revenue'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading Revenue'),
            failure: (e) => CompanyProfileErrorState(
              message: 'Error loading revenue',
              onRetry: () => context.read<CompanyRevenueBloc>().add(
                CompanyRevenueEvent.loadRequested(
                  widget.ticker,
                  forceRefresh: true,
                ),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.revenueStats;
              final isAnnual = _selectedIndex == 0;
              final chartData = isAnnual
                  ? loadedState.annualChartData
                  : loadedState.quarterlyChartData;

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
                          context.read<CompanyRevenueBloc>().add(
                            CompanyRevenueEvent.periodViewed(
                              isAnnual: index == 0,
                            ),
                          );
                        },
                      ),
                      AppConstants.emptyStateTopSpacing,
                      const BizzieEmptyState(
                        mascotAsset: AppAssets.defaultMascot,
                        message: 'No revenue data available for this period.',
                      ),
                    ],
                  ),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  context.read<CompanyRevenueBloc>().add(
                    CompanyRevenueEvent.periodViewed(isAnnual: isAnnual),
                  );
                }
              });

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
                        context.read<CompanyRevenueBloc>().add(
                          CompanyRevenueEvent.periodViewed(
                            isAnnual: index == 0,
                          ),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    BizzieExpandableChart(
                      key: ValueKey('revenue_chart_$isAnnual'),
                      data: chartData
                          .map((p) => BizzieChartData(p.label, p.value))
                          .toList(),
                      numberFormat: NumberFormat.compactSimpleCurrency(
                        locale: Localizations.localeOf(context).toString(),
                        name: stats.reportedCurrency,
                      ),
                      visibleCount: loadedState.historyLimit,
                      thresholdCount: loadedState.historyLimit,
                      source: PaywallSource.company_profile,
                      onAnalyticsTap: () {
                        context.read<CompanyRevenueBloc>().add(
                          CompanyRevenueEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: true,
                          ),
                        );
                      },
                      onViewAllTapped: () {
                        _showAllHistory(
                          context,
                          isAnnual
                              ? stats.annualRevenue
                              : stats.quarterlyRevenue,
                          isAnnual ? 'Yearly Revenue' : 'Quarterly Revenue',
                          stats.reportedCurrency,
                          isAnnual,
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialHighlightsSection(
                      annualData: stats.annualRevenue,
                      quarterlyData: stats.quarterlyRevenue,
                      ttmTitle: 'Revenue TTM',
                      currency: stats.reportedCurrency,
                      isAnnual: isAnnual,
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialDataTable(
                      data: isAnnual
                          ? stats.annualRevenue
                          : stats.quarterlyRevenue,
                      metricLabel: 'Revenue',
                      currency: stats.reportedCurrency,
                      periodHeaderLabel: isAnnual
                          ? 'Year Ended'
                          : 'Quarter Ended',
                      dateFormat: isAnnual
                          ? FinancialDateFormat.monthYear
                          : FinancialDateFormat.quarterShort,
                      onAnalyticsTap: () {
                        context.read<CompanyRevenueBloc>().add(
                          CompanyRevenueEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: false,
                          ),
                        );
                      },
                      onViewMore: () {
                        _showAllHistory(
                          context,
                          isAnnual
                              ? stats.annualRevenue
                              : stats.quarterlyRevenue,
                          isAnnual ? 'Yearly Revenue' : 'Quarterly Revenue',
                          stats.reportedCurrency,
                          isAnnual,
                        );
                      },
                      limit: loadedState.historyLimit,
                      source: PaywallSource.company_profile,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAllHistory(
    BuildContext context,
    List<FinancialDataPoint> data,
    String title,
    String currency,
    bool isAnnual,
  ) {
    final sortedData = List<FinancialDataPoint>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));

    AppHistoryModalHelper.show<FinancialDataPoint>(
      context: context,
      title: title,
      header: FinancialTableHeader(
        metricLabel: 'Revenue',
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
        currency: currency,
        dateFormat: isAnnual
            ? FinancialDateFormat.monthYear
            : FinancialDateFormat.quarterShort,
      ),
    );
  }
}
