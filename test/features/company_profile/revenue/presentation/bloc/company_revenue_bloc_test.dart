import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/revenue/domain/models/revenue_stats.dart';
import 'package:bizzie/features/company_profile/revenue/domain/usecases/get_revenue_stats_usecase.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_bloc.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_event.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetRevenueStatsUseCase extends Mock
    implements GetRevenueStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyRevenueBloc bloc;
  late MockGetRevenueStatsUseCase mockGetRevenueStats;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetRevenueStats = MockGetRevenueStatsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyRevenueBloc(mockGetRevenueStats, mockConfigService);
  });

  const tTicker = 'AAPL';
  const tRevenueStats = RevenueStats(
    symbol: tTicker,
    reportedCurrency: 'USD',
    annualRevenue: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 383285.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 394328.0),
    ],
    quarterlyRevenue: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 81797.0),
    ],
  );

  test('initialState_isCorrect', () {
    expect(bloc.state, const CompanyRevenueState.initial());
  });

  group('CompanyRevenueBloc - loadRequested', () {
    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetRevenueStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tRevenueStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyRevenueEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        isA<CompanyRevenueState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) =>
                  s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
      // Assert
      verify: (_) {
        verify(() => mockGetRevenueStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyRevenueEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        const CompanyRevenueState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyRevenueState.loaded(
        ticker: tTicker,
        revenueStats: tRevenueStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyRevenueEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetRevenueStats(any()));
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetRevenueStats('MSFT')).thenAnswer(
          (_) async =>
              const Right((tRevenueStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyRevenueState.loaded(
        ticker: 'AAPL',
        revenueStats: tRevenueStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyRevenueEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        isA<CompanyRevenueState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetRevenueStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tRevenueStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyRevenueState.loaded(
        ticker: tTicker,
        revenueStats: tRevenueStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyRevenueEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        isA<CompanyRevenueState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) =>
                  s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );
  });

  group('CompanyRevenueBloc - stalenessCheckRequested', () {
    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetRevenueStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tRevenueStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        isA<CompanyRevenueState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) =>
                  s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      // Arrange
      build: () => bloc,
      seed: () => CompanyRevenueState.loaded(
        ticker: tTicker,
        revenueStats: tRevenueStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetRevenueStats(any()));
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetRevenueStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tRevenueStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyRevenueState.loaded(
        ticker: tTicker,
        revenueStats: tRevenueStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyRevenueState.loading(),
        isA<CompanyRevenueState>()
            .having(
              (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
              'ticker',
              tTicker,
            )
            .having(
              (s) =>
                  s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
              'dataOrigin',
              CompanyProfileDataOrigin.api,
            ),
      ],
    );
  });
}
