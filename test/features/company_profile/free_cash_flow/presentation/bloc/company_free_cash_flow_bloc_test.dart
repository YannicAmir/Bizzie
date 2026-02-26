import 'package:bizzie/core/enums/data_origin.dart';
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
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetFreeCashFlowStatsUseCase extends Mock
    implements GetFreeCashFlowStatsUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyFreeCashFlowBloc bloc;
  late MockGetFreeCashFlowStatsUseCase mockGetFreeCashFlowStats;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetFreeCashFlowStats = MockGetFreeCashFlowStatsUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyFreeCashFlowBloc(mockGetFreeCashFlowStats, mockConfigService);
  });

  const tTicker = 'AAPL';
  const tFcfStats = FreeCashFlowStats(
    reportedCurrency: 'USD',
    annualFcf: [
      FinancialDataPoint(date: '2023-09-30', period: 'FY', value: 99584.0),
      FinancialDataPoint(date: '2022-09-24', period: 'FY', value: 111443.0),
    ],
    quarterlyFcf: [
      FinancialDataPoint(date: '2023-07-01', period: 'Q3', value: 24285.0),
    ],
  );

  test('initialState_isCorrect', () {
    expect(bloc.state, const CompanyFreeCashFlowState.initial());
  });

  group('CompanyFreeCashFlowBloc - loadRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>()
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
        verify(() => mockGetFreeCashFlowStats(tTicker)).called(1);
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetFreeCashFlowStats(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        const CompanyFreeCashFlowState.failure(Failure.server('Server error')),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      // Arrange
      build: () => bloc,
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested(tTicker)),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats('MSFT')).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: 'AAPL',
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) =>
          bloc.add(const CompanyFreeCashFlowEvent.loadRequested('MSFT')),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadedOnly',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: [],
        quarterlyChartData: [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.loadRequested(
          tTicker,
          forceRefresh: true,
        ),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });

  group('CompanyFreeCashFlowBloc - stalenessCheckRequested', () {
    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      // Arrange
      build: () => bloc,
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetFreeCashFlowStats(any()));
      },
    );

    blocTest<CompanyFreeCashFlowBloc, CompanyFreeCashFlowState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetFreeCashFlowStats(tTicker)).thenAnswer(
          (_) async => const Right((tFcfStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyFreeCashFlowState.loaded(
        ticker: tTicker,
        fcfStats: tFcfStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      // Act
      act: (bloc) => bloc.add(
        const CompanyFreeCashFlowEvent.stalenessCheckRequested(tTicker),
      ),
      // Assert
      expect: () => [
        const CompanyFreeCashFlowState.loading(),
        isA<CompanyFreeCashFlowState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          tTicker,
        ),
      ],
    );
  });
}
