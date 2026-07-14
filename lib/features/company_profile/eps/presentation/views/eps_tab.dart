import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_event.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_state.dart';
import 'package:bizzie/features/company_profile/eps/presentation/extensions/company_eps_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_metric_tab_content.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Widget _loadingView = CompanyProfileLoadingState(message: 'Loading EPS');

class EpsTab extends StatefulWidget {
  final String ticker;

  const EpsTab({super.key, required this.ticker});

  @override
  State<EpsTab> createState() => _EpsTabState();
}

class _EpsTabState extends State<EpsTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyEpsBloc>().add(
      CompanyEpsEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(BuildContext context, {required bool isAnnual}) {
    context.read<CompanyEpsBloc>().add(
      CompanyEpsEvent.periodChanged(isAnnual: isAnnual),
    );
  }

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
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading EPS',
              onRetry: () => context.read<CompanyEpsBloc>().add(
                CompanyEpsEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.epsStats;
              final isAnnual = loadedState.isAnnualView;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  isAnnual: isAnnual,
                  message: 'No EPS data available for this period.',
                  onPeriodChanged: (isAnnual) =>
                      _onPeriodChanged(context, isAnnual: isAnnual),
                );
              }

              return CurrencyMetricTabContent(
                isAnnual: isAnnual,
                chartData: chartData,
                annualData: stats.annualEps,
                quarterlyData: stats.quarterlyEps,
                currency: stats.reportedCurrency,
                historyLimit: loadedState.historyLimit,
                metricLabel: 'EPS',
                ttmTitle: 'EPS TTM',
                chartKeyPrefix: 'eps_chart',
                onPeriodChanged: (isAnnual) =>
                    _onPeriodChanged(context, isAnnual: isAnnual),
                onChartAnalyticsTap: () => context.read<CompanyEpsBloc>().add(
                  CompanyEpsEvent.viewAllTapped(
                    isAnnual: isAnnual,
                    isChart: true,
                  ),
                ),
                onTableAnalyticsTap: () => context.read<CompanyEpsBloc>().add(
                  CompanyEpsEvent.viewAllTapped(
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
