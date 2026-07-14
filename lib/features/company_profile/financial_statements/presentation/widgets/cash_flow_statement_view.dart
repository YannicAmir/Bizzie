import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/extensions/financial_statements_state_extensions.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statement_chart.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_selector_dropdown.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/shared/financial_history_row.dart';

class CashFlowStatementView extends StatelessWidget {
  const CashFlowStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
      builder: (context, state) {
        final locale = Localizations.localeOf(context).toString();
        if (state.annualCashFlowStatements.isEmpty &&
            state.quarterlyCashFlowStatements.isEmpty) {
          final mascotAsset = context.select<UserBloc, String>(
            (bloc) => bloc.state.mascotAsset,
          );
          return BizzieEmptyState(
            message: 'No cash flow data available for this company.',
            mascotAsset: mascotAsset,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.annualCashFlowStatements.isNotEmpty) ...[
              _CashFlowStatementSection(
                title: 'For the Year Ended',
                state: state,
                locale: locale,
                isAnnual: true,
              ),
              AppConstants.mainSectionSpacing,
            ],
            if (state.quarterlyCashFlowStatements.isNotEmpty)
              _CashFlowStatementSection(
                title: 'For the Quarter Ended',
                state: state,
                locale: locale,
                isAnnual: false,
              ),
          ],
        );
      },
    );
  }
}

class _CashFlowStatementSection extends StatelessWidget {
  final String title;
  final FinancialStatementsState state;
  final String locale;
  final bool isAnnual;

  const _CashFlowStatementSection({
    required this.title,
    required this.state,
    required this.locale,
    required this.isAnnual,
  });

  List<CashFlowStatement> get _statements => isAnnual
      ? state.annualCashFlowStatements
      : state.quarterlyCashFlowStatements;

  CashFlowStatement get _selectedStatement => isAnnual
      ? state.selectedAnnualCashFlowStatement
      : state.selectedQuarterlyCashFlowStatement;

  @override
  Widget build(BuildContext context) {
    final selectedStatement = _selectedStatement;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PeriodSelectorDropdown<CashFlowStatement>(
          title: title,
          items: _statements,
          selectedItem: selectedStatement,
          onItemSelected: (item) => context.read<FinancialStatementsBloc>().add(
            FinancialStatementsEvent.cashFlowDateSelected(
              item.date,
              isAnnual: isAnnual,
            ),
          ),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          modalTitle: 'Cash Flow Statement Periods',
          historyLimit: state.freePlanHistoryCount,
        ),
        AppConstants.mainSectionSpacing,
        _CashFlowStatementChart(
          statement: selectedStatement,
          currency: state.reportedCurrency,
        ),
        AppConstants.mainSectionSpacing,
        FinancialStatementsTable(
          rows: state.cashFlowRows(locale: locale, isAnnual: isAnnual),
          onViewAll: () {
            context.read<FinancialStatementsBloc>().add(
              FinancialStatementsEvent.viewAllTapped(isAnnual: isAnnual),
            );

            if (context.read<UserBloc>().state.canViewFullHistory) {
              _showFullHistory(context);
            }
          },
          showPercentage: false,
          growthHeader: 'Change',
          amountAlignment: Alignment.center,
          amountTextAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showFullHistory(BuildContext context) {
    AppHistoryModalHelper.show<CashFlowStatement>(
      context: context,
      title: 'Cash Flow History',
      header: const FinancialHistoryHeader(
        label: 'Year',
        header1: 'O.C.F',
        header2: 'CapEx',
        header3: 'Free C.F',
      ),
      data: _statements,
      itemBuilder: (context, item, index) {
        final data = state.cashFlowHistoryRowData(item, locale);
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
    final freeCashFlow = statement.freeCashFlow;
    final positiveValueColor = badgeTheme?.goodText ?? AppColors.successText;
    final negativeValueColor = badgeTheme?.criticalText ?? AppColors.criticalText;
    final primary = theme.colorScheme.primary;

    final data = [
      FinancialStatementChartData(
        'O.C.F',
        statement.operatingCashFlow,
        badgeTheme?.neutralText ?? primary,
      ),
      FinancialStatementChartData(
        'I.C.F',
        statement.investingCashFlow,
        badgeTheme?.neutralText ?? primary,
      ),
      FinancialStatementChartData(
        'Fin.C.F',
        statement.financingCashFlow,
        badgeTheme?.neutralText ?? primary,
      ),
      FinancialStatementChartData(
        'Free.C.F',
        freeCashFlow,
        freeCashFlow >= 0 ? positiveValueColor : negativeValueColor,
      ),
    ];

    return FinancialStatementChart(data: data, currency: currency);
  }
}
