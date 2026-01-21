import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/metric_summary_card.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/shared/financial_data_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_bar_chart.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_expandable_chart.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/shared/widgets/app_badge.dart'; // Import AppBadgeStyle
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

class SharesTab extends StatefulWidget {
  final String ticker;

  const SharesTab({super.key, required this.ticker});

  @override
  State<SharesTab> createState() => _SharesTabState();
}

class _SharesTabState extends State<SharesTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0; // 0 = Yearly, 1 = Quarterly

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Number formatter for cards and chart
    final numberFormat = NumberFormat.compact(
      locale: Localizations.localeOf(context).toString(),
    );
    // Explicit 2 decimal places max for consistency with design (e.g. 15.12B)
    numberFormat.maximumFractionDigits = 2;

    return BlocBuilder<CompanySharesBloc, CompanySharesState>(
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
                  message: 'Error loading share',
                  mascotAssetPath: mascot,
                ),
              );
            },
          ),
          loaded: (loadedState) {
            final stats = loadedState.shareStats;
            final isAnnual = _selectedIndex == 0;
            final dataPoints = isAnnual
                ? stats.annualWeightedAverageShares
                : stats.quarterlyWeightedAverageShares;

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
                      message: 'No Share data available for this period.',
                    ),
                  ],
                ),
              );
            }

            // Sort data Oldest -> Newest for Chart and Calculation
            final sortedPoints = List<FinancialDataPoint>.from(dataPoints)
              ..sort((a, b) => a.date.compareTo(b.date));

            // Calculate Summary Card Data
            final currentPoint = sortedPoints.last;

            // Reference Point Logic: "latest date ... compared to 5y ago ... down to 1y ago"
            // We look for the oldest point within a 5-year window.
            FinancialDataPoint referencePoint =
                sortedPoints.first; // Default fallback

            final currentDate = DateTime.tryParse(currentPoint.date);
            if (currentDate != null) {
              // Annual: 5 years lookback
              // Quarterly: 1 year lookback
              final lookbackYears = isAnnual ? 5 : 1;
              final cutoffDate = DateTime(
                currentDate.year - lookbackYears,
                currentDate.month,
                currentDate.day,
              );
              try {
                // Find the first point (oldest) that is ON or AFTER the cutoff date
                referencePoint = sortedPoints.firstWhere((p) {
                  final d = DateTime.tryParse(p.date);
                  if (d == null) return false;
                  return d.isAfter(cutoffDate) ||
                      d.isAtSameMomentAs(cutoffDate);
                });
              } catch (e) {
                // Fallback to reversedPoints.first if no match (shouldn't happen if current is valid)
              }
            }

            final currentValue = currentPoint.value;
            final referenceValue = referencePoint.value;

            final delta = currentValue - referenceValue;
            final growthPercentage = (referenceValue == 0)
                ? 0.0
                : (delta / referenceValue) * 100;

            final isPositive = delta >= 0;
            final absDelta = delta.abs();

            // Badge Logic: For Shares, Increase is generally Bad (Dilution), Decrease is Good (Buybacks).
            final AppBadgeStyle badgeStyle = isPositive
                ? AppBadgeStyle.critical
                : AppBadgeStyle.good;

            // Reference Date Label
            String referenceLabel;
            final refDate = DateTime.tryParse(referencePoint.date);
            if (refDate != null) {
              if (isAnnual) {
                referenceLabel = DateFormat('yyyy').format(refDate);
              } else {
                // User requested month format (MMM) instead of quarter
                referenceLabel = DateFormat('MMM yyyy').format(refDate);
              }
            } else {
              referenceLabel = referencePoint.period.isEmpty
                  ? referencePoint.date
                  : referencePoint.period;
            }

            // Summary Strings
            final valueStr = numberFormat.format(currentValue);
            final badgeText =
                '${growthPercentage > 0 ? '+' : ''}${growthPercentage.toStringAsFixed(1)}%';
            final subtitle =
                '${isPositive ? 'Increased' : 'Decreased'} by ${numberFormat.format(absDelta)} since $referenceLabel';

            // Chart Data
            final chartData = sortedPoints.map((p) {
              String label;
              final date = DateTime.tryParse(p.date);
              if (date != null) {
                if (isAnnual) {
                  label = DateFormat('yyyy').format(date);
                } else {
                  // Match FCPS format: MMM 'yy
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
                  MetricSummaryCard(
                    title: 'Outstanding Shares (Diluted)',
                    value: valueStr,
                    badgeText: badgeText,
                    badgeStyle: badgeStyle,
                    subtitle: subtitle,
                  ),
                  AppConstants.mainSectionSpacing,
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: BizzieExpandableChart(
                      key: ValueKey(
                        'shares_chart_${isAnnual}_${chartData.length}_${sortedPoints.last.date}',
                      ),
                      data: chartData,
                      numberFormat: numberFormat,
                    ),
                  ),
                  AppConstants.mainSectionSpacing,
                  FinancialDataTable(
                    data: isAnnual
                        ? stats.annualWeightedAverageShares
                        : stats.quarterlyWeightedAverageShares,
                    metricLabel: 'Shares',
                    currency: '', // No currency
                    isInverseGrowth: true, // Specific for Shares
                    periodHeaderLabel: isAnnual
                        ? 'Year Ended'
                        : 'Quarter Ended',
                    dateFormat: isAnnual
                        ? FinancialDateFormat.monthYear
                        : FinancialDateFormat.quarterShort,
                    onViewMore: () => _showAllHistory(
                      context,
                      isAnnual
                          ? stats.annualWeightedAverageShares
                          : stats.quarterlyWeightedAverageShares,
                      isAnnual ? 'Yearly Shares Data' : 'Quarterly Shares Data',
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
                    metricLabel: 'Shares',
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
                          currency: '',
                          isInverseGrowth: true,
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
        return BizzieLoader(message: 'Loading Share', mascotAssetPath: mascot);
      },
    );
  }
}
