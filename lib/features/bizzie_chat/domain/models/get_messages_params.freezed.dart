// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_messages_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetMessagesParams {

 String get uid; String get sessionId;
/// Create a copy of GetMessagesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetMessagesParamsCopyWith<GetMessagesParams> get copyWith => _$GetMessagesParamsCopyWithImpl<GetMessagesParams>(this as GetMessagesParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetMessagesParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,uid,sessionId);

@override
String toString() {
  return 'GetMessagesParams(uid: $uid, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $GetMessagesParamsCopyWith<$Res>  {
  factory $GetMessagesParamsCopyWith(GetMessagesParams value, $Res Function(GetMessagesParams) _then) = _$GetMessagesParamsCopyWithImpl;
@useResult
$Res call({
 String uid, String sessionId
});




}
/// @nodoc
class _$GetMessagesParamsCopyWithImpl<$Res>
    implements $GetMessagesParamsCopyWith<$Res> {
  _$GetMessagesParamsCopyWithImpl(this._self, this._then);

  final GetMessagesParams _self;
  final $Res Function(GetMessagesParams) _then;

/// Create a copy of GetMessagesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? sessionId = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetMessagesParams].
extension GetMessagesParamsPatterns on GetMessagesParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetMessagesParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetMessagesParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetMessagesParams value)  $default,){
final _that = this;
switch (_that) {
case _GetMessagesParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetMessagesParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetMessagesParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetMessagesParams() when $default != null:
return $default(_that.uid,_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String sessionId)  $default,) {final _that = this;
switch (_that) {
case _GetMessagesParams():
return $default(_that.uid,_that.sessionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String sessionId)?  $default,) {final _that = this;
switch (_that) {
case _GetMessagesParams() when $default != null:
return $default(_that.uid,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc


class _GetMessagesParams implements GetMessagesParams {
  const _GetMessagesParams({required this.uid, required this.sessionId});
  

@override final  String uid;
@override final  String sessionId;

/// Create a copy of GetMessagesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetMessagesParamsCopyWith<_GetMessagesParams> get copyWith => __$GetMessagesParamsCopyWithImpl<_GetMessagesParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetMessagesParams&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,uid,sessionId);

@override
String toString() {
  return 'GetMessagesParams(uid: $uid, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$GetMessagesParamsCopyWith<$Res> implements $GetMessagesParamsCopyWith<$Res> {
  factory _$GetMessagesParamsCopyWith(_GetMessagesParams value, $Res Function(_GetMessagesParams) _then) = __$GetMessagesParamsCopyWithImpl;
@override @useResult
$Res call({
 String uid, String sessionId
});




}
/// @nodoc
class __$GetMessagesParamsCopyWithImpl<$Res>
    implements _$GetMessagesParamsCopyWith<$Res> {
  __$GetMessagesParamsCopyWithImpl(this._self, this._then);

  final _GetMessagesParams _self;
  final $Res Function(_GetMessagesParams) _then;

/// Create a copy of GetMessagesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? sessionId = null,}) {
  return _then(_GetMessagesParams(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
