import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/share_stats.dart';
import 'package:bizzie/features/company_profile/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_share_stats_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_shares/company_shares_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetShareStatsUseCase extends Mock implements GetShareStatsUseCase {}

void main() {
  late CompanySharesBloc bloc;
  late MockGetShareStatsUseCase mockGetShareStats;

  setUp(() {
    mockGetShareStats = MockGetShareStatsUseCase();
    bloc = CompanySharesBloc(mockGetShareStats);
  });

  const tTicker = 'AAPL';
  const tShareStats = ShareStats(
    currentSharesOutstanding: 15640.0,
    annualWeightedAverageShares: [
      FinancialDataPoint(date: '2018-10-01', period: 'FY', value: 18000.0),
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 15000.0),
    ],
    quarterlyWeightedAverageShares: [
      FinancialDataPoint(date: '2022-07-01', period: 'Q3', value: 16000.0),
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 15500.0),
    ],
  );

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanySharesState.initial());
  });

  group('CompanySharesBloc - loadRequested', () {
    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetShareStats(tTicker),
        ).thenAnswer((_) async => const Right(tShareStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySharesState.loading(),
          isA<CompanySharesState>()
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.shareStats, orElse: () => null),
                'shareStats',
                tShareStats,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.annualSummary.currentValue,
                  orElse: () => null,
                ),
                'annualSummary currentValue',
                15000.0,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.quarterlySummary.currentValue,
                  orElse: () => null,
                ),
                'quarterlySummary currentValue',
                15500.0,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetShareStats(tTicker)).called(1);
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetShareStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySharesState.loading(),
          const CompanySharesState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        annualSummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
        quarterlySummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetShareStats(any()));
      },
    );
  });

  group('CompanySharesBloc - stalenessCheckRequested', () {
    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetShareStats(tTicker),
        ).thenAnswer((_) async => const Right(tShareStats));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySharesState.loading(),
          isA<CompanySharesState>().having(
            (s) => s.maybeMap(loaded: (l) => l.shareStats, orElse: () => null),
            'shareStats',
            tShareStats,
          ),
        ];
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        annualSummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
        quarterlySummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetShareStats(any()));
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetShareStats(tTicker),
        ).thenAnswer((_) async => const Right(tShareStats));
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        annualSummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
        quarterlySummary: const SharesSummaryData(
          currentValue: 0,
          growthPercentage: 0,
          absoluteDelta: 0,
          isPositive: false,
          referenceLabel: '',
        ),
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanySharesState.loading(),
          isA<CompanySharesState>().having(
            (s) => s.maybeMap(loaded: (l) => l.shareStats, orElse: () => null),
            'shareStats',
            tShareStats,
          ),
        ];
      },
    );
  });
}
