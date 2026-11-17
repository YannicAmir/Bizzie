// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchEvent()';
}


}

/// @nodoc
class $SearchEventCopyWith<$Res>  {
$SearchEventCopyWith(SearchEvent _, $Res Function(SearchEvent) __);
}


/// Adds pattern-matching-related methods to [SearchEvent].
extension SearchEventPatterns on SearchEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchStarted value)?  started,TResult Function( SearchQueryChanged value)?  queryChanged,TResult Function( SearchCleared value)?  cleared,TResult Function( SearchSearchCleared value)?  searchCleared,TResult Function( SearchResultClicked value)?  resultClicked,TResult Function( SearchRecommendedClicked value)?  recommendedClicked,TResult Function( SearchAiSearchRequested value)?  aiSearchRequested,TResult Function( SearchSearchCancelled value)?  searchCancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchStarted() when started != null:
return started(_that);case SearchQueryChanged() when queryChanged != null:
return queryChanged(_that);case SearchCleared() when cleared != null:
return cleared(_that);case SearchSearchCleared() when searchCleared != null:
return searchCleared(_that);case SearchResultClicked() when resultClicked != null:
return resultClicked(_that);case SearchRecommendedClicked() when recommendedClicked != null:
return recommendedClicked(_that);case SearchAiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that);case SearchSearchCancelled() when searchCancelled != null:
return searchCancelled(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchStarted value)  started,required TResult Function( SearchQueryChanged value)  queryChanged,required TResult Function( SearchCleared value)  cleared,required TResult Function( SearchSearchCleared value)  searchCleared,required TResult Function( SearchResultClicked value)  resultClicked,required TResult Function( SearchRecommendedClicked value)  recommendedClicked,required TResult Function( SearchAiSearchRequested value)  aiSearchRequested,required TResult Function( SearchSearchCancelled value)  searchCancelled,}){
final _that = this;
switch (_that) {
case SearchStarted():
return started(_that);case SearchQueryChanged():
return queryChanged(_that);case SearchCleared():
return cleared(_that);case SearchSearchCleared():
return searchCleared(_that);case SearchResultClicked():
return resultClicked(_that);case SearchRecommendedClicked():
return recommendedClicked(_that);case SearchAiSearchRequested():
return aiSearchRequested(_that);case SearchSearchCancelled():
return searchCancelled(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchStarted value)?  started,TResult? Function( SearchQueryChanged value)?  queryChanged,TResult? Function( SearchCleared value)?  cleared,TResult? Function( SearchSearchCleared value)?  searchCleared,TResult? Function( SearchResultClicked value)?  resultClicked,TResult? Function( SearchRecommendedClicked value)?  recommendedClicked,TResult? Function( SearchAiSearchRequested value)?  aiSearchRequested,TResult? Function( SearchSearchCancelled value)?  searchCancelled,}){
final _that = this;
switch (_that) {
case SearchStarted() when started != null:
return started(_that);case SearchQueryChanged() when queryChanged != null:
return queryChanged(_that);case SearchCleared() when cleared != null:
return cleared(_that);case SearchSearchCleared() when searchCleared != null:
return searchCleared(_that);case SearchResultClicked() when resultClicked != null:
return resultClicked(_that);case SearchRecommendedClicked() when recommendedClicked != null:
return recommendedClicked(_that);case SearchAiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that);case SearchSearchCancelled() when searchCancelled != null:
return searchCancelled(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SearchSource source)?  started,TResult Function( String query)?  queryChanged,TResult Function()?  cleared,TResult Function()?  searchCleared,TResult Function( String ticker,  bool isAiResult)?  resultClicked,TResult Function( String ticker)?  recommendedClicked,TResult Function( String query)?  aiSearchRequested,TResult Function()?  searchCancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchStarted() when started != null:
return started(_that.source);case SearchQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case SearchCleared() when cleared != null:
return cleared();case SearchSearchCleared() when searchCleared != null:
return searchCleared();case SearchResultClicked() when resultClicked != null:
return resultClicked(_that.ticker,_that.isAiResult);case SearchRecommendedClicked() when recommendedClicked != null:
return recommendedClicked(_that.ticker);case SearchAiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that.query);case SearchSearchCancelled() when searchCancelled != null:
return searchCancelled();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SearchSource source)  started,required TResult Function( String query)  queryChanged,required TResult Function()  cleared,required TResult Function()  searchCleared,required TResult Function( String ticker,  bool isAiResult)  resultClicked,required TResult Function( String ticker)  recommendedClicked,required TResult Function( String query)  aiSearchRequested,required TResult Function()  searchCancelled,}) {final _that = this;
switch (_that) {
case SearchStarted():
return started(_that.source);case SearchQueryChanged():
return queryChanged(_that.query);case SearchCleared():
return cleared();case SearchSearchCleared():
return searchCleared();case SearchResultClicked():
return resultClicked(_that.ticker,_that.isAiResult);case SearchRecommendedClicked():
return recommendedClicked(_that.ticker);case SearchAiSearchRequested():
return aiSearchRequested(_that.query);case SearchSearchCancelled():
return searchCancelled();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SearchSource source)?  started,TResult? Function( String query)?  queryChanged,TResult? Function()?  cleared,TResult? Function()?  searchCleared,TResult? Function( String ticker,  bool isAiResult)?  resultClicked,TResult? Function( String ticker)?  recommendedClicked,TResult? Function( String query)?  aiSearchRequested,TResult? Function()?  searchCancelled,}) {final _that = this;
switch (_that) {
case SearchStarted() when started != null:
return started(_that.source);case SearchQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case SearchCleared() when cleared != null:
return cleared();case SearchSearchCleared() when searchCleared != null:
return searchCleared();case SearchResultClicked() when resultClicked != null:
return resultClicked(_that.ticker,_that.isAiResult);case SearchRecommendedClicked() when recommendedClicked != null:
return recommendedClicked(_that.ticker);case SearchAiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that.query);case SearchSearchCancelled() when searchCancelled != null:
return searchCancelled();case _:
  return null;

}
}

}

