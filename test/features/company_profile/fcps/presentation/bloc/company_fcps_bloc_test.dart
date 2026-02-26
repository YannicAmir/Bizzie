import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/fcps/domain/models/fcps_stats.dart';
import 'package:bizzie/features/company_profile/fcps/domain/usecases/get_fcps_stats_usecase.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_bloc.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_event.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetFcpsStatsUseCase extends Mock implements GetFcpsStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyFcpsBloc bloc;
  late MockGetFcpsStatsUseCase mockGetFcpsStats;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetFcpsStats = MockGetFcpsStatsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyFcpsBloc(mockGetFcpsStats, mockConfigService);
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
    expect(bloc.state, const CompanyFcpsState.initial());
  });

  group('CompanyFcpsBloc - loadRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
        verify(() => mockGetFcpsStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetFcpsStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        const CompanyFcpsState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats('MSFT')).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        ticker: 'AAPL',
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyFcpsEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFcpsEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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

  group('CompanyFcpsBloc - stalenessCheckRequested', () {
    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      // Arrange
      build: () => bloc,
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFcpsStats(any()));
      },
    );

    blocTest<CompanyFcpsBloc, CompanyFcpsState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFcpsStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyFcpsState.loaded(
        ticker: tTicker,
        fcpsStats: tFcpsStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFcpsEvent.stalenessCheckRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFcpsState.loading(),
        isA<CompanyFcpsState>()
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
