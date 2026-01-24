import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/usecases/get_ratios_usecase.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_bloc.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_event.dart';
import 'package:bizzie/features/company_profile/presentation/bloc/company_pfcf_ratio/company_pfcf_ratio_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRatiosUseCase extends Mock implements GetRatiosUseCase {}

void main() {
  late CompanyPfcfRatioBloc bloc;
  late MockGetRatiosUseCase mockGetRatios;

  setUp(() {
    mockGetRatios = MockGetRatiosUseCase();
    bloc = CompanyPfcfRatioBloc(mockGetRatios);
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
    expect(bloc.state, const CompanyPfcfRatioState.initial());
  });

  group('CompanyPfcfRatioBloc - loadRequested', () {
    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
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
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                25.0,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((25.0 - 15.0) / 15.0) * 100,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRatios(tTicker)).called(1);
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_filtersZeroValues_emitsLoadedWithValidPoints',
      build: () {
        // arrange
        final ratiosWithZero = [
          ...tRatios,
          CompanyRatios(
            symbol: tTicker,
            date: '2024-01-01',
            period: 'FY',
            priceToEarningsRatio: 0.0,
            priceToFreeCashFlowRatio: 0.0,
          ),
        ];
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => Right(ratiosWithZero));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>().having(
            (s) => s.maybeMap(
              loaded: (l) => l.dataPoints.length,
              orElse: () => null,
            ),
            'dataPoints length',
            2,
          ),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
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
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          const CompanyPfcfRatioState.failure(ServerFailure('Server error')),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyPfcfRatioState.loaded(
        dataPoints: [],
        chartData: [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.loadRequested(tTicker));
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
  });

  group('CompanyPfcfRatioBloc - stalenessCheckRequested', () {
    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
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
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            25.0,
          ),
        ];
      },
    );

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyPfcfRatioState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
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

    blocTest<CompanyPfcfRatioBloc, CompanyPfcfRatioState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRatios(tTicker),
        ).thenAnswer((_) async => const Right(tRatios));
        return bloc;
      },
      seed: () => CompanyPfcfRatioState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 25.0,
        growthPercentage: 5.0,
        absoluteDelta: 1.0,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyPfcfRatioEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyPfcfRatioState.loading(),
          isA<CompanyPfcfRatioState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            25.0,
          ),
        ];
      },
    );
  });
}
