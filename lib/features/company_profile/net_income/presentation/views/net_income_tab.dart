import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_state.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/extensions/company_net_income_state_extensions.dart';
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
  message: 'Loading Net Income',
);

class NetIncomeTab extends StatefulWidget {
  final String ticker;

  const NetIncomeTab({super.key, required this.ticker});

  @override
  State<NetIncomeTab> createState() => _NetIncomeTabState();
}

class _NetIncomeTabState extends State<NetIncomeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanyNetIncomeBloc>().add(
      CompanyNetIncomeEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(BuildContext context, {required bool isAnnual}) {
    context.read<CompanyNetIncomeBloc>().add(
      CompanyNetIncomeEvent.periodChanged(isAnnual: isAnnual),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.netIncome.analyticsName,
      onTabShown: () => context.read<CompanyNetIncomeBloc>().add(
        CompanyNetIncomeEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanyNetIncomeBloc>().add(
        const CompanyNetIncomeEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanyNetIncomeBloc>().add(
        const CompanyNetIncomeEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanyNetIncomeBloc>().add(
        const CompanyNetIncomeEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanyNetIncomeBloc, CompanyNetIncomeState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading net income',
              onRetry: () => context.read<CompanyNetIncomeBloc>().add(
                CompanyNetIncomeEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final stats = loadedState.netIncomeStats;
              final isAnnual = loadedState.isAnnualView;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  isAnnual: isAnnual,
                  message: 'No net income data available for this period.',
                  onPeriodChanged: (isAnnual) =>
                      _onPeriodChanged(context, isAnnual: isAnnual),
                );
              }

              return CurrencyMetricTabContent(
                isAnnual: isAnnual,
                chartData: chartData,
                annualData: stats.annualNetIncome,
                quarterlyData: stats.quarterlyNetIncome,
                currency: stats.reportedCurrency,
                historyLimit: loadedState.historyLimit,
                metricLabel: 'Net Income',
                ttmTitle: 'Net Income TTM',
                chartKeyPrefix: 'net_income_chart',
                onPeriodChanged: (isAnnual) =>
                    _onPeriodChanged(context, isAnnual: isAnnual),
                onChartAnalyticsTap: () =>
                    context.read<CompanyNetIncomeBloc>().add(
                      CompanyNetIncomeEvent.viewAllTapped(
                        isAnnual: isAnnual,
                        isChart: true,
                      ),
                    ),
                onTableAnalyticsTap: () =>
                    context.read<CompanyNetIncomeBloc>().add(
                      CompanyNetIncomeEvent.viewAllTapped(
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
