import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/chart_data_point_list_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/extensions/company_profile_tab_x.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_history_modal_helper.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_period_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_data_table.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/metric_summary_card.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_metric_empty_view.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_switch.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_event.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_state.dart';
import 'package:bizzie/features/company_profile/shares/presentation/extensions/company_shares_state_extensions.dart';
import 'package:bizzie/features/company_profile/shares/presentation/utils/shares_presentation_helper.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const _maxFractionDigits = 2;

const Widget _loadingView = CompanyProfileLoadingState(
  message: 'Loading shares',
);

class SharesTab extends StatefulWidget {
  final String ticker;

  const SharesTab({super.key, required this.ticker});

  @override
  State<SharesTab> createState() => _SharesTabState();
}

class _SharesTabState extends State<SharesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CompanySharesBloc>().add(
      CompanySharesEvent.stalenessCheckRequested(widget.ticker),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPeriodChanged(
    BuildContext context, {
    required FinancialPeriod period,
  }) {
    context.read<CompanySharesBloc>().add(
      CompanySharesEvent.periodChanged(period: period),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final numberFormat = NumberFormat.compact(
      locale: Localizations.localeOf(context).toString(),
    );
    numberFormat.maximumFractionDigits = _maxFractionDigits;

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.shares.analyticsName,
      onTabShown: () => context.read<CompanySharesBloc>().add(
        CompanySharesEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<CompanySharesBloc>().add(
        const CompanySharesEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<CompanySharesBloc>().add(
        const CompanySharesEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<CompanySharesBloc>().add(
        const CompanySharesEvent.appForegrounded(),
      ),
      child: BlocBuilder<CompanySharesBloc, CompanySharesState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => _loadingView,
            loading: (_) => _loadingView,
            failure: (_) => CompanyProfileErrorState(
              message: 'Error loading shares',
              onRetry: () => context.read<CompanySharesBloc>().add(
                CompanySharesEvent.loadRequested(widget.ticker),
              ),
            ),
            loaded: (loadedState) {
              final period = loadedState.period;
              final chartData = loadedState.activeChartData;

              if (chartData.isEmpty) {
                return PeriodMetricEmptyView(
                  period: period,
                  message: 'No Share data available for this period.',
                  onPeriodChanged: (period) =>
                      _onPeriodChanged(context, period: period),
                );
              }

              return _SharesLoadedView(
                period: period,
                chartData: chartData,
                summary: loadedState.activeSummary,
                tableData: loadedState.activeTableData,
                historyLimit: loadedState.historyLimit,
                numberFormat: numberFormat,
                onPeriodChanged: (period) =>
                    _onPeriodChanged(context, period: period),
              );
            },
          );
        },
      ),
    );
  }
}

class _SharesLoadedView extends StatelessWidget {
  final FinancialPeriod period;
  final List<ChartDataPoint> chartData;
  final SharesSummaryData summary;
  final List<FinancialDataPoint> tableData;
  final int historyLimit;
  final NumberFormat numberFormat;
  final ValueChanged<FinancialPeriod> onPeriodChanged;

  const _SharesLoadedView({
    required this.period,
    required this.chartData,
    required this.summary,
    required this.tableData,
    required this.historyLimit,
    required this.numberFormat,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final summaryFormatted = SharesPresentationHelper.formatSummary(
      summary,
      numberFormat,
    );

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PeriodSwitch(period: period, onPeriodChanged: onPeriodChanged),
          AppConstants.mainSectionSpacing,
          MetricSummaryCard(
            title: 'Outstanding Shares',
            value: summaryFormatted.valueStr,
            badgeText: summaryFormatted.badgeText,
            badgeStyle: summaryFormatted.badgeStyle,
            subtitle: summaryFormatted.subtitle,
          ),
          AppConstants.mainSectionSpacing,
          BizzieExpandableChart(
            key: ValueKey(
              'shares_chart_${period.isAnnual}_${chartData.length}',
            ),
            data: chartData.toBizzieChartData(),
            numberFormat: numberFormat,
            visibleCount: historyLimit,
            thresholdCount: historyLimit,
            source: PaywallSource.company_profile,
            onAnalyticsTap: () => _onViewAllTapped(context, isChart: true),
          ),
          AppConstants.mainSectionSpacing,
          FinancialDataTable(
            data: tableData,
            metricLabel: 'Shares',
            currency: '',
            isInverseGrowth: true,
            periodHeaderLabel: period.tableHeaderLabel,
            dateFormat: period.tableDateFormat,
            onAnalyticsTap: () => _onViewAllTapped(context, isChart: false),
            onViewMore: () => FinancialHistoryModalHelper.show(
              context,
              title: period.historyTitle('Shares Data'),
              data: tableData,
              metricLabel: 'Shares',
              currency: '',
              period: period,
              isInverseGrowth: true,
            ),
            limit: historyLimit,
            source: PaywallSource.company_profile,
          ),
        ],
      ),
    );
  }

  void _onViewAllTapped(BuildContext context, {required bool isChart}) {
    context.read<CompanySharesBloc>().add(
      CompanySharesEvent.viewAllTapped(period: period, isChart: isChart),
    );
  }
}
