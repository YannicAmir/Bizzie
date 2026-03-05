import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import '../bloc/company_free_cash_flow_bloc.dart';
import '../bloc/company_free_cash_flow_event.dart';
import '../bloc/company_free_cash_flow_state.dart';
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
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FreeCashFlowTab extends StatefulWidget {
  final String ticker;

  const FreeCashFlowTab({super.key, required this.ticker});

  @override
  State<FreeCashFlowTab> createState() => _FreeCashFlowTabState();
}

class _FreeCashFlowTabState extends State<FreeCashFlowTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.freeCash.analyticsName,
      onTabShown: () => context.read<CompanyFreeCashFlowBloc>().add(
        CompanyFreeCashFlowEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyFreeCashFlowBloc>().add(
        const CompanyFreeCashFlowEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyFreeCashFlowBloc>().add(
        const CompanyFreeCashFlowEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyFreeCashFlowBloc>().add(
        const CompanyFreeCashFlowEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const CompanyProfileLoadingState(
              message: 'Loading free cash flow',
            ),
            loading: (_) => const CompanyProfileLoadingState(
              message: 'Loading free cash flow',
            ),
            failure: (e) => CompanyProfileErrorState(
              message: 'Error loading free cash flow',
              onRetry: () => context.read<CompanyFreeCashFlowBloc>().add(
                CompanyFreeCashFlowEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.fcfStats;
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
                          context.read<CompanyFreeCashFlowBloc>().add(
                            CompanyFreeCashFlowEvent.periodViewed(
                              isAnnual: index == 0,
                            ),
                          );
                        },
                      ),
                      AppConstants.emptyStateTopSpacing,
                      const BizzieEmptyState(
                        mascotAsset: AppAssets.defaultMascot,
                        message:
                            'No Free Cash Flow data available for this period.',
                      ),
                    ],
                  ),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  context.read<CompanyFreeCashFlowBloc>().add(
                    CompanyFreeCashFlowEvent.periodViewed(isAnnual: isAnnual),
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
                        context.read<CompanyFreeCashFlowBloc>().add(
                          CompanyFreeCashFlowEvent.periodViewed(
                            isAnnual: index == 0,
                          ),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    BizzieExpandableChart(
                      key: ValueKey('fcf_chart_$isAnnual'),
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
                        context.read<CompanyFreeCashFlowBloc>().add(
                          CompanyFreeCashFlowEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: true,
                          ),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialHighlightsSection(
                      annualData: stats.annualFcf,
                      quarterlyData: stats.quarterlyFcf,
                      ttmTitle: 'FCF TTM',
                      currency: stats.reportedCurrency,
                      isAnnual: isAnnual,
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialDataTable(
                      data: isAnnual ? stats.annualFcf : stats.quarterlyFcf,
                      metricLabel: 'Free Cash Flow',
                      currency: stats.reportedCurrency,
                      periodHeaderLabel: isAnnual
                          ? 'Year Ended'
                          : 'Quarter Ended',
                      dateFormat: isAnnual
                          ? FinancialDateFormat.monthYear
                          : FinancialDateFormat.quarterShort,
                      onAnalyticsTap: () {
                        context.read<CompanyFreeCashFlowBloc>().add(
                          CompanyFreeCashFlowEvent.viewAllTapped(
                            isAnnual: isAnnual,
                            isChart: false,
                          ),
                        );
                      },
                      onViewMore: () {
                        _showAllHistory(
                          context,
                          isAnnual ? stats.annualFcf : stats.quarterlyFcf,
                          isAnnual
                              ? 'Yearly Free Cash Flow'
                              : 'Quarterly Free Cash Flow',
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
        metricLabel: 'FCF',
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
