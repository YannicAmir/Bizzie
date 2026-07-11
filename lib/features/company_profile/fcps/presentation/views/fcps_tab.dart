import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import '../bloc/company_fcps_bloc.dart';
import '../bloc/company_fcps_event.dart';
import '../bloc/company_fcps_state.dart';
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
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FcpsTab extends StatefulWidget {
  final String ticker;

  const FcpsTab({super.key, required this.ticker});

  @override
  State<FcpsTab> createState() => _FcpsTabState();
}

class _FcpsTabState extends State<FcpsTab> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CompanyFcpsBloc>().add(
      CompanyFcpsEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.fcps.analyticsName,
      onTabShown: () => context.read<CompanyFcpsBloc>().add(
        CompanyFcpsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyFcpsBloc>().add(
        const CompanyFcpsEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyFcpsBloc>().add(
        const CompanyFcpsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyFcpsBloc>().add(
        const CompanyFcpsEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyFcpsBloc, CompanyFcpsState>(
        builder: (context, state) {
          return state.map(
            initial: (_) =>
                const CompanyProfileLoadingState(message: 'Loading FCPS'),
            loading: (_) =>
                const CompanyProfileLoadingState(message: 'Loading FCPS'),
            failure: (e) => CompanyProfileErrorState(
              message: 'Error loading FCPS',
              onRetry: () => context.read<CompanyFcpsBloc>().add(
                CompanyFcpsEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.fcpsStats;
              final historyLimit = loadedState.historyLimit;
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
                          context.read<CompanyFcpsBloc>().add(
                            CompanyFcpsEvent.periodViewed(isAnnual: index == 0),
                          );
                        },
                      ),
                      AppConstants.emptyStateTopSpacing,
                      const BizzieEmptyState(
                        mascotAsset: AppAssets.defaultMascot,
                        message: 'No FCPS data available for this period.',
                      ),
                    ],
                  ),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  context.read<CompanyFcpsBloc>().add(
                    CompanyFcpsEvent.periodViewed(isAnnual: isAnnual),
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
                        context.read<CompanyFcpsBloc>().add(
                          CompanyFcpsEvent.periodViewed(isAnnual: index == 0),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    BizzieExpandableChart(
                      key: ValueKey('fcps_chart_$isAnnual'),
                      data: chartData
                          .map((p) => BizzieChartData(p.label, p.value))
                          .toList(),
                      numberFormat: NumberFormat.compactSimpleCurrency(
                        locale: Localizations.localeOf(context).toString(),
                        name: stats.reportedCurrency,
                      ),
                      visibleCount: historyLimit,
                      thresholdCount: historyLimit,
                      source: PaywallSource.company_profile,
                      onAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                        CompanyFcpsEvent.viewAllTapped(
                          isAnnual: isAnnual,
                          isChart: true,
                        ),
                      ),
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialHighlightsSection(
                      annualData: stats.annualFcps,
                      quarterlyData: stats.quarterlyFcps,
                      ttmTitle: 'FCPS TTM',
                      currency: stats.reportedCurrency,
                      isAnnual: isAnnual,
                    ),
                    AppConstants.mainSectionSpacing,
                    FinancialDataTable(
                      data: isAnnual ? stats.annualFcps : stats.quarterlyFcps,
                      metricLabel: 'FCPS',
                      currency: stats.reportedCurrency,
                      periodHeaderLabel: isAnnual
                          ? 'Year Ended'
                          : 'Quarter Ended',
                      dateFormat: isAnnual
                          ? FinancialDateFormat.monthYear
                          : FinancialDateFormat.quarterShort,
                      limit: historyLimit,
                      source: PaywallSource.company_profile,
                      onAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                        CompanyFcpsEvent.viewAllTapped(
                          isAnnual: isAnnual,
                          isChart: false,
                        ),
                      ),
                      onViewMore: () => _showAllHistory(
                        context,
                        isAnnual ? stats.annualFcps : stats.quarterlyFcps,
                        isAnnual ? 'Yearly FCPS' : 'Quarterly FCPS',
                        stats.reportedCurrency,
                        isAnnual,
                      ),
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
        metricLabel: 'FCPS',
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
