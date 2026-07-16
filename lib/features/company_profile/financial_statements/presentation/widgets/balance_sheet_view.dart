import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/extensions/financial_statements_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/models/financial_history_row_data.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/period_selector_dropdown.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/financial_statements_table.dart';
import 'package:bizzie/shared/widgets/carousel_page_indicator.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/extensions/balance_sheet_x.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/currency_formatter.dart';
import 'package:bizzie/shared/widgets/charts/bizzie_pie_chart.dart';
import 'package:bizzie/shared/widgets/modals/app_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/shared/widgets/states/bizzie_empty_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/shared/financial_history_row.dart';

const String _chartTitle = 'Chart';
const int _ratioDecimalPlaces = 2;

class BalanceSheetView extends StatefulWidget {
  const BalanceSheetView({super.key});

  @override
  State<BalanceSheetView> createState() => _BalanceSheetViewState();
}

class _BalanceSheetViewState extends State<BalanceSheetView> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      _currentPage = page;
      context.read<FinancialStatementsBloc>().add(
        FinancialStatementsEvent.chartSwiped(page),
      );
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
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
            if (state.quarterlyBalanceSheets.isNotEmpty)
              _BalanceSheetSection(
                title: 'On',
                data: state.quarterlyBalanceSheets,
                selectedItem: state.selectedQuarterlyBalanceSheet,
                onSelect: (date) => context.read<FinancialStatementsBloc>().add(
                  FinancialStatementsEvent.balanceDateSelected(
                    date,
                    isAnnual: false,
                  ),
                ),
                pageController: _pageController,
                rows: state.balanceRows(locale: locale, isAnnual: false),
                historyBuilder: (item) =>
                    state.balanceHistoryRowData(item, locale),
                historyLimit: state.freePlanHistoryCount,
              ),
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
  final PageController pageController;
  final List<FinancialStatementTableRow> rows;
  final FinancialHistoryRowData Function(BalanceSheet) historyBuilder;
  final int historyLimit;

  const _BalanceSheetSection({
    required this.title,
    required this.data,
    required this.selectedItem,
    required this.onSelect,
    required this.pageController,
    required this.rows,
    required this.historyBuilder,
    required this.historyLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PeriodSelectorDropdown<BalanceSheet>(
          title: title,
          items: data,
          selectedItem: selectedItem,
          onItemSelected: (item) => onSelect(item.date),
          dateStringExtractor: (item) => item.date,
          periodExtractor: (item) => item.period,
          modalTitle: 'Balance Sheet Periods',
          historyLimit: historyLimit,
        ),
        AppConstants.mainSectionSpacing,
        _BalanceSheetCharts(
          statement: selectedItem,
          controller: pageController,
        ),
        AppConstants.mainSectionSpacing,
        FinancialStatementsTable(
          rows: rows,
          onViewAll: () {
            context.read<FinancialStatementsBloc>().add(
              const FinancialStatementsEvent.viewAllTapped(isAnnual: false),
            );

            if (context.read<UserBloc>().state.canViewFullHistory) {
              _showBalanceSheetHistory(context, data);
            }
          },
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
      BizziePieChart(
        key: const ValueKey('assets_chart'),
        title: _chartTitle,
        currency: currency,
        data: [
          BizziePieChartData(
            label: 'Assets',
            value: statement.totalAssets,
            color: badgeTheme?.goodText ?? AppColors.successText,
          ),
          BizziePieChartData(
            label: 'Liabilities',
            value: statement.totalLiabilities,
            color: badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
          BizziePieChartData(
            label: 'Equity',
            value: statement.totalEquity,
            color: badgeTheme?.neutralText ?? AppColors.primary,
          ),
        ],
        centerWidget: ChartCenterMetric(
          label: 'Equity',
          value: CurrencyFormatter.formatCompact(
            statement.totalEquity,
            currency,
            locale: Localizations.localeOf(context).toString(),
          ),
        ),
      ),
      BizziePieChart(
        key: const ValueKey('ratio_chart'),
        title: _chartTitle,
        currency: currency,
        data: [
          BizziePieChartData(
            label: 'Current Assets',
            value: statement.totalCurrentAssets,
            color: badgeTheme?.goodText ?? AppColors.successText,
          ),
          BizziePieChartData(
            label: 'Current Liabilities',
            value: statement.totalCurrentLiabilities,
            color: badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
        ],
        centerWidget: ChartCenterMetric(
          label: 'Current Ratio',
          value: statement.currentRatio.toStringAsFixed(_ratioDecimalPlaces),
        ),
      ),
      BizziePieChart(
        key: const ValueKey('capital_chart'),
        title: _chartTitle,
        currency: currency,
        data: [
          BizziePieChartData(
            label: 'L.T. Debt',
            value: statement.longTermDebt,
            color: badgeTheme?.criticalText ?? AppColors.criticalText,
          ),
          BizziePieChartData(
            label: 'S.T. Debt',
            value: statement.shortTermDebt,
            color: AppColors.darkCritical,
          ),
          BizziePieChartData(
            label: 'Equity',
            value: statement.totalEquity,
            color: badgeTheme?.neutralText ?? AppColors.primary,
          ),
        ],
        centerWidget: ChartCenterMetric(
          label: 'Debt-to-Equity',
          value: statement.debtToEquity.toStringAsFixed(_ratioDecimalPlaces),
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: AppConstants.chartCarouselHeight,
          child: PageView(controller: controller, children: charts),
        ),
        AppConstants.secondarySectionSpacing,
        CarouselPageIndicator(controller: controller, count: charts.length),
      ],
    );
  }
}
