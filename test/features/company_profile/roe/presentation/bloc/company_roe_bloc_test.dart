import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/roe/domain/models/roe.dart';
import 'package:bizzie/features/company_profile/roe/domain/usecases/get_roe_usecase.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_bloc.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_event.dart';
import 'package:bizzie/features/company_profile/roe/presentation/bloc/company_roe_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRoeUseCase extends Mock implements GetRoeUseCase {}

void main() {
  late CompanyRoeBloc bloc;
  late MockGetRoeUseCase mockGetRoe;

  setUp(() {
    mockGetRoe = MockGetRoeUseCase();
    bloc = CompanyRoeBloc(mockGetRoe);
  });

  const tTicker = 'AAPL';
  const tRoeMetrics = [
    Roe(
      symbol: tTicker,
      date: '2018-10-01',
      period: 'FY',
      returnOnEquity: 0.35,
    ),
    Roe(
      symbol: tTicker,
      date: '2023-09-30',
      period: 'FY',
      returnOnEquity: 0.45,
    ),
  ];

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const CompanyRoeState.initial());
  });

  group('CompanyRoeBloc - loadRequested', () {
    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Right(tRoeMetrics));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>()
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.currentValue,
                  orElse: () => null,
                ),
                'currentValue',
                0.45,
              )
              .having(
                (s) => s.maybeMap(
                  loaded: (l) => l.growthPercentage,
                  orElse: () => null,
                ),
                'growthPercentage',
                ((0.45 - 0.35) / 0.35) * 100,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRoe(tTicker)).called(1);
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          const CompanyRoeState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const CompanyRoeState.loaded(
        dataPoints: [],
        chartData: [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRoe(any()));
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Right(tRoeMetrics));
        return bloc;
      },
      seed: () => const CompanyRoeState.loaded(
        dataPoints: [],
        chartData: [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
      ),
      act: (bloc) {
        // act
        bloc.add(
          const CompanyRoeEvent.loadRequested(tTicker, forceRefresh: true),
        );
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetRoe(tTicker)).called(1);
      },
    );
  });

  group('CompanyRoeBloc - stalenessCheckRequested', () {
    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Right(tRoeMetrics));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => CompanyRoeState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetRoe(any()));
      },
    );

    blocTest<CompanyRoeBloc, CompanyRoeState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(
          () => mockGetRoe(tTicker),
        ).thenAnswer((_) async => const Right(tRoeMetrics));
        return bloc;
      },
      seed: () => CompanyRoeState.loaded(
        dataPoints: const [],
        chartData: const [],
        currentValue: 0.45,
        growthPercentage: 5.0,
        absoluteDelta: 0.1,
        isPositive: true,
        referenceLabel: '2018',
        lastUpdated: DateTime.now().subtract(const Duration(hours: 25)),
      ),
      act: (bloc) {
        // act
        bloc.add(const CompanyRoeEvent.stalenessCheckRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const CompanyRoeState.loading(),
          isA<CompanyRoeState>().having(
            (s) =>
                s.maybeMap(loaded: (l) => l.currentValue, orElse: () => null),
            'currentValue',
            0.45,
          ),
        ];
      },
    );
  });
}
