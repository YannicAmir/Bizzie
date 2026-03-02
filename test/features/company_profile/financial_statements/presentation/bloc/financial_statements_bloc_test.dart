import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
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
import 'package:bizzie/features/company_profile/financial_statements/presentation/enums/financial_statement_type.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_analytics.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/inc_stmt_tab_view_state.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
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

class MockIncStmtTabAnalytics extends Mock implements IncStmtTabAnalytics {}

class MockBalStmtTabAnalytics extends Mock implements BalStmtTabAnalytics {}

class MockCashStmtTabAnalytics extends Mock implements CashStmtTabAnalytics {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late FinancialStatementsBloc bloc;
  late MockGetIncomeStatementsUseCase mockGetIncomeStatements;
  late MockGetBalanceSheetsUseCase mockGetBalanceSheets;
  late MockGetCashFlowStatementsUseCase mockGetCashFlowStatements;
  late MockIncStmtTabAnalytics mockIncTracker;
  late MockBalStmtTabAnalytics mockBalTracker;
  late MockCashStmtTabAnalytics mockCashTracker;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetIncomeStatements = MockGetIncomeStatementsUseCase();
    mockGetBalanceSheets = MockGetBalanceSheetsUseCase();
    mockGetCashFlowStatements = MockGetCashFlowStatementsUseCase();
    mockIncTracker = MockIncStmtTabAnalytics();
    mockBalTracker = MockBalStmtTabAnalytics();
    mockCashTracker = MockCashStmtTabAnalytics();
    mockConfigService = MockConfigService();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(5);

    bloc = FinancialStatementsBloc(
      mockGetIncomeStatements,
      mockGetBalanceSheets,
      mockGetCashFlowStatements,
      mockIncTracker,
      mockBalTracker,
      mockCashTracker,
      mockConfigService,
    );

    registerFallbackValue(const GetFinancialStatementParams(ticker: ''));

