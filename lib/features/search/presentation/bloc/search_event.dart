import 'package:bizzie/core/enums/search_source.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
sealed class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started({required SearchSource source}) =
      SearchStarted;
  const factory SearchEvent.queryChanged(String query) = SearchQueryChanged;
  const factory SearchEvent.cleared() = SearchCleared;
  const factory SearchEvent.searchCleared() = SearchSearchCleared;
  const factory SearchEvent.resultClicked({
    required String ticker,
    required bool isAiResult,
  }) = SearchResultClicked;
  const factory SearchEvent.recommendedClicked({required String ticker}) =
      SearchRecommendedClicked;
  const factory SearchEvent.aiSearchRequested(String query) =
      SearchAiSearchRequested;
  const factory SearchEvent.searchCancelled() = SearchSearchCancelled;
}
