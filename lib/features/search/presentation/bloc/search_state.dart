part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial({
    String? favoriteSector,
    @Default([]) List<Company> recommendedBrands,
  }) = _Initial;
  const factory SearchState.loading({String? favoriteSector}) = _Loading;
  const factory SearchState.loaded({
    required List<StockSymbol> results,
    required String query,
  }) = _Loaded;
  const factory SearchState.localEmpty(String query) = _LocalEmpty;
  const factory SearchState.aiSearching(String query) = _AiSearching;
  const factory SearchState.aiSuccess({
    required String productQuery,
    required StockSymbol stock,
  }) = _AiSuccess;
  const factory SearchState.aiEmpty(String productQuery) = _AiEmpty;
  const factory SearchState.failure(String message) = _Failure;
}
