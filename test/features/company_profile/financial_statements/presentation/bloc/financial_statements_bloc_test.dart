import 'dart:async';

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
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/bal_stmt_tab_view_state.dart';
import 'package:bizzie/features/company_profile/financial_statements/presentation/analytics/cash_stmt_tab_view_state.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/company_profile/shared/domain/enums/company_profile_tab.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/tab_activation.dart';
import 'package:bizzie/features/company_profile/shared/domain/usecases/watch_active_tab_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
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

class MockWatchActiveTabUseCase extends Mock implements WatchActiveTabUseCase {}

class MockTimeProvider extends Mock implements ITimeProvider {}

MockTimeProvider stubbedTimeProvider() {
  final mock = MockTimeProvider();
  when(() => mock.nowLocal).thenAnswer((_) => DateTime.now());
  return mock;
}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(const IncStmtTabViewState(ticker: '', timestamp: ''));
    registerFallbackValue(const BalStmtTabViewState(ticker: '', timestamp: ''));
    registerFallbackValue(
      const CashStmtTabViewState(ticker: '', timestamp: ''),
    );
  });

  late FinancialStatementsBloc bloc;
  late MockGetIncomeStatementsUseCase mockGetIncomeStatements;
  late MockGetBalanceSheetsUseCase mockGetBalanceSheets;
  late MockGetCashFlowStatementsUseCase mockGetCashFlowStatements;
  late MockIncStmtTabAnalytics mockIncTracker;
  late MockBalStmtTabAnalytics mockBalTracker;
  late MockCashStmtTabAnalytics mockCashTracker;
  late MockConfigService mockConfigService;
  late MockWatchActiveTabUseCase mockWatchActiveTabUseCase;
  late StreamController<TabActivation> tabActivationController;

  setUp(() {
    mockGetIncomeStatements = MockGetIncomeStatementsUseCase();
    mockGetBalanceSheets = MockGetBalanceSheetsUseCase();
    mockGetCashFlowStatements = MockGetCashFlowStatementsUseCase();
    mockIncTracker = MockIncStmtTabAnalytics();
    mockBalTracker = MockBalStmtTabAnalytics();
    mockCashTracker = MockCashStmtTabAnalytics();
    mockConfigService = MockConfigService();
    mockWatchActiveTabUseCase = MockWatchActiveTabUseCase();

    tabActivationController = StreamController<TabActivation>.broadcast();

    when(() => mockConfigService.freePlanHistoryCount).thenReturn(5);
    when(
      () => mockWatchActiveTabUseCase(any()),
    ).thenAnswer((_) => tabActivationController.stream);
    when(
      () => mockIncTracker.logViewSummary(
        any(),
        isFinal: any(named: 'isFinal'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockBalTracker.logViewSummary(
        any(),
        isFinal: any(named: 'isFinal'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockCashTracker.logViewSummary(
        any(),
        isFinal: any(named: 'isFinal'),
      ),
    ).thenAnswer((_) async {});

    bloc = FinancialStatementsBloc(
      mockGetIncomeStatements,
      mockGetBalanceSheets,
      mockGetCashFlowStatements,
      mockIncTracker,
      mockBalTracker,
      mockCashTracker,
      mockConfigService,
      mockWatchActiveTabUseCase,
      stubbedTimeProvider(),
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

  tearDown(() async {
    await bloc.close();
    await tabActivationController.close();
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

  const tFinancialStatementsActivation = TabActivation(
    tab: CompanyProfileTab.financialStatements,
    ticker: tTicker,
  );

  const tOtherTabActivation = TabActivation(
    tab: CompanyProfileTab.security,
    ticker: tTicker,
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

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_dataAlreadyLoadedWithoutForceRefresh_emitsNothing',
      build: () {
        // arrange
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: '',
            freePlanHistoryCount: 5,
          ).copyWith(annualIncomeStatements: [tIncome]),
      act: (bloc) {
        // act
        bloc.add(const FinancialStatementsEvent.loadIncomeStatements(tTicker));
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (_) {
        verifyNever(() => mockGetIncomeStatements(any()));
      },
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadIncomeStatements_forceRefreshWithExistingData_reloads',
      build: () {
        // arrange
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
          ).copyWith(annualIncomeStatements: [tIncome]),
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.loadIncomeStatements(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingIncome,
          'isLoadingIncome',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingIncome, 'isLoadingIncome', false)
            .having(
              (s) => s.annualIncomeStatements,
              'annualIncomeStatements',
              [tIncome],
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

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadBalanceSheets_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        when(
          () => mockGetBalanceSheets(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const FinancialStatementsEvent.loadBalanceSheets(tTicker));
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingBalance,
          'isLoadingBalance',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingBalance, 'isLoadingBalance', false)
            .having(
              (s) => s.balanceError,
              'balanceError',
              const Failure.server('error'),
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

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'loadCashFlows_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        when(
          () => mockGetCashFlowStatements(any()),
        ).thenAnswer((_) async => const Left(Failure.server('error')));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const FinancialStatementsEvent.loadCashFlows(tTicker));
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.isLoadingCashFlow,
          'isLoadingCashFlow',
          true,
        ),
        isA<FinancialStatementsState>()
            .having((s) => s.isLoadingCashFlow, 'isLoadingCashFlow', false)
            .having(
              (s) => s.cashFlowError,
              'cashFlowError',
              const Failure.server('error'),
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

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'viewTypeChanged_sameTypeSelected_emitsNothing',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.viewTypeChanged(
            tTicker,
            FinancialStatementType.income,
          ),
        );
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'incomeDateSelected_quarterly_updatesQuarterlySelection',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.incomeDateSelected(
            '2023-06-30',
            isAnnual: false,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedQuarterlyIncomeDate,
          'selectedQuarterlyIncomeDate',
          '2023-06-30',
        ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'balanceDateSelected_annual_updatesAnnualSelection',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.balanceDateSelected(
            '2022-09-24',
            isAnnual: true,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedAnnualBalanceDate,
          'selectedAnnualBalanceDate',
          '2022-09-24',
        ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'balanceDateSelected_quarterly_updatesQuarterlySelection',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.balanceDateSelected(
            '2023-06-30',
            isAnnual: false,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedQuarterlyBalanceDate,
          'selectedQuarterlyBalanceDate',
          '2023-06-30',
        ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'cashFlowDateSelected_annual_updatesAnnualSelection',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.cashFlowDateSelected(
            '2022-09-24',
            isAnnual: true,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedAnnualCashFlowDate,
          'selectedAnnualCashFlowDate',
          '2022-09-24',
        ),
      ],
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'cashFlowDateSelected_quarterly_updatesQuarterlySelection',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const FinancialStatementsEvent.cashFlowDateSelected(
            '2023-06-30',
            isAnnual: false,
          ),
        );
      },
      // assert
      expect: () => [
        isA<FinancialStatementsState>().having(
          (s) => s.selectedQuarterlyCashFlowDate,
          'selectedQuarterlyCashFlowDate',
          '2023-06-30',
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
      verify: (bloc) {
        expect(bloc.incAnalytics?.ticker, tTicker);
        expect(bloc.incAnalytics?.isSuccess, isTrue);
        expect(bloc.incAnalytics?.dataSource, CompanyProfileDataOrigin.api);
        expect((bloc.incAnalytics?.loadTimeMs ?? -1) >= 0, isTrue);
      },
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
      expect: () => const <FinancialStatementsState>[],
      verify: (bloc) {
        expect(
          bloc.incAnalytics,
          isA<IncStmtTabViewState>()
              .having((a) => a.loadTimeMs, 'loadTimeMs', 123)
              .having((a) => a.isSuccess, 'isSuccess', true)
              .having(
                (a) => a.dataSource,
                'dataSource',
                CompanyProfileDataOrigin.db,
              ),
        );
      },
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
            incomeLoadTimeMs: 456,
            isIncomeSuccess: true,
            incomeOrigin: CompanyProfileDataOrigin.api,
          ),
      act: (bloc) => bloc
        ..add(const FinancialStatementsEvent.tabShown(tTicker))
        ..add(const FinancialStatementsEvent.viewAllTapped(isAnnual: true)),
      expect: () => const <FinancialStatementsState>[],
      verify: (bloc) {
        expect(
          bloc.incAnalytics,
          isA<IncStmtTabViewState>()
              .having((a) => a.loadTimeMs, 'loadTimeMs', 456)
              .having((a) => a.isSuccess, 'isSuccess', true)
              .having(
                (a) => a.tappedAllIncomeYrly,
                'tappedAllIncomeYrly',
                true,
              ),
        );
      },
    );
  });

  group('FinancialStatementsBloc - Lifecycle Analytics', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'tabHidden_afterTabShown_logsFinalViewSummary',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc
          ..add(const FinancialStatementsEvent.tabShown(tTicker))
          ..add(const FinancialStatementsEvent.tabHidden());
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (_) {
        verify(
          () => mockIncTracker.logViewSummary(any(), isFinal: true),
        ).called(1);
      },
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'appBackgrounded_afterTabShown_logsNonFinalViewSummary',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc
          ..add(const FinancialStatementsEvent.tabShown(tTicker))
          ..add(const FinancialStatementsEvent.appBackgrounded());
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (_) {
        verify(
          () => mockIncTracker.logViewSummary(any(), isFinal: false),
        ).called(1);
      },
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'appForegrounded_afterAppBackgrounded_resumesWithoutLoggingAgain',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        bloc
          ..add(const FinancialStatementsEvent.tabShown(tTicker))
          ..add(const FinancialStatementsEvent.appBackgrounded())
          ..add(const FinancialStatementsEvent.appForegrounded());
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (_) {
        verify(
          () => mockIncTracker.logViewSummary(
            any(),
            isFinal: any(named: 'isFinal'),
          ),
        ).called(1);
      },
    );

    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'chartSwiped_onBalanceTab_marksCurrencyChartViewed',
      build: () {
        // arrange
        return bloc;
      },
      seed: () =>
          FinancialStatementsState.initial(
            ticker: tTicker,
            freePlanHistoryCount: 5,
          ).copyWith(selectedType: FinancialStatementType.balance),
      act: (bloc) {
        // act
        bloc
          ..add(const FinancialStatementsEvent.tabShown(tTicker))
          ..add(const FinancialStatementsEvent.chartSwiped(1));
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (bloc) {
        expect(bloc.balAnalytics?.viewedCurrChart, isTrue);
        expect(bloc.balAnalytics?.viewedBalanceTab, isTrue);
      },
    );
  });

  group('FinancialStatementsBloc - Active Tab Subscription', () {
    blocTest<FinancialStatementsBloc, FinancialStatementsState>(
      'activeTabStream_financialStatementsActivated_triggersStalenessLoad',
      build: () {
        // arrange
        when(() => mockGetIncomeStatements(any())).thenAnswer(
          (_) async => Right((
            List<IncomeStatement>.from([tIncome]),
            CompanyProfileDataOrigin.api,
          )),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        tabActivationController.add(tFinancialStatementsActivation);
      },
      // assert
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
      'activeTabStream_otherTabActivated_emitsNothing',
      build: () {
        // arrange
        return bloc;
      },
      act: (bloc) {
        // act
        tabActivationController.add(tOtherTabActivation);
      },
      // assert
      expect: () => const <FinancialStatementsState>[],
      verify: (_) {
        verifyNever(() => mockGetIncomeStatements(any()));
      },
      wait: const Duration(milliseconds: 500),
    );
  });
}
