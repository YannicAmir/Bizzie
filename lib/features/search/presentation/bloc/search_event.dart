part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started({required SearchSource source}) = _Started;
  const factory SearchEvent.queryChanged(String query) = _QueryChanged;
  const factory SearchEvent.cleared() = _Cleared;
  const factory SearchEvent.searchCleared() = _SearchCleared;
  const factory SearchEvent.resultClicked({
    required String ticker,
    required bool isAiResult,
  }) = _ResultClicked;
  const factory SearchEvent.recommendedClicked({required String ticker}) =
      _RecommendedClicked;
  const factory SearchEvent.aiSearchRequested(String query) =
      _AiSearchRequested;
  const factory SearchEvent.searchCancelled() = _SearchCancelled;
}
