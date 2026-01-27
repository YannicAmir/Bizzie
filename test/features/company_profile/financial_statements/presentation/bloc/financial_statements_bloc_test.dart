import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/balance_sheet.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/cash_flow_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/get_financial_statement_params.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/models/income_statement.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_balance_sheets_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_cash_flow_statements_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/domain/usecases/get_income_statements_usecase.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_bloc.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_event.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/bloc/financial_statements_state.dart';
import 'package:bizzie/features/company_profile/presentation/enums/financial_statement_type.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetIncomeStatementsUseCase extends Mock
    implements GetIncomeStatementsUseCase {}

class MockGetBalanceSheetsUseCase extends Mock
    implements GetBalanceSheetsUseCase {}

class MockGetCashFlowStatementsUseCase extends Mock
    implements GetCashFlowStatementsUseCase {}

void main() {
  late FinancialStatementsBloc bloc;
  late MockGetIncomeStatementsUseCase mockGetIncomeStatements;
  late MockGetBalanceSheetsUseCase mockGetBalanceSheets;
  late MockGetCashFlowStatementsUseCase mockGetCashFlowStatements;

  setUp(() {
    mockGetIncomeStatements = MockGetIncomeStatementsUseCase();
    mockGetBalanceSheets = MockGetBalanceSheetsUseCase();
    mockGetCashFlowStatements = MockGetCashFlowStatementsUseCase();
    bloc = FinancialStatementsBloc(
      mockGetIncomeStatements,
      mockGetBalanceSheets,
      mockGetCashFlowStatements,
    );

    registerFallbackValue(const GetFinancialStatementParams(ticker: ''));

    // Default mocks
    when(
      () => mockGetIncomeStatements(any()),
    ).thenAnswer((_) async => Right(List.from([])));
    when(
      () => mockGetBalanceSheets(any()),
    ).thenAnswer((_) async => Right(List.from([])));
    when(
      () => mockGetCashFlowStatements(any()),
    ).thenAnswer((_) async => Right(List.from([])));
  });

  const tTicker = 'AAPL';
  const tIncome = IncomeStatement(
    date: '2023-09-30',
    symbol: tTicker,
    reportedCurrency: 'USD',
    period: 'FY',
    revenue: 383285000000.0,
    grossProfit: 169148000000.0,
    operatingIncome: 114301000000.0,
    netIncome: 96995000000.0,
    eps: 6.13,
    ebitda: 125820000000.0,
    costOfRevenue: 214137000000.0,
    operatingExpenses: 54847000000.0,
    costAndExpenses: 268984000000.0,
  );

  const tBalance = BalanceSheet(
    date: '2023-09-30',
    symbol: tTicker,
    reportedCurrency: 'USD',
    period: 'FY',
    totalAssets: 352583000000.0,
    totalLiabilities: 290437000000.0,
    totalEquity: 62146000000.0,
    cashAndShortTermInvestments: 61555000000.0,
    totalDebt: 111088000000.0,
    totalCurrentAssets: 143566000000.0,
    totalNonCurrentAssets: 209017000000.0,
    totalCurrentLiabilities: 145308000000.0,
    totalNonCurrentLiabilities: 145129000000.0,
    longTermDebt: 95081000000.0,
    shortTermDebt: 15807000000.0,
  );

  const tCashFlow = CashFlowStatement(
    date: '2023-09-30',
    symbol: tTicker,
    reportedCurrency: 'USD',
    period: 'FY',
    operatingCashFlow: 110543000000.0,
    investingCashFlow: -9571000000.0,
    financingCashFlow: -108488000000.0,
    capitalExpenditure: -10959000000.0,
    freeCashFlow: 99584000000.0,
    dividendsPaid: -15025000000.0,
    cashAtBeginningOfPeriod: 24977000000.0,
    cashAtEndOfPeriod: 29965000000.0,
  );

  test('initialState_isCorrect', () {
    expect(bloc.state, FinancialStatementsState.initial());
  });

  group('FinancialStatementsBloc - loadIncomeStatements', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_success_emitsLoadingAndLoaded',
      build: () {
        when(
          () => mockGetIncomeStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tIncome])));
        when(
          () => mockGetIncomeStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tIncome])));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.loadIncomeStatements(tTicker),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingIncome, 'isLoadingIncome', false)
            .having((s) => s.annualIncomeStatements, 'annualIncomeStatements', [
              tIncome,
            ]),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_failure_emitsLoadingAndFailure',
      build: () {
        when(
          () => mockGetIncomeStatements(any()),
        ).thenAnswer((_) async => const Left(ServerFailure('error')));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.loadIncomeStatements(tTicker),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingIncome, 'isLoadingIncome', false)
            .having(
              (s) => s.incomeError,
              'incomeError',
              const ServerFailure('error'),
            ),
      ],
    );
  });

  group('FinancialStatementsBloc - loadBalanceSheets', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadBalanceSheets_success_emitsLoadingAndLoaded',
      build: () {
        when(
          () => mockGetBalanceSheets(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tBalance])));
        when(
          () => mockGetBalanceSheets(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tBalance])));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const FinancialStatementsEvent.loadBalanceSheets(tTicker)),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingBalance,
          'isLoadingBalance',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingBalance, 'isLoadingBalance', false)
            .having((s) => s.annualBalanceSheets, 'annualBalanceSheets', [
              tBalance,
            ]),
      ],
    );
  });

  group('FinancialStatementsBloc - loadCashFlows', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadCashFlows_success_emitsLoadingAndLoaded',
      build: () {
        when(
          () => mockGetCashFlowStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tCashFlow])));
        when(
          () => mockGetCashFlowStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer((_) async => Right(List.from([tCashFlow])));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const FinancialStatementsEvent.loadCashFlows(tTicker)),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingCashFlow,
          'isLoadingCashFlow',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingCashFlow, 'isLoadingCashFlow', false)
            .having(
              (s) => s.annualCashFlowStatements,
              'annualCashFlowStatements',
              [tCashFlow],
            ),
      ],
    );
  });

  group('FinancialStatementsBloc - View & Selection', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'viewTypeChanged_emitsNewTypeAndTriggersStalenessCheck',
      build: () {
        when(
          () => mockGetBalanceSheets(any()),
        ).thenAnswer((_) async => Right(List.from([tBalance])));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.viewTypeChanged(
          tTicker,
          FinancialStatementType.balance,
        ),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedType,
          'selectedType',
          FinancialStatementType.balance,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingBalance,
          'isLoadingBalance',
          true,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingBalance,
          'isLoadingBalance',
          false,
        ),
      ],
      wait: const Duration(milliseconds: 500),
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'incomeDateSelected_updatesAnnualSelection',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.incomeDateSelected(
          '2022-09-24',
          isAnnual: true,
        ),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedAnnualIncomeDate,
          'selectedAnnualIncomeDate',
          '2022-09-24',
        ),
      ],
    );
  });

  group('FinancialStatementsBloc - stalenessCheckRequested', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'stalenessCheckRequested_empty_triggersLoad',
      build: () {
        when(
          () => mockGetIncomeStatements(any()),
        ).thenAnswer((_) async => Right(List.from([tIncome])));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.stalenessCheckRequested(
          tTicker,
          type: FinancialStatementType.income,
        ),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          false,
        ),
      ],
      wait: const Duration(milliseconds: 500),
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'stalenessCheckRequested_fresh_doesNothing',
      build: () => bloc,
      seed: () => FinancialStatementsState.initial().copyWith(
        annualIncomeStatements: [tIncome],
        lastUpdatedIncome: DateTime.now(),
      ),
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.stalenessCheckRequested(
          tTicker,
          type: FinancialStatementType.income,
        ),
      ),
      expect: () => [],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'stalenessCheckRequested_stale_triggersLoad',
      build: () {
        when(
          () => mockGetIncomeStatements(any()),
        ).thenAnswer((_) async => Right(List.from([tIncome])));
        return bloc;
      },
      seed: () => FinancialStatementsState.initial().copyWith(
        annualIncomeStatements: [tIncome],
        lastUpdatedIncome: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.stalenessCheckRequested(
          tTicker,
          type: FinancialStatementType.income,
        ),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          false,
        ),
      ],
      wait: const Duration(milliseconds: 500),
    );
  });
}
