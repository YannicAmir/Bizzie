// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mark_reports_viewed_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MarkReportsViewedParams {

 String get uid; DateTime get timestamp;
/// Create a copy of MarkReportsViewedParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkReportsViewedParamsCopyWith<MarkReportsViewedParams> get copyWith => _$MarkReportsViewedParamsCopyWithImpl<MarkReportsViewedParams>(this as MarkReportsViewedParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkReportsViewedParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,uid,timestamp);

@override
String toString() {
  return 'MarkReportsViewedParams(uid: $uid, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $MarkReportsViewedParamsCopyWith<$Res>  {
  factory $MarkReportsViewedParamsCopyWith(MarkReportsViewedParams value, $Res Function(MarkReportsViewedParams) _then) = _$MarkReportsViewedParamsCopyWithImpl;
@useResult
$Res call({
 String uid, DateTime timestamp
});




}
/// @nodoc
class _$MarkReportsViewedParamsCopyWithImpl<$Res>
    implements $MarkReportsViewedParamsCopyWith<$Res> {
  _$MarkReportsViewedParamsCopyWithImpl(this._self, this._then);

  final MarkReportsViewedParams _self;
  final $Res Function(MarkReportsViewedParams) _then;

/// Create a copy of MarkReportsViewedParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MarkReportsViewedParams].
extension MarkReportsViewedParamsPatterns on MarkReportsViewedParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkReportsViewedParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkReportsViewedParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkReportsViewedParams value)  $default,){
final _that = this;
switch (_that) {
case _MarkReportsViewedParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkReportsViewedParams value)?  $default,){
final _that = this;
switch (_that) {
case _MarkReportsViewedParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MarkReportsViewedParams() when $default != null:
return $default(_that.uid,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _MarkReportsViewedParams():
return $default(_that.uid,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _MarkReportsViewedParams() when $default != null:
return $default(_that.uid,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _MarkReportsViewedParams implements MarkReportsViewedParams {
  const _MarkReportsViewedParams({required this.uid, required this.timestamp});
  

@override final  String uid;
@override final  DateTime timestamp;

/// Create a copy of MarkReportsViewedParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkReportsViewedParamsCopyWith<_MarkReportsViewedParams> get copyWith => __$MarkReportsViewedParamsCopyWithImpl<_MarkReportsViewedParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkReportsViewedParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,uid,timestamp);

@override
String toString() {
  return 'MarkReportsViewedParams(uid: $uid, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$MarkReportsViewedParamsCopyWith<$Res> implements $MarkReportsViewedParamsCopyWith<$Res> {
  factory _$MarkReportsViewedParamsCopyWith(_MarkReportsViewedParams value, $Res Function(_MarkReportsViewedParams) _then) = __$MarkReportsViewedParamsCopyWithImpl;
@override @useResult
$Res call({
 String uid, DateTime timestamp
});




}
/// @nodoc
class __$MarkReportsViewedParamsCopyWithImpl<$Res>
    implements _$MarkReportsViewedParamsCopyWith<$Res> {
  __$MarkReportsViewedParamsCopyWithImpl(this._self, this._then);

  final _MarkReportsViewedParams _self;
  final $Res Function(_MarkReportsViewedParams) _then;

/// Create a copy of MarkReportsViewedParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? timestamp = null,}) {
  return _then(_MarkReportsViewedParams(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
