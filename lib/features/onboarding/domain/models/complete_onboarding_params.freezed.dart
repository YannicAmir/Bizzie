// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_onboarding_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompleteOnboardingParams {

 OnboardingData get data; String get uid; bool get awaitServerAck; bool get deferNotificationSetup; bool get hasExistingProfile;
/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteOnboardingParamsCopyWith<CompleteOnboardingParams> get copyWith => _$CompleteOnboardingParamsCopyWithImpl<CompleteOnboardingParams>(this as CompleteOnboardingParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOnboardingParams&&(identical(other.data, data) || other.data == data)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.awaitServerAck, awaitServerAck) || other.awaitServerAck == awaitServerAck)&&(identical(other.deferNotificationSetup, deferNotificationSetup) || other.deferNotificationSetup == deferNotificationSetup)&&(identical(other.hasExistingProfile, hasExistingProfile) || other.hasExistingProfile == hasExistingProfile));
}


@override
int get hashCode => Object.hash(runtimeType,data,uid,awaitServerAck,deferNotificationSetup,hasExistingProfile);

@override
String toString() {
  return 'CompleteOnboardingParams(data: $data, uid: $uid, awaitServerAck: $awaitServerAck, deferNotificationSetup: $deferNotificationSetup, hasExistingProfile: $hasExistingProfile)';
}


}

/// @nodoc
abstract mixin class $CompleteOnboardingParamsCopyWith<$Res>  {
  factory $CompleteOnboardingParamsCopyWith(CompleteOnboardingParams value, $Res Function(CompleteOnboardingParams) _then) = _$CompleteOnboardingParamsCopyWithImpl;
@useResult
$Res call({
 OnboardingData data, String uid, bool awaitServerAck, bool deferNotificationSetup, bool hasExistingProfile
});


$OnboardingDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CompleteOnboardingParamsCopyWithImpl<$Res>
    implements $CompleteOnboardingParamsCopyWith<$Res> {
  _$CompleteOnboardingParamsCopyWithImpl(this._self, this._then);

  final CompleteOnboardingParams _self;
  final $Res Function(CompleteOnboardingParams) _then;

/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? uid = null,Object? awaitServerAck = null,Object? deferNotificationSetup = null,Object? hasExistingProfile = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,awaitServerAck: null == awaitServerAck ? _self.awaitServerAck : awaitServerAck // ignore: cast_nullable_to_non_nullable
as bool,deferNotificationSetup: null == deferNotificationSetup ? _self.deferNotificationSetup : deferNotificationSetup // ignore: cast_nullable_to_non_nullable
as bool,hasExistingProfile: null == hasExistingProfile ? _self.hasExistingProfile : hasExistingProfile // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get data {
  
  return $OnboardingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompleteOnboardingParams].
extension CompleteOnboardingParamsPatterns on CompleteOnboardingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompleteOnboardingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompleteOnboardingParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompleteOnboardingParams value)  $default,){
final _that = this;
switch (_that) {
case _CompleteOnboardingParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompleteOnboardingParams value)?  $default,){
final _that = this;
switch (_that) {
case _CompleteOnboardingParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingData data,  String uid,  bool awaitServerAck,  bool deferNotificationSetup,  bool hasExistingProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompleteOnboardingParams() when $default != null:
return $default(_that.data,_that.uid,_that.awaitServerAck,_that.deferNotificationSetup,_that.hasExistingProfile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingData data,  String uid,  bool awaitServerAck,  bool deferNotificationSetup,  bool hasExistingProfile)  $default,) {final _that = this;
switch (_that) {
case _CompleteOnboardingParams():
return $default(_that.data,_that.uid,_that.awaitServerAck,_that.deferNotificationSetup,_that.hasExistingProfile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingData data,  String uid,  bool awaitServerAck,  bool deferNotificationSetup,  bool hasExistingProfile)?  $default,) {final _that = this;
switch (_that) {
case _CompleteOnboardingParams() when $default != null:
return $default(_that.data,_that.uid,_that.awaitServerAck,_that.deferNotificationSetup,_that.hasExistingProfile);case _:
  return null;

}
}

}

/// @nodoc


class _CompleteOnboardingParams implements CompleteOnboardingParams {
  const _CompleteOnboardingParams({required this.data, required this.uid, this.awaitServerAck = true, this.deferNotificationSetup = false, this.hasExistingProfile = false});
  

@override final  OnboardingData data;
@override final  String uid;
@override@JsonKey() final  bool awaitServerAck;
@override@JsonKey() final  bool deferNotificationSetup;
@override@JsonKey() final  bool hasExistingProfile;

/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteOnboardingParamsCopyWith<_CompleteOnboardingParams> get copyWith => __$CompleteOnboardingParamsCopyWithImpl<_CompleteOnboardingParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteOnboardingParams&&(identical(other.data, data) || other.data == data)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.awaitServerAck, awaitServerAck) || other.awaitServerAck == awaitServerAck)&&(identical(other.deferNotificationSetup, deferNotificationSetup) || other.deferNotificationSetup == deferNotificationSetup)&&(identical(other.hasExistingProfile, hasExistingProfile) || other.hasExistingProfile == hasExistingProfile));
}


@override
int get hashCode => Object.hash(runtimeType,data,uid,awaitServerAck,deferNotificationSetup,hasExistingProfile);

@override
String toString() {
  return 'CompleteOnboardingParams(data: $data, uid: $uid, awaitServerAck: $awaitServerAck, deferNotificationSetup: $deferNotificationSetup, hasExistingProfile: $hasExistingProfile)';
}


}

/// @nodoc
abstract mixin class _$CompleteOnboardingParamsCopyWith<$Res> implements $CompleteOnboardingParamsCopyWith<$Res> {
  factory _$CompleteOnboardingParamsCopyWith(_CompleteOnboardingParams value, $Res Function(_CompleteOnboardingParams) _then) = __$CompleteOnboardingParamsCopyWithImpl;
@override @useResult
$Res call({
 OnboardingData data, String uid, bool awaitServerAck, bool deferNotificationSetup, bool hasExistingProfile
});


@override $OnboardingDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CompleteOnboardingParamsCopyWithImpl<$Res>
    implements _$CompleteOnboardingParamsCopyWith<$Res> {
  __$CompleteOnboardingParamsCopyWithImpl(this._self, this._then);

  final _CompleteOnboardingParams _self;
  final $Res Function(_CompleteOnboardingParams) _then;

/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? uid = null,Object? awaitServerAck = null,Object? deferNotificationSetup = null,Object? hasExistingProfile = null,}) {
  return _then(_CompleteOnboardingParams(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,awaitServerAck: null == awaitServerAck ? _self.awaitServerAck : awaitServerAck // ignore: cast_nullable_to_non_nullable
as bool,deferNotificationSetup: null == deferNotificationSetup ? _self.deferNotificationSetup : deferNotificationSetup // ignore: cast_nullable_to_non_nullable
as bool,hasExistingProfile: null == hasExistingProfile ? _self.hasExistingProfile : hasExistingProfile // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CompleteOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get data {
  
  return $OnboardingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
