import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_event.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_state.dart';
import 'package:bizzie/features/company_profile/eps/presentation/extensions/company_eps_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/currency_metric_labels.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_metric_tab_content.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _labels = CurrencyMetricLabels(
  metricLabel: 'EPS',
  ttmTitle: 'EPS TTM',
  chartKeyPrefix: 'eps_chart',
);

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

  void _onPeriodChanged(
    BuildContext context, {
    required FinancialPeriod period,
  }) {
    context.read<CompanyEpsBloc>().add(
      CompanyEpsEvent.periodChanged(period: period),
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
              final period = loadedState.period;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  period: period,
                  message: 'No EPS data available for this period.',
                  onPeriodChanged: (period) =>
                      _onPeriodChanged(context, period: period),
                );
              }

              return CurrencyMetricTabContent(
                period: period,
                chartData: chartData,
                annualData: stats.annualEps,
                quarterlyData: stats.quarterlyEps,
                currency: stats.reportedCurrency,
                originalCurrency: stats.originalCurrency,
                historyLimit: loadedState.historyLimit,
                labels: _labels,
                onPeriodChanged: (period) =>
                    _onPeriodChanged(context, period: period),
                onChartAnalyticsTap: () => context.read<CompanyEpsBloc>().add(
                  CompanyEpsEvent.viewAllTapped(period: period, isChart: true),
                ),
                onTableAnalyticsTap: () => context.read<CompanyEpsBloc>().add(
                  CompanyEpsEvent.viewAllTapped(period: period, isChart: false),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
