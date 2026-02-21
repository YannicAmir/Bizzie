import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHistoricalEodPricesUseCase extends Mock
    implements GetHistoricalEodPricesUseCase {}

void main() {
  late HistoricalPriceEodBloc bloc;
  late MockGetHistoricalEodPricesUseCase mockGetPrices;

  setUp(() {
    mockGetPrices = MockGetHistoricalEodPricesUseCase();
    bloc = HistoricalPriceEodBloc(mockGetPrices);
  });

  const tTicker = 'AAPL';
  const tPrices = [
    HistoricalPriceEod(
      symbol: tTicker,
      date: '2023-09-30',
      price: 171.21,
      volume: 1000000.0,
    ),
  ];

  test('initialState_isCorrect', () {
    // assert
    expect(bloc.state, const HistoricalPriceEodState.initial());
  });

  group('HistoricalPriceEodBloc - loadRequested', () {
    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'loadRequested_success_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetPrices(tTicker)).thenAnswer(
          (_) async => const Right((tPrices, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const HistoricalPriceEodEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          isA<HistoricalPriceEodState>()
              .having(
                (s) => s.maybeMap(loaded: (l) => l.prices, orElse: () => null),
                'prices',
                tPrices,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataSource, orElse: () => null),
                'dataSource',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetPrices(tTicker)).called(1);
      },
    );

    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'loadRequested_failure_emitsLoadingAndFailure',
      build: () {
        // arrange
        const failure = Failure.server('Server error');
        when(
          () => mockGetPrices(tTicker),
        ).thenAnswer((_) async => const Left(failure));
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(const HistoricalPriceEodEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          const HistoricalPriceEodState.failure(Failure.server('Server error')),
        ];
      },
    );

    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'loadRequested_alreadyLoaded_skipsLoading',
      build: () {
        // arrange
        return bloc;
      },
      seed: () => const HistoricalPriceEodState.loaded(
        tPrices,
        dataSource: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(const HistoricalPriceEodEvent.loadRequested(tTicker));
      },
      expect: () {
        // assert
        return [];
      },
      verify: (_) {
        // assert
        verifyNever(() => mockGetPrices(any()));
      },
    );

    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'loadRequested_alreadyLoadedWithForceRefresh_emitsLoadingAndLoaded',
      build: () {
        // arrange
        when(() => mockGetPrices(tTicker)).thenAnswer(
          (_) async => const Right((tPrices, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => const HistoricalPriceEodState.loaded(
        tPrices,
        dataSource: CompanyProfileDataOrigin.api,
      ),
      act: (bloc) {
        // act
        bloc.add(
          const HistoricalPriceEodEvent.loadRequested(
            tTicker,
            forceRefresh: true,
          ),
        );
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          isA<HistoricalPriceEodState>()
              .having(
                (s) => s.maybeMap(loaded: (l) => l.prices, orElse: () => null),
                'prices',
                tPrices,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataSource, orElse: () => null),
                'dataSource',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
      verify: (_) {
        // assert
        verify(() => mockGetPrices(tTicker)).called(1);
      },
    );
  });

  group('HistoricalPriceEodBloc - stalenessCheckRequested', () {
    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'stalenessCheckRequested_initialState_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetPrices(tTicker)).thenAnswer(
          (_) async => const Right((tPrices, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      act: (bloc) {
        // act
        bloc.add(
          const HistoricalPriceEodEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          isA<HistoricalPriceEodState>()
              .having(
                (s) => s.maybeMap(loaded: (l) => l.prices, orElse: () => null),
                'prices',
                tPrices,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataSource, orElse: () => null),
                'dataSource',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
    );

    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'stalenessCheckRequested_stale_triggersLoadRequested',
      build: () {
        // arrange
        when(() => mockGetPrices(tTicker)).thenAnswer(
          (_) async => const Right((tPrices, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () => HistoricalPriceEodState.loaded(
        tPrices,
        dataSource: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now().subtract(const Duration(days: 10)),
      ),
      act: (bloc) {
        // act
        bloc.add(
          const HistoricalPriceEodEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          isA<HistoricalPriceEodState>()
              .having(
                (s) => s.maybeMap(loaded: (l) => l.prices, orElse: () => null),
                'prices',
                tPrices,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataSource, orElse: () => null),
                'dataSource',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
    );

    blocTest<HistoricalPriceEodBloc, HistoricalPriceEodState>(
      'stalenessCheckRequested_failureState_triggersRetry',
      build: () {
        // arrange
        when(() => mockGetPrices(tTicker)).thenAnswer(
          (_) async => const Right((tPrices, CompanyProfileDataOrigin.api)),
        );
        return bloc;
      },
      seed: () =>
          const HistoricalPriceEodState.failure(Failure.server('error')),
      act: (bloc) {
        // act
        bloc.add(
          const HistoricalPriceEodEvent.stalenessCheckRequested(tTicker),
        );
      },
      expect: () {
        // assert
        return [
          const HistoricalPriceEodState.loading(),
          isA<HistoricalPriceEodState>()
              .having(
                (s) => s.maybeMap(loaded: (l) => l.prices, orElse: () => null),
                'prices',
                tPrices,
              )
              .having(
                (s) =>
                    s.maybeMap(loaded: (l) => l.dataSource, orElse: () => null),
                'dataSource',
                CompanyProfileDataOrigin.api,
              ),
        ];
      },
    );
  });
}
