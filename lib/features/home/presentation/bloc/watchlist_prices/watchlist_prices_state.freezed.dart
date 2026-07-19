// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_prices_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistPricesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistPricesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistPricesState()';
}


}

/// @nodoc
class $WatchlistPricesStateCopyWith<$Res>  {
$WatchlistPricesStateCopyWith(WatchlistPricesState _, $Res Function(WatchlistPricesState) __);
}


/// Adds pattern-matching-related methods to [WatchlistPricesState].
extension WatchlistPricesStatePatterns on WatchlistPricesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Disabled value)?  disabled,TResult Function( WatchlistPricesLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Disabled() when disabled != null:
return disabled(_that);case WatchlistPricesLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Disabled value)  disabled,required TResult Function( WatchlistPricesLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Disabled():
return disabled(_that);case WatchlistPricesLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Disabled value)?  disabled,TResult? Function( WatchlistPricesLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Disabled() when disabled != null:
return disabled(_that);case WatchlistPricesLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  disabled,TResult Function( Map<String, WatchlistStockPrice> prices)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Disabled() when disabled != null:
return disabled();case WatchlistPricesLoaded() when loaded != null:
return loaded(_that.prices);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  disabled,required TResult Function( Map<String, WatchlistStockPrice> prices)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Disabled():
return disabled();case WatchlistPricesLoaded():
return loaded(_that.prices);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  disabled,TResult? Function( Map<String, WatchlistStockPrice> prices)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Disabled() when disabled != null:
return disabled();case WatchlistPricesLoaded() when loaded != null:
return loaded(_that.prices);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements WatchlistPricesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistPricesState.initial()';
}


}




/// @nodoc


class _Loading implements WatchlistPricesState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistPricesState.loading()';
}


}




/// @nodoc


class _Disabled implements WatchlistPricesState {
  const _Disabled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disabled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistPricesState.disabled()';
}


}




/// @nodoc


class WatchlistPricesLoaded implements WatchlistPricesState {
  const WatchlistPricesLoaded(final  Map<String, WatchlistStockPrice> prices): _prices = prices;
  

 final  Map<String, WatchlistStockPrice> _prices;
 Map<String, WatchlistStockPrice> get prices {
  if (_prices is EqualUnmodifiableMapView) return _prices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_prices);
}


/// Create a copy of WatchlistPricesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistPricesLoadedCopyWith<WatchlistPricesLoaded> get copyWith => _$WatchlistPricesLoadedCopyWithImpl<WatchlistPricesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistPricesLoaded&&const DeepCollectionEquality().equals(other._prices, _prices));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_prices));

@override
String toString() {
  return 'WatchlistPricesState.loaded(prices: $prices)';
}


}

/// @nodoc
abstract mixin class $WatchlistPricesLoadedCopyWith<$Res> implements $WatchlistPricesStateCopyWith<$Res> {
  factory $WatchlistPricesLoadedCopyWith(WatchlistPricesLoaded value, $Res Function(WatchlistPricesLoaded) _then) = _$WatchlistPricesLoadedCopyWithImpl;
@useResult
$Res call({
 Map<String, WatchlistStockPrice> prices
});




}
/// @nodoc
class _$WatchlistPricesLoadedCopyWithImpl<$Res>
    implements $WatchlistPricesLoadedCopyWith<$Res> {
  _$WatchlistPricesLoadedCopyWithImpl(this._self, this._then);

  final WatchlistPricesLoaded _self;
  final $Res Function(WatchlistPricesLoaded) _then;

/// Create a copy of WatchlistPricesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? prices = null,}) {
  return _then(WatchlistPricesLoaded(
null == prices ? _self._prices : prices // ignore: cast_nullable_to_non_nullable
as Map<String, WatchlistStockPrice>,
  ));
}


}

/// @nodoc


class _Failure implements WatchlistPricesState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of WatchlistPricesState
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
  return 'WatchlistPricesState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $WatchlistPricesStateCopyWith<$Res> {
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

/// Create a copy of WatchlistPricesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of WatchlistPricesState
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
