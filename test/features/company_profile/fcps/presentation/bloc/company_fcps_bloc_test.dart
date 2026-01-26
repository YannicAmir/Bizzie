import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/fcps/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetFcpsStatsUseCase extends Mock implements GetFcpsStatsUseCase {}

void main() {
  late CompanyFcpsBloc bloc;
  late MockGetFcpsStatsUseCase mockGetFcpsStats;

  setUp(() {
    mockGetFcpsStats = MockGetFcpsStatsUseCase();
    bloc = CompanyFcpsBloc(mockGetFcpsStats);
  });

  const tTicker = 'AAPL';
  const tFcpsStats = FcpsStats(
    reportedCurrency: 'USD',
    annualFcps: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 3.50),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 3.20),
    ],
    quarterlyFcps: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 0.85),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyFcpsState.initial());
  });

  group('CompanyFcpsBloc - loadRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcpsStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFcpsState.loading(),
          isA<CompanyFcpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcpsStats, orElse: () => null),
            'fcpsStats',
            tFcpsStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetFcpsStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFcpsState.loading(),
          const CompanyFcpsState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcpsStats));
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyFcpsEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyFcpsState.loading(),
          isA<CompanyFcpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcpsStats, orElse: () => null),
            'fcpsStats',
            tFcpsStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetFcpsStats(tTicker)).called(1);
      },
    );
  });

  group('CompanyFcpsBloc - stalenessCheckRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcpsStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFcpsState.loading(),
          isA<CompanyFcpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcpsStats, orElse: () => null),
            'fcpsStats',
            tFcpsStats,
          ),
        ];
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyFcpsState.loaded(
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Right(tFcpsStats));
        return bloc;
      },
      seed: () => CompanyFcpsState.loaded(
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyFcpsState.loading(),
          isA<CompanyFcpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.fcpsStats, orElse: () => null),
            'fcpsStats',
            tFcpsStats,
          ),
        ];
      },
    );
  });
}
