import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/utils/financial_statement_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_color_behavior.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/growth_display_formatter.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

const double _percentFactor = 100;
const int _percentFractionDigits = 1;

final List<_RowSpec<IncomeStatement>> _incomeRowSpecs = [
  _RowSpec(
    metric: 'Revenue',
    valueOf: (statement) => statement.revenue,
    isBold: true,
  ),
  _RowSpec(
    metric: 'Cost of Revenue',
    valueOf: (statement) => statement.costOfRevenue,
  ),
  _RowSpec(
    metric: 'Gross Profit',
    valueOf: (statement) => statement.grossProfit,
    isBold: true,
  ),
  _RowSpec(
    metric: 'Operating Exp.',
    valueOf: (statement) => statement.operatingExpenses,
  ),
  _RowSpec(
    metric: 'Op. Income',
    valueOf: (statement) => statement.operatingIncome,
  ),
  _RowSpec(
    metric: 'Net Income',
    valueOf: (statement) => statement.netIncome,
    isBold: true,
  ),
];

final List<_RowSpec<BalanceSheet>> _balanceRowSpecs = [
  _RowSpec(
    metric: 'Total Current Assets',
    valueOf: (statement) => statement.totalCurrentAssets,
  ),
  _RowSpec(
    metric: 'Total Non-Current Assets',
    valueOf: (statement) => statement.totalNonCurrentAssets,
  ),
  _RowSpec(
    metric: 'Total Assets',
    valueOf: (statement) => statement.totalAssets,
  ),
  _RowSpec(
    metric: 'Total Current Liabilities',
    valueOf: (statement) => statement.totalCurrentLiabilities,
    colorBehavior: GrowthColorBehavior.inverted,
  ),
  _RowSpec(
    metric: 'Total Non-Current Liabilities',
    valueOf: (statement) => statement.totalNonCurrentLiabilities,
    colorBehavior: GrowthColorBehavior.inverted,
  ),
  _RowSpec(
    metric: 'Total Liabilities',
    valueOf: (statement) => statement.totalLiabilities,
    colorBehavior: GrowthColorBehavior.inverted,
  ),
  _RowSpec(
    metric: 'Total Equity',
    valueOf: (statement) => statement.totalEquity,
  ),
];

final List<_RowSpec<CashFlowStatement>> _cashFlowRowSpecs = [
  _RowSpec(
    metric: 'Operating C.F.',
    valueOf: (statement) => statement.operatingCashFlow,
  ),
  _RowSpec(
    metric: 'CapEx',
    valueOf: (statement) => statement.capitalExpenditure,
    colorBehavior: GrowthColorBehavior.inverted,
  ),
  _RowSpec(
    metric: 'Investing C.F.',
    valueOf: (statement) => statement.investingCashFlow,
    colorBehavior: GrowthColorBehavior.neutral,
  ),
  _RowSpec(
    metric: 'Financing C.F.',
    valueOf: (statement) => statement.financingCashFlow,
    colorBehavior: GrowthColorBehavior.neutral,
  ),
  _RowSpec(metric: 'Free C.F.', valueOf: (statement) => statement.freeCashFlow),
  _RowSpec(
    metric: 'Starting Cash',
    valueOf: (statement) => statement.cashAtBeginningOfPeriod,
  ),
  _RowSpec(
    metric: 'Ending Cash',
    valueOf: (statement) => statement.cashAtEndOfPeriod,
  ),
];

extension FinancialStatementsStateX on FinancialStatementsState {
  IncomeStatement get selectedAnnualIncomeStatement =>
      annualIncomeStatements.firstWhere(
        (e) => e.date == selectedAnnualIncomeDate,
        orElse: () => annualIncomeStatements.first,
      );

  IncomeStatement get selectedQuarterlyIncomeStatement =>
      quarterlyIncomeStatements.firstWhere(
        (e) => e.date == selectedQuarterlyIncomeDate,
        orElse: () => quarterlyIncomeStatements.first,
      );

  BalanceSheet get selectedQuarterlyBalanceSheet =>
      quarterlyBalanceSheets.firstWhere(
        (e) => e.date == selectedQuarterlyBalanceDate,
        orElse: () => quarterlyBalanceSheets.first,
      );

  CashFlowStatement get selectedAnnualCashFlowStatement =>
      annualCashFlowStatements.firstWhere(
        (e) => e.date == selectedAnnualCashFlowDate,
        orElse: () => annualCashFlowStatements.first,
      );

  CashFlowStatement get selectedQuarterlyCashFlowStatement =>
      quarterlyCashFlowStatements.firstWhere(
        (e) => e.date == selectedQuarterlyCashFlowDate,
        orElse: () => quarterlyCashFlowStatements.first,
      );

  List<FinancialStatementTableRow> incomeRows({
    required String locale,
    required bool isAnnual,
  }) {
    return _tableRows(
      statements: isAnnual ? annualIncomeStatements : quarterlyIncomeStatements,
      selectedDate: isAnnual
          ? selectedAnnualIncomeDate
          : selectedQuarterlyIncomeDate,
      dateOf: (statement) => statement.date,
      totalBaseOf: (statement) => statement.revenue,
      rowSpecs: _incomeRowSpecs,
      locale: locale,
    );
  }

