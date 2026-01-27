import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_color_behavior.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/utils/financial_statement_extensions.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:flutter/material.dart';

extension FinancialStatementsStateX on FinancialStatementsState {
  List<FinancialStatementTableRow> incomeRows({
    required String locale,
    required bool isAnnual,
  }) {
    final list = isAnnual ? annualIncomeStatements : quarterlyIncomeStatements;
    final selectedDate = isAnnual
        ? selectedAnnualIncomeDate
        : selectedQuarterlyIncomeDate;

    final current = _findStatement(list, selectedDate);
    if (current == null) return [];

    final prev = _findPrevious(list, current);
    final currency = reportedCurrency;

    return [
      _buildRow(
        locale: locale,
        metric: 'Revenue',
        current: current.revenue,
        previous: prev?.revenue,
        currency: currency,
        totalBase: current.revenue,
        isBold: true,
      ),
      _buildRow(
        locale: locale,
        metric: 'Cost of Revenue',
        current: current.costOfRevenue,
        previous: prev?.costOfRevenue,
        currency: currency,
        totalBase: current.revenue,
      ),
      _buildRow(
        locale: locale,
        metric: 'Gross Profit',
        current: current.grossProfit,
        previous: prev?.grossProfit,
        currency: currency,
        totalBase: current.revenue,
        isBold: true,
      ),
      _buildRow(
        locale: locale,
        metric: 'Operating Exp.',
        current: current.operatingExpenses,
        previous: prev?.operatingExpenses,
        currency: currency,
        totalBase: current.revenue,
      ),
      _buildRow(
        locale: locale,
        metric: 'Op. Income',
        current: current.operatingIncome,
        previous: prev?.operatingIncome,
        currency: currency,
        totalBase: current.revenue,
      ),
      _buildRow(
        locale: locale,
        metric: 'Net Income',
        current: current.netIncome,
        previous: prev?.netIncome,
        currency: currency,
        totalBase: current.revenue,
        isBold: true,
      ),
    ];
  }

  List<FinancialStatementTableRow> balanceRows({
    required String locale,
    required bool isAnnual,
  }) {
    final list = isAnnual ? annualBalanceSheets : quarterlyBalanceSheets;
    final selectedDate = isAnnual
        ? selectedAnnualBalanceDate
        : selectedQuarterlyBalanceDate;

    final current = _findStatement(list, selectedDate);
    if (current == null) return [];

    final prev = _findPrevious(list, current);
    final currency = reportedCurrency;

    return [
      _buildRow(
        locale: locale,
        metric: 'Total Current Assets',
        current: current.totalCurrentAssets,
        previous: prev?.totalCurrentAssets,
        currency: currency,
        totalBase: current.totalAssets,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Non-Current Assets',
        current: current.totalNonCurrentAssets,
        previous: prev?.totalNonCurrentAssets,
        currency: currency,
        totalBase: current.totalAssets,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Assets',
        current: current.totalAssets,
        previous: prev?.totalAssets,
        currency: currency,
        totalBase: current.totalAssets,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Current Liabilities',
        current: current.totalCurrentLiabilities,
        previous: prev?.totalCurrentLiabilities,
        currency: currency,
        totalBase: current.totalAssets,
        colorBehavior: GrowthColorBehavior.inverted,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Non-Current Liabilities',
        current: current.totalNonCurrentLiabilities,
        previous: prev?.totalNonCurrentLiabilities,
        currency: currency,
        totalBase: current.totalAssets,
        colorBehavior: GrowthColorBehavior.inverted,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Liabilities',
        current: current.totalLiabilities,
        previous: prev?.totalLiabilities,
        currency: currency,
        totalBase: current.totalAssets,
        colorBehavior: GrowthColorBehavior.inverted,
      ),
      _buildRow(
        locale: locale,
        metric: 'Total Equity',
        current: current.totalEquity,
        previous: prev?.totalEquity,
        currency: currency,
        totalBase: current.totalAssets,
      ),
    ];
  }

  List<FinancialStatementTableRow> cashFlowRows({
    required String locale,
    required bool isAnnual,
  }) {
    final list = isAnnual
        ? annualCashFlowStatements
        : quarterlyCashFlowStatements;
    final selectedDate = isAnnual
        ? selectedAnnualCashFlowDate
        : selectedQuarterlyCashFlowDate;

    final current = _findStatement(list, selectedDate);
    if (current == null) return [];

    final prev = _findPrevious(list, current);
    final currency = reportedCurrency;

    return [
      _buildRow(
        locale: locale,
        metric: 'Operating C.F.',
        current: current.operatingCashFlow,
        previous: prev?.operatingCashFlow,
        currency: currency,
      ),
      _buildRow(
        locale: locale,
        metric: 'CapEx',
        current: current.capitalExpenditure,
        previous: prev?.capitalExpenditure,
        currency: currency,
        colorBehavior: GrowthColorBehavior.inverted,
      ),
      _buildRow(
        locale: locale,
        metric: 'Investing C.F.',
        current: current.investingCashFlow,
        previous: prev?.investingCashFlow,
        currency: currency,
        colorBehavior: GrowthColorBehavior.neutral,
      ),
      _buildRow(
        locale: locale,
        metric: 'Financing C.F.',
        current: current.financingCashFlow,
        previous: prev?.financingCashFlow,
        currency: currency,
        colorBehavior: GrowthColorBehavior.neutral,
      ),
      _buildRow(
        locale: locale,
        metric: 'Free C.F.',
        current: current.freeCashFlow,
        previous: prev?.freeCashFlow,
        currency: currency,
      ),
      _buildRow(
        locale: locale,
        metric: 'Starting Cash',
        current: current.cashAtBeginningOfPeriod,
        previous: prev?.cashAtBeginningOfPeriod,
        currency: currency,
      ),
      _buildRow(
        locale: locale,
        metric: 'Ending Cash',
        current: current.cashAtEndOfPeriod,
        previous: prev?.cashAtEndOfPeriod,
        currency: currency,
      ),
    ];
  }

