import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/extensions/company_revenue_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_metric_tab_content.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Widget _loadingView = CompanyProfileLoadingState(
  message: 'Loading Revenue',
);

class RevenueTab extends StatefulWidget {
  final String ticker;

  const RevenueTab({super.key, required this.ticker});

  @override
  State<RevenueTab> createState() => _RevenueTabState();
}

class _RevenueTabState extends State<RevenueTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyRevenueBloc>().add(
      CompanyRevenueEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(BuildContext context, {required bool isAnnual}) {
    context.read<CompanyRevenueBloc>().add(
      CompanyRevenueEvent.periodChanged(isAnnual: isAnnual),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.revenue.analyticsName,
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
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
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
              final isAnnual = loadedState.isAnnualView;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  isAnnual: isAnnual,
                  message: 'No revenue data available for this period.',
                  onPeriodChanged: (isAnnual) =>
                      _onPeriodChanged(context, isAnnual: isAnnual),
                );
              }

              return CurrencyMetricTabContent(
                isAnnual: isAnnual,
                chartData: chartData,
                annualData: stats.annualRevenue,
                quarterlyData: stats.quarterlyRevenue,
                currency: stats.reportedCurrency,
                historyLimit: loadedState.historyLimit,
                metricLabel: 'Revenue',
                ttmTitle: 'Revenue TTM',
                chartKeyPrefix: 'revenue_chart',
                onPeriodChanged: (isAnnual) =>
                    _onPeriodChanged(context, isAnnual: isAnnual),
                onChartAnalyticsTap: () =>
                    context.read<CompanyRevenueBloc>().add(
                      CompanyRevenueEvent.viewAllTapped(
                        isAnnual: isAnnual,
                        isChart: true,
                      ),
                    ),
                onTableAnalyticsTap: () =>
                    context.read<CompanyRevenueBloc>().add(
                      CompanyRevenueEvent.viewAllTapped(
                        isAnnual: isAnnual,
                        isChart: false,
                      ),
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
