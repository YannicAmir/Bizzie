import 'package:bizzie/core/enums/data_origin.dart';
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
    expect(bloc.state, const CompanyEpsState.initial());
  });

  group('CompanyEpsBloc - loadRequested', () {
    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetEpsStatsUseCase(tTicker)).thenAnswer(
          (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyEpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyEpsState.loading(),
        isA<CompanyEpsState>()
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
      verify: (_) {
        verify(() => mockGetEpsStatsUseCase(tTicker)).called(1);
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetEpsStatsUseCase(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(const CompanyEpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyEpsState.loading(),
        const CompanyEpsState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyEpsState.loaded(
        ticker: tTicker,
        epsStats: tEpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyEpsEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetEpsStatsUseCase(any()));
      },
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetEpsStatsUseCase('MSFT')).thenAnswer(
          (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyEpsState.loaded(
        ticker: 'AAPL',
        epsStats: tEpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(const CompanyEpsEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyEpsState.loading(),
        isA<CompanyEpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyEpsBloc, CompanyEpsState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetEpsStatsUseCase(tTicker)).thenAnswer(
          (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyEpsState.loaded(
        ticker: tTicker,
        epsStats: tEpsStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyEpsEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      // Assert
      expect: () => [
        const CompanyEpsState.loading(),
        isA<CompanyEpsState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
    group('CompanyEpsBloc - stalenessCheckRequested', () {
      blocTest<CompanyEpsBloc, CompanyEpsState>(
        'stalenessCheckRequested_initialState_triggersLoadRequested',
        build: () {
          // Arrange
          when(() => mockGetEpsStatsUseCase(tTicker)).thenAnswer(
            (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
          );
          return bloc;
        },
        // Act
        act: (bloc) =>
            bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker)),
        // Assert
        expect: () => [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>()
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

      blocTest<CompanyEpsBloc, CompanyEpsState>(
        'stalenessCheckRequested_fresh_doesNotTriggerLoad',
        // Arrange
        build: () => bloc,
        seed: () => CompanyEpsState.loaded(
          ticker: tTicker,
          epsStats: tEpsStats,
          annualChartData: const [],
          quarterlyChartData: const [],
          historyLimit: 7,
          dataOrigin: CompanyProfileDataOrigin.api,
          lastUpdated: DateTime.now(),
        ),
        // Act
        act: (bloc) =>
            bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker)),
        // Assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetEpsStatsUseCase(any()));
        },
      );

      blocTest<CompanyEpsBloc, CompanyEpsState>(
        'stalenessCheckRequested_stale_triggersLoadRequested',
        build: () {
          // Arrange
          when(() => mockGetEpsStatsUseCase(tTicker)).thenAnswer(
            (_) async => const Right((tEpsStats, CompanyProfileDataOrigin.api)),
          );
          return bloc;
        },
        seed: () => CompanyEpsState.loaded(
          ticker: tTicker,
          epsStats: tEpsStats,
          annualChartData: const [],
          quarterlyChartData: const [],
          historyLimit: 7,
          dataOrigin: CompanyProfileDataOrigin.api,
          lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
        ),
        // Act
        act: (bloc) =>
            bloc.add(const CompanyEpsEvent.stalenessCheckRequested(tTicker)),
        // Assert
        expect: () => [
          const CompanyEpsState.loading(),
          isA<CompanyEpsState>()
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
  });
}
