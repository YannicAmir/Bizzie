import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/extensions/company_fcps_state_extensions.dart';
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
  metricLabel: 'FCPS',
  ttmTitle: 'FCPS TTM',
  chartKeyPrefix: 'fcps_chart',
);

const Widget _loadingView = CompanyProfileLoadingState(message: 'Loading FCPS');

class FcpsTab extends StatefulWidget {
  final String ticker;

  const FcpsTab({super.key, required this.ticker});

  @override
  State<FcpsTab> createState() => _FcpsTabState();
}

class _FcpsTabState extends State<FcpsTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyFcpsBloc>().add(
      CompanyFcpsEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(
    BuildContext context, {
    required FinancialPeriod period,
  }) {
    context.read<CompanyFcpsBloc>().add(
      CompanyFcpsEvent.periodChanged(period: period),
    );
  }

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
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading FCPS',
              onRetry: () => context.read<CompanyFcpsBloc>().add(
                CompanyFcpsEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.fcpsStats;
              final period = loadedState.period;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  period: period,
                  message: 'No FCPS data available for this period.',
                  onPeriodChanged: (period) =>
                      _onPeriodChanged(context, period: period),
                );
              }

              return CurrencyMetricTabContent(
                period: period,
                chartData: chartData,
                annualData: stats.annualFcps,
                quarterlyData: stats.quarterlyFcps,
                currency: stats.reportedCurrency,
                originalCurrency: stats.originalCurrency,
                historyLimit: loadedState.historyLimit,
                labels: _labels,
                onPeriodChanged: (period) =>
                    _onPeriodChanged(context, period: period),
                onChartAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                  CompanyFcpsEvent.viewAllTapped(period: period, isChart: true),
                ),
                onTableAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                  CompanyFcpsEvent.viewAllTapped(
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
