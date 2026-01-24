import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_state_extensions.dart';
import 'package:bizzie/features/company_profile/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_chart.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/financial_statements_table.dart';
import 'package:bizzie/features/company_profile/domain/models/cash_flow_statement.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/shared/financial_history_row.dart';

class CashFlowStatementView extends StatelessWidget {
  const CashFlowStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
      builder: (context, state) {
        final locale = Localizations.localeOf(context).toString();
        if (state.annualCashFlowStatements.isEmpty &&
            state.quarterlyCashFlowStatements.isEmpty) {
          final userState = context.watch<UserBloc>().state;
          return BizzieEmptyState(
            message: 'No cash flow data available for this company.',
            mascotAsset: userState.mascotAsset,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.annualCashFlowStatements.isNotEmpty) ...[
              _CashFlowStatementSection(
                title: 'For the Year Ended',
                data: state.annualCashFlowStatements,
                selectedItem: state.annualCashFlowStatements.firstWhere(
                  (e) => e.date == state.selectedAnnualCashFlowDate,
                  orElse: () => state.annualCashFlowStatements.first,
                ),
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.cashFlowDateSelected(
                    date,
                    isAnnual: true,
                  ),
                ),
                dateFormat: 'MMM d, yyyy',
                currency: state.reportedCurrency,
                rows: state.cashFlowRows(locale: locale, isAnnual: true),
                historyBuilder: (item) =>
                    state.cashFlowHistoryRowData(item, locale),
              ),
              AppConstants.mainSectionSpacing,
            ],
            if (state.quarterlyCashFlowStatements.isNotEmpty) ...[
              _CashFlowStatementSection(
                title: 'For the Quarter Ended',
                data: state.quarterlyCashFlowStatements,
                selectedItem: state.quarterlyCashFlowStatements.firstWhere(
                  (e) => e.date == state.selectedQuarterlyCashFlowDate,
                  orElse: () => state.quarterlyCashFlowStatements.first,
                ),
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.cashFlowDateSelected(
                    date,
                    isAnnual: false,
                  ),
                ),
                dateFormat: 'MMM d, yyyy',
                currency: state.reportedCurrency,
                rows: state.cashFlowRows(locale: locale, isAnnual: false),
                historyBuilder: (item) =>
                    state.cashFlowHistoryRowData(item, locale),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _CashFlowStatementSection extends StatelessWidget {
  final String title;
  final List<CashFlowStatement> data;
  final CashFlowStatement selectedItem;
  final ValueChanged<String> onSelect;
  final String dateFormat;
  final String currency;
  final List<FinancialStatementTableRow> rows;
  final FinancialHistoryRowData Function(CashFlowStatement) historyBuilder;

  const _CashFlowStatementSection({
    required this.title,
    required this.data,
    required this.selectedItem,
    required this.onSelect,
    required this.dateFormat,
    required this.currency,
    required this.rows,
    required this.historyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<CashFlowStatement>(
          title: title,
          items: data,
          selectedItem: selectedItem,
          onItemSelected: (item) => onSelect(item.date),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          dateFormat: dateFormat,
          modalTitle: 'Cash Flow Statement Periods',
        ),
        AppConstants.mainSectionSpacing,
        _CashFlowStatementChart(statement: selectedItem, currency: currency),
        AppConstants.mainSectionSpacing,
        FinancialStatementsTable(
          rows: rows,
          onViewAll: () => _showFullHistory(context, data),
          showPercentage: false,
          growthHeader: 'Change',
          amountAlignment: Alignment.center,
          amountTextAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showFullHistory(BuildContext context, List<CashFlowStatement> dataset) {
    AppHistoryModalHelper.show<CashFlowStatement>(
      context: context,
      title: 'Cash Flow History',
      header: const FinancialHistoryHeader(
        label: 'Year',
        header1: 'O.C.F',
        header2: 'CapEx',
        header3: 'Free C.F',
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

class _CashFlowStatementChart extends StatelessWidget {
  final CashFlowStatement statement;
  final String currency;

  const _CashFlowStatementChart({
    required this.statement,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final freeCf = statement.freeCashFlow;
    final green = badgeTheme?.goodText ?? AppColors.successText;
    final red = badgeTheme?.criticalText ?? AppColors.criticalText;

    final data = [
      FinancialStatementChartData(
        'O.C.F',
        statement.operatingCashFlow,
        badgeTheme?.neutralText ?? AppColors.primary,
      ),
      FinancialStatementChartData(
        'I.C.F',
        statement.investingCashFlow,
        badgeTheme?.neutralText ?? AppColors.primary,
      ),
      FinancialStatementChartData(
        'Fin.C.F',
        statement.financingCashFlow,
        badgeTheme?.neutralText ?? AppColors.primary,
      ),
      FinancialStatementChartData(
        'Free.C.F',
        freeCf,
        freeCf >= 0 ? green : red,
      ),
    ];

    return FinancialStatementChart(data: data, currency: currency);
  }
}
