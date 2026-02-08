import 'dart:async';
import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/get_search_dashboard_data_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';
import 'package:bizzie/features/user/domain/usecases/watch_user_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

final _logger = BizzieLogger('SearchBloc');

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchStocksUseCase _searchStocksUseCase;
  final GetSearchDashboardDataUseCase _dashboardDataUseCase;
  final FindStockForProductUseCase _findStockForProductUseCase;
  final WatchUserUseCase _watchUserUseCase;
  StreamSubscription? _userSubscription;

  CancelableOperation? _searchOperation;

  String? _cachedFavoriteSector;
  List<Company>? _cachedRecommendedBrands;

  SearchBloc(
    this._searchStocksUseCase,
    this._dashboardDataUseCase,
    this._findStockForProductUseCase,
    this._watchUserUseCase,
  ) : super(const SearchState.initial()) {
    _userSubscription = _watchUserUseCase().listen((_) {
      add(const SearchEvent.started());
    });

    on<_Started>(_onStarted);
    on<_QueryChanged>(_onQueryChanged);
    on<_Cleared>(_onCleared);
    on<_AiSearchRequested>(_onAiSearchRequested);
  }

  @override
  Future<void> close() {
    _searchOperation?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<SearchState> emit) async {
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
          emit(SearchState.failure('AI Search failed: ${failure.message}'));
        },
        (stock) {
          if (stock != null) {
            emit(
              SearchState.aiSuccess(productQuery: event.query, stock: stock),
            );
          } else {
            emit(SearchState.aiEmpty(event.query));
          }
        },
      );
    } catch (e) {
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

  String _normalizeQuery(String query) {
    final noPunctuation = query.replaceAll(RegExp(r'[^\w\s]'), '');
    return noPunctuation.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
