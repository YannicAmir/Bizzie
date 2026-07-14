import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/extensions/company_fcps_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/currency_metric_tab_content.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onPeriodChanged(BuildContext context, {required bool isAnnual}) {
    context.read<CompanyFcpsBloc>().add(
      CompanyFcpsEvent.periodChanged(isAnnual: isAnnual),
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
              final isAnnual = loadedState.isAnnualView;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  isAnnual: isAnnual,
                  message: 'No FCPS data available for this period.',
                  onPeriodChanged: (isAnnual) =>
                      _onPeriodChanged(context, isAnnual: isAnnual),
                );
              }

              return CurrencyMetricTabContent(
                isAnnual: isAnnual,
                chartData: chartData,
                annualData: stats.annualFcps,
                quarterlyData: stats.quarterlyFcps,
                currency: stats.reportedCurrency,
                historyLimit: loadedState.historyLimit,
                metricLabel: 'FCPS',
                ttmTitle: 'FCPS TTM',
                chartKeyPrefix: 'fcps_chart',
                onPeriodChanged: (isAnnual) =>
                    _onPeriodChanged(context, isAnnual: isAnnual),
                onChartAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                  CompanyFcpsEvent.viewAllTapped(
                    isAnnual: isAnnual,
                    isChart: true,
                  ),
                ),
                onTableAnalyticsTap: () => context.read<CompanyFcpsBloc>().add(
                  CompanyFcpsEvent.viewAllTapped(
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
