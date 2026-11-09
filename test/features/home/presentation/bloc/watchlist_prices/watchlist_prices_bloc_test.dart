import 'dart:async';

import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/home/domain/models/watchlist_stock_price.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_prices_usecase.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_event.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchWatchlistPricesUseCase extends Mock
    implements WatchWatchlistPricesUseCase {}

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

const tUpdatedStockPrice = WatchlistStockPrice(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 299.10,
  previousClose: 294.75,
  change: 4.35,
  changePercent: 1.48,
  sessionDate: '2026-07-17',
  series: [WatchlistStockPricePoint(time: '09:30', close: 295.1)],
  closeFinalized: false,
);

const tStaleStockPrice = WatchlistStockPrice(
  ticker: 'AXP',
  companyName: 'American Express Company',
  price: 250.00,
  previousClose: 251.00,
  change: -1.00,
  changePercent: -0.40,
  sessionDate: '2026-07-16',
  series: [],
  closeFinalized: true,
);

void main() {
  late WatchlistPricesBloc bloc;
  late MockWatchWatchlistPricesUseCase mockWatchWatchlistPrices;
  late MockGetWatchlistUseCase mockGetWatchlist;
  late MockConfigService mockConfigService;

  WatchlistPricesBloc buildBloc({Stream<UserModel?>? authStream}) {
    return WatchlistPricesBloc(
      mockWatchWatchlistPrices,
      mockGetWatchlist,
      mockConfigService,
      stubbedGetAuthStream(authStream),
    );
  }

  void stubWatchPrices(
    Stream<Either<Failure, List<WatchlistStockPrice>>> stream,
  ) {
    when(() => mockWatchWatchlistPrices(tTickers)).thenAnswer((_) => stream);
  }

  setUp(() {
    mockWatchWatchlistPrices = MockWatchWatchlistPricesUseCase();
    mockGetWatchlist = MockGetWatchlistUseCase();
    mockConfigService = MockConfigService();
    when(() => mockConfigService.showWatchlistPrice).thenReturn(true);
    bloc = buildBloc();
  });

  tearDown(() => bloc.close());

  group('WatchlistPricesBloc', () {
    test('initialState_isCorrect', () {
      // arrange
      // act
      // assert
      expect(bloc.state, const WatchlistPricesState.initial());
    });

    group('loadRequested', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_configFlagOff_emitsDisabledWithoutWatching',
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
          verifyNever(() => mockWatchWatchlistPrices(any()));
        },
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_useCaseEmitsRight_emitsLoadingAndLoaded',
        build: () {
          // arrange
          stubWatchPrices(Stream.value(const Right([tStockPrice])));
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
        'loadRequested_pricesUpdate_emitsEachLiveSnapshot',
        build: () {
          // arrange
          stubWatchPrices(
            Stream.fromIterable(const [
              Right([tStockPrice]),
              Right([tUpdatedStockPrice]),
            ]),
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
          const WatchlistPricesState.loaded({'AXP': tUpdatedStockPrice}),
        ],
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_useCaseEmitsLeft_emitsLoadingAndFailure',
        build: () {
          // arrange
          stubWatchPrices(Stream.value(const Left(tFailure)));
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
        'loadRequested_streamErrors_emitsLoadingAndFailure',
        build: () {
          // arrange
          stubWatchPrices(Stream.error(Exception('stream failed')));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.failure(
            Failure.server('Exception: stream failed'),
          ),
        ],
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_failureAfterLiveSnapshot_keepsLoadedPrices',
        build: () {
          // arrange
          stubWatchPrices(
            Stream.fromIterable(const [
              Right([tStockPrice]),
              Left(tFailure),
            ]),
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
        'loadRequested_refreshFailsAfterLoaded_keepsLoadedPrices',
        seed: () => const WatchlistPricesState.loaded({'AXP': tStockPrice}),
        build: () {
          // arrange
          stubWatchPrices(Stream.value(const Left(tFailure)));
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
          stubWatchPrices(Stream.value(const Right([tStockPrice])));
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

      final sameTickersController =
          StreamController<Either<Failure, List<WatchlistStockPrice>>>();
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'loadRequested_sameTickerSet_keepsExistingSubscription',
        build: () {
          // arrange
          stubWatchPrices(sameTickersController.stream);
          return bloc;
        },
        act: (bloc) async {
          // act — the watchlist stream re-emits the same tickers on unrelated
          // document changes; the live price stream must not restart.
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
          await Future<void>.delayed(Duration.zero);
          sameTickersController.add(const Right([tStockPrice]));
          await Future<void>.delayed(Duration.zero);
          bloc.add(const WatchlistPricesEvent.loadRequested(['NVDA', 'AXP']));
          await Future<void>.delayed(Duration.zero);
          sameTickersController.add(const Right([tUpdatedStockPrice]));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
          const WatchlistPricesState.loaded({'AXP': tUpdatedStockPrice}),
        ],
        verify: (_) {
          verify(() => mockWatchWatchlistPrices(tTickers)).called(1);
        },
        tearDown: sameTickersController.close,
      );
    });

    group('watchlist subscription', () {
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'signedInWatchlistEmits_autoWatchesPricesForTickers',
        build: () {
          // arrange
          when(() => mockGetWatchlist('uid-1')).thenAnswer(
            (_) async =>
                Stream.value(const Right<Failure, List<Company>>(tCompanies)),
          );
          stubWatchPrices(Stream.value(const Right([tStockPrice])));
          return buildBloc(authStream: Stream.value(tUser));
        },
        // act — no widget-layer dispatch required; the bloc reacts to the
        // watchlist stream on its own.
        wait: const Duration(milliseconds: 50),
        // assert
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
          verifyNever(() => mockWatchWatchlistPrices(any()));
        },
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'refreshRequested_afterLoad_resubscribesToRememberedTickers',
        build: () {
          // arrange
          when(
            () => mockWatchWatchlistPrices(tTickers),
          ).thenAnswer((_) => Stream.value(const Right([tStockPrice])));
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
          verify(() => mockWatchWatchlistPrices(tTickers)).called(2);
        },
      );

      final initialController =
          StreamController<Either<Failure, List<WatchlistStockPrice>>>();
      final refreshedController =
          StreamController<Either<Failure, List<WatchlistStockPrice>>>();
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'refreshRequested_whileWatching_cancelsPreviousSubscription',
        build: () {
          // arrange
          final streams = [
            initialController.stream,
            refreshedController.stream,
          ];
          when(
            () => mockWatchWatchlistPrices(tTickers),
          ).thenAnswer((_) => streams.removeAt(0));
          return bloc;
        },
        act: (bloc) async {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
          await Future<void>.delayed(Duration.zero);
          initialController.add(const Right([tStockPrice]));
          await Future<void>.delayed(Duration.zero);
          bloc.add(const WatchlistPricesEvent.refreshRequested());
          await Future<void>.delayed(Duration.zero);
          refreshedController.add(const Right([tUpdatedStockPrice]));
          await Future<void>.delayed(Duration.zero);
          initialController.add(const Right([tStaleStockPrice]));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
          const WatchlistPricesState.loaded({'AXP': tUpdatedStockPrice}),
        ],
        tearDown: () {
          initialController.close();
          refreshedController.close();
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

      final controller =
          StreamController<Either<Failure, List<WatchlistStockPrice>>>();
      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'reset_whileWatching_cancelsSubscription',
        build: () {
          // arrange
          stubWatchPrices(controller.stream);
          return bloc;
        },
        act: (bloc) async {
          // act
          bloc.add(const WatchlistPricesEvent.loadRequested(tTickers));
          await Future<void>.delayed(Duration.zero);
          controller.add(const Right([tStockPrice]));
          await Future<void>.delayed(Duration.zero);
          bloc.add(const WatchlistPricesEvent.reset());
          await Future<void>.delayed(Duration.zero);
          controller.add(const Right([tUpdatedStockPrice]));
        },
        // assert
        expect: () => [
          const WatchlistPricesState.loading(),
          const WatchlistPricesState.loaded({'AXP': tStockPrice}),
          const WatchlistPricesState.initial(),
        ],
        tearDown: controller.close,
      );

      blocTest<WatchlistPricesBloc, WatchlistPricesState>(
        'reset_thenSameTickers_resubscribesInsteadOfDeduping',
        build: () {
          // arrange
          when(
            () => mockWatchWatchlistPrices(tTickers),
          ).thenAnswer((_) => Stream.value(const Right([tStockPrice])));
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
          verify(() => mockWatchWatchlistPrices(tTickers)).called(2);
        },
      );
    });
  });
}
