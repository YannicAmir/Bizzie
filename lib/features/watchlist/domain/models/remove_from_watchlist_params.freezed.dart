// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remove_from_watchlist_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RemoveFromWatchlistParams {

 String get ticker; String get uid;
/// Create a copy of RemoveFromWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFromWatchlistParamsCopyWith<RemoveFromWatchlistParams> get copyWith => _$RemoveFromWatchlistParamsCopyWithImpl<RemoveFromWatchlistParams>(this as RemoveFromWatchlistParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFromWatchlistParams&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,uid);

@override
String toString() {
  return 'RemoveFromWatchlistParams(ticker: $ticker, uid: $uid)';
}


}

/// @nodoc
abstract mixin class $RemoveFromWatchlistParamsCopyWith<$Res>  {
  factory $RemoveFromWatchlistParamsCopyWith(RemoveFromWatchlistParams value, $Res Function(RemoveFromWatchlistParams) _then) = _$RemoveFromWatchlistParamsCopyWithImpl;
@useResult
$Res call({
 String ticker, String uid
});




}
/// @nodoc
class _$RemoveFromWatchlistParamsCopyWithImpl<$Res>
    implements $RemoveFromWatchlistParamsCopyWith<$Res> {
  _$RemoveFromWatchlistParamsCopyWithImpl(this._self, this._then);

  final RemoveFromWatchlistParams _self;
  final $Res Function(RemoveFromWatchlistParams) _then;

/// Create a copy of RemoveFromWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? uid = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoveFromWatchlistParams].
extension RemoveFromWatchlistParamsPatterns on RemoveFromWatchlistParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoveFromWatchlistParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoveFromWatchlistParams value)  $default,){
final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoveFromWatchlistParams value)?  $default,){
final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String uid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams() when $default != null:
return $default(_that.ticker,_that.uid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String uid)  $default,) {final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams():
return $default(_that.ticker,_that.uid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String uid)?  $default,) {final _that = this;
switch (_that) {
case _RemoveFromWatchlistParams() when $default != null:
return $default(_that.ticker,_that.uid);case _:
  return null;

}
}

}

/// @nodoc


class _RemoveFromWatchlistParams implements RemoveFromWatchlistParams {
  const _RemoveFromWatchlistParams({required this.ticker, required this.uid});
  

@override final  String ticker;
@override final  String uid;

/// Create a copy of RemoveFromWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveFromWatchlistParamsCopyWith<_RemoveFromWatchlistParams> get copyWith => __$RemoveFromWatchlistParamsCopyWithImpl<_RemoveFromWatchlistParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveFromWatchlistParams&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,uid);

@override
String toString() {
  return 'RemoveFromWatchlistParams(ticker: $ticker, uid: $uid)';
}


}

/// @nodoc
abstract mixin class _$RemoveFromWatchlistParamsCopyWith<$Res> implements $RemoveFromWatchlistParamsCopyWith<$Res> {
  factory _$RemoveFromWatchlistParamsCopyWith(_RemoveFromWatchlistParams value, $Res Function(_RemoveFromWatchlistParams) _then) = __$RemoveFromWatchlistParamsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String uid
});




}
/// @nodoc
class __$RemoveFromWatchlistParamsCopyWithImpl<$Res>
    implements _$RemoveFromWatchlistParamsCopyWith<$Res> {
  __$RemoveFromWatchlistParamsCopyWithImpl(this._self, this._then);

  final _RemoveFromWatchlistParams _self;
  final $Res Function(_RemoveFromWatchlistParams) _then;

/// Create a copy of RemoveFromWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? uid = null,}) {
  return _then(_RemoveFromWatchlistParams(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
