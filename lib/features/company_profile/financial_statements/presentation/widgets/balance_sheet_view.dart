import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/balance_sheet_pie_chart.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statement_selector.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/shared/financial_history_row.dart';

class BalanceSheetView extends StatefulWidget {
  const BalanceSheetView({super.key});

  @override
  State<BalanceSheetView> createState() => _BalanceSheetViewState();
}

class _BalanceSheetViewState extends State<BalanceSheetView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
      builder: (context, state) {
        final locale = Localizations.localeOf(context).toString();
        if (state.annualBalanceSheets.isEmpty &&
            state.quarterlyBalanceSheets.isEmpty) {
          final userState = context.watch<UserBloc>().state;
          return BizzieEmptyState(
            message: 'No balance sheet data available for this company.',
            mascotAsset: userState.mascotAsset,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.quarterlyBalanceSheets.isNotEmpty) ...[
              _BalanceSheetSection(
                title: 'On',
                data: state.quarterlyBalanceSheets,
                selectedItem: state.quarterlyBalanceSheets.firstWhere(
                  (e) => e.date == state.selectedQuarterlyBalanceDate,
                  orElse: () => state.quarterlyBalanceSheets.first,
                ),
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.balanceDateSelected(
                    date,
                    isAnnual: false,
                  ),
                ),
                pageController: _pageController,
                rows: [...state.balanceRows(locale: locale, isAnnual: false)],
                historyBuilder: (item) =>
                    state.balanceHistoryRowData(item, locale),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _BalanceSheetSection extends StatelessWidget {
  final String title;
  final List<BalanceSheet> data;
  final BalanceSheet selectedItem;
  final ValueChanged<String> onSelect;
  final PageController? pageController;
  final List<FinancialStatementTableRow> rows;
  final FinancialHistoryRowData Function(BalanceSheet) historyBuilder;

  const _BalanceSheetSection({
    required this.title,
    required this.data,
    required this.selectedItem,
    required this.onSelect,
    required this.pageController,
    required this.rows,
    required this.historyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FinancialStatementSelector<BalanceSheet>(
          title: title,
          items: data,
          selectedItem: selectedItem,
          onItemSelected: (item) => onSelect(item.date),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          modalTitle: 'Balance Sheet Periods',
        ),
        AppConstants.mainSectionSpacing,
        if (pageController != null) ...[
          _BalanceSheetCharts(
            statement: selectedItem,
            controller: pageController!,
          ),
          AppConstants.mainSectionSpacing,
        ],
        FinancialStatementsTable(
          rows: rows,
          onViewAll: () => _showBalanceSheetHistory(context, data),
          showPercentage: false,
          amountAlignment: Alignment.center,
          amountTextAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showBalanceSheetHistory(
    BuildContext context,
    List<BalanceSheet> dataset,
  ) {
    AppHistoryModalHelper.show<BalanceSheet>(
      context: context,
      title: 'Net Worth History',
      header: const FinancialHistoryHeader(
        label: 'Year',
        header1: 'Assets',
        header2: 'Liabilities',
        header3: 'Equity',
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

class _BalanceSheetCharts extends StatelessWidget {
  final BalanceSheet statement;
  final PageController controller;

  const _BalanceSheetCharts({
    required this.statement,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final currency = statement.reportedCurrency;
    final charts = [
      BalanceSheetPieChart(
        key: const ValueKey('assets_chart'),
        currency: currency,
        data: [
          BalanceSheetPieChartData(
            'Assets',
            statement.totalAssets,
            badgeTheme?.goodText ?? AppColors.successText,
          ),
          BalanceSheetPieChartData(
            'Liabilities',
            statement.totalLiabilities,
            badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
          BalanceSheetPieChartData(
            'Equity',
            statement.totalEquity,
            badgeTheme?.neutralText ?? AppColors.primary,
          ),
        ],
      ),
      BalanceSheetPieChart(
        key: const ValueKey('ratio_chart'),
        currency: currency,
        data: [
          BalanceSheetPieChartData(
            'Current Assets',
            statement.totalCurrentAssets,
            badgeTheme?.goodText ?? AppColors.successText,
          ),
          BalanceSheetPieChartData(
            'Current Liabilities',
            statement.totalCurrentLiabilities,
            badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
        ],
      ),
      BalanceSheetPieChart(
        key: const ValueKey('capital_chart'),
        currency: currency,
        data: [
          BalanceSheetPieChartData(
            'L.T. Debt',
            statement.longTermDebt,
            badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
          BalanceSheetPieChartData(
            'S.T. Debt',
            statement.shortTermDebt,
            AppColors.darkCritical,
          ),
          BalanceSheetPieChartData(
            'Equity',
            statement.totalEquity,
            badgeTheme?.neutralText ?? AppColors.primary,
          ),
        ],
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 400,
          child: PageView(controller: controller, children: charts),
        ),
        AppConstants.secondarySectionSpacing,
        SmoothPageIndicator(
          controller: controller,
          count: charts.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: theme.colorScheme.primary,
            dotColor: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
