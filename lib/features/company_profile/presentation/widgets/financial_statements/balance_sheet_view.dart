import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/balance_sheet_pie_chart.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statements_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BalanceSheetView extends StatefulWidget {
  final List<BalanceSheet> annualData;
  final List<BalanceSheet> quarterlyData;
  final List<IncomeStatement>? annualIncome;
  final List<IncomeStatement>? quarterlyIncome;

  const BalanceSheetView({
    super.key,
    required this.annualData,
    required this.quarterlyData,
    this.annualIncome,
    this.quarterlyIncome,
  });

  @override
  State<BalanceSheetView> createState() => _BalanceSheetViewState();
}

class _BalanceSheetViewState extends State<BalanceSheetView> {
  // We prioritize Quarterly data as per user request ("simply use quarterly")
  // We prioritize Quarterly data as per user request ("simply use quarterly")
  BalanceSheet? _selectedStatement;
  final PageController _pageController = PageController();
  late List<BalanceSheet> _activeData;
  late List<IncomeStatement>? _activeIncomeData;

  @override
  void initState() {
    super.initState();
    _initSelectedStatements();
  }

  @override
  void didUpdateWidget(covariant BalanceSheetView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.annualData != oldWidget.annualData ||
        widget.quarterlyData != oldWidget.quarterlyData ||
        widget.annualIncome != oldWidget.annualIncome ||
        widget.quarterlyIncome != oldWidget.quarterlyIncome) {
      _initSelectedStatements();
    }
  }

  void _initSelectedStatements() {
    // User requested "simply use quarterly balance sheet".
    // Fallback to annual only if quarterly is empty for robustness,
    if (widget.quarterlyData.isNotEmpty) {
      _activeData = widget.quarterlyData;
      _activeIncomeData = widget.quarterlyIncome;
    } else {
      _activeData = widget.annualData;
      _activeIncomeData = widget.annualIncome;
    }

    if (_activeData.isNotEmpty) {
      // Preserve selection if possible
      if (_selectedStatement != null &&
          mounted &&
          _activeData.any((e) => e.date == _selectedStatement!.date)) {
        _selectedStatement = _activeData.firstWhere(
          (e) => e.date == _selectedStatement!.date,
        );
      } else {
        _selectedStatement = _activeData.first;
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildChartsCarousel(
    BalanceSheet statement,
    PageController controller,
  ) {
    final charts = [
      BalanceSheetPieChart(
        key: const ValueKey('assets_chart'),
        title: 'Assets vs Liabilities & Equity',
        data: [
          BalanceSheetPieChartData(
            'Assets',
            statement.totalAssets,
            AppColors.successText,
          ),
          BalanceSheetPieChartData(
            'Liabilities',
            statement.totalLiabilities,
            AppColors.error,
          ),
          BalanceSheetPieChartData(
            'Equity',
            statement.totalEquity,
            AppColors.primary,
          ),
        ],
      ),
      BalanceSheetPieChart(
        key: const ValueKey('ratio_chart'),
        title: 'Current Ratio Breakdown',
        data: [
          BalanceSheetPieChartData(
            'Current Assets',
            statement.totalCurrentAssets,
            AppColors.successText,
          ),
          BalanceSheetPieChartData(
            'Current Liabilities',
            statement.totalCurrentLiabilities,
            AppColors.error,
          ),
        ],
      ),
      BalanceSheetPieChart(
        key: const ValueKey('capital_chart'),
        title: 'Capital Structure',
        data: [
          BalanceSheetPieChartData(
            'L.T. Debt',
            statement.longTermDebt,
            AppColors.error,
          ),
          BalanceSheetPieChartData(
            'S.T. Debt',
            statement.shortTermDebt,
            Colors.red[900]!,
          ),
          BalanceSheetPieChartData(
            'Equity',
            statement.totalEquity,
            AppColors.primary,
          ),
        ],
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 320,
          child: PageView(controller: controller, children: charts),
        ),
        AppConstants.secondarySectionSpacing,
        SmoothPageIndicator(
          controller: controller,
          count: charts.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Color(0xFF2563EB), // Royal Blue (matches News Tab)
            dotColor: Color(0xFFE2E8F0), // Slate 200
          ),
        ),
      ],
    );
  }

  Widget _buildTableFor(BalanceSheet currentItem, List<BalanceSheet> dataset) {
    // 1) totalNonCurrentAssets
    // 2) totalCurrentAssets
    // 3) Total Assets
    // 4) totalCurrentLiabilities
    // 5) totalNonCurrentLiabilities
    // 6) Total Liabilities
    // 7) roe (return on equity)

    // Find previous statement first (needed for Growth calcs)
    // Find previous statement first (needed for Growth calcs)
    BalanceSheet? prevStatement;
    if (dataset.isNotEmpty) {
      final index = dataset.indexOf(currentItem);
      if (index != -1 && index + 1 < dataset.length) {
        prevStatement = dataset[index + 1];
      }
    }

    // Calculate ROE
    // We need netIncome from the matching period in IncomeStatement
    double? netIncome;
    String roeStr = '-';

    if (_activeIncomeData != null) {
      try {
        // Match by date
        final incomeStatement = _activeIncomeData!.firstWhere(
          (e) => e.date == currentItem.date,
        );
        netIncome = incomeStatement.netIncome;
      } catch (e) {
        // No matching income statement found
      }
    }

    if (netIncome != null && currentItem.totalEquity != 0) {
      final roe = (netIncome / currentItem.totalEquity) * 100;
      roeStr = '${roe.toStringAsFixed(1)}%';
    }

    // Calculate ROE Growth
    String roeGrowthStr = '-';
    Color roeGrowthColor = AppColors.textPrimary;

    if (prevStatement != null && _activeIncomeData != null) {
      try {
        final prevIncome = _activeIncomeData!.firstWhere(
          (e) => e.date == prevStatement!.date,
        );
        final prevNetIncome = prevIncome.netIncome;
        final prevEquity = prevStatement.totalEquity;

        if (prevEquity != 0) {
          final prevRoe = (prevNetIncome / prevEquity) * 100;
          // Current ROE
          double? currentRoe;
          if (netIncome != null && currentItem.totalEquity != 0) {
            currentRoe = (netIncome / currentItem.totalEquity) * 100;
          }

          if (currentRoe != null && prevRoe != 0) {
            final growth = (currentRoe - prevRoe) / prevRoe.abs() * 100;
            if (growth > 0) {
              roeGrowthStr = '+${growth.toStringAsFixed(1)}%';
              roeGrowthColor = AppColors.successText;
            } else if (growth < 0) {
              roeGrowthStr = '${growth.toStringAsFixed(1)}%';
              roeGrowthColor = AppColors.red800;
            } else {
              roeGrowthStr = '0.0%';
            }
          }
        }
      } catch (e) {
        // Missing previous income data
      }
    }

    final rows = [
      _buildRow(
        'Total Current Assets',
        currentItem.totalCurrentAssets,
        prevStatement?.totalCurrentAssets,
        currentItem.totalAssets,
      ),
      _buildRow(
        'Total Non-Current Assets',
        currentItem.totalNonCurrentAssets,
        prevStatement?.totalNonCurrentAssets,
        currentItem.totalAssets,
      ),
      _buildRow(
        'Total Assets',
        currentItem.totalAssets,
        prevStatement?.totalAssets,
        currentItem.totalAssets,
      ),
      _buildRow(
        'Total Current Liabilities',
        currentItem.totalCurrentLiabilities,
        prevStatement?.totalCurrentLiabilities,
        currentItem.totalAssets,
        isLiability: true,
      ),
      _buildRow(
        'Total Non-Current Liabilities',
        currentItem.totalNonCurrentLiabilities,
        prevStatement?.totalNonCurrentLiabilities,
        currentItem.totalAssets,
        isLiability: true,
      ),
      _buildRow(
        'Total Liabilities',
        currentItem.totalLiabilities,
        prevStatement?.totalLiabilities,
        currentItem.totalAssets,
        isLiability: true,
      ),
      _buildRow(
        'Total Equity',
        currentItem.totalEquity,
        prevStatement?.totalEquity,
        currentItem.totalAssets,
      ),
      // ROE Row
      FinancialStatementTableRow(
        metric: 'ROE',
        amount: roeStr,
        percentage: '', // N/A for ROE
        growth: roeGrowthStr,
        growthColor: roeGrowthColor,
      ),
    ];

    return FinancialStatementsTable(
      rows: rows,
      onViewAll: () => _showBalanceSheetHistory(context, dataset),
      showPercentage: false,
      amountAlignment: Alignment.center,
      amountTextAlign: TextAlign.center,
    );
  }

  void _showBalanceSheetHistory(
    BuildContext context,
    List<BalanceSheet> dataset,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AppBottomModal(
          title: 'Full Balance Sheet History',
          builder: (context, scrollController) {
            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Year',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Assets',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Liabilities',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Equity',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.slate50),
                // List
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: dataset.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.slate50),
                    itemBuilder: (context, index) {
                      final item = dataset[index];
                      // Date processing
                      final date = DateTime.tryParse(item.date);
                      String year = item.date;
                      if (date != null) {
                        if (item.period.isNotEmpty) {
                          // e.g. Q4 2024
                          year = '${item.period} ${date.year}';
                        } else {
                          year = date.year.toString();
                        }
                      }

                      final currency = item.reportedCurrency;
                      final locale = Localizations.localeOf(context).toString();

                      final assets = CurrencyFormatter.formatCompact(
                        item.totalAssets,
                        currency,
                        locale: locale,
                      );

                      final liabilities = CurrencyFormatter.formatCompact(
                        item.totalLiabilities,
                        currency,
                        locale: locale,
                      );

                      final equityVal = item.totalEquity;
                      final equity = CurrencyFormatter.formatCompact(
                        equityVal,
                        currency,
                        locale: locale,
                      );
                      final equityColor = equityVal >= 0
                          ? AppColors.successText
                          : AppColors.red800;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                year,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                assets,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                liabilities,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                equity,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: equityColor,
                                ),
                              ),
                            ),
                          ],
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

  FinancialStatementTableRow _buildRow(
    String metric,
    double amount,
    double? previous,
    double? totalAssets, {
    bool isBold = false,
    bool isLiability = false,
  }) {
    // Amount Formatting
    final amountStr = CurrencyFormatter.formatCompact(
      amount,
      'USD', // Assuming USD or get from data if available. DTO has reportedCurrency.
      locale: Localizations.localeOf(context).toString(),
    );

    // % of Total Assets
    String percentStr = '-';
    if (totalAssets != null && totalAssets != 0) {
      final percent = (amount / totalAssets) * 100;
      percentStr = '${percent.toStringAsFixed(1)}%';
    }

    // QoQ Growth
    String growthStr = '-';
    Color growthColor = AppColors.textPrimary;

    if (previous != null && previous != 0) {
      final growth = (amount - previous) / previous.abs() * 100;
      if (growth > 0) {
        growthStr = '+${growth.toStringAsFixed(1)}%';
        // For Liabilities, positive growth is Bad (Red)
        growthColor = isLiability ? AppColors.red800 : AppColors.successText;
      } else if (growth < 0) {
        growthStr = '${growth.toStringAsFixed(1)}%';
        // For Liabilities, negative growth is Good (Green)
        growthColor = isLiability ? AppColors.successText : AppColors.red800;
      } else {
        growthStr = '0.0%';
      }
    }

    return FinancialStatementTableRow(
      metric: metric,
      amount: amountStr,
      percentage: percentStr,
      growth: growthStr,
      growthColor: growthColor,
      isBold: isBold,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_activeData.isEmpty) {
      return const Center(child: Text('No Balance Sheet Data'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<BalanceSheet>(
          title: '',
          items: _activeData,
          selectedItem: _selectedStatement!,
          onItemSelected: (item) => setState(() => _selectedStatement = item),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
        ),
        AppConstants.mainSectionSpacing,
        _buildChartsCarousel(_selectedStatement!, _pageController),
        AppConstants.mainSectionSpacing,
        _buildTableFor(_selectedStatement!, _activeData),
      ],
    );
  }
}
