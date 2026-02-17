import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/eps/domain/usecases/get_eps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_bloc.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_event.dart';
import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetEpsStatsUseCase extends Mock implements GetEpsStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyEpsBloc bloc;
  late MockGetEpsStatsUseCase mockGetEpsStatsUseCase;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetEpsStatsUseCase = MockGetEpsStatsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyEpsBloc(mockGetEpsStatsUseCase, mockConfigService);
  });

  const tTicker = 'AAPL';
  const tEpsStats = EpsStats(
    reportedCurrency: 'USD',
    annualEps: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 6.13),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 6.11),
    ],
    quarterlyEps: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 1.26),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyEpsState.initial());
  });

  group('CompanyEpsBloc - loadRequested', () {
    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Right(tEpsStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.epsStats, orElse: () => null),
            'epsStats',
            tEpsStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetEpsStatsUseCase(tTicker)).called(1);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyEpsState.loading(),
          const CompanyEpsState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyEpsState.loaded(
        epsStats: tEpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetEpsStatsUseCase(any()));
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Right(tEpsStats));
        return bloc;
      },
      seed: () => const CompanyEpsState.loaded(
        epsStats: tEpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyEpsEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.epsStats, orElse: () => null),
            'epsStats',
            tEpsStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetEpsStatsUseCase(tTicker)).called(1);
      },
    );
  });

  group('CompanyEpsBloc - stalenessCheckRequested', () {
    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Right(tEpsStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.epsStats, orElse: () => null),
            'epsStats',
            tEpsStats,
          ),
        ];
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyEpsState.loaded(
        epsStats: tEpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetEpsStatsUseCase(any()));
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Right(tEpsStats));
        return bloc;
      },
      seed: () => CompanyEpsState.loaded(
        epsStats: tEpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>().having(
            (s) => s.maybeMap(loaded: (l) => l.epsStats, orElse: () => null),
            'epsStats',
            tEpsStats,
          ),
        ];
      },
    );
  });
}
