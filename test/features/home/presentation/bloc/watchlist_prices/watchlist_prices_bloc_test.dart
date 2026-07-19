import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/get_watchlist_prices_usecase.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_event.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWatchlistPricesUseCase extends Mock
    implements GetWatchlistPricesUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

const tTickers = ['AXP', 'NVDA'];
const tFailure = Failure.server('error');

const tStockPrice = WatchlistStockPrice(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 298.42,
  previousClose: 294.75,
  change: 3.67,
  changePercent: 1.24,
  sessionDate: '2026-07-17',
  series: [WatchlistStockPricePoint(time: '09:30', close: 295.1)],
  closeFinalized: false,
);

void main() {
  late WatchlistPricesBloc bloc;
  late MockGetWatchlistPricesUseCase mockGetWatchlistPrices;
  late MockConfigService mockConfigService;

  setUp(() {
    mockGetWatchlistPrices = MockGetWatchlistPricesUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.showWatchlistPrice).thenReturn(true);
    bloc = WatchlistPricesBloc(
      mockGetWatchlistPrices,
      mockConfigService,
      stubbedGetAuthStream(),
    );
  });

  tearDown(() => bloc.close());

  group('WatchlistPricesBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(bloc.state, const WatchlistPricesState.initial());
    });

    group('loadRequested', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_configFlagOff_emitsDisabledWithoutFetching',
        build: () {
          // arrange
          when(() => mockConfigService.showWatchlistPrice).thenReturn(false);
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [const WatchlistPricesState.disabled()],
        verify: (_) {
          verifyNever(() => mockGetWatchlistPrices(any()));
        },
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_useCaseReturnsRight_emitsLoadingAndLoaded',
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Right([tStockPrice]),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        ],
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_useCaseReturnsLeft_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Left(tFailure),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.failure(tFailure),
        ],
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_refreshFailsAfterLoaded_keepsLoadedPrices',
        seed: () => const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Left(tFailure),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => <WatchlistPricesState>[],
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_refreshSucceedsAfterLoaded_emitsLoadedWithoutLoading',
        seed: () => const WatchlistPricesState.loaded({}),
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Right([tStockPrice]),
          );
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        ],
      );
    });

    group('reset', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'reset_fromLoaded_emitsInitial',
        seed: () => const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        build: () => bloc,
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.reset());
        },
        // assert
        expect: () => [const WatchlistPricesState.initial()],
      );
    });
  });
}
