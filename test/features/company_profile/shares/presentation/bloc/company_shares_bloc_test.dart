import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/domain/usecases/get_shares_usecase.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_bloc.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_event.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetSharesUseCase extends Mock implements GetSharesUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanySharesBloc bloc;
  late MockGetSharesUseCase mockGetShares;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetShares = MockGetSharesUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanySharesBloc(mockGetShares, mockConfigService);
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
    // Assert
    expect(bloc.state, const CompanySharesState.initial());
  });

  group('CompanySharesBloc - loadRequested', () {
    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetShares(tTicker)).thenAnswer(
          (_) async => const Right((tShareStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
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
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
                'dataOrigin',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
      verify: (_) {
        // Assert
        verify(() => mockGetShares(tTicker)).called(1);
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetShares(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanySharesState.loading(),
          const CompanySharesState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        ticker: tTicker,
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
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
        // Act
        bloc.add(const CompanySharesEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetShares(any()));
      },
    );
  });

  group('CompanySharesBloc - stalenessCheckRequested', () {
    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetShares(tTicker)).thenAnswer(
          (_) async => const Right((tShareStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
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
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
                'dataOrigin',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        ticker: tTicker,
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
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
        // Act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetShares(any()));
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetShares(tTicker)).thenAnswer(
          (_) async => const Right((tShareStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        ticker: tTicker,
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
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
        // Act
        bloc.add(const CompanySharesEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
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
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataOrigin, orElse: () => null),
                'dataOrigin',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
    );

    blocTest<CompanySharesBloc, CompanySharesState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetShares('MSFT')).thenAnswer(
          (_) async => const Right((tShareStats, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanySharesState.loaded(
        ticker: 'AAPL',
        shareStats: tShareStats,
        annualChartData: const [],
        quarterlyChartData: const [],
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
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
        // Act
        bloc.add(const CompanySharesEvent.loadRequested('MSFT'));
      },
      expect: () => [
        const CompanySharesState.loading(),
        isA<CompanySharesState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );
  });
}
