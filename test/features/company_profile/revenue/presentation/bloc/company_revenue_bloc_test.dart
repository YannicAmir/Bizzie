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
    // assert
    expect(bloc.state, const CompanyRevenueState.initial());
  });

  group('CompanyRevenueBloc - loadRequested', () {
    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Right(tRevenueStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRevenueState.loading(),
          isA<CompanyRevenueState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.revenueStats, orElse: () => null),
            'revenueStats',
            tRevenueStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRevenueStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRevenueState.loading(),
          const CompanyRevenueState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyRevenueState.loaded(
        revenueStats: tRevenueStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRevenueStats(any()));
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Right(tRevenueStats));
        return bloc;
      },
      seed: () => const CompanyRevenueState.loaded(
        revenueStats: tRevenueStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyRevenueEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyRevenueState.loading(),
          isA<CompanyRevenueState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.revenueStats, orElse: () => null),
            'revenueStats',
            tRevenueStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRevenueStats(tTicker)).called(1);
      },
    );
  });

  group('CompanyRevenueBloc - stalenessCheckRequested', () {
    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Right(tRevenueStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRevenueState.loading(),
          isA<CompanyRevenueState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.revenueStats, orElse: () => null),
            'revenueStats',
            tRevenueStats,
          ),
        ];
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyRevenueState.loaded(
        revenueStats: tRevenueStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRevenueStats(any()));
      },
    );

    blocTest<CompanyRevenueBloc, CompanyRevenueState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRevenueStats(tTicker),
        ).thenAnswer((_) async => const Right(tRevenueStats));
        return bloc;
      },
      seed: () => CompanyRevenueState.loaded(
        revenueStats: tRevenueStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRevenueEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRevenueState.loading(),
          isA<CompanyRevenueState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.revenueStats, orElse: () => null),
            'revenueStats',
            tRevenueStats,
          ),
        ];
      },
    );
  });
}
