import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist_ytd/domain/models/ytd_price_change.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/bloc/watchlist_ytd/watchlist_ytd_state.dart';
import 'package:bizzie/features/watchlist_ytd/presentation/extensions/watchlist_ytd_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

YtdPriceChange _change(String ticker) => YtdPriceChange(
  ticker: ticker,
  companyName: '$ticker Inc.',
  year: 2026,
  baselineDate: '2026-01-01',
  baselineClose: 100,
  latestDate: '2026-07-22',
  latestClose: 110,
  ytdChange: 10,
  ytdChangePercent: 10,
);

void main() {
  group('WatchlistYtdStateX.orderedChanges', () {
    group('loaded state', () {
      test('orderedChanges_emptyOrder_returnsChangesInMapOrder', () {
        // arrange
        final aapl = _change('AAPL');
        final msft = _change('MSFT');
        final state = WatchlistYtdState.loaded({'AAPL': aapl, 'MSFT': msft});

        // act
        final result = state.orderedChanges(const []);

        // assert
        expect(result, [aapl, msft]);
      });

      test('orderedChanges_nonEmptyOrder_returnsChangesOrderedByTicker', () {
        // arrange
        final aapl = _change('AAPL');
        final msft = _change('MSFT');
        final state = WatchlistYtdState.loaded({'AAPL': aapl, 'MSFT': msft});

        // act — request the reverse of the map insertion order
        final result = state.orderedChanges(['MSFT', 'AAPL']);

        // assert
        expect(result, [msft, aapl]);
      });

      test('orderedChanges_tickerMissingFromChanges_skipsMissingTicker', () {
        // arrange
        final aapl = _change('AAPL');
        final state = WatchlistYtdState.loaded({'AAPL': aapl});

        // act — GOOG is in the order but has no change entry
        final result = state.orderedChanges(['GOOG', 'AAPL']);

        // assert
        expect(result, [aapl]);
      });

      test('orderedChanges_orderOmitsPresentTicker_excludesUnlistedChange', () {
        // arrange
        final aapl = _change('AAPL');
        final msft = _change('MSFT');
        final state = WatchlistYtdState.loaded({'AAPL': aapl, 'MSFT': msft});

        // act — order lists only AAPL
        final result = state.orderedChanges(['AAPL']);

        // assert — MSFT is dropped because it is absent from the order
        expect(result, [aapl]);
      });

      test('orderedChanges_emptyChangesEmptyOrder_returnsEmptyList', () {
        // arrange
        const state = WatchlistYtdState.loaded({});

        // act & assert
        expect(state.orderedChanges(const []), isEmpty);
      });
    });

    group('non-loaded states return empty list', () {
      test('orderedChanges_initialState_returnsEmptyList', () {
        // arrange
        const state = WatchlistYtdState.initial();

        // act & assert
        expect(state.orderedChanges(const ['AAPL']), isEmpty);
      });

      test('orderedChanges_loadingState_returnsEmptyList', () {
        // arrange
        const state = WatchlistYtdState.loading();

        // act & assert
        expect(state.orderedChanges(const ['AAPL']), isEmpty);
      });

      test('orderedChanges_failureState_returnsEmptyList', () {
        // arrange
        final state = WatchlistYtdState.failure(Failure.server('error'));

        // act & assert
        expect(state.orderedChanges(const ['AAPL']), isEmpty);
      });
    });
  });
}