  List<FinancialStatementTableRow> balanceRows({
    required String locale,
    required bool isAnnual,
  }) {
    return _tableRows(
      statements: isAnnual ? annualBalanceSheets : quarterlyBalanceSheets,
      selectedDate: isAnnual
          ? selectedAnnualBalanceDate
          : selectedQuarterlyBalanceDate,
      dateOf: (statement) => statement.date,
      totalBaseOf: (statement) => statement.totalAssets,
      rowSpecs: _balanceRowSpecs,
      locale: locale,
    );
  }

  List<FinancialStatementTableRow> cashFlowRows({
    required String locale,
    required bool isAnnual,
  }) {
    return _tableRows(
      statements: isAnnual
          ? annualCashFlowStatements
          : quarterlyCashFlowStatements,
      selectedDate: isAnnual
          ? selectedAnnualCashFlowDate
          : selectedQuarterlyCashFlowDate,
      dateOf: (statement) => statement.date,
      rowSpecs: _cashFlowRowSpecs,
      locale: locale,
    );
  }

  FinancialHistoryRowData incomeHistoryRowData(
    IncomeStatement item,
    String locale,
  ) {
    final marginPercent = _percentOfBase(item.netIncome, item.revenue);

    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: _formatCompact(item.revenue, locale),
      value2: _formatCompact(item.netIncome, locale),
      value3: _formatPercent(marginPercent),
      value3Color: GrowthDisplayFormatter.colorFor(marginPercent),
    );
  }

  FinancialHistoryRowData balanceHistoryRowData(
    BalanceSheet item,
    String locale,
  ) {
    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: _formatCompact(item.totalAssets, locale),
      value2: _formatCompact(item.totalLiabilities, locale),
      value3: _formatCompact(item.totalEquity, locale),
      value3Color: _signColor(item.totalEquity),
    );
  }

  FinancialHistoryRowData cashFlowHistoryRowData(
    CashFlowStatement item,
    String locale,
  ) {
    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: _formatCompact(item.operatingCashFlow, locale),
      value2: _formatCompact(item.capitalExpenditure, locale),
      value3: _formatCompact(item.freeCashFlow, locale),
      value3Color: _signColor(item.freeCashFlow),
    );
  }

  List<FinancialStatementTableRow> _tableRows<T>({
    required List<T> statements,
    required String? selectedDate,
    required String Function(T) dateOf,
    required List<_RowSpec<T>> rowSpecs,
    required String locale,
    double Function(T)? totalBaseOf,
  }) {
    final current = _findStatement(statements, selectedDate, dateOf);
    if (current == null) return [];

    final previous = _findPrevious(statements, current);
    final totalBase = totalBaseOf == null ? null : totalBaseOf(current);

    return [
      for (final rowSpec in rowSpecs)
        _buildRow(
          rowSpec: rowSpec,
          current: current,
          previous: previous,
          totalBase: totalBase,
          locale: locale,
        ),
    ];
  }

  T? _findStatement<T>(
    List<T> statements,
    String? date,
    String Function(T) dateOf,
  ) {
    if (date == null) return null;
    return statements.firstWhereOrNull(
      (statement) => dateOf(statement) == date,
    );
  }

  T? _findPrevious<T>(List<T> statements, T current) {
    final index = statements.indexOf(current);
    if (index != -1 && index + 1 < statements.length) {
      return statements[index + 1];
    }
    return null;
  }

  FinancialStatementTableRow _buildRow<T>({
    required _RowSpec<T> rowSpec,
    required T current,
    required T? previous,
    required double? totalBase,
    required String locale,
  }) {
    final value = rowSpec.valueOf(current);
    final previousValue = previous == null ? null : rowSpec.valueOf(previous);

    final growth = GrowthDisplayFormatter.format(
      _growthPercent(value, previousValue, rowSpec.colorBehavior),
      colorBehavior: rowSpec.colorBehavior,
    );

    return FinancialStatementTableRow(
      metric: rowSpec.metric,
      amount: _formatCompact(value, locale),
      secondaryValue: _formatPercent(_percentOfBase(value, totalBase)),
      growth: growth.text,
      growthColor: growth.color,
      isBold: rowSpec.isBold,
    );
  }

  double? _growthPercent(
    double value,
    double? previousValue,
    GrowthColorBehavior colorBehavior,
  ) {
    if (previousValue == null || previousValue == 0) return null;
    return colorBehavior == GrowthColorBehavior.inverted
        ? (value.abs() - previousValue.abs()) /
              previousValue.abs() *
              _percentFactor
        : (value - previousValue) / previousValue.abs() * _percentFactor;
  }

  double? _percentOfBase(double value, double? base) {
    if (base == null || base == 0) return null;
    return (value / base) * _percentFactor;
  }

  String _formatPercent(double? percent) {
    if (percent == null) return '-';
    return '${percent.toStringAsFixed(_percentFractionDigits)}%';
  }

  String _formatCompact(double value, String locale) =>
      CurrencyFormatter.formatCompact(value, reportedCurrency, locale: locale);

  Color _signColor(double value) =>
      value >= 0 ? AppColors.successText : AppColors.criticalText;
}

class _RowSpec<T> {
  const _RowSpec({
    required this.metric,
    required this.valueOf,
    this.colorBehavior = GrowthColorBehavior.standard,
    this.isBold = false,
  });

  final String metric;
  final double Function(T) valueOf;
  final GrowthColorBehavior colorBehavior;
  final bool isBold;
}
