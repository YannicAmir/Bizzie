import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/net_income_stats.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_net_income/company_net_income_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNetIncomeStatsUseCase extends Mock
    implements GetNetIncomeStatsUseCase {}

void main() {
  late CompanyNetIncomeBloc bloc;
  late MockGetNetIncomeStatsUseCase mockGetNetIncomeStats;

  setUp(() {
    mockGetNetIncomeStats = MockGetNetIncomeStatsUseCase();
    bloc = CompanyNetIncomeBloc(mockGetNetIncomeStats);
  });

  const tTicker = 'AAPL';
  const tNetIncomeStats = NetIncomeStats(
    reportedCurrency: 'USD',
    annualNetIncome: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 96995.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 99803.0),
    ],
    quarterlyNetIncome: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 19881.0),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyNetIncomeState.initial());
  });

  group('CompanyNetIncomeBloc - loadRequested', () {
    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Right(tNetIncomeStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNetIncomeState.loading(),
          isA<CompanyNetIncomeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.netIncomeStats, orElse: () => null),
            'netIncomeStats',
            tNetIncomeStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetNetIncomeStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNetIncomeState.loading(),
          const CompanyNetIncomeState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyNetIncomeState.loaded(
        netIncomeStats: tNetIncomeStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetNetIncomeStats(any()));
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Right(tNetIncomeStats));
        return bloc;
      },
      seed: () => const CompanyNetIncomeState.loaded(
        netIncomeStats: tNetIncomeStats,
        annualChartData: [],
        quarterlyChartData: [],
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyNetIncomeEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyNetIncomeState.loading(),
          isA<CompanyNetIncomeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.netIncomeStats, orElse: () => null),
            'netIncomeStats',
            tNetIncomeStats,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetNetIncomeStats(tTicker)).called(1);
      },
    );
  });

  group('CompanyNetIncomeBloc - stalenessCheckRequested', () {
    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Right(tNetIncomeStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNetIncomeState.loading(),
          isA<CompanyNetIncomeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.netIncomeStats, orElse: () => null),
            'netIncomeStats',
            tNetIncomeStats,
          ),
        ];
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyNetIncomeState.loaded(
        netIncomeStats: tNetIncomeStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetNetIncomeStats(any()));
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Right(tNetIncomeStats));
        return bloc;
      },
      seed: () => CompanyNetIncomeState.loaded(
        netIncomeStats: tNetIncomeStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyNetIncomeState.loading(),
          isA<CompanyNetIncomeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.netIncomeStats, orElse: () => null),
            'netIncomeStats',
            tNetIncomeStats,
          ),
        ];
      },
    );
  });
}
