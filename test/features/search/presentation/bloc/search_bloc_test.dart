import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/get_search_dashboard_data_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
// Event and State are parts of SearchBloc, so we don't import them directly.
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchStocksUseCase extends Mock implements SearchStocksUseCase {}

class MockGetSearchDashboardDataUseCase extends Mock
    implements GetSearchDashboardDataUseCase {}

class MockFindStockForProductUseCase extends Mock
    implements FindStockForProductUseCase {}

class MockWatchUserUseCase extends Mock implements WatchUserUseCase {}

void main() {
  late SearchBloc bloc;
  late MockSearchStocksUseCase mockSearchStocks;
  late MockGetSearchDashboardDataUseCase mockDashboardData;
  late MockFindStockForProductUseCase mockFindStock;
  late MockWatchUserUseCase mockWatchUser;

  setUp(() {
    mockSearchStocks = MockSearchStocksUseCase();
    mockDashboardData = MockGetSearchDashboardDataUseCase();
    mockFindStock = MockFindStockForProductUseCase();
    mockWatchUser = MockWatchUserUseCase();

    when(() => mockWatchUser.call()).thenAnswer((_) => const Stream.empty());

    bloc = SearchBloc(
      mockSearchStocks,
      mockDashboardData,
      mockFindStock,
      mockWatchUser,
    );
  });

  final tStocks = [const StockSymbol(symbol: 'AAPL', name: 'Apple Inc.')];
  final tDashboardData = SearchDashboardData(
    favoriteSector: 'Technology',
    recommendedBrands: [const Company(name: 'Apple', ticker: 'AAPL')],
  );

  group('SearchBloc', () {
    test('initialState_isInitial', () {
      expect(bloc.state, const SearchState.initial());
    });

    blocTest<SearchBloc, SearchState>(
      'started_success_emitsLoadingAndInitial',
      // arrange
      build: () {
        when(() => mockSearchStocks.initialize()).thenAnswer((_) async {});
        when(
          () => mockDashboardData.execute(),
        ).thenAnswer((_) async => Right(tDashboardData));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.started()),
      // assert
      expect: () => [
        const SearchState.loading(),
        SearchState.initial(
          favoriteSector: tDashboardData.favoriteSector,
          recommendedBrands: tDashboardData.recommendedBrands,
        ),
      ],
      verify: (_) {
        verify(() => mockSearchStocks.initialize()).called(1);
        verify(() => mockDashboardData.execute()).called(1);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'queryChanged_noResults_emitsLocalEmpty',
      // arrange
      build: () {
        when(() => mockSearchStocks.execute(any())).thenAnswer((_) async => []);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.queryChanged('unknown')),
      // assert
      expect: () => [
        const SearchState.loading(),
        const SearchState.localEmpty('unknown'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'queryChanged_hasResults_emitsLoaded',
      // arrange
      build: () {
        when(
          () => mockSearchStocks.execute(any()),
        ).thenAnswer((_) async => tStocks);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.queryChanged('Apple')),
      // assert
      expect: () => [
        const SearchState.loading(),
        SearchState.loaded(results: tStocks, query: 'Apple'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'aiSearchRequested_matchFound_emitsAiSearchingAndAiSuccess',
      // arrange
      build: () {
        when(
          () => mockFindStock.execute(any()),
        ).thenAnswer((_) async => Right(tStocks.first));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.aiSearchRequested('MacBook')),
      // assert
      expect: () => [
        const SearchState.aiSearching('MacBook'),
        SearchState.aiSuccess(productQuery: 'MacBook', stock: tStocks.first),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'aiSearchRequested_noMatch_emitsAiSearchingAndAiEmpty',
      // arrange
      build: () {
        when(
          () => mockFindStock.execute(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const SearchEvent.aiSearchRequested('UnknownProduct')),
      // assert
      expect: () => [
        const SearchState.aiSearching('UnknownProduct'),
        const SearchState.aiEmpty('UnknownProduct'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'aiSearchRequested_useCaseFails_emitsAiSearchingAndFailure',
      // arrange
      build: () {
        when(
          () => mockFindStock.execute(any()),
        ).thenAnswer((_) async => Left(Failure.server('AI Error')));
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.aiSearchRequested('Crash')),
      // assert
      expect: () => [
        const SearchState.aiSearching('Crash'),
        const SearchState.failure('AI Search failed: AI Error'),
      ],
    );
    blocTest<SearchBloc, SearchState>(
      'queryChanged_normalizesInput_collapsesSpacesAndRemovesPunctuation',
      // arrange
      build: () {
        when(
          () => mockSearchStocks.execute('AAPL Inc'),
        ).thenAnswer((_) async => tStocks);
        return bloc;
      },
      // act
      act: (bloc) => bloc.add(const SearchEvent.queryChanged('AAPL !!  Inc ')),
      // assert
      expect: () => [
        const SearchState.loading(),
        SearchState.loaded(results: tStocks, query: 'AAPL !!  Inc '),
      ],
      verify: (_) {
        verify(() => mockSearchStocks.execute('AAPL Inc')).called(1);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'aiSearchRequested_normalizesInput_collapsesSpacesAndRemovesPunctuation',
      // arrange
      build: () {
        when(
          () => mockFindStock.execute('MacBook Pro'),
        ).thenAnswer((_) async => Right(tStocks.first));
        return bloc;
      },
      // act
      act: (bloc) =>
          bloc.add(const SearchEvent.aiSearchRequested('MacBook  Pro??')),
      // assert
      expect: () => [
        const SearchState.aiSearching('MacBook  Pro??'),
        SearchState.aiSuccess(
          productQuery: 'MacBook  Pro??',
          stock: tStocks.first,
        ),
      ],
      verify: (_) {
        verify(() => mockFindStock.execute('MacBook Pro')).called(1);
      },
    );
  });
}
