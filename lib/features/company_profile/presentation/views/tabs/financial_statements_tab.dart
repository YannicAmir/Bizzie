import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_bloc.dart';

import 'package:bizzie/features/company_profile/presentation/bloc/financial_statements/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/income_statement_view.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/balance_sheet_view.dart';
import 'package:bizzie/features/company_profile/presentation/widgets/financial_statements/cash_flow_statement_view.dart';

import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';

class FinancialStatementsTab extends StatefulWidget {
  final String ticker;

  const FinancialStatementsTab({super.key, required this.ticker});

  @override
  State<FinancialStatementsTab> createState() => _FinancialStatementsTabState();
}

class _FinancialStatementsTabState extends State<FinancialStatementsTab>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mascot = context.watch<UserBloc>().state.mascotAsset;

    return SingleChildScrollView(
      padding: AppConstants.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BizzieSwitch(
            options: const [
              'Income Statement',
              'Balance Sheet',
              'Cash Flow Statement',
            ],
            selectedIndex: _selectedIndex,
            onChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
              final bloc = context.read<FinancialStatementsBloc>();
              if (index == 0) {
                bloc.checkIncomeStaleness(widget.ticker);
              } else if (index == 1) {
                bloc.checkBalanceStaleness(widget.ticker);
              } else if (index == 2) {
                bloc.checkCashFlowStaleness(widget.ticker);
              }
            },
          ),
          AppConstants.mainSectionSpacing,
          BlocBuilder<FinancialStatementsBloc, FinancialStatementsState>(
            builder: (context, state) {
              return IndexedStack(
                index: _selectedIndex,
                children: [
                  Builder(
                    builder: (context) {
                      if (state.isLoadingIncome) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: BizzieLoader(
                            message: 'Loading Income Statement',
                            mascotAssetPath: mascot,
                          ),
                        );
                      }
                      final error = state.incomeError;
                      if (error != null) {
                        return Center(child: Text('Error: ${error.message}'));
                      }
                      return IncomeStatementView(
                        annualData: state.annualIncomeStatements,
                        quarterlyData: state.quarterlyIncomeStatements,
                        currency: state.reportedCurrency,
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      if (state.isLoadingBalance) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: BizzieLoader(
                            message: 'Loading Balance Sheet',
                            mascotAssetPath: mascot,
                          ),
                        );
                      }
                      final error = state.balanceError;
                      if (error != null) {
                        return Center(child: Text('Error: ${error.message}'));
                      }
                      return BalanceSheetView(
                        annualData: state.annualBalanceSheets,
                        quarterlyData: state.quarterlyBalanceSheets,
                        annualIncome: state.annualIncomeStatements,
                        quarterlyIncome: state.quarterlyIncomeStatements,
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      if (state.isLoadingCashFlow) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: BizzieLoader(
                            message: 'Loading Cash Flow Statement',
                            mascotAssetPath: mascot,
                          ),
                        );
                      }
                      final error = state.cashFlowError;
                      if (error != null) {
                        return Center(child: Text('Error: ${error.message}'));
                      }
                      return CashFlowStatementView(
                        annualData: state.annualCashFlowStatements,
                        quarterlyData: state.quarterlyCashFlowStatements,
                        currency: state.reportedCurrency,
                      );
                    },
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
