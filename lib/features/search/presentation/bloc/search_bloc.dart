import 'dart:async';
import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/core/domain/models/company.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/get_search_dashboard_data_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';

import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/search/presentation/analytics/search_tracker.dart';
import 'package:bizzie/core/interfaces/i_local_storage_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

final _logger = BizzieLogger('SearchBloc');

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchStocksUseCase _searchStocksUseCase;
  final GetSearchDashboardDataUseCase _dashboardDataUseCase;
  final FindStockForProductUseCase _findStockForProductUseCase;
  final SearchTracker _tracker;
  final ILocalStorageService _localStorageService;
  StreamSubscription? _userSubscription;

  CancelableOperation? _searchOperation;

  String? _cachedFavoriteSector;
  List<Company>? _cachedRecommendedBrands;

  SearchBloc(
    this._searchStocksUseCase,
    this._dashboardDataUseCase,
    this._findStockForProductUseCase,
    this._tracker,
    this._localStorageService,
  ) : super(const SearchState.initial()) {
    on<_Started>(_onStarted);
    on<_QueryChanged>(_onQueryChanged);
    on<_Cleared>(_onCleared);
    on<_SearchCleared>(_onSearchCleared);
    on<_AiSearchRequested>(_onAiSearchRequested);
    on<_SearchCancelled>(_onSearchCancelled);
    on<_ResultClicked>(_onResultClicked);
    on<_RecommendedClicked>(_onRecommendedClicked);
  }

  @override
  Future<void> close() {
    _searchOperation?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<SearchState> emit) async {
    _tracker.logPageView(source: event.source);

    emit(SearchState.loading(favoriteSector: _cachedFavoriteSector));
    try {
      await _searchStocksUseCase.initialize();
      final result = await _dashboardDataUseCase.execute();

      result.fold(
        (failure) {
          emit(
            SearchState.failure(
              'Failed to load dashboard: ${failure.toString()}',
            ),
          );
        },
        (data) {
          final limitedBrands = data.recommendedBrands.take(5).toList();
          _cachedFavoriteSector = data.favoriteSector;
          _cachedRecommendedBrands = limitedBrands;
          emit(
            SearchState.initial(
              favoriteSector: data.favoriteSector,
              recommendedBrands: limitedBrands,
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      _logger.severe('Unexpected error in _onStarted', e, stackTrace);
      emit(SearchState.failure(e.toString()));
    }
  }

  Future<void> _onQueryChanged(
    _QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final normalized = _normalizeQuery(event.query);

    if (normalized.isEmpty) {
      add(const SearchEvent.cleared());
      return;
    }

    emit(SearchState.loading(favoriteSector: _cachedFavoriteSector));

    await _searchOperation?.cancel();

    _searchOperation = CancelableOperation.fromFuture(
      _searchStocksUseCase.execute(normalized),
    );

    try {
      final results = await _searchOperation!.value;

      _tracker.setLastSearchQuery(event.query);
      _incrementSearchCount();

      if (results.isEmpty) {
        emit(SearchState.localEmpty(event.query));
      } else {
        emit(SearchState.loaded(results: results, query: event.query));
      }
    } catch (e) {
      if (_searchOperation?.isCanceled == true) return;
      emit(SearchState.failure("Search failed: $e"));
    }
  }

  Future<void> _onAiSearchRequested(
    _AiSearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    final normalized = _normalizeQuery(event.query);
    emit(SearchState.aiSearching(event.query));

    try {
      final result = await _findStockForProductUseCase.execute(normalized);
      result.fold(
        (failure) {
          _tracker.logAiSearchOutcome(
            query: normalized,
            outcome: SearchOutcome.error,
          );
          emit(SearchState.failure('AI Search failed: ${failure.errorMessage}'));
        },
        (stock) {
          if (stock != null) {
            _tracker.logAiSearchOutcome(
              query: normalized,
              outcome: SearchOutcome.matchFound,
              matchTicker: stock.symbol,
            );
            emit(
              SearchState.aiSuccess(productQuery: event.query, stock: stock),
            );
          } else {
            _tracker.logAiSearchOutcome(
              query: normalized,
              outcome: SearchOutcome.noMatch,
            );
            emit(SearchState.aiEmpty(event.query));
          }
        },
      );
    } catch (e) {
      _tracker.logAiSearchOutcome(
        query: normalized,
        outcome: SearchOutcome.error,
      );
      emit(SearchState.failure('AI Search failed: $e'));
    }
  }

  void _onCleared(_Cleared event, Emitter<SearchState> emit) {
    emit(
      SearchState.initial(
        favoriteSector: _cachedFavoriteSector,
        recommendedBrands: _cachedRecommendedBrands ?? [],
      ),
    );
  }

  void _onSearchCleared(_SearchCleared event, Emitter<SearchState> emit) {
    _tracker.logSearchCleared();
    add(const SearchEvent.cleared());
  }

  Future<void> _onResultClicked(
    _ResultClicked event,
    Emitter<SearchState> emit,
  ) async {
    final query = state.maybeMap(
      loaded: (s) => s.query,
      aiSuccess: (s) => s.productQuery,
      orElse: () => '',
    );
    await _tracker.logResultClicked(
      query: query,
      ticker: event.ticker,
      isAiResult: event.isAiResult,
    );
  }

  Future<void> _onRecommendedClicked(
    _RecommendedClicked event,
    Emitter<SearchState> emit,
  ) async {
    final query = state.maybeMap(initial: (_) => '', orElse: () => '');
    await _tracker.logRecommendedClicked(query: query, ticker: event.ticker);
  }

  Future<void> _incrementSearchCount() async {
    const storageKey = 'search_total_count';
    final currentCount = _localStorageService.getInt(storageKey) ?? 0;
    final newCount = currentCount + 1;
    await _localStorageService.setInt(storageKey, newCount);
    _tracker.setTotalSearchCount(newCount);
  }

  String _normalizeQuery(String query) {
    final noPunctuation = query.replaceAll(RegExp(r'[^\w\s]'), '');
    return noPunctuation.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  void _onSearchCancelled(_SearchCancelled event, Emitter<SearchState> emit) {
    _tracker.logSearchCancelled();
  }
}
