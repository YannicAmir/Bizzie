import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/cp/presentation/widgets/company_profile_tour_target.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/extensions/company_revenue_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/currency_metric_labels.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_metric_tab_content.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _labels = CurrencyMetricLabels(
  metricLabel: 'Revenue',
  ttmTitle: 'Revenue TTM',
  chartKeyPrefix: 'revenue_chart',
);

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

  void _onPeriodChanged(
    BuildContext context, {
    required FinancialPeriod period,
  }) {
    context.read<CompanyRevenueBloc>().add(
      CompanyRevenueEvent.periodChanged(period: period),
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
              final period = loadedState.period;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  period: period,
                  message: 'No revenue data available for this period.',
                  onPeriodChanged: (period) =>
                      _onPeriodChanged(context, period: period),
                );
              }

              return CurrencyMetricTabContent(
                period: period,
                chartData: chartData,
                annualData: stats.annualRevenue,
                quarterlyData: stats.quarterlyRevenue,
                currency: stats.reportedCurrency,
                originalCurrency: stats.originalCurrency,
                historyLimit: loadedState.historyLimit,
                labels: _labels,
                highlightsBuilder: (child) => CompanyProfileTourTarget(
                  step: CompanyProfileTourStep.revenueGrowth,
                  child: child,
                ),
                onPeriodChanged: (period) =>
                    _onPeriodChanged(context, period: period),
                onChartAnalyticsTap: () =>
                    context.read<CompanyRevenueBloc>().add(
                      CompanyRevenueEvent.viewAllTapped(
                        period: period,
                        isChart: true,
                      ),
                    ),
                onTableAnalyticsTap: () =>
                    context.read<CompanyRevenueBloc>().add(
                      CompanyRevenueEvent.viewAllTapped(
                        period: period,
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
