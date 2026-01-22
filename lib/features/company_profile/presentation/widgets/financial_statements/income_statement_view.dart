import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_chart.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statements_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';

class IncomeStatementView extends StatefulWidget {
  final List<IncomeStatement> annualData;
  final List<IncomeStatement> quarterlyData;
  final String currency;

  const IncomeStatementView({
    super.key,
    required this.annualData,
    required this.quarterlyData,
    required this.currency,
  });

  @override
  State<IncomeStatementView> createState() => _IncomeStatementViewState();
}

class _IncomeStatementViewState extends State<IncomeStatementView> {
  late IncomeStatement _selectedAnnualStatement;
  late IncomeStatement _selectedQuarterStatement;

  @override
  void initState() {
    super.initState();
    _initSelectedStatements();
  }

  @override
  void didUpdateWidget(covariant IncomeStatementView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.annualData != oldWidget.annualData ||
        widget.quarterlyData != oldWidget.quarterlyData) {
      _initSelectedStatements();
    }
  }

  void _initSelectedStatements() {
    if (widget.annualData.isNotEmpty) {
      // Sort desc just in case, or assume sorted
      _selectedAnnualStatement = widget.annualData.first;
    }
    if (widget.quarterlyData.isNotEmpty) {
      _selectedQuarterStatement = widget.quarterlyData.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.annualData.isEmpty && widget.quarterlyData.isEmpty) {
      return const Center(child: Text('No Income Statement Data'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.annualData.isNotEmpty) ...[
          _buildSection(
            title: 'For the Year Ended',
            data: widget.annualData,
            selectedItem: _selectedAnnualStatement,
            onSelect: (item) => setState(() => _selectedAnnualStatement = item),
            dateFormat: 'MMM d, yyyy', // e.g. Sep 28, 2024
          ),
          AppConstants.mainSectionSpacing,
        ],
        if (widget.quarterlyData.isNotEmpty) ...[
          _buildSection(
            title: 'For the Quarter Ended',
            data: widget.quarterlyData,
            selectedItem: _selectedQuarterStatement,
            onSelect: (item) =>
                setState(() => _selectedQuarterStatement = item),
            dateFormat: 'MMM d, yyyy',
          ),
        ],
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<IncomeStatement> data,
    required IncomeStatement selectedItem,
    required ValueChanged<IncomeStatement> onSelect,
    required String dateFormat,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<IncomeStatement>(
          title: title,
          items: data,
          selectedItem: selectedItem,
          onItemSelected: onSelect,
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          dateFormat: dateFormat,
        ),
        AppConstants.mainSectionSpacing,
        _buildChartFor(selectedItem),
        AppConstants.mainSectionSpacing,
        _buildTableFor(selectedItem, data),
      ],
    );
  }

  Widget _buildChartFor(IncomeStatement statement) {
    final revenue = statement.revenue;
    final expenses = statement.costAndExpenses;
    final netIncome = statement.netIncome;

    final data = [
      FinancialStatementChartData('Revenue', revenue, AppColors.primary),
      FinancialStatementChartData('Expenses', expenses, AppColors.primary),
      FinancialStatementChartData(
        'Net Income',
        netIncome,
        netIncome >= 0 ? AppColors.successText : AppColors.red800,
      ),
    ];

    return FinancialStatementChart(data: data, currency: widget.currency);
  }

  Widget _buildTableFor(
    IncomeStatement currentItem,
    List<IncomeStatement> dataset,
  ) {
    IncomeStatement? prevStatement;
    final currentIndex = dataset.indexOf(currentItem);
    if (currentIndex != -1 && currentIndex + 1 < dataset.length) {
      prevStatement = dataset[currentIndex + 1];
    }

    final rows = [
      _buildRow(
        'Revenue',
        currentItem.revenue,
        prevStatement?.revenue,
        currentItem.revenue, // Pass total revenue for margin calc
        true,
      ),
      _buildRow(
        'Cost of Revenue',
        currentItem.costOfRevenue,
        prevStatement?.costOfRevenue,
        currentItem.revenue,
      ),
      _buildRow(
        'Gross Profit',
        currentItem.grossProfit,
        prevStatement?.grossProfit,
        currentItem.revenue,
        true,
      ),
      _buildRow(
        'Operating Exp.',
        currentItem.operatingExpenses,
        prevStatement?.operatingExpenses,
        currentItem.revenue,
      ),
      _buildRow(
        'Op. Income',
        currentItem.operatingIncome,
        prevStatement?.operatingIncome,
        currentItem.revenue,
      ),
      _buildRow(
        'Net Income',
        currentItem.netIncome,
        prevStatement?.netIncome,
        currentItem.revenue,
        true,
      ),
    ];

    return FinancialStatementsTable(
      rows: rows,
      onViewAll: () => _showFullHistory(context, dataset),
    );
  }

  void _showFullHistory(BuildContext context, List<IncomeStatement> dataset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AppBottomModal(
          title: 'Full History',
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: AppConstants.bottomModalPadding,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Year',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.bodyMediumBoldSecondary,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Revenue',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMediumBoldSecondary,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Net Income',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMediumBoldSecondary,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Margin %',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.bodyMediumBoldSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppConstants.subSectionSpacing,
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: AppConstants.bottomModalPadding,
                    itemCount: dataset.length,
                    itemBuilder: (context, index) {
                      final item = dataset[index];
                      final date = DateTime.tryParse(item.date);
                      final year = date != null
                          ? date.year.toString()
                          : item.date;

                      final revenue = CurrencyFormatter.formatCompact(
                        item.revenue,
                        widget.currency,
                        locale: Localizations.localeOf(context).toString(),
                      );

                      final netIncome = CurrencyFormatter.formatCompact(
                        item.netIncome,
                        widget.currency,
                        locale: Localizations.localeOf(context).toString(),
                      );

                      String marginStr = '-';
                      Color marginColor = AppColors.textPrimary;
                      if (item.revenue != 0) {
                        final margin = (item.netIncome / item.revenue) * 100;
                        marginStr = '${margin.toStringAsFixed(1)}%';
                        if (margin > 0) {
                          marginColor = AppColors.successText;
                        } else if (margin < 0) {
                          marginColor = AppColors.red800;
                        }
                      }

                      return Padding(
                        padding: AppConstants.dataRowVerticalPadding,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                year,
                                textAlign: TextAlign.left,
                                style: AppTextStyles.bodyMedium,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                revenue,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMediumBold,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                netIncome,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyMediumBold,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                marginStr,
                                textAlign: TextAlign.right,
                                style: AppTextStyles.bodyMediumBold.copyWith(
                                  color: marginColor,
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
    double current,
    double? previous,
    double totalRevenue, [
    bool isBold = false,
  ]) {
    // Amount
    final amountStr = CurrencyFormatter.formatCompact(
      current,
      widget.currency,
      locale: Localizations.localeOf(context).toString(),
    );

    // % (Percent of Revenue?) usually common size analysis
    // or just % change?
    // Design says "%" and "Growth".
    // "Growth" is clearly YoY change.
    // "%" is likely "Margin" (as % of Revenue).

    String percentStr = '-';
    if (totalRevenue != 0) {
      final margin = (current / totalRevenue) * 100;
      percentStr = '${margin.toStringAsFixed(1)}%';
    }

    // Growth
    String growthStr = '-';
    Color growthColor = AppColors.textPrimary;

    if (previous != null && previous != 0) {
      final growth =
          (current - previous) /
          previous.abs() *
          100; // .abs() for denominator usually?
      if (growth > 0) {
        growthStr = '+${growth.toStringAsFixed(1)}%';
        growthColor = AppColors.successText;
      } else if (growth < 0) {
        growthStr = '${growth.toStringAsFixed(1)}%';
        growthColor = AppColors.red800;
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
    );
  }
}
