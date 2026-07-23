import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/get_watchlist_prices_usecase.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_event.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWatchlistPricesUseCase extends Mock
    implements GetWatchlistPricesUseCase {}

class MockGetWatchlistUseCase extends Mock implements GetWatchlistUseCase {}

class MockConfigService extends Mock implements IConfigService {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream([Stream<UserModel?>? stream]) {
  final mock = MockGetAuthStream();
  // Firebase's authStateChanges is a broadcast stream; mirror that so the
  // bloc's reset subscription and watchlist subscription can both listen.
  final broadcast = stream?.asBroadcastStream() ?? const Stream.empty();
  when(() => mock()).thenAnswer((_) => broadcast);
  return mock;
}

const tTickers = ['AXP', 'NVDA'];
const tFailure = Failure.server('error');

const tUser = UserModel(id: 'uid-1', email: 'test@bizzie.app');

const tCompanies = [
  Company(ticker: 'AXP', name: 'American Express Company'),
  Company(ticker: 'NVDA', name: 'NVIDIA Corporation'),
];

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
  late MockGetWatchlistUseCase mockGetWatchlist;
  late MockConfigService mockConfigService;

  WatchlistPricesBloc buildBloc({Stream<UserModel?>? authStream}) {
    return WatchlistPricesBloc(
      mockGetWatchlistPrices,
      mockGetWatchlist,
      mockConfigService,
      stubbedGetAuthStream(authStream),
    );
  }

  setUp(() {
    mockGetWatchlistPrices = MockGetWatchlistPricesUseCase();
    mockGetWatchlist = MockGetWatchlistUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.showWatchlistPrice).thenReturn(true);
    bloc = buildBloc();
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

    group('watchlist subscription', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'signedInWatchlistEmits_autoLoadsPricesForTickers',
        build: () {
          // arrange
          when(() => mockGetWatchlist('uid-1')).thenAnswer(
            (_) async =>
                Stream.value(const Right<Failure, List<Company>>(tCompanies)),
          );
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Right([tStockPrice]),
          );
          return buildBloc(authStream: Stream.value(tUser));
        },
        // assert — no widget-layer dispatch required; the bloc reacts to the
        // watchlist stream on its own.
        wait: const Duration(milliseconds: 50),
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        ],
      );
    });

    group('refreshRequested', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'refreshRequested_withoutKnownTickers_doesNothing',
        build: () => bloc,
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.refreshRequested());
        },
        // assert
        expect: () => <WatchlistPricesState>[],
        verify: (_) {
          verifyNever(() => mockGetWatchlistPrices(any()));
        },
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'refreshRequested_afterLoad_reloadsRememberedTickers',
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Right([tStockPrice]),
          );
          return bloc;
        },
        act: (bloc) async {
          // act — first load establishes the tracked tickers, then refresh
          // reuses them without any ticker payload.
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
          await bloc.stream.firstWhere((s) => s is WatchlistPricesLoaded);
          bloc.add(const WatchlistPricesEvent.refreshRequested());
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        ],
        verify: (_) {
          verify(() => mockGetWatchlistPrices(tTickers)).called(2);
        },
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

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'reset_thenSameTickers_reloadsInsteadOfDeduping',
        build: () {
          // arrange
          when(() => mockGetWatchlistPrices(tTickers)).thenAnswer(
            (_) async => const Right([tStockPrice]),
          );
          return bloc;
        },
        act: (bloc) async {
          // act — load a ticker set, reset the session, then load the identical
          // set again. The dedup baseline must clear on reset so the second load
          // is not suppressed against the previous session.
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
          await bloc.stream.firstWhere((s) => s is WatchlistPricesLoaded);
          bloc.add(const WatchlistPricesEvent.reset());
          await bloc.stream.firstWhere(
            (s) => s == const WatchlistPricesState.initial(),
          );
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
          const WatchlistPricesState.initial(),
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        ],
        verify: (_) {
          verify(() => mockGetWatchlistPrices(tTickers)).called(2);
        },
      );
    });
  });
}
