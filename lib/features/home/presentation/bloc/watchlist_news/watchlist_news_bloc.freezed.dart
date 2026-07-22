// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_news_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistNewsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistNewsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistNewsEvent()';
}


}

/// @nodoc
class $WatchlistNewsEventCopyWith<$Res>  {
$WatchlistNewsEventCopyWith(WatchlistNewsEvent _, $Res Function(WatchlistNewsEvent) __);
}


/// Adds pattern-matching-related methods to [WatchlistNewsEvent].
extension WatchlistNewsEventPatterns on WatchlistNewsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadRequested value)?  loadRequested,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadRequested value)  loadRequested,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that);case Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<String> tickers)?  loadRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.tickers);case Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<String> tickers)  loadRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case LoadRequested():
return loadRequested(_that.tickers);case Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<String> tickers)?  loadRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case LoadRequested() when loadRequested != null:
return loadRequested(_that.tickers);case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class LoadRequested implements WatchlistNewsEvent {
  const LoadRequested(final  List<String> tickers): _tickers = tickers;
  

 final  List<String> _tickers;
 List<String> get tickers {
  if (_tickers is EqualUnmodifiableListView) return _tickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickers);
}


/// Create a copy of WatchlistNewsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadRequestedCopyWith<LoadRequested> get copyWith => _$LoadRequestedCopyWithImpl<LoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRequested&&const DeepCollectionEquality().equals(other._tickers, _tickers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickers));

@override
String toString() {
  return 'WatchlistNewsEvent.loadRequested(tickers: $tickers)';
}


}

/// @nodoc
abstract mixin class $LoadRequestedCopyWith<$Res> implements $WatchlistNewsEventCopyWith<$Res> {
  factory $LoadRequestedCopyWith(LoadRequested value, $Res Function(LoadRequested) _then) = _$LoadRequestedCopyWithImpl;
@useResult
$Res call({
 List<String> tickers
});




}
/// @nodoc
class _$LoadRequestedCopyWithImpl<$Res>
    implements $LoadRequestedCopyWith<$Res> {
  _$LoadRequestedCopyWithImpl(this._self, this._then);

  final LoadRequested _self;
  final $Res Function(LoadRequested) _then;

/// Create a copy of WatchlistNewsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tickers = null,}) {
  return _then(LoadRequested(
null == tickers ? _self._tickers : tickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class Reset implements WatchlistNewsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistNewsEvent.reset()';
}


}




/// @nodoc
mixin _$WatchlistNewsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistNewsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistNewsState()';
}


}

/// @nodoc
class $WatchlistNewsStateCopyWith<$Res>  {
$WatchlistNewsStateCopyWith(WatchlistNewsState _, $Res Function(WatchlistNewsState) __);
}


/// Adds pattern-matching-related methods to [WatchlistNewsState].
extension WatchlistNewsStatePatterns on WatchlistNewsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( WatchlistNewsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case WatchlistNewsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( WatchlistNewsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case WatchlistNewsLoaded():
return loaded(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( WatchlistNewsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case WatchlistNewsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WatchlistNewsArticle> articles)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case WatchlistNewsLoaded() when loaded != null:
return loaded(_that.articles);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WatchlistNewsArticle> articles)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case WatchlistNewsLoaded():
return loaded(_that.articles);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WatchlistNewsArticle> articles)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case WatchlistNewsLoaded() when loaded != null:
return loaded(_that.articles);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements WatchlistNewsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistNewsState.initial()';
}


}




/// @nodoc


class _Loading implements WatchlistNewsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistNewsState.loading()';
}


}




/// @nodoc


class WatchlistNewsLoaded implements WatchlistNewsState {
  const WatchlistNewsLoaded(final  List<WatchlistNewsArticle> articles): _articles = articles;
  

 final  List<WatchlistNewsArticle> _articles;
 List<WatchlistNewsArticle> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}


/// Create a copy of WatchlistNewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistNewsLoadedCopyWith<WatchlistNewsLoaded> get copyWith => _$WatchlistNewsLoadedCopyWithImpl<WatchlistNewsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistNewsLoaded&&const DeepCollectionEquality().equals(other._articles, _articles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles));

@override
String toString() {
  return 'WatchlistNewsState.loaded(articles: $articles)';
}


}

/// @nodoc
abstract mixin class $WatchlistNewsLoadedCopyWith<$Res> implements $WatchlistNewsStateCopyWith<$Res> {
  factory $WatchlistNewsLoadedCopyWith(WatchlistNewsLoaded value, $Res Function(WatchlistNewsLoaded) _then) = _$WatchlistNewsLoadedCopyWithImpl;
@useResult
$Res call({
 List<WatchlistNewsArticle> articles
});




}
/// @nodoc
class _$WatchlistNewsLoadedCopyWithImpl<$Res>
    implements $WatchlistNewsLoadedCopyWith<$Res> {
  _$WatchlistNewsLoadedCopyWithImpl(this._self, this._then);

  final WatchlistNewsLoaded _self;
  final $Res Function(WatchlistNewsLoaded) _then;

/// Create a copy of WatchlistNewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? articles = null,}) {
  return _then(WatchlistNewsLoaded(
null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<WatchlistNewsArticle>,
  ));
}


}

/// @nodoc


class _Failure implements WatchlistNewsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of WatchlistNewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'WatchlistNewsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $WatchlistNewsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of WatchlistNewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of WatchlistNewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
