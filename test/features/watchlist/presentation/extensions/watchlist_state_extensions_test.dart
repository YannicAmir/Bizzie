import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

const tCompanyAapl = Company(ticker: 'AAPL', name: 'Apple Inc.');
const tCompanyMsft = Company(ticker: 'MSFT', name: 'Microsoft Corp.');
const tCompanyGoog = Company(ticker: 'GOOG', name: 'Alphabet Inc.');
const tAaplLogoUrl = 'https://example.com/aapl.png';
const tCompanyAaplWithLogo = Company(
  ticker: 'AAPL',
  name: 'Apple Inc.',
  logoUrl: tAaplLogoUrl,
);
const tCompanyMsftEmptyLogo = Company(
  ticker: 'MSFT',
  name: 'Microsoft Corp.',
  logoUrl: '',
);

void main() {
  group('WatchlistStateX.tickerOrder', () {
    test('tickerOrder_loadedWithCompanies_returnsTickersInCompanyOrder', () {
      // arrange
      const state = WatchlistState.loaded([
        tCompanyAapl,
        tCompanyMsft,
        tCompanyGoog,
      ]);

      // act
      final result = state.tickerOrder;

      // assert
      expect(result, ['AAPL', 'MSFT', 'GOOG']);
    });

    test('tickerOrder_loadedWithNoCompanies_returnsEmptyList', () {
      // arrange
      const state = WatchlistState.loaded([]);

      // act
      final result = state.tickerOrder;

      // assert
      expect(result, isEmpty);
    });

    group('non-loaded states return empty list', () {
      test('tickerOrder_initialState_returnsEmptyList', () {
        // arrange
        const state = WatchlistState.initial();

        // act & assert
        expect(state.tickerOrder, isEmpty);
      });

      test('tickerOrder_loadingState_returnsEmptyList', () {
        // arrange
        const state = WatchlistState.loading();

        // act & assert
        expect(state.tickerOrder, isEmpty);
      });

      test('tickerOrder_failureState_returnsEmptyList', () {
        // arrange
        final state = WatchlistState.failure(Failure.server('error'));

        // act & assert
        expect(state.tickerOrder, isEmpty);
      });

      test('tickerOrder_successState_returnsEmptyList', () {
        // arrange
        const state = WatchlistState.success('done');

        // act & assert
        expect(state.tickerOrder, isEmpty);
      });
    });
  });

  group('WatchlistStateX.logoUrlsByTicker', () {
    test('logoUrlsByTicker_loaded_mapsOnlyNonEmptyLogoUrlsByTicker', () {
      // arrange
      const state = WatchlistState.loaded([
        tCompanyAaplWithLogo,
        tCompanyMsftEmptyLogo,
        tCompanyGoog,
      ]);

      // act
      final result = state.logoUrlsByTicker;

      // assert
      expect(result, {'AAPL': tAaplLogoUrl});
    });

    test('logoUrlsByTicker_nonLoadedState_returnsEmptyMap', () {
      // arrange
      const state = WatchlistState.loading();

      // act
      final result = state.logoUrlsByTicker;

      // assert
      expect(result, isEmpty);
    });
  });

  group('WatchlistStateX.logoUrlFor', () {
    const loadedState = WatchlistState.loaded([
      tCompanyAaplWithLogo,
      tCompanyMsftEmptyLogo,
      tCompanyGoog,
    ]);

    test('logoUrlFor_tickerWithLogo_returnsLogoUrl', () {
      // act
      final result = loadedState.logoUrlFor('AAPL');

      // assert
      expect(result, tAaplLogoUrl);
    });

    test('logoUrlFor_tickerWithEmptyLogo_returnsNull', () {
      // act
      final result = loadedState.logoUrlFor('MSFT');

      // assert
      expect(result, isNull);
    });

    test('logoUrlFor_tickerWithoutLogo_returnsNull', () {
      // act
      final result = loadedState.logoUrlFor('GOOG');

      // assert
      expect(result, isNull);
    });

    test('logoUrlFor_tickerNotInWatchlist_returnsNull', () {
      // act
      final result = loadedState.logoUrlFor('TSLA');

      // assert
      expect(result, isNull);
    });

    test('logoUrlFor_nullTicker_returnsNull', () {
      // act
      final result = loadedState.logoUrlFor(null);

      // assert
      expect(result, isNull);
    });

    test('logoUrlFor_nonLoadedState_returnsNull', () {
      // arrange
      const state = WatchlistState.loading();

      // act
      final result = state.logoUrlFor('AAPL');

      // assert
      expect(result, isNull);
    });
  });
}
