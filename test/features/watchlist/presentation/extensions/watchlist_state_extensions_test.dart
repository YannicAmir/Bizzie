import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

const tCompanyAapl = Company(ticker: 'AAPL', name: 'Apple Inc.');
const tCompanyMsft = Company(ticker: 'MSFT', name: 'Microsoft Corp.');
const tCompanyGoog = Company(ticker: 'GOOG', name: 'Alphabet Inc.');

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
}
