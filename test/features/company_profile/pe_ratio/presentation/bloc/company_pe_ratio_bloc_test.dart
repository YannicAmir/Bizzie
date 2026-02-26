import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/models/pe_ratio.dart';
import 'package:bizzie/features/company_profile/pe_ratio/domain/usecases/get_pe_ratio_usecase.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_event.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/bloc/company_pe_ratio_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bizzie/core/interfaces/i_config_service.dart';

class MockGetPeRatioUseCase extends Mock implements GetPeRatioUseCase {}

class MockConfigService extends Mock implements IConfigService {}

void main() {
  late CompanyPeRatioBloc bloc;
  late MockGetPeRatioUseCase mockGetPeRatio;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetPeRatio = MockGetPeRatioUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.freePlanHistoryCount).thenReturn(7);
    bloc = CompanyPeRatioBloc(mockGetPeRatio, mockConfigService);
  });

  const tTicker = 'AAPL';
  const tRatios = [
    PeRatio(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      priceToEarningsRatio: 18.0,
    ),
    PeRatio(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      priceToEarningsRatio: 28.0,
    ),
  ];

  test('initialState_isCorrect', () {
    // Assert
    expect(bloc.state, const CompanyPeRatioState.initial());
  });

  group('CompanyPeRatioBloc - loadRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                28.0,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((28.0 - 18.0) / 18.0) * 100,
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
        verify(() => mockGetPeRatio(tTicker)).called(1);
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // Arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetPeRatio(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          const CompanyPeRatioState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetPeRatio(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // Act
        bloc.add(
          const CompanyPeRatioEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
      verify: (_) {
        // Assert
        verify(() => mockGetPeRatio(tTicker)).called(1);
      },
    );
  });

  group('CompanyPeRatioBloc - stalenessCheckRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // Arrange
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [];
      },
      verify: (_) {
        // Assert
        verifyNever(() => mockGetPeRatio(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // Arrange
        when(() => mockGetPeRatio(tTicker)).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        ticker: tTicker,
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // Act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // Assert
        return [
          const CompanyPeRatioState.loading(),
          isA<CompanyPeRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            28.0,
          ),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_differentTicker_reloadsData',
      build: () {
        // Arrange
        when(() => mockGetPeRatio('MSFT')).thenAnswer(
          (_) async => const Right((tRatios, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        ticker: 'AAPL',
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) => bloc.add(const CompanyPeRatioEvent.loadRequested('MSFT')),
      expect: () => [
        const CompanyPeRatioState.loading(),
        isA<CompanyPeRatioState>().having(
          (s) => s.maybeMap(loaded: (l) => l.ticker, orElse: () => null),
          'ticker',
          'MSFT',
        ),
      ],
    );
  });
}
