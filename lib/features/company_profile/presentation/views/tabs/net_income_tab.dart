import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NetIncomeTab extends StatefulWidget {
  final String ticker;

  const NetIncomeTab({super.key, required this.ticker});

  @override
  State<NetIncomeTab> createState() => _NetIncomeTabState();
}

class _NetIncomeTabState extends State<NetIncomeTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      builder: (context, state) {
        return state.map(
          initial: (_) =>
              const CompanyProfileLoadingState(message: 'Loading Net Income'),
          loading: (_) =>
              const CompanyProfileLoadingState(message: 'Loading Net Income'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading net income',
            onRetry: () => context.read<CompanyNetIncomeBloc>().add(
              CompanyNetIncomeEvent.loadRequested(widget.ticker),
            ),
          ),
          loaded: (loadedState) {
            final stats = loadedState.netIncomeStats;
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
                      },
                    ),
                    AppConstants.emptyStateTopSpacing,
                    const BizzieEmptyState(
                      mascotAsset: AppAssets.defaultMascot,
                      message: 'No net income data available for this period.',
                    ),
                  ],
                ),
              );
            }

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
                    },
                  ),
                  AppConstants.mainSectionSpacing,
                  BizzieExpandableChart(
                    key: ValueKey('net_income_chart_$isAnnual'),
                    data: chartData
                        .map((p) => BizzieChartData(p.label, p.value))
                        .toList(),
                    numberFormat: NumberFormat.compactSimpleCurrency(
                      locale: Localizations.localeOf(context).toString(),
                      name: stats.reportedCurrency,
                    ),
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialHighlightsSection(
                    annualData: stats.annualNetIncome,
                    quarterlyData: stats.quarterlyNetIncome,
                    ttmTitle: 'Net Income TTM',
                    currency: stats.reportedCurrency,
                    isAnnual: isAnnual,
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialDataTable(
                    data: isAnnual
                        ? stats.annualNetIncome
                        : stats.quarterlyNetIncome,
                    metricLabel: 'Net Income',
                    currency: stats.reportedCurrency,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    onViewMore: () => _showAllHistory(
                      context,
                      isAnnual
                          ? stats.annualNetIncome
                          : stats.quarterlyNetIncome,
                      isAnnual ? 'Yearly Net Income' : 'Quarterly Net Income',
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
        metricLabel: 'Net Income',
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
