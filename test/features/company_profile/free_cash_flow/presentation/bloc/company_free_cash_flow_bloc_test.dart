import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/domain/usecases/get_free_cash_flow_stats_usecase.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_bloc.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_event.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFreeCashFlowStatsUseCase extends Mock
    implements GetFreeCashFlowStatsUseCase {}

void main() {
  late CompanyFreeCashFlowBloc bloc;
  late MockGetFreeCashFlowStatsUseCase mockGetFreeCashFlowStats;

  setUp(() {
    mockGetFreeCashFlowStats = MockGetFreeCashFlowStatsUseCase();
    bloc = CompanyFreeCashFlowBloc(mockGetFreeCashFlowStats);
  });

  const tTicker = 'AAPL';
  const tFcfStats = FreeCashFlowStats(
    reportedCurrency: 'USD',
    annualFcf: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 99584.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 111443.0),
    ],
    quarterlyFcf: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 24256.0),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyFreeCashFlowState.initial());
  });

  group('CompanyFreeCashFlowBloc - loadRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcfStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFreeCashFlowState.loading(),
          isA<CompanyFreeCashFlowState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcfStats, orElse: () => null),
            'fcfStats',
            tFcfStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetFreeCashFlowStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFreeCashFlowState.loading(),
          const CompanyFreeCashFlowState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcfStats));
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyFreeCashFlowEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyFreeCashFlowState.loading(),
          isA<CompanyFreeCashFlowState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcfStats, orElse: () => null),
            'fcfStats',
            tFcfStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetFreeCashFlowStats(tTicker)).called(1);
      },
    );
  });

  group('CompanyFreeCashFlowBloc - stalenessCheckRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcfStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyFreeCashFlowState.loading(),
          isA<CompanyFreeCashFlowState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcfStats, orElse: () => null),
            'fcfStats',
            tFcfStats,
          ),
        ];
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcfStats));
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyFreeCashFlowState.loading(),
          isA<CompanyFreeCashFlowState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcfStats, orElse: () => null),
            'fcfStats',
            tFcfStats,
          ),
        ];
      },
    );
  });
}
