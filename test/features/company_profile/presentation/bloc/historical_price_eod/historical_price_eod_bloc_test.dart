import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/company_profile/security/domain/models/historical_price_eod.dart';
import 'package:bizzie/features/company_profile/security/domain/usecases/get_historical_eod_prices_use_case.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_bloc.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_event.dart';
import 'package:bizzie/features/company_profile/security/presentation/bloc/historical_price_eod/historical_price_eod_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/services/market_hours_freshness_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/interfaces/i_time_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHistoricalEodPricesUseCase extends Mock
    implements GetHistoricalEodPricesUseCase {}

class MockMarketHoursFreshnessService extends Mock
    implements MarketHoursFreshnessService {}

class MockTimeProvider extends Mock implements ITimeProvider {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockTimeProvider stubbedTimeProvider() {
  final mock = MockTimeProvider();
  when(() => mock.nowLocal).thenAnswer((_) => DateTime.now());
  return mock;
}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

void main() {
  late HistoricalPriceEodBloc bloc;
  late MockGetHistoricalEodPricesUseCase mockGetPrices;
  late MockMarketHoursFreshnessService mockFreshnessService;

  setUp(() {
    mockGetPrices = MockGetHistoricalEodPricesUseCase();
    mockFreshnessService = MockMarketHoursFreshnessService();
    bloc = HistoricalPriceEodBloc(
      mockGetPrices,
      mockFreshnessService,
      stubbedTimeProvider(),
      stubbedGetAuthStream(),
    );
  });

  tearDown(() => bloc.close());

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
        when(() => mockFreshnessService.isStale(any())).thenReturn(true);
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
      'stalenessCheckRequested_fresh_doesNotTriggerLoad',
      build: () {
        // arrange
        when(() => mockFreshnessService.isStale(any())).thenReturn(false);
        return bloc;
      },
      seed: () => HistoricalPriceEodState.loaded(
        tPrices,
        dataSource: CompanyProfileDataOrigin.api,
        lastUpdated: DateTime.now(),
      ),
      act: (bloc) {
        // act
        bloc.add(
          const HistoricalPriceEodEvent.stalenessCheckRequested(tTicker),
        );
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
