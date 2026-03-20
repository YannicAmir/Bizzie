import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/income_statement_view.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/balance_sheet_view.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/widgets/cash_flow_statement_view.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/tab_visibility_observer.dart';

class FinancialStatementsTab extends StatefulWidget {
  final String ticker;

  const FinancialStatementsTab({super.key, required this.ticker});

  @override
  State<FinancialStatementsTab> createState() => _FinancialStatementsTabState();
}

class _FinancialStatementsTabState extends State<FinancialStatementsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mascot = context.select((UserBloc bloc) => bloc.state.mascotAsset);

    return TabVisibilityObserver(
      tabName: CompanyProfileTab.financialStatements.analyticsName,
      onTabShown: () => context.read<FinancialStatementsBloc>().add(
        FinancialStatementsEvent.tabShown(widget.ticker),
      ),
      onTabHidden: () => context.read<FinancialStatementsBloc>().add(
        const FinancialStatementsEvent.tabHidden(),
      ),
      onAppBackgrounded: () => context.read<FinancialStatementsBloc>().add(
        const FinancialStatementsEvent.appBackgrounded(),
      ),
      onAppForegrounded: () => context.read<FinancialStatementsBloc>().add(
        const FinancialStatementsEvent.appForegrounded(),
      ),
      child: SingleChildScrollView(
        padding: AppConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BizzieSwitch(
                      options: FinancialStatementType.values
                          .map((e) => e.label)
                          .toList(),
                      selectedIndex: state.selectedType.index,
                      onChanged: (index) {
                        context.read<FinancialStatementsBloc>().add(
                          FinancialStatementsEvent.viewTypeChanged(
                            widget.ticker,
                            FinancialStatementType.values[index],
                          ),
                        );
                      },
                    ),
                    AppConstants.mainSectionSpacing,
                    _ActiveStatementSwitcher(
                      state: state,
                      ticker: widget.ticker,
                      mascotAsset: mascot,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveStatementSwitcher extends StatelessWidget {
  final FinancialStatementsState state;
  final String ticker;
  final String mascotAsset;

  const _ActiveStatementSwitcher({
    required this.state,
    required this.ticker,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return switch (state.selectedType) {
      FinancialStatementType.income => _FinancialStatementLoader(
        isLoading: state.isLoadingIncome,
        failureDetail: state.incomeError?.errorMessage,
        loadingMessage: 'Loading Income Statement',
        mascotAsset: mascotAsset,
        errorLabel: 'Error loading income statement',
        onRetry: () {
          context.read<FinancialStatementsBloc>().add(
            FinancialStatementsEvent.loadIncomeStatements(
              ticker,
              forceRefresh: true,
            ),
          );
        },
        child: const IncomeStatementView(),
      ),
      FinancialStatementType.balance => _FinancialStatementLoader(
        isLoading: state.isLoadingBalance,
        failureDetail: state.balanceError?.errorMessage,
        loadingMessage: 'Loading Balance Sheet',
        mascotAsset: mascotAsset,
        errorLabel: 'Error loading balance sheet',
        onRetry: () {
          context.read<FinancialStatementsBloc>().add(
            FinancialStatementsEvent.loadBalanceSheets(
              ticker,
              forceRefresh: true,
            ),
          );
        },
        child: const BalanceSheetView(),
      ),
      FinancialStatementType.cashFlow => _FinancialStatementLoader(
        isLoading: state.isLoadingCashFlow,
        failureDetail: state.cashFlowError?.errorMessage,
        loadingMessage: 'Loading Cash Flow Statement',
        mascotAsset: mascotAsset,
        errorLabel: 'Error loading cash flow statement',
        onRetry: () {
          context.read<FinancialStatementsBloc>().add(
            FinancialStatementsEvent.loadCashFlows(ticker, forceRefresh: true),
          );
        },
        child: const CashFlowStatementView(),
      ),
    };
  }
}

class _FinancialStatementLoader extends StatelessWidget {
  final bool isLoading;
  final String? failureDetail;
  final String loadingMessage;
  final String mascotAsset;
  final String errorLabel;
  final VoidCallback onRetry;
  final Widget child;

  const _FinancialStatementLoader({
    required this.isLoading,
    required this.failureDetail,
    required this.loadingMessage,
    required this.mascotAsset,
    required this.errorLabel,
    required this.onRetry,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(top: 120),
        child: BizzieLoader(
          message: loadingMessage,
          mascotAssetPath: mascotAsset,
        ),
      );
    }
    if (failureDetail != null) {
      return CompanyProfileErrorState(message: errorLabel, onRetry: onRetry);
    }
    return child;
  }
}
