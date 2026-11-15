// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_onboarding_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SkipOnboardingParams {

 OnboardingData get data; bool get hasExistingProfile;
/// Create a copy of SkipOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkipOnboardingParamsCopyWith<SkipOnboardingParams> get copyWith => _$SkipOnboardingParamsCopyWithImpl<SkipOnboardingParams>(this as SkipOnboardingParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkipOnboardingParams&&(identical(other.data, data) || other.data == data)&&(identical(other.hasExistingProfile, hasExistingProfile) || other.hasExistingProfile == hasExistingProfile));
}


@override
int get hashCode => Object.hash(runtimeType,data,hasExistingProfile);

@override
String toString() {
  return 'SkipOnboardingParams(data: $data, hasExistingProfile: $hasExistingProfile)';
}


}

/// @nodoc
abstract mixin class $SkipOnboardingParamsCopyWith<$Res>  {
  factory $SkipOnboardingParamsCopyWith(SkipOnboardingParams value, $Res Function(SkipOnboardingParams) _then) = _$SkipOnboardingParamsCopyWithImpl;
@useResult
$Res call({
 OnboardingData data, bool hasExistingProfile
});


$OnboardingDataCopyWith<$Res> get data;

}
/// @nodoc
class _$SkipOnboardingParamsCopyWithImpl<$Res>
    implements $SkipOnboardingParamsCopyWith<$Res> {
  _$SkipOnboardingParamsCopyWithImpl(this._self, this._then);

  final SkipOnboardingParams _self;
  final $Res Function(SkipOnboardingParams) _then;

/// Create a copy of SkipOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? hasExistingProfile = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,hasExistingProfile: null == hasExistingProfile ? _self.hasExistingProfile : hasExistingProfile // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SkipOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get data {
  
  return $OnboardingDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SkipOnboardingParams].
extension SkipOnboardingParamsPatterns on SkipOnboardingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkipOnboardingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkipOnboardingParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkipOnboardingParams value)  $default,){
final _that = this;
switch (_that) {
case _SkipOnboardingParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkipOnboardingParams value)?  $default,){
final _that = this;
switch (_that) {
case _SkipOnboardingParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingData data,  bool hasExistingProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkipOnboardingParams() when $default != null:
return $default(_that.data,_that.hasExistingProfile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingData data,  bool hasExistingProfile)  $default,) {final _that = this;
switch (_that) {
case _SkipOnboardingParams():
return $default(_that.data,_that.hasExistingProfile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingData data,  bool hasExistingProfile)?  $default,) {final _that = this;
switch (_that) {
case _SkipOnboardingParams() when $default != null:
return $default(_that.data,_that.hasExistingProfile);case _:
  return null;

}
}

}

/// @nodoc


class _SkipOnboardingParams implements SkipOnboardingParams {
  const _SkipOnboardingParams({required this.data, this.hasExistingProfile = false});
  

@override final  OnboardingData data;
@override@JsonKey() final  bool hasExistingProfile;

/// Create a copy of SkipOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkipOnboardingParamsCopyWith<_SkipOnboardingParams> get copyWith => __$SkipOnboardingParamsCopyWithImpl<_SkipOnboardingParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkipOnboardingParams&&(identical(other.data, data) || other.data == data)&&(identical(other.hasExistingProfile, hasExistingProfile) || other.hasExistingProfile == hasExistingProfile));
}


@override
int get hashCode => Object.hash(runtimeType,data,hasExistingProfile);

@override
String toString() {
  return 'SkipOnboardingParams(data: $data, hasExistingProfile: $hasExistingProfile)';
}


}

/// @nodoc
abstract mixin class _$SkipOnboardingParamsCopyWith<$Res> implements $SkipOnboardingParamsCopyWith<$Res> {
  factory _$SkipOnboardingParamsCopyWith(_SkipOnboardingParams value, $Res Function(_SkipOnboardingParams) _then) = __$SkipOnboardingParamsCopyWithImpl;
@override @useResult
$Res call({
 OnboardingData data, bool hasExistingProfile
});


@override $OnboardingDataCopyWith<$Res> get data;

}
/// @nodoc
class __$SkipOnboardingParamsCopyWithImpl<$Res>
    implements _$SkipOnboardingParamsCopyWith<$Res> {
  __$SkipOnboardingParamsCopyWithImpl(this._self, this._then);

  final _SkipOnboardingParams _self;
  final $Res Function(_SkipOnboardingParams) _then;

/// Create a copy of SkipOnboardingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? hasExistingProfile = null,}) {
  return _then(_SkipOnboardingParams(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData,hasExistingProfile: null == hasExistingProfile ? _self.hasExistingProfile : hasExistingProfile // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SkipOnboardingParams
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
