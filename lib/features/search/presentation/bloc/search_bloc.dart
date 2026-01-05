import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:bizzie/features/search/domain/services/stock_search_service.dart';
import 'package:bizzie/features/search/domain/models/stock_symbol.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final StockSearchService _service;

  SearchBloc(this._service) : super(const SearchState.initial()) {
    on<_Started>(_onStarted);
    on<_QueryChanged>(_onQueryChanged);
    on<_Cleared>(_onCleared);
  }

  Future<void> _onStarted(_Started event, Emitter<SearchState> emit) async {
    emit(const SearchState.loading());
    try {
      await _service.initialize();
      emit(const SearchState.loaded([]));
    } catch (e) {
      emit(SearchState.failure(e.toString()));
    }
  }

  void _onQueryChanged(_QueryChanged event, Emitter<SearchState> emit) {
    if (event.query.isEmpty) {
      emit(const SearchState.loaded([]));
      return;
    }

    final results = _service.search(event.query);

    if (results.isEmpty) {
      emit(const SearchState.empty());
    } else {
      emit(SearchState.loaded(results));
    }
  }

  void _onCleared(_Cleared event, Emitter<SearchState> emit) {
    emit(const SearchState.loaded([]));
  }
}
