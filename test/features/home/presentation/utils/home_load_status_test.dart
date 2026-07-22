import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_news/watchlist_news_bloc.dart';
import 'package:bizzie/features/home/presentation/bloc/watchlist_prices/watchlist_prices_state.dart';
import 'package:bizzie/features/home/presentation/utils/home_load_status.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const company = Company(ticker: 'AAPL', name: 'Apple');
  const failure = Failure.server('boom');

  const populatedWatchlist = WatchlistState.loaded([company]);
  const emptyWatchlist = WatchlistState.loaded([]);

  const pricesLoaded = WatchlistPricesState.loaded({});
  const newsLoaded = WatchlistNewsState.loaded([]);

  group('resolveHomeLoadStatus', () {
    // --- Watchlist is authoritative: secondary feeds are ignored ---

    test('resolveHomeLoadStatus_watchlistInitial_returnsLoading', () {
      // act
      final result = resolveHomeLoadStatus(
        const WatchlistState.initial(),
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });

    test('resolveHomeLoadStatus_watchlistLoading_returnsLoading', () {
      // act
      final result = resolveHomeLoadStatus(
        const WatchlistState.loading(),
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });

    test('resolveHomeLoadStatus_watchlistFailure_returnsFailure', () {
      // act
      final result = resolveHomeLoadStatus(
        const WatchlistState.failure(failure),
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.failure);
    });

    test('resolveHomeLoadStatus_watchlistEmpty_returnsEmpty', () {
      // act
      final result = resolveHomeLoadStatus(
        emptyWatchlist,
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.empty);
    });

    test('resolveHomeLoadStatus_watchlistSuccessWithFeedsLoading_returnsLoading',
        () {
      // act — success is a transient message-only state carrying no companies,
      // so it maps to loading and never signals data-ready
      final result = resolveHomeLoadStatus(
        const WatchlistState.success('done'),
        const WatchlistPricesState.loading(),
        const WatchlistNewsState.loading(),
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });

    test('resolveHomeLoadStatus_watchlistSuccessWithFeedsResolved_returnsLoading',
        () {
      // act — success does not falsely signal data-ready even when the
      // secondary feeds have loaded, because it holds no companies payload
      final result = resolveHomeLoadStatus(
        const WatchlistState.success('done'),
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });

    // --- Populated watchlist: secondary feeds contribute ---

    test('resolveHomeLoadStatus_populatedAndBothFeedsLoaded_returnsReady', () {
      // act
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        pricesLoaded,
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.ready);
    });

    test('resolveHomeLoadStatus_populatedAndPricesDisabled_returnsReady', () {
      // act — disabled prices count as resolved
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        const WatchlistPricesState.disabled(),
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.ready);
    });

    test('resolveHomeLoadStatus_populatedAndPricesFailed_returnsReady', () {
      // act — a failed secondary feed is settled, not page-fatal: the page
      // renders and the prices widget surfaces its own inline error
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        const WatchlistPricesState.failure(failure),
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.ready);
    });

    test('resolveHomeLoadStatus_populatedAndNewsFailed_returnsReady', () {
      // act — a failed news feed is settled, not page-fatal: the page renders
      // and the news widget surfaces its own inline error
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        pricesLoaded,
        const WatchlistNewsState.failure(failure),
      );

      // assert
      expect(result, HomeLoadStatus.ready);
    });

    test('resolveHomeLoadStatus_populatedAndBothFeedsFailed_returnsReady', () {
      // act — both secondary feeds settled (failed) leaves the primary
      // watchlist content free to render in a degraded state
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        const WatchlistPricesState.failure(failure),
        const WatchlistNewsState.failure(failure),
      );

      // assert
      expect(result, HomeLoadStatus.ready);
    });

    test(
      'resolveHomeLoadStatus_populatedAndFailureWhileOtherLoading_returnsLoading',
      () {
        // act — a failed feed is settled, but the sibling feed is still
        // loading, so the page waits on the unresolved feed
        final result = resolveHomeLoadStatus(
          populatedWatchlist,
          const WatchlistPricesState.failure(failure),
          const WatchlistNewsState.loading(),
        );

        // assert
        expect(result, HomeLoadStatus.loading);
      },
    );

    test('resolveHomeLoadStatus_populatedAndPricesLoading_returnsLoading', () {
      // act
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        const WatchlistPricesState.loading(),
        newsLoaded,
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });

    test('resolveHomeLoadStatus_populatedAndNewsLoading_returnsLoading', () {
      // act
      final result = resolveHomeLoadStatus(
        populatedWatchlist,
        pricesLoaded,
        const WatchlistNewsState.loading(),
      );

      // assert
      expect(result, HomeLoadStatus.loading);
    });
  });
}