  FinancialHistoryRowData incomeHistoryRowData(
    IncomeStatement item,
    String locale,
  ) {
    final revenue = CurrencyFormatter.formatCompact(
      item.revenue,
      reportedCurrency,
      locale: locale,
    );
    final netIncome = CurrencyFormatter.formatCompact(
      item.netIncome,
      reportedCurrency,
      locale: locale,
    );

    String marginStr = '-';
    Color marginColor = AppColors.textPrimary;
    if (item.revenue != 0) {
      final margin = (item.netIncome / item.revenue) * 100;
      marginStr = '${margin.toStringAsFixed(1)}%';
      if (margin > 0) {
        marginColor = AppColors.successText;
      } else if (margin < 0) {
        marginColor = AppColors.criticalText;
      }
    }

    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: revenue,
      value2: netIncome,
      value3: marginStr,
      value3Color: marginColor,
    );
  }

  FinancialHistoryRowData balanceHistoryRowData(
    BalanceSheet item,
    String locale,
  ) {
    final assets = CurrencyFormatter.formatCompact(
      item.totalAssets,
      reportedCurrency,
      locale: locale,
    );
    final liabilities = CurrencyFormatter.formatCompact(
      item.totalLiabilities,
      reportedCurrency,
      locale: locale,
    );
    final equity = CurrencyFormatter.formatCompact(
      item.totalEquity,
      reportedCurrency,
      locale: locale,
    );

    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: assets,
      value2: liabilities,
      value3: equity,
      value3Color: item.totalEquity >= 0
          ? AppColors.successText
          : AppColors.criticalText,
    );
  }

  FinancialHistoryRowData cashFlowHistoryRowData(
    CashFlowStatement item,
    String locale,
  ) {
    final ocf = CurrencyFormatter.formatCompact(
      item.operatingCashFlow,
      reportedCurrency,
      locale: locale,
    );
    final capex = CurrencyFormatter.formatCompact(
      item.capitalExpenditure,
      reportedCurrency,
      locale: locale,
    );
    final fcf = CurrencyFormatter.formatCompact(
      item.freeCashFlow,
      reportedCurrency,
      locale: locale,
    );

    return FinancialHistoryRowData(
      label: item.formattedPeriod,
      value1: ocf,
      value2: capex,
      value3: fcf,
      value3Color: item.freeCashFlow >= 0
          ? AppColors.successText
          : AppColors.criticalText,
    );
  }

  T? _findStatement<T>(List<T> list, String? date) {
    if (date == null) return null;
    try {
      return list.firstWhere((e) => (e as dynamic).date == date);
    } catch (_) {
      return null;
    }
  }

  T? _findPrevious<T>(List<T> list, T current) {
    final index = list.indexOf(current);
    if (index != -1 && index + 1 < list.length) {
      return list[index + 1];
    }
    return null;
  }

  FinancialStatementTableRow _buildRow({
    required String locale,
    required String metric,
    required double current,
    required double? previous,
    required String currency,
    double? totalBase,
    GrowthColorBehavior colorBehavior = GrowthColorBehavior.standard,
    bool isBold = false,
  }) {
    final amountStr = CurrencyFormatter.formatCompact(
      current,
      currency,
      locale: locale,
    );

    String percentStr = '-';
    if (totalBase != null && totalBase != 0) {
      final margin = (current / totalBase) * 100;
      percentStr = '${margin.toStringAsFixed(1)}%';
    }

    String growthStr = '-';
    Color growthColor = AppColors.textPrimary;

    if (previous != null && previous != 0) {
      double growth;
      if (colorBehavior == GrowthColorBehavior.inverted) {
        growth = (current.abs() - previous.abs()) / previous.abs() * 100;
      } else {
        growth = (current - previous) / previous.abs() * 100;
      }

      if (growth > 0) {
        growthStr = '+${growth.toStringAsFixed(1)}%';
        switch (colorBehavior) {
          case GrowthColorBehavior.standard:
            growthColor = AppColors.successText;
            break;
          case GrowthColorBehavior.inverted:
            growthColor = AppColors.red800;
            break;
          case GrowthColorBehavior.neutral:
            growthColor = AppColors.textPrimary;
            break;
        }
      } else if (growth < 0) {
        growthStr = '${growth.toStringAsFixed(1)}%';
        switch (colorBehavior) {
          case GrowthColorBehavior.standard:
            growthColor = AppColors.red800;
            break;
          case GrowthColorBehavior.inverted:
            growthColor = AppColors.successText;
            break;
          case GrowthColorBehavior.neutral:
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
      percentage: percentStr,
      growth: growthStr,
      growthColor: growthColor,
      isBold: isBold,
    );
  }
}