    when(() => mockGetIncomeStatements(any())).thenAnswer(
      (_) async =>
          Right((List<IncomeStatement>.from([]), CompanyProfileDataOrigin.api)),
    );
    when(() => mockGetBalanceSheets(any())).thenAnswer(
      (_) async =>
          Right((List<BalanceSheet>.from([]), CompanyProfileDataOrigin.api)),
    );
    when(() => mockGetCashFlowStatements(any())).thenAnswer(
      (_) async => Right((
        List<CashFlowStatement>.from([]),
        CompanyProfileDataOrigin.api,
      )),
    );
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
    // Assert
    expect(
      bloc.state,
      FinancialStatementsState.initial(ticker: '', freePlanHistoryCount: 5),
    );
  });

  group('FinancialStatementsBloc - loadIncomeStatements', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(
          () => mockGetIncomeStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        when(
          () => mockGetIncomeStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const FinancialStatementsEvent.loadIncomeStatements(tTicker));
      },
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
            ])
            .having(
              (s) => s.incomeOrigin,
              'incomeOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        when(
          () => mockGetIncomeStatements(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const FinancialStatementsEvent.loadIncomeStatements(tTicker));
      },
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
              const Failure.server('error'),
            ),
      ],
    );
  });

  group('FinancialStatementsBloc - loadBalanceSheets', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadBalanceSheets_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(
          () => mockGetBalanceSheets(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<BalanceSheet>.from([tBalance]),
            CompanyProfileDataOrigin.api,
          )),
        );
        when(
          () => mockGetBalanceSheets(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<BalanceSheet>.from([tBalance]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const FinancialStatementsEvent.loadBalanceSheets(tTicker));
      },
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
            ])
            .having(
              (s) => s.balanceOrigin,
              'balanceOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );
  });

  group('FinancialStatementsBloc - loadCashFlows', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadCashFlows_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(
          () => mockGetCashFlowStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'annual',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<CashFlowStatement>.from([tCashFlow]),
            CompanyProfileDataOrigin.api,
          )),
        );
        when(
          () => mockGetCashFlowStatements(
            const GetFinancialStatementParams(
              ticker: tTicker,
              period: 'quarter',
            ),
          ),
        ).thenAnswer(
          (_) async => Right((
            List<CashFlowStatement>.from([tCashFlow]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const FinancialStatementsEvent.loadCashFlows(tTicker));
      },
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
            )
            .having(
              (s) => s.cashFlowOrigin,
              'cashFlowOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );
  });

  group('FinancialStatementsBloc - View & Selection', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'viewTypeChanged_emitsNewTypeAndTriggersStalenessCheck',
      build: () {
        // Arrange
        when(() => mockGetBalanceSheets(any())).thenAnswer(
          (_) async => Right((
            List<BalanceSheet>.from([tBalance]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.viewTypeChanged(
            tTicker,
            FinancialStatementType.balance,
          ),
        );
      },
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
      build: () {
        // Arrange
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.incomeDateSelected(
            '2022-09-24',
            isAnnual: true,
          ),
        );
      },
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
        // Arrange
        when(() => mockGetIncomeStatements(any())).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.stalenessCheckRequested(
            tTicker,
            type: FinancialStatementType.income,
          ),
        );
      },
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
      build: () {
        // Arrange
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: '',
            freePlanHistoryCount: 5,
          ).copyWith(
            annualIncomeStatements: [tIncome],
            incomeOrigin: CompanyProfileDataOrigin.api,
            lastUpdatedIncome: DateTime.now(),
          ),
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.stalenessCheckRequested(
            tTicker,
            type: FinancialStatementType.income,
          ),
        );
      },
      expect: () => [],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'stalenessCheckRequested_stale_triggersLoad',
      build: () {
        // Arrange
        when(() => mockGetIncomeStatements(any())).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: '',
            freePlanHistoryCount: 5,
          ).copyWith(
            annualIncomeStatements: [tIncome],
            incomeOrigin: CompanyProfileDataOrigin.api,
            lastUpdatedIncome: DateTime.now().subtract(
              const Duration(hours: 25),
            ),
          ),
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.stalenessCheckRequested(
            tTicker,
            type: FinancialStatementType.income,
          ),
        );
      },
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
      'stalenessCheckRequested_staleBalance_triggersLoad',
      build: () {
        // Arrange
        when(() => mockGetBalanceSheets(any())).thenAnswer(
          (_) async => Right((
            List<BalanceSheet>.from([tBalance]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: '',
            freePlanHistoryCount: 5,
          ).copyWith(
            annualBalanceSheets: [tBalance],
            balanceOrigin: CompanyProfileDataOrigin.api,
            lastUpdatedBalance: DateTime.now().subtract(
              const Duration(hours: 25),
            ),
          ),
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.stalenessCheckRequested(
            tTicker,
            type: FinancialStatementType.balance,
          ),
        );
      },
      expect: () => [
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
      'stalenessCheckRequested_staleCashFlow_triggersLoad',
      build: () {
        // Arrange
        when(() => mockGetCashFlowStatements(any())).thenAnswer(
          (_) async => Right((
            List<CashFlowStatement>.from([tCashFlow]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: '',
            freePlanHistoryCount: 5,
          ).copyWith(
            annualCashFlowStatements: [tCashFlow],
            cashFlowOrigin: CompanyProfileDataOrigin.api,
            lastUpdatedCashFlow: DateTime.now().subtract(
              const Duration(hours: 25),
            ),
          ),
      act: (bloc) {
        // Act
        bloc.add(
          const FinancialStatementsEvent.stalenessCheckRequested(
            tTicker,
            type: FinancialStatementType.cashFlow,
          ),
        );
      },
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingCashFlow,
          'isLoadingCashFlow',
          true,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingCashFlow,
          'isLoadingCashFlow',
          false,
        ),
      ],
      wait: const Duration(milliseconds: 500),
    );
  });

  group('FinancialStatementsBloc - Analytics Synchronization', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_syncsMetricsIntoAnalyticsState',
      build: () {
        when(() => mockGetIncomeStatements(any())).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        bloc.add(const FinancialStatementsEvent.tabShown(tTicker));
        bloc.add(const FinancialStatementsEvent.loadIncomeStatements(tTicker));
      },
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.incAnalytics?.ticker,
          'ticker',
          tTicker,
        ),
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingIncome, 'isLoadingIncome', false)
            .having((s) => s.incAnalytics?.isSuccess, 'isSuccess', true)
            .having(
              (s) => s.incAnalytics?.dataSource,
              'dataSource',
              CompanyProfileDataOrigin.api,
            )
            .having(
              (s) => (s.incAnalytics?.loadTimeMs ?? 0) >= 0,
              'loadTimeMs',
              true,
            ),
      ],
      wait: const Duration(milliseconds: 500),
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'tabShown_initializesAnalyticsWithExistingMetrics',
      build: () => bloc,
      seed: () =>
          FinancialStatementsState.initial(
            ticker: tTicker,
            freePlanHistoryCount: 5,
          ).copyWith(
            incomeLoadTimeMs: 123,
            isIncomeSuccess: true,
            incomeOrigin: CompanyProfileDataOrigin.db,
          ),
      act: (bloc) => bloc.add(const FinancialStatementsEvent.tabShown(tTicker)),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.incAnalytics,
          'incAnalytics',
          isA<IncStmtTabViewState>()
              .having((a) => a.loadTimeMs, 'loadTimeMs', 123)
              .having((a) => a.isSuccess, 'isSuccess', true)
              .having(
                (a) => a.dataSource,
                'dataSource',
                CompanyProfileDataOrigin.db,
              ),
        ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'viewAllTapped_persistsMetricsWhileUpdatingFlags',
      build: () => bloc,
      seed: () =>
          FinancialStatementsState.initial(
            ticker: tTicker,
            freePlanHistoryCount: 5,
          ).copyWith(
            selectedType: FinancialStatementType.income,
            incAnalytics: IncStmtTabViewState(
              ticker: tTicker,
              timestamp: DateTime.now().toIso8601String(),
              loadTimeMs: 456,
              isSuccess: true,
              dataSource: CompanyProfileDataOrigin.api,
            ),
          ),
      act: (bloc) => bloc.add(
        const FinancialStatementsEvent.viewAllTapped(isAnnual: true),
      ),
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.incAnalytics,
          'incAnalytics',
          isA<IncStmtTabViewState>()
              .having((a) => a.loadTimeMs, 'loadTimeMs', 456)
              .having((a) => a.isSuccess, 'isSuccess', true)
              .having(
                (a) => a.tappedAllIncomeYrly,
                'tappedAllIncomeYrly',
                true,
              ),
        ),
      ],
    );
  });
}
