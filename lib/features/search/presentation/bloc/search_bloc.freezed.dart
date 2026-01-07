// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _QueryChanged value)?  queryChanged,TResult Function( _Cleared value)?  cleared,TResult Function( _AiSearchRequested value)?  aiSearchRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Cleared() when cleared != null:
return cleared(_that);case _AiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _QueryChanged value)  queryChanged,required TResult Function( _Cleared value)  cleared,required TResult Function( _AiSearchRequested value)  aiSearchRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _QueryChanged():
return queryChanged(_that);case _Cleared():
return cleared(_that);case _AiSearchRequested():
return aiSearchRequested(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _QueryChanged value)?  queryChanged,TResult? Function( _Cleared value)?  cleared,TResult? Function( _AiSearchRequested value)?  aiSearchRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Cleared() when cleared != null:
return cleared(_that);case _AiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  queryChanged,TResult Function()?  cleared,TResult Function( String query)?  aiSearchRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Cleared() when cleared != null:
return cleared();case _AiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  queryChanged,required TResult Function()  cleared,required TResult Function( String query)  aiSearchRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _QueryChanged():
return queryChanged(_that.query);case _Cleared():
return cleared();case _AiSearchRequested():
return aiSearchRequested(_that.query);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  queryChanged,TResult? Function()?  cleared,TResult? Function( String query)?  aiSearchRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Cleared() when cleared != null:
return cleared();case _AiSearchRequested() when aiSearchRequested != null:
return aiSearchRequested(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SearchEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent.started()';
}


}




/// @nodoc


class _QueryChanged implements SearchEvent {
  const _QueryChanged(this.query);
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryChangedCopyWith<_QueryChanged> get copyWith => __$QueryChangedCopyWithImpl<_QueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory _$QueryChangedCopyWith(_QueryChanged value, $Res Function(_QueryChanged) _then) = __$QueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$QueryChangedCopyWithImpl<$Res>
    implements _$QueryChangedCopyWith<$Res> {
  __$QueryChangedCopyWithImpl(this._self, this._then);

  final _QueryChanged _self;
  final $Res Function(_QueryChanged) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Cleared implements SearchEvent {
  const _Cleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent.cleared()';
}


}




/// @nodoc


class _AiSearchRequested implements SearchEvent {
  const _AiSearchRequested(this.query);
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiSearchRequestedCopyWith<_AiSearchRequested> get copyWith => __$AiSearchRequestedCopyWithImpl<_AiSearchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiSearchRequested&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchEvent.aiSearchRequested(query: $query)';
}


}

