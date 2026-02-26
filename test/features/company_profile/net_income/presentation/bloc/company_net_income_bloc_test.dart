import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:bizzie/features/company_profile/net_income/domain/usecases/get_net_income_stats_usecase.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_bloc.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_event.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetNetIncomeStatsUseCase extends Mock
    implements GetNetIncomeStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyNetIncomeBloc bloc;
  late MockGetNetIncomeStatsUseCase mockGetNetIncomeStats;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetNetIncomeStats = MockGetNetIncomeStatsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyNetIncomeBloc(mockGetNetIncomeStats, mockConfigService);
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
    expect(bloc.state, const CompanyNetIncomeState.initial());
  });

  group('CompanyNetIncomeBloc - loadRequested', () {
    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetNetIncomeStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>()
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
        verify(() => mockGetNetIncomeStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetNetIncomeStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        const CompanyNetIncomeState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyNetIncomeState.loaded(
        ticker: tTicker,
        netIncomeStats: tNetIncomeStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetNetIncomeStats(any()));
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetNetIncomeStats('MSFT')).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyNetIncomeState.loaded(
        ticker: 'AAPL',
        netIncomeStats: tNetIncomeStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyNetIncomeEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetNetIncomeStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyNetIncomeState.loaded(
        ticker: tTicker,
        netIncomeStats: tNetIncomeStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyNetIncomeEvent.loadRequested(tTicker, forceRefresh: true),
      ),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });

  group('CompanyNetIncomeBloc - stalenessCheckRequested', () {
    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetNetIncomeStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(
        const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>()
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

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      // Arrange
      build: () => bloc,
      seed: () => CompanyNetIncomeState.loaded(
        ticker: tTicker,
        netIncomeStats: tNetIncomeStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetNetIncomeStats(any()));
      },
    );

    blocTest<CompanyNetIncomeBloc, CompanyNetIncomeState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetNetIncomeStats(tTicker)).thenAnswer(
          (_) async =>
              const Right((tNetIncomeStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyNetIncomeState.loaded(
        ticker: tTicker,
        netIncomeStats: tNetIncomeStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyNetIncomeEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyNetIncomeState.loading(),
        isA<CompanyNetIncomeState>()
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
