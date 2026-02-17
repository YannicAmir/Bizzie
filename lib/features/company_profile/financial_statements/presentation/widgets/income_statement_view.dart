import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statement_chart.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/shared/financial_history_row.dart';

class IncomeStatementView extends StatelessWidget {
  const IncomeStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
      builder: (context, state) {
        var locale = Localizations.localeOf(context).toString();

        if (state.annualIncomeStatements.isEmpty &&
            state.quarterlyIncomeStatements.isEmpty) {
          final userState = context.watch<UserBloc>().state;
          return BizzieEmptyState(
            message: 'No income statement data available for this company.',
            mascotAsset: userState.mascotAsset,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.annualIncomeStatements.isNotEmpty) ...[
              _IncomeStatementSection(
                title: 'For the Year Ended',
                data: state.annualIncomeStatements,
                selectedItem: state.annualIncomeStatements.firstWhere(
                  (e) => e.date == state.selectedAnnualIncomeDate,
                  orElse: () => state.annualIncomeStatements.first,
                ),
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.incomeDateSelected(
                    date,
                    isAnnual: true,
                  ),
                ),
                dateFormat: 'MMM d, yyyy',
                currency: state.reportedCurrency,
                rows: state.incomeRows(locale: locale, isAnnual: true),
                historyBuilder: (item) =>
                    state.incomeHistoryRowData(item, locale),
                historyLimit: state.freePlanHistoryCount,
              ),
              AppConstants.mainSectionSpacing,
            ],
            if (state.quarterlyIncomeStatements.isNotEmpty) ...[
              _IncomeStatementSection(
                title: 'For the Quarter Ended',
                data: state.quarterlyIncomeStatements,
                selectedItem: state.quarterlyIncomeStatements.firstWhere(
                  (e) => e.date == state.selectedQuarterlyIncomeDate,
                  orElse: () => state.quarterlyIncomeStatements.first,
                ),
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.incomeDateSelected(
                    date,
                    isAnnual: false,
                  ),
                ),
                dateFormat: 'MMM d, yyyy',
                currency: state.reportedCurrency,
                rows: state.incomeRows(locale: locale, isAnnual: false),
                historyBuilder: (item) =>
                    state.incomeHistoryRowData(item, locale),
                historyLimit: state.freePlanHistoryCount,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _IncomeStatementSection extends StatelessWidget {
  final String title;
  final List<IncomeStatement> data;
  final IncomeStatement selectedItem;
  final ValueChanged<String> onSelect;
  final String dateFormat;
  final String currency;
  final List<FinancialStatementTableRow> rows;
  final FinancialHistoryRowData Function(IncomeStatement) historyBuilder;
  final int historyLimit;

  const _IncomeStatementSection({
    required this.title,
    required this.data,
    required this.selectedItem,
    required this.onSelect,
    required this.dateFormat,
    required this.currency,
    required this.rows,
    required this.historyBuilder,
    required this.historyLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<IncomeStatement>(
          title: title,
          items: data,
          selectedItem: selectedItem,
          onItemSelected: (item) => onSelect(item.date),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          dateFormat: dateFormat,
          modalTitle: 'Income Statement Periods',
          historyLimit: historyLimit,
        ),
        AppConstants.mainSectionSpacing,
        _IncomeStatementChart(statement: selectedItem, currency: currency),
        AppConstants.mainSectionSpacing,
        FinancialStatementsTable(
          rows: rows,
          onViewAll: () => _showFullHistory(context, data),
        ),
      ],
    );
  }

  void _showFullHistory(BuildContext context, List<IncomeStatement> dataset) {
    AppHistoryModalHelper.show<IncomeStatement>(
      context: context,
      title: 'Earnings History',
      header: const FinancialHistoryHeader(
        label: 'Year',
        header1: 'Revenue',
        header2: 'Net Income',
        header3: 'Margin %',
      ),
      data: dataset,
      itemBuilder: (context, item, index) {
        final data = historyBuilder(item);
        return FinancialHistoryRow(
          label: data.label,
          value1: data.value1,
          value2: data.value2,
          value3: data.value3,
          value3Color: data.value3Color,
        );
      },
    );
  }
}

class _IncomeStatementChart extends StatelessWidget {
  final IncomeStatement statement;
  final String currency;

  const _IncomeStatementChart({
    required this.statement,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final netIncome = statement.netIncome;

    final data = [
      FinancialStatementChartData(
        'Revenue',
        statement.revenue,
        theme.colorScheme.primary,
      ),
      FinancialStatementChartData(
        'Expenses',
        statement.costAndExpenses,
        theme.colorScheme.primary,
      ),
      FinancialStatementChartData(
        'Net Income',
        netIncome,
        netIncome >= 0 ? AppColors.successText : AppColors.criticalText,
      ),
    ];

    return FinancialStatementChart(data: data, currency: currency);
  }
}