/// @nodoc
abstract mixin class _$AiSearchRequestedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory _$AiSearchRequestedCopyWith(_AiSearchRequested value, $Res Function(_AiSearchRequested) _then) = __$AiSearchRequestedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$AiSearchRequestedCopyWithImpl<$Res>
    implements _$AiSearchRequestedCopyWith<$Res> {
  __$AiSearchRequestedCopyWithImpl(this._self, this._then);

  final _AiSearchRequested _self;
  final $Res Function(_AiSearchRequested) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_AiSearchRequested(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _LocalEmpty value)?  localEmpty,TResult Function( _AiSearching value)?  aiSearching,TResult Function( _AiSuccess value)?  aiSuccess,TResult Function( _AiEmpty value)?  aiEmpty,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LocalEmpty() when localEmpty != null:
return localEmpty(_that);case _AiSearching() when aiSearching != null:
return aiSearching(_that);case _AiSuccess() when aiSuccess != null:
return aiSuccess(_that);case _AiEmpty() when aiEmpty != null:
return aiEmpty(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _LocalEmpty value)  localEmpty,required TResult Function( _AiSearching value)  aiSearching,required TResult Function( _AiSuccess value)  aiSuccess,required TResult Function( _AiEmpty value)  aiEmpty,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _LocalEmpty():
return localEmpty(_that);case _AiSearching():
return aiSearching(_that);case _AiSuccess():
return aiSuccess(_that);case _AiEmpty():
return aiEmpty(_that);case _Failure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _LocalEmpty value)?  localEmpty,TResult? Function( _AiSearching value)?  aiSearching,TResult? Function( _AiSuccess value)?  aiSuccess,TResult? Function( _AiEmpty value)?  aiEmpty,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _LocalEmpty() when localEmpty != null:
return localEmpty(_that);case _AiSearching() when aiSearching != null:
return aiSearching(_that);case _AiSuccess() when aiSuccess != null:
return aiSuccess(_that);case _AiEmpty() when aiEmpty != null:
return aiEmpty(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? favoriteSector,  List<Company> recommendedBrands)?  initial,TResult Function( String? favoriteSector)?  loading,TResult Function( List<StockSymbol> results,  String query)?  loaded,TResult Function( String query)?  localEmpty,TResult Function( String query)?  aiSearching,TResult Function( String productQuery,  StockSymbol stock)?  aiSuccess,TResult Function( String productQuery)?  aiEmpty,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.favoriteSector,_that.recommendedBrands);case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Loaded() when loaded != null:
return loaded(_that.results,_that.query);case _LocalEmpty() when localEmpty != null:
return localEmpty(_that.query);case _AiSearching() when aiSearching != null:
return aiSearching(_that.query);case _AiSuccess() when aiSuccess != null:
return aiSuccess(_that.productQuery,_that.stock);case _AiEmpty() when aiEmpty != null:
return aiEmpty(_that.productQuery);case _Failure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? favoriteSector,  List<Company> recommendedBrands)  initial,required TResult Function( String? favoriteSector)  loading,required TResult Function( List<StockSymbol> results,  String query)  loaded,required TResult Function( String query)  localEmpty,required TResult Function( String query)  aiSearching,required TResult Function( String productQuery,  StockSymbol stock)  aiSuccess,required TResult Function( String productQuery)  aiEmpty,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.favoriteSector,_that.recommendedBrands);case _Loading():
return loading(_that.favoriteSector);case _Loaded():
return loaded(_that.results,_that.query);case _LocalEmpty():
return localEmpty(_that.query);case _AiSearching():
return aiSearching(_that.query);case _AiSuccess():
return aiSuccess(_that.productQuery,_that.stock);case _AiEmpty():
return aiEmpty(_that.productQuery);case _Failure():
return failure(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? favoriteSector,  List<Company> recommendedBrands)?  initial,TResult? Function( String? favoriteSector)?  loading,TResult? Function( List<StockSymbol> results,  String query)?  loaded,TResult? Function( String query)?  localEmpty,TResult? Function( String query)?  aiSearching,TResult? Function( String productQuery,  StockSymbol stock)?  aiSuccess,TResult? Function( String productQuery)?  aiEmpty,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.favoriteSector,_that.recommendedBrands);case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Loaded() when loaded != null:
return loaded(_that.results,_that.query);case _LocalEmpty() when localEmpty != null:
return localEmpty(_that.query);case _AiSearching() when aiSearching != null:
return aiSearching(_that.query);case _AiSuccess() when aiSuccess != null:
return aiSuccess(_that.productQuery,_that.stock);case _AiEmpty() when aiEmpty != null:
return aiEmpty(_that.productQuery);case _Failure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SearchState {
  const _Initial({this.favoriteSector, final  List<Company> recommendedBrands = const []}): _recommendedBrands = recommendedBrands;
  

 final  String? favoriteSector;
 final  List<Company> _recommendedBrands;
@JsonKey() List<Company> get recommendedBrands {
  if (_recommendedBrands is EqualUnmodifiableListView) return _recommendedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendedBrands);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&const DeepCollectionEquality().equals(other._recommendedBrands, _recommendedBrands));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector,const DeepCollectionEquality().hash(_recommendedBrands));

@override
String toString() {
  return 'SearchState.initial(favoriteSector: $favoriteSector, recommendedBrands: $recommendedBrands)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@useResult
$Res call({
 String? favoriteSector, List<Company> recommendedBrands
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,Object? recommendedBrands = null,}) {
  return _then(_Initial(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,recommendedBrands: null == recommendedBrands ? _self._recommendedBrands : recommendedBrands // ignore: cast_nullable_to_non_nullable
as List<Company>,
  ));
}


}

/// @nodoc


class _Loading implements SearchState {
  const _Loading({this.favoriteSector});
  

 final  String? favoriteSector;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'SearchState.loading(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Loading(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Loaded implements SearchState {
  const _Loaded({required final  List<StockSymbol> results, required this.query}): _results = results;
  

 final  List<StockSymbol> _results;
 List<StockSymbol> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),query);

