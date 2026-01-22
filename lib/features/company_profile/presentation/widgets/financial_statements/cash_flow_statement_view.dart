import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_chart.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statements_table.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';

class CashFlowStatementView extends StatefulWidget {
  final List<CashFlowStatement> annualData;
  final List<CashFlowStatement> quarterlyData;
  final String currency;

  const CashFlowStatementView({
    super.key,
    required this.annualData,
    required this.quarterlyData,
    required this.currency,
  });

  @override
  State<CashFlowStatementView> createState() => _CashFlowStatementViewState();
}

class _CashFlowStatementViewState extends State<CashFlowStatementView>
    with AutomaticKeepAliveClientMixin {
  late CashFlowStatement _selectedAnnualStatement;
  late CashFlowStatement _selectedQuarterStatement;

  @override
  void initState() {
    super.initState();
    _initSelectedStatements();
  }

  @override
  void didUpdateWidget(covariant CashFlowStatementView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.annualData != oldWidget.annualData ||
        widget.quarterlyData != oldWidget.quarterlyData) {
      _initSelectedStatements();
    }
  }

  void _initSelectedStatements() {
    if (widget.annualData.isNotEmpty) {
      _selectedAnnualStatement = widget.annualData.first;
    }
    if (widget.quarterlyData.isNotEmpty) {
      _selectedQuarterStatement = widget.quarterlyData.first;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.annualData.isEmpty && widget.quarterlyData.isEmpty) {
      return const Center(child: Text('No Cash Flow Data'));
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
            dateFormat: 'MMM d, yyyy',
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
    required List<CashFlowStatement> data,
    required CashFlowStatement selectedItem,
    required ValueChanged<CashFlowStatement> onSelect,
    required String dateFormat,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<CashFlowStatement>(
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

  Widget _buildChartFor(CashFlowStatement statement) {
    // 1) O.C.F - Blue
    // 2) I.C.F - Blue
    // 3) Fin.C.F - Blue
    // 4) Free.C.F - Dynamic (Red/Green)

    final ocf = statement.operatingCashFlow;
    final icf = statement.investingCashFlow;
    final fcf = statement.financingCashFlow; // Fin.C.F
    final freeCf = statement.freeCashFlow; // Free C.F

    final data = [
      FinancialStatementChartData('O.C.F', ocf, AppColors.primary),
      FinancialStatementChartData('I.C.F', icf, AppColors.primary),
      FinancialStatementChartData('Fin.C.F', fcf, AppColors.primary),
      FinancialStatementChartData(
        'Free.C.F',
        freeCf,
        freeCf >= 0 ? AppColors.successText : AppColors.red800,
      ),
    ];

    return FinancialStatementChart(data: data, currency: widget.currency);
  }

  Widget _buildTableFor(
    CashFlowStatement currentItem,
    List<CashFlowStatement> dataset,
  ) {
    CashFlowStatement? prevStatement;
    final currentIndex = dataset.indexOf(currentItem);
    if (currentIndex != -1 && currentIndex + 1 < dataset.length) {
      prevStatement = dataset[currentIndex + 1];
    }

    // Base for % calculation is unused in current design but kept for reference if needed
    // final totalBase = currentItem.operatingCashFlow;

    final rows = [
      _buildRow(
        'Operating C.F.',
        currentItem.operatingCashFlow,
        prevStatement?.operatingCashFlow,
        _GrowthColorBehavior.standard,
      ),
      _buildRow(
        'CapEx',
        currentItem.capitalExpenditure,
        prevStatement?.capitalExpenditure,
        _GrowthColorBehavior.inverted,
      ),
      _buildRow(
        'Investing C.F.',
        currentItem.investingCashFlow,
        prevStatement?.investingCashFlow,
        _GrowthColorBehavior.neutral,
      ),
      _buildRow(
        'Financing C.F.',
        currentItem.financingCashFlow,
        prevStatement?.financingCashFlow,
        _GrowthColorBehavior.neutral,
      ),
      _buildRow(
        'Free C.F.',
        currentItem.freeCashFlow,
        prevStatement?.freeCashFlow,
        _GrowthColorBehavior.standard,
      ),
      _buildRow(
        'Starting Cash',
        currentItem.cashAtBeginningOfPeriod,
        prevStatement?.cashAtBeginningOfPeriod,
        _GrowthColorBehavior.standard,
      ),
      _buildRow(
        'Ending Cash',
        currentItem.cashAtEndOfPeriod,
        prevStatement?.cashAtEndOfPeriod,
        _GrowthColorBehavior.standard,
      ),
    ];

    return FinancialStatementsTable(
      rows: rows,
      onViewAll: () => _showFullHistory(context, dataset),
      showPercentage: false, // User Requirement 2
      growthHeader: 'Change', // User Requirement 5
      amountAlignment: Alignment.center, // User Requirement: More Centered
      amountTextAlign: TextAlign.center,
    );
  }

  FinancialStatementTableRow _buildRow(
    String metric,
    double current,
    double? previous,
    _GrowthColorBehavior colorBehavior,
  ) {
    final amountStr = CurrencyFormatter.formatCompact(
      current,
      widget.currency,
      locale: Localizations.localeOf(context).toString(),
    );

    String growthStr = '-';
    Color growthColor = AppColors.textPrimary;

    if (previous != null && previous != 0) {
      double growth;
      if (colorBehavior == _GrowthColorBehavior.inverted) {
        // For CapEx (inverted), we want to show increased spending (more negative) as positive growth
        growth = (current.abs() - previous.abs()) / previous.abs() * 100;
      } else {
        growth = (current - previous) / previous.abs() * 100;
      }

      if (growth > 0) {
        growthStr = '+${growth.toStringAsFixed(1)}%';
        switch (colorBehavior) {
          case _GrowthColorBehavior.standard:
            growthColor = AppColors.successText;
            break;
          case _GrowthColorBehavior.inverted:
            growthColor = AppColors.red800;
            break;
          case _GrowthColorBehavior.neutral:
            growthColor = AppColors.textPrimary;
            break;
        }
      } else if (growth < 0) {
        growthStr = '${growth.toStringAsFixed(1)}%';
        switch (colorBehavior) {
          case _GrowthColorBehavior.standard:
            growthColor = AppColors.red800;
            break;
          case _GrowthColorBehavior.inverted:
            growthColor = AppColors.successText;
            break;
          case _GrowthColorBehavior.neutral:
            growthColor = AppColors.textPrimary;
            break;
        }
      } else {
        growthStr = '0.0%';
        growthColor = AppColors.textPrimary;
      }
    }

    return FinancialStatementTableRow(
      metric: metric,
      amount: amountStr,
      percentage: '',
      growth: growthStr,
      growthColor: growthColor,
    );
  }

  void _showFullHistory(BuildContext context, List<CashFlowStatement> dataset) {
    AppHistoryModalHelper.show<CashFlowStatement>(
      context: context,
      title: 'Cash Flow History',
      header: const _CashFlowHistoryHeader(),
      data: dataset,
      itemBuilder: (context, item, index) =>
          _CashFlowHistoryRow(item: item, currency: widget.currency),
    );
  }
}

enum _GrowthColorBehavior { standard, inverted, neutral }

class _CashFlowHistoryHeader extends StatelessWidget {
  const _CashFlowHistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
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
            'O.C.F',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'CapEx',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Free C.F',
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMediumBoldSecondary,
          ),
        ),
      ],
    );
  }
}

class _CashFlowHistoryRow extends StatelessWidget {
  final CashFlowStatement item;
  final String currency;

  const _CashFlowHistoryRow({required this.item, required this.currency});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(item.date);
    String yearText = item.date;

    if (item.period.isNotEmpty) {
      if (date != null) {
        yearText = '${item.period} | ${date.year}';
      } else {
        yearText = item.period;
      }
    } else if (date != null) {
      yearText = date.year.toString();
    }

    final ocf = CurrencyFormatter.formatCompact(
      item.operatingCashFlow,
      currency,
      locale: Localizations.localeOf(context).toString(),
    );

    final capex = CurrencyFormatter.formatCompact(
      item.capitalExpenditure,
      currency,
      locale: Localizations.localeOf(context).toString(),
    );

    final freeCf = CurrencyFormatter.formatCompact(
      item.freeCashFlow,
      currency,
      locale: Localizations.localeOf(context).toString(),
    );

    final fcfColor = item.freeCashFlow >= 0
        ? AppColors.goodText
        : AppColors.criticalText;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            yearText,
            textAlign: TextAlign.left,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            ocf,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            capex,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMediumBold,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            freeCf,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodyMediumBold.copyWith(color: fcfColor),
          ),
        ),
      ],
    );
  }
}
