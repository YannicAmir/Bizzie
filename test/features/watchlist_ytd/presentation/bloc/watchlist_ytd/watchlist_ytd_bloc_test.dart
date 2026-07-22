import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/auth/domain/usecases/get_auth_stream.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/domain/usecases/get_watchlist_ytd_usecase.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_bloc.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_event.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWatchlistYtdUseCase extends Mock
    implements GetWatchlistYtdUseCase {}

class MockGetAuthStream extends Mock implements GetAuthStream {}

MockGetAuthStream stubbedGetAuthStream() {
  final mock = MockGetAuthStream();
  when(() => mock()).thenAnswer((_) => const Stream.empty());
  return mock;
}

const tTickers = ['FTNT', 'NVDA'];
const tFailure = Failure.server('error');

const tYtd = YtdPriceChange(
  ticker: 'FTNT',
  companyName: 'Fortinet, Inc.',
  year: 2026,
  baselineDate: '2025-12-31',
  baselineClose: 79.41,
  latestDate: '2026-07-21',
  latestClose: 158.1,
  ytdChange: 78.69,
  ytdChangePercent: 99.09,
);

void main() {
  late WatchlistYtdBloc bloc;
  late MockGetWatchlistYtdUseCase mockGetWatchlistYtd;

  setUp(() {
    mockGetWatchlistYtd = MockGetWatchlistYtdUseCase();
    bloc = WatchlistYtdBloc(mockGetWatchlistYtd, stubbedGetAuthStream());
  });

  tearDown(() => bloc.close());

  group('WatchlistYtdBloc', () {
    test('initialState_isCorrect', () {
      // assert
      expect(bloc.state, const WatchlistYtdState.initial());
    });

    group('loadRequested', () {
      blocTest<WatchlistYtdBloc, WatchlistYtdState>(
        'loadRequested_useCaseReturnsRight_emitsLoadingAndLoaded',
        build: () {
          // arrange
          when(
            () => mockGetWatchlistYtd(tTickers),
          ).thenAnswer((_) async => const Right([tYtd]));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistYtdEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistYtdState.loading(),
          const WatchlistYtdState.loaded({'FTNT': tYtd}),
        ],
      );

      blocTest<WatchlistYtdBloc, WatchlistYtdState>(
        'loadRequested_useCaseReturnsLeft_emitsLoadingAndFailure',
        build: () {
          // arrange
          when(
            () => mockGetWatchlistYtd(tTickers),
          ).thenAnswer((_) async => const Left(tFailure));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistYtdEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistYtdState.loading(),
          const WatchlistYtdState.failure(tFailure),
        ],
      );

      blocTest<WatchlistYtdBloc, WatchlistYtdState>(
        'loadRequested_refreshFailsAfterLoaded_keepsLoadedChanges',
        seed: () => const WatchlistYtdState.loaded({'FTNT': tYtd}),
        build: () {
          // arrange
          when(
            () => mockGetWatchlistYtd(tTickers),
          ).thenAnswer((_) async => const Left(tFailure));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistYtdEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => <WatchlistYtdState>[],
      );

      blocTest<WatchlistYtdBloc, WatchlistYtdState>(
        'loadRequested_refreshSucceedsAfterLoaded_emitsLoadedWithoutLoading',
        seed: () => const WatchlistYtdState.loaded({}),
        build: () {
          // arrange
          when(
            () => mockGetWatchlistYtd(tTickers),
          ).thenAnswer((_) async => const Right([tYtd]));
          return bloc;
        },
        act: (bloc) {
          // act
          bloc.add(const WatchlistYtdEvent.loadRequested(tTickers));
        },
        // assert
        expect: () => [
          const WatchlistYtdState.loaded({'FTNT': tYtd}),
        ],
      );
    });

    group('reset', () {
      blocTest<WatchlistYtdBloc, WatchlistYtdState>(
        'reset_fromLoaded_emitsInitial',
        seed: () => const WatchlistYtdState.loaded({'FTNT': tYtd}),
        build: () => bloc,
        act: (bloc) {
          // act
          bloc.add(const WatchlistYtdEvent.reset());
        },
        // assert
        expect: () => [const WatchlistYtdState.initial()],
      );
    });
  });
}
