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
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/features/company_profile/shared/presentation/widgets/company_profile_error_state.dart';

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

    return SingleChildScrollView(
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
        error: state.incomeError?.message,
        loadingMessage: 'Loading Income Statement',
        mascotAsset: mascotAsset,
        errorMessage: 'Error loading income statement',
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
        error: state.balanceError?.message,
        loadingMessage: 'Loading Balance Sheet',
        mascotAsset: mascotAsset,
        errorMessage: 'Error loading balance sheet',
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
        error: state.cashFlowError?.message,
        loadingMessage: 'Loading Cash Flow Statement',
        mascotAsset: mascotAsset,
        errorMessage: 'Error loading cash flow statement',
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
  final String? error;
  final String loadingMessage;
  final String mascotAsset;
  final String errorMessage;
  final VoidCallback onRetry;
  final Widget child;

  const _FinancialStatementLoader({
    required this.isLoading,
    required this.error,
    required this.loadingMessage,
    required this.mascotAsset,
    required this.errorMessage,
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
    if (error != null) {
      return CompanyProfileErrorState(message: errorMessage, onRetry: onRetry);
    }
    return child;
  }
}