/// @nodoc


class SearchStarted implements SearchEvent {
  const SearchStarted({required this.source});
  

 final  SearchSource source;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStartedCopyWith<SearchStarted> get copyWith => _$SearchStartedCopyWithImpl<SearchStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchStarted&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,source);
}

@override
String toString() {
    return 'SearchEvent.started(source: $source)';
}


}

/// @nodoc
abstract mixin class $SearchStartedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchStartedCopyWith(SearchStarted value, $Res Function(SearchStarted) _then) = _$SearchStartedCopyWithImpl;
@useResult
$Res call({
 SearchSource source
});




}
/// @nodoc
class _$SearchStartedCopyWithImpl<$Res>
    implements $SearchStartedCopyWith<$Res> {
  _$SearchStartedCopyWithImpl(this._self, this._then);

  final SearchStarted _self;
  final $Res Function(SearchStarted) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(SearchStarted(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as SearchSource,
  ));
}


}

/// @nodoc


class SearchQueryChanged implements SearchEvent {
  const SearchQueryChanged(this.query);
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryChangedCopyWith<SearchQueryChanged> get copyWith => _$SearchQueryChangedCopyWithImpl<SearchQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'SearchEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchQueryChangedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchQueryChangedCopyWith(SearchQueryChanged value, $Res Function(SearchQueryChanged) _then) = _$SearchQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchQueryChangedCopyWithImpl<$Res>
    implements $SearchQueryChangedCopyWith<$Res> {
  _$SearchQueryChangedCopyWithImpl(this._self, this._then);

  final SearchQueryChanged _self;
  final $Res Function(SearchQueryChanged) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchCleared implements SearchEvent {
  const SearchCleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchEvent.cleared()';
}


}




/// @nodoc


class SearchSearchCleared implements SearchEvent {
  const SearchSearchCleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSearchCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchEvent.searchCleared()';
}


}




/// @nodoc


class SearchResultClicked implements SearchEvent {
  const SearchResultClicked({required this.ticker, required this.isAiResult});
  

 final  String ticker;
 final  bool isAiResult;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultClickedCopyWith<SearchResultClicked> get copyWith => _$SearchResultClickedCopyWithImpl<SearchResultClicked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultClicked&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.isAiResult, isAiResult) || other.isAiResult == isAiResult));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,isAiResult);
}

@override
String toString() {
    return 'SearchEvent.resultClicked(ticker: $ticker, isAiResult: $isAiResult)';
}


}

/// @nodoc
abstract mixin class $SearchResultClickedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchResultClickedCopyWith(SearchResultClicked value, $Res Function(SearchResultClicked) _then) = _$SearchResultClickedCopyWithImpl;
@useResult
$Res call({
 String ticker, bool isAiResult
});




}
/// @nodoc
class _$SearchResultClickedCopyWithImpl<$Res>
    implements $SearchResultClickedCopyWith<$Res> {
  _$SearchResultClickedCopyWithImpl(this._self, this._then);

  final SearchResultClicked _self;
  final $Res Function(SearchResultClicked) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? isAiResult = null,}) {
  return _then(SearchResultClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,isAiResult: null == isAiResult ? _self.isAiResult : isAiResult // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SearchRecommendedClicked implements SearchEvent {
  const SearchRecommendedClicked({required this.ticker});
  

 final  String ticker;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchRecommendedClickedCopyWith<SearchRecommendedClicked> get copyWith => _$SearchRecommendedClickedCopyWithImpl<SearchRecommendedClicked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchRecommendedClicked&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker);
}

@override
String toString() {
    return 'SearchEvent.recommendedClicked(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $SearchRecommendedClickedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchRecommendedClickedCopyWith(SearchRecommendedClicked value, $Res Function(SearchRecommendedClicked) _then) = _$SearchRecommendedClickedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$SearchRecommendedClickedCopyWithImpl<$Res>
    implements $SearchRecommendedClickedCopyWith<$Res> {
  _$SearchRecommendedClickedCopyWithImpl(this._self, this._then);

  final SearchRecommendedClicked _self;
  final $Res Function(SearchRecommendedClicked) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(SearchRecommendedClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchAiSearchRequested implements SearchEvent {
  const SearchAiSearchRequested(this.query);
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchAiSearchRequestedCopyWith<SearchAiSearchRequested> get copyWith => _$SearchAiSearchRequestedCopyWithImpl<SearchAiSearchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchAiSearchRequested&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'SearchEvent.aiSearchRequested(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchAiSearchRequestedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchAiSearchRequestedCopyWith(SearchAiSearchRequested value, $Res Function(SearchAiSearchRequested) _then) = _$SearchAiSearchRequestedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchAiSearchRequestedCopyWithImpl<$Res>
    implements $SearchAiSearchRequestedCopyWith<$Res> {
  _$SearchAiSearchRequestedCopyWithImpl(this._self, this._then);

  final SearchAiSearchRequested _self;
  final $Res Function(SearchAiSearchRequested) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchAiSearchRequested(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchSearchCancelled implements SearchEvent {
  const SearchSearchCancelled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSearchCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchEvent.searchCancelled()';
}


}




// dart format on
