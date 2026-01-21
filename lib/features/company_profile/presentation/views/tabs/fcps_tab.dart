import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_fcps/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_fcps/company_fcps_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_highlights_section.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FcpsTab extends StatefulWidget {
  final String ticker;

  const FcpsTab({super.key, required this.ticker});

  @override
  State<FcpsTab> createState() => _FcpsTabState();
}

class _FcpsTabState extends State<FcpsTab> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0; // 0 = Yearly, 1 = Quarterly

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CompanyFcpsBloc, CompanyFcpsState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => const _LoadingState(),
          loading: (_) => const _LoadingState(),
          failure: (f) => BlocSelector<UserBloc, UserState, String>(
            selector: (state) => state.maybeMap(
              loaded: (u) =>
                  AppAssets.getMascotForSector(u.user.favoriteSector),
              orElse: () => AppAssets.defaultMascot,
            ),
            builder: (context, mascot) {
              return Center(
                child: BizzieError(
                  message: 'Error loading FCPS',
                  mascotAssetPath: mascot,
                ),
              );
            },
          ),
          loaded: (loadedState) {
            final stats = loadedState.fcpsStats;
            final isAnnual = _selectedIndex == 0;
            final dataPoints = isAnnual
                ? stats.annualFcps
                : stats.quarterlyFcps;

            if (dataPoints.isEmpty) {
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
                    const SizedBox(height: 48),
                    const BizzieEmptyState(
                      mascotAsset: AppAssets.defaultMascot,
                      message: 'No FCPS data available for this period.',
                    ),
                  ],
                ),
              );
            }

            final reversedPoints = dataPoints.reversed.toList();
            final chartData = reversedPoints.map((p) {
              String label;
              final date = DateTime.tryParse(p.date);
              if (date != null) {
                if (isAnnual) {
                  label = DateFormat('yyyy').format(date);
                } else {
                  label = DateFormat("MMM ''yy").format(date);
                }
              } else {
                label = p.date;
              }
              return BizzieChartData(label, p.value);
            }).toList();

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
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: BizzieExpandableChart(
                      key: ValueKey('fcps_chart_$isAnnual'),
                      data: chartData,
                      numberFormat: NumberFormat.compactSimpleCurrency(
                        locale: Localizations.localeOf(context).toString(),
                        name: stats.reportedCurrency,
                      ),
                    ),
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialHighlightsSection(
                    annualData: stats.annualFcps,
                    quarterlyData: stats.quarterlyFcps,
                    ttmTitle: 'FCPS TTM',
                    currency: stats.reportedCurrency,
                    isAnnual: isAnnual,
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialDataTable(
                    data: isAnnual ? stats.annualFcps : stats.quarterlyFcps,
                    metricLabel: 'FCPS',
                    currency: stats.reportedCurrency,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    onViewMore: () => _showAllHistory(
                      context,
                      isAnnual ? stats.annualFcps : stats.quarterlyFcps,
                      isAnnual ? 'Yearly FCPS Data' : 'Quarterly FCPS Data',
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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AppBottomModal(
          title: title,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: FinancialTableHeader(
                    metricLabel: 'FCPS',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                  ),
                ),
                const Divider(height: 1, color: AppColors.slate50),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: sortedData.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.slate50),
                    itemBuilder: (context, index) {
                      final item = sortedData[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
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

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.maybeMap(
        loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
        orElse: () => AppAssets.defaultMascot,
      ),
      builder: (context, mascot) {
        return BizzieLoader(message: 'Loading FCPS', mascotAssetPath: mascot);
      },
    );
  }
}