@override
String toString() {
  return 'SearchState.loaded(results: $results, query: $query)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<StockSymbol> results, String query
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? results = null,Object? query = null,}) {
  return _then(_Loaded(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<StockSymbol>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LocalEmpty implements SearchState {
  const _LocalEmpty(this.query);
  

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalEmptyCopyWith<_LocalEmpty> get copyWith => __$LocalEmptyCopyWithImpl<_LocalEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalEmpty&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchState.localEmpty(query: $query)';
}


}

/// @nodoc
abstract mixin class _$LocalEmptyCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$LocalEmptyCopyWith(_LocalEmpty value, $Res Function(_LocalEmpty) _then) = __$LocalEmptyCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$LocalEmptyCopyWithImpl<$Res>
    implements _$LocalEmptyCopyWith<$Res> {
  __$LocalEmptyCopyWithImpl(this._self, this._then);

  final _LocalEmpty _self;
  final $Res Function(_LocalEmpty) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_LocalEmpty(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AiSearching implements SearchState {
  const _AiSearching(this.query);
  

 final  String query;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiSearchingCopyWith<_AiSearching> get copyWith => __$AiSearchingCopyWithImpl<_AiSearching>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiSearching&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchState.aiSearching(query: $query)';
}


}

/// @nodoc
abstract mixin class _$AiSearchingCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$AiSearchingCopyWith(_AiSearching value, $Res Function(_AiSearching) _then) = __$AiSearchingCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$AiSearchingCopyWithImpl<$Res>
    implements _$AiSearchingCopyWith<$Res> {
  __$AiSearchingCopyWithImpl(this._self, this._then);

  final _AiSearching _self;
  final $Res Function(_AiSearching) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_AiSearching(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AiSuccess implements SearchState {
  const _AiSuccess({required this.productQuery, required this.stock});
  

 final  String productQuery;
 final  StockSymbol stock;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiSuccessCopyWith<_AiSuccess> get copyWith => __$AiSuccessCopyWithImpl<_AiSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiSuccess&&(identical(other.productQuery, productQuery) || other.productQuery == productQuery)&&(identical(other.stock, stock) || other.stock == stock));
}


@override
int get hashCode => Object.hash(runtimeType,productQuery,stock);

@override
String toString() {
  return 'SearchState.aiSuccess(productQuery: $productQuery, stock: $stock)';
}


}

/// @nodoc
abstract mixin class _$AiSuccessCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$AiSuccessCopyWith(_AiSuccess value, $Res Function(_AiSuccess) _then) = __$AiSuccessCopyWithImpl;
@useResult
$Res call({
 String productQuery, StockSymbol stock
});


$StockSymbolCopyWith<$Res> get stock;

}
/// @nodoc
class __$AiSuccessCopyWithImpl<$Res>
    implements _$AiSuccessCopyWith<$Res> {
  __$AiSuccessCopyWithImpl(this._self, this._then);

  final _AiSuccess _self;
  final $Res Function(_AiSuccess) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productQuery = null,Object? stock = null,}) {
  return _then(_AiSuccess(
productQuery: null == productQuery ? _self.productQuery : productQuery // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as StockSymbol,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StockSymbolCopyWith<$Res> get stock {
  
  return $StockSymbolCopyWith<$Res>(_self.stock, (value) {
    return _then(_self.copyWith(stock: value));
  });
}
}

/// @nodoc


class _AiEmpty implements SearchState {
  const _AiEmpty(this.productQuery);
  

 final  String productQuery;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiEmptyCopyWith<_AiEmpty> get copyWith => __$AiEmptyCopyWithImpl<_AiEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiEmpty&&(identical(other.productQuery, productQuery) || other.productQuery == productQuery));
}


@override
int get hashCode => Object.hash(runtimeType,productQuery);

@override
String toString() {
  return 'SearchState.aiEmpty(productQuery: $productQuery)';
}


}

/// @nodoc
abstract mixin class _$AiEmptyCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$AiEmptyCopyWith(_AiEmpty value, $Res Function(_AiEmpty) _then) = __$AiEmptyCopyWithImpl;
@useResult
$Res call({
 String productQuery
});




}
/// @nodoc
class __$AiEmptyCopyWithImpl<$Res>
    implements _$AiEmptyCopyWith<$Res> {
  __$AiEmptyCopyWithImpl(this._self, this._then);

  final _AiEmpty _self;
  final $Res Function(_AiEmpty) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productQuery = null,}) {
  return _then(_AiEmpty(
null == productQuery ? _self.productQuery : productQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Failure implements SearchState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SearchState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
