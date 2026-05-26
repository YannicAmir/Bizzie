// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_sessions_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetSessionsParams {

 String get uid; String get ticker;
/// Create a copy of GetSessionsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetSessionsParamsCopyWith<GetSessionsParams> get copyWith => _$GetSessionsParamsCopyWithImpl<GetSessionsParams>(this as GetSessionsParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetSessionsParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,uid,ticker);

@override
String toString() {
  return 'GetSessionsParams(uid: $uid, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $GetSessionsParamsCopyWith<$Res>  {
  factory $GetSessionsParamsCopyWith(GetSessionsParams value, $Res Function(GetSessionsParams) _then) = _$GetSessionsParamsCopyWithImpl;
@useResult
$Res call({
 String uid, String ticker
});




}
/// @nodoc
class _$GetSessionsParamsCopyWithImpl<$Res>
    implements $GetSessionsParamsCopyWith<$Res> {
  _$GetSessionsParamsCopyWithImpl(this._self, this._then);

  final GetSessionsParams _self;
  final $Res Function(GetSessionsParams) _then;

/// Create a copy of GetSessionsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? ticker = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetSessionsParams].
extension GetSessionsParamsPatterns on GetSessionsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetSessionsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetSessionsParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetSessionsParams value)  $default,){
final _that = this;
switch (_that) {
case _GetSessionsParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetSessionsParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetSessionsParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String ticker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetSessionsParams() when $default != null:
return $default(_that.uid,_that.ticker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String ticker)  $default,) {final _that = this;
switch (_that) {
case _GetSessionsParams():
return $default(_that.uid,_that.ticker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String ticker)?  $default,) {final _that = this;
switch (_that) {
case _GetSessionsParams() when $default != null:
return $default(_that.uid,_that.ticker);case _:
  return null;

}
}

}

/// @nodoc


class _GetSessionsParams implements GetSessionsParams {
  const _GetSessionsParams({required this.uid, required this.ticker});
  

@override final  String uid;
@override final  String ticker;

/// Create a copy of GetSessionsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetSessionsParamsCopyWith<_GetSessionsParams> get copyWith => __$GetSessionsParamsCopyWithImpl<_GetSessionsParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetSessionsParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,uid,ticker);

@override
String toString() {
  return 'GetSessionsParams(uid: $uid, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$GetSessionsParamsCopyWith<$Res> implements $GetSessionsParamsCopyWith<$Res> {
  factory _$GetSessionsParamsCopyWith(_GetSessionsParams value, $Res Function(_GetSessionsParams) _then) = __$GetSessionsParamsCopyWithImpl;
@override @useResult
$Res call({
 String uid, String ticker
});




}
/// @nodoc
class __$GetSessionsParamsCopyWithImpl<$Res>
    implements _$GetSessionsParamsCopyWith<$Res> {
  __$GetSessionsParamsCopyWithImpl(this._self, this._then);

  final _GetSessionsParams _self;
  final $Res Function(_GetSessionsParams) _then;

/// Create a copy of GetSessionsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? ticker = null,}) {
  return _then(_GetSessionsParams(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
