import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_event.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_state.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/extensions/company_free_cash_flow_state_extensions.dart';
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
  message: 'Loading free cash flow',
);

class FreeCashFlowTab extends StatefulWidget {
  final String ticker;

  const FreeCashFlowTab({super.key, required this.ticker});

  @override
  State<FreeCashFlowTab> createState() => _FreeCashFlowTabState();
}

class _FreeCashFlowTabState extends State<FreeCashFlowTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyFreeCashFlowBloc>().add(
      CompanyFreeCashFlowEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(BuildContext context, {required bool isAnnual}) {
    context.read<CompanyFreeCashFlowBloc>().add(
      CompanyFreeCashFlowEvent.periodChanged(isAnnual: isAnnual),
    );
  }

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
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading free cash flow',
              onRetry: () => context.read<CompanyFreeCashFlowBloc>().add(
                CompanyFreeCashFlowEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.fcfStats;
              final isAnnual = loadedState.isAnnualView;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  isAnnual: isAnnual,
                  message: 'No Free Cash Flow data available for this period.',
                  onPeriodChanged: (isAnnual) =>
                      _onPeriodChanged(context, isAnnual: isAnnual),
                );
              }

              return CurrencyMetricTabContent(
                isAnnual: isAnnual,
                chartData: chartData,
                annualData: stats.annualFcf,
                quarterlyData: stats.quarterlyFcf,
                currency: stats.reportedCurrency,
                historyLimit: loadedState.historyLimit,
                metricLabel: 'Free Cash Flow',
                modalMetricLabel: 'FCF',
                ttmTitle: 'FCF TTM',
                chartKeyPrefix: 'fcf_chart',
                onPeriodChanged: (isAnnual) =>
                    _onPeriodChanged(context, isAnnual: isAnnual),
                onChartAnalyticsTap: () =>
                    context.read<CompanyFreeCashFlowBloc>().add(
                      CompanyFreeCashFlowEvent.viewAllTapped(
                        isAnnual: isAnnual,
                        isChart: true,
                      ),
                    ),
                onTableAnalyticsTap: () =>
                    context.read<CompanyFreeCashFlowBloc>().add(
                      CompanyFreeCashFlowEvent.viewAllTapped(
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
