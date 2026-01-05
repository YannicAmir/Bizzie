part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  const factory SearchEvent.queryChanged(String query) = _QueryChanged;
  const factory SearchEvent.cleared() = _Cleared;
}
