import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/search/domain/usecases/search_stocks_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/get_search_dashboard_data_usecase.dart';
import 'package:bizzie/features/search/domain/usecases/find_stock_for_product_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

final _logger = BizzieLogger('SearchBloc');

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchStocksUseCase _searchStocksUseCase;
  final GetSearchDashboardDataUseCase _dashboardDataUseCase;
  final FindStockForProductUseCase _findStockForProductUseCase;

  String? _cachedFavoriteSector;
  List<Company>? _cachedRecommendedBrands;

  SearchBloc(
    this._searchStocksUseCase,
    this._dashboardDataUseCase,
    this._findStockForProductUseCase,
  ) : super(const SearchState.initial()) {
    on<_Started>(_onStarted);
    on<_QueryChanged>(_onQueryChanged);
    on<_Cleared>(_onCleared);
    on<_AiSearchRequested>(_onAiSearchRequested);
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
          _cachedFavoriteSector = data.favoriteSector;
          _cachedRecommendedBrands = data.recommendedBrands;
          emit(
            SearchState.initial(
              favoriteSector: data.favoriteSector,
              recommendedBrands: data.recommendedBrands,
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
    if (event.query.isEmpty) {
      emit(
        SearchState.initial(
          favoriteSector: _cachedFavoriteSector,
          recommendedBrands: _cachedRecommendedBrands ?? [],
        ),
      );
      return;
    }

    emit(SearchState.loading(favoriteSector: _cachedFavoriteSector));
    final results = await _searchStocksUseCase.execute(event.query);

    if (results.isEmpty) {
      emit(SearchState.localEmpty(event.query));
    } else {
      emit(SearchState.loaded(results: results, query: event.query));
    }
  }

  Future<void> _onAiSearchRequested(
    _AiSearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchState.aiSearching(event.query));
    try {
      final stock = await _findStockForProductUseCase.execute(event.query);
      if (stock != null) {
        emit(SearchState.aiSuccess(productQuery: event.query, stock: stock));
      } else {
        emit(SearchState.aiEmpty(event.query));
      }
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
}
