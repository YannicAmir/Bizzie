import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import '../bloc/company_eps_bloc.dart';
import '../bloc/company_eps_event.dart';
import '../bloc/company_eps_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EpsTab extends StatefulWidget {
  final String ticker;

  const EpsTab({super.key, required this.ticker});

  @override
  State<EpsTab> createState() => _EpsTabState();
}

class _EpsTabState extends State<EpsTab> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.eps.analyticsName,
      onTabShown: () => context.read<CompanyEpsBloc>().add(
        CompanyEpsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () =>
          context.read<CompanyEpsBloc>().add(const CompanyEpsEvent.tabHidden()),
      onAppBackgrounded: () => context.read<CompanyEpsBloc>().add(
        const CompanyEpsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyEpsBloc>().add(
        const CompanyEpsEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyEpsBloc, CompanyEpsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading EPS'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading EPS'),
            failure: (e) => CompanyProfileErrorState(
              message: 'Error loading EPS',
              onRetry: () => context.read<CompanyEpsBloc>().add(
                CompanyEpsEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.epsStats;
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
                          context.read<CompanyEpsBloc>().add(
                            CompanyEpsEvent.periodViewed(isAnnual: index == 0),
                          );
                        },
                      ),
                      AppConstants.emptyStateTopSpacing,
                      const BizzieEmptyState(
                        mascotAsset: AppAssets.defaultMascot,
                        message: 'No EPS data available for this period.',
                      ),
                    ],
                  ),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  context.read<CompanyEpsBloc>().add(
                    CompanyEpsEvent.periodViewed(isAnnual: isAnnual),
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
                        context.read<CompanyEpsBloc>().add(
                          CompanyEpsEvent.periodViewed(isAnnual: index == 0),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    BizzieExpandableChart(
                      key: ValueKey('eps_chart_$isAnnual'),
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
                        context.read<CompanyEpsBloc>().add(
                          CompanyEpsEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: true,
                          ),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialHighlightsSection(
                      annualData: stats.annualEps,
                      quarterlyData: stats.quarterlyEps,
                      ttmTitle: 'EPS TTM',
                      currency: stats.reportedCurrency,
                      isAnnual: isAnnual,
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialDataTable(
                      data: isAnnual ? stats.annualEps : stats.quarterlyEps,
                      metricLabel: 'EPS',
                      currency: stats.reportedCurrency,
                      periodHeaderLabel: isAnnual
                          ? 'Year Ended'
                          : 'Quarter Ended',
                      dateFormat: isAnnual
                          ? FinancialDateFormat.monthYear
                          : FinancialDateFormat.quarterShort,
                      onAnalyticsTap: () {
                        context.read<CompanyEpsBloc>().add(
                          CompanyEpsEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: false,
                          ),
                        );
                      },
                      onViewMore: () {
                        _showAllHistory(
                          context,
                          isAnnual ? stats.annualEps : stats.quarterlyEps,
                          isAnnual ? 'Yearly EPS' : 'Quarterly EPS',
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
        metricLabel: 'EPS',
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
