import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_ratios_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pe_ratio/company_pe_ratio_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRatiosUseCase extends Mock implements GetRatiosUseCase {}

void main() {
  late CompanyPeRatioBloc bloc;
  late MockGetRatiosUseCase mockGetRatios;

  setUp(() {
    mockGetRatios = MockGetRatiosUseCase();
    bloc = CompanyPeRatioBloc(mockGetRatios);
  });

  const tTicker = 'AAPL';
  const tRatios = [
    CompanyRatios(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      priceToEarningsRatio: 18.0,
      priceToFreeCashFlowRatio: 15.0,
    ),
    CompanyRatios(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      priceToEarningsRatio: 28.0,
      priceToFreeCashFlowRatio: 25.0,
    ),
  ];

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyPeRatioState.initial());
  });

  group('CompanyPeRatioBloc - loadRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Right(tRatios));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
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
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRatios(tTicker)).called(1);
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = ServerFailure('Server error');
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPeRatioState.loading(),
          const CompanyPeRatioState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRatios(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Right(tRatios));
        return bloc;
      },
      seed: () => const CompanyPeRatioState.loaded(
        dataPoints: [],
        chartData: [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyPeRatioEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
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
        // assert
        verify(() => mockGetRatios(tTicker)).called(1);
      },
    );
  });

  group('CompanyPeRatioBloc - stalenessCheckRequested', () {
    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Right(tRatios));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
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
        // arrange
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRatios(any()));
      },
    );

    blocTest<CompanyPeRatioBloc, CompanyPeRatioState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Right(tRatios));
        return bloc;
      },
      seed: () => CompanyPeRatioState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 28.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPeRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
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
  });
}
