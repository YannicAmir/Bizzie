import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_revenue/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_revenue/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_revenue/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/company_profile_loading_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RevenueTab extends StatefulWidget {
  final String ticker;

  const RevenueTab({super.key, required this.ticker});

  @override
  State<RevenueTab> createState() => _RevenueTabState();
}

class _RevenueTabState extends State<RevenueTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CompanyRevenueBloc, CompanyRevenueState>(
      builder: (context, state) {
        return state.map(
          initial: (_) =>
              const CompanyProfileLoadingState(message: 'Loading Revenue'),
          loading: (_) =>
              const CompanyProfileLoadingState(message: 'Loading Revenue'),
          failure: (e) => CompanyProfileErrorState(
            message: 'Error loading revenue',
            onRetry: () => context.read<CompanyRevenueBloc>().add(
              CompanyRevenueEvent.loadRequested(widget.ticker),
            ),
          ),
          loaded: (loadedState) {
            final stats = loadedState.revenueStats;
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
                      message: 'No revenue data available for this period.',
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
                    key: ValueKey('revenue_chart_$isAnnual'),
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
                    annualData: stats.annualRevenue,
                    quarterlyData: stats.quarterlyRevenue,
                    ttmTitle: 'Revenue TTM',
                    currency: stats.reportedCurrency,
                    isAnnual: isAnnual,
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialDataTable(
                    data: isAnnual
                        ? stats.annualRevenue
                        : stats.quarterlyRevenue,
                    metricLabel: 'Revenue',
                    currency: stats.reportedCurrency,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    onViewMore: () => _showAllHistory(
                      context,
                      isAnnual ? stats.annualRevenue : stats.quarterlyRevenue,
                      isAnnual
                          ? 'Yearly Revenue Data'
                          : 'Quarterly Revenue Data',
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AppBottomModal(
          title: title,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: AppConstants.bottomModalPadding,
                  child: FinancialTableHeader(
                    metricLabel: 'Revenue',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: AppConstants.bottomModalPadding,
                    itemCount: sortedData.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.slate50),
                    itemBuilder: (context, index) {
                      final item = sortedData[index];
                      return Container(
                        padding: AppConstants.dataRowVerticalPadding,
                        child: FinancialTableRow(
                          item: item,
                          index: index,
                          allData: sortedData,
                          currency: currency,
                          dateFormat: isAnnual
                              ? FinancialDateFormat.monthYear
                              : FinancialDateFormat.quarterShort,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
