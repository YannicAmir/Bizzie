import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/get_search_dashboard_data_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:bizzie/features/search/presentation/bloc/search_bloc.dart';
import 'package:bizzie/features/search/presentation/analytics/search_tracker.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';
import 'package:dartz/dartz.dart';
import 'package:bizzie/features/user/domain/interfaces/user_repository.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchStocksUseCase extends Mock implements SearchStocksUseCase {}

class MockGetSearchDashboardDataUseCase extends Mock
    implements GetSearchDashboardDataUseCase {}

class MockFindStockForProductUseCase extends Mock
    implements FindStockForProductUseCase {}

class MockIUserRepository extends Mock implements IUserRepository {}

class MockSearchTracker extends Mock implements SearchTracker {}

class MockILocalStorageService extends Mock implements ILocalStorageService {}

void main() {
  late SearchBloc bloc;
  late MockSearchStocksUseCase mockSearchStocks;
  late MockGetSearchDashboardDataUseCase mockDashboardData;
  late MockFindStockForProductUseCase mockFindStock;
  late MockIUserRepository mockUserRepository;
  late MockSearchTracker mockTracker;
  late MockILocalStorageService mockLocalStorageService;

  setUpAll(() {
    registerFallbackValue(SearchType.stock);
    registerFallbackValue(SearchOutcome.matchFound);
    registerFallbackValue(SearchSource.home);
    registerFallbackValue(const StockSymbol(symbol: '', name: ''));
    registerFallbackValue(
      SearchDashboardData(favoriteSector: '', recommendedBrands: []),
    );
  });

  setUp(() {
    mockSearchStocks = MockSearchStocksUseCase();
    mockDashboardData = MockGetSearchDashboardDataUseCase();
    mockFindStock = MockFindStockForProductUseCase();
    mockUserRepository = MockIUserRepository();
    mockTracker = MockSearchTracker();
    mockLocalStorageService = MockILocalStorageService();

    when(
      () => mockUserRepository.userStream,
    ).thenAnswer((_) => const Stream<UserModel>.empty());

    when(
      () => mockTracker.logPageView(source: any(named: 'source')),
    ).thenAnswer((_) async {});
    when(() => mockTracker.setLastSearchQuery(any())).thenAnswer((_) async {});
    when(() => mockTracker.setTotalSearchCount(any())).thenAnswer((_) async {});
    when(
      () => mockTracker.logAiSearchOutcome(
        query: any(named: 'query'),
        outcome: any(named: 'outcome'),
        matchTicker: any(named: 'matchTicker'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logResultClicked(
        query: any(named: 'query'),
        ticker: any(named: 'ticker'),
        isAiResult: any(named: 'isAiResult'),
        companyName: any(named: 'companyName'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => mockTracker.logRecommendedClicked(
        query: any(named: 'query'),
        ticker: any(named: 'ticker'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockTracker.logSearchCleared()).thenAnswer((_) async {});
    when(() => mockTracker.logSearchCancelled()).thenAnswer((_) async {});

    when(() => mockLocalStorageService.getInt(any())).thenReturn(null);
    when(
      () => mockLocalStorageService.setInt(any(), any()),
    ).thenAnswer((_) async => true);

    bloc = SearchBloc(
      mockSearchStocks,
      mockDashboardData,
      mockFindStock,
      mockTracker,
      mockLocalStorageService,
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
      act: (bloc) =>
          bloc.add(const SearchEvent.started(source: SearchSource.home)),
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
        verify(
          () => mockTracker.logPageView(source: SearchSource.home),
        ).called(1);
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
      verify: (_) {
        verify(() => mockTracker.setLastSearchQuery('unknown')).called(1);
        verify(() => mockTracker.setTotalSearchCount(1)).called(1);
        verify(
          () => mockLocalStorageService.setInt('search_total_count', 1),
        ).called(1);
      },
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
      verify: (_) {
        verify(() => mockTracker.setLastSearchQuery('Apple')).called(1);
      },
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
      verify: (_) {
        verify(
          () => mockTracker.logAiSearchOutcome(
            query: 'MacBook',
            outcome: SearchOutcome.matchFound,
            matchTicker: tStocks.first.symbol,
          ),
        ).called(1);
      },
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
      verify: (_) {
        verify(
          () => mockTracker.logAiSearchOutcome(
            query: 'UnknownProduct',
            outcome: SearchOutcome.noMatch,
          ),
        ).called(1);
      },
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
      verify: (_) {
        verify(
          () => mockTracker.logAiSearchOutcome(
            query: 'Crash',
            outcome: SearchOutcome.error,
          ),
        ).called(1);
      },
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

    blocTest<SearchBloc, SearchState>(
      'searchCleared_logsAndEmitsInitial',
      build: () => bloc,
      act: (bloc) => bloc.add(const SearchEvent.searchCleared()),
      expect: () => [const SearchState.initial()],
      verify: (_) {
        verify(() => mockTracker.logSearchCleared()).called(1);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'cleared_emitsInitialWithoutLogging',
      build: () => bloc,
      act: (bloc) => bloc.add(const SearchEvent.cleared()),
      expect: () => [const SearchState.initial()],
      verify: (_) {
        verifyNever(() => mockTracker.logSearchCleared());
      },
    );

    blocTest<SearchBloc, SearchState>(
      'resultClicked_inLoadedState_logsWithQuery',
      build: () => bloc,
      seed: () => SearchState.loaded(results: tStocks, query: 'Apple'),
      act: (bloc) => bloc.add(
        const SearchEvent.resultClicked(ticker: 'AAPL', isAiResult: true),
      ),
      verify: (_) {
        verify(
          () => mockTracker.logResultClicked(
            query: 'Apple',
            ticker: 'AAPL',
            isAiResult: true,
          ),
        ).called(1);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'recommendedClicked_inInitialState_logsWithEmptyQuery',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(const SearchEvent.recommendedClicked(ticker: 'TSLA')),
      verify: (_) {
        verify(
          () => mockTracker.logRecommendedClicked(query: '', ticker: 'TSLA'),
        ).called(1);
      },
    );
  });
}
