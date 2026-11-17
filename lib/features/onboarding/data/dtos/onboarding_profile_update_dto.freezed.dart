// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_profile_update_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingProfileUpdateDto {

 String? get name; String? get investingExperience; bool? get notificationsEnabled;
/// Create a copy of OnboardingProfileUpdateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingProfileUpdateDtoCopyWith<OnboardingProfileUpdateDto> get copyWith => _$OnboardingProfileUpdateDtoCopyWithImpl<OnboardingProfileUpdateDto>(this as OnboardingProfileUpdateDto, _$identity);

  /// Serializes this OnboardingProfileUpdateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OnboardingProfileUpdateDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingProfileUpdateDto&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.investingExperience, _this.investingExperience) || other.investingExperience == _this.investingExperience)&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OnboardingProfileUpdateDto;
  return Object.hash(runtimeType,_this.name,_this.investingExperience,_this.notificationsEnabled);
}

@override
String toString() {
  final _this = this as OnboardingProfileUpdateDto;
  return 'OnboardingProfileUpdateDto(name: ${_this.name}, investingExperience: ${_this.investingExperience}, notificationsEnabled: ${_this.notificationsEnabled})';
}


}

/// @nodoc
abstract mixin class $OnboardingProfileUpdateDtoCopyWith<$Res>  {
  factory $OnboardingProfileUpdateDtoCopyWith(OnboardingProfileUpdateDto value, $Res Function(OnboardingProfileUpdateDto) _then) = _$OnboardingProfileUpdateDtoCopyWithImpl;
@useResult
$Res call({
 String? name, String? investingExperience, bool? notificationsEnabled
});




}
/// @nodoc
class _$OnboardingProfileUpdateDtoCopyWithImpl<$Res>
    implements $OnboardingProfileUpdateDtoCopyWith<$Res> {
  _$OnboardingProfileUpdateDtoCopyWithImpl(this._self, this._then);

  final OnboardingProfileUpdateDto _self;
  final $Res Function(OnboardingProfileUpdateDto) _then;

/// Create a copy of OnboardingProfileUpdateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? investingExperience = freezed,Object? notificationsEnabled = freezed,}) {
  return _then(OnboardingProfileUpdateDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,investingExperience: freezed == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as String?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingProfileUpdateDto].
extension OnboardingProfileUpdateDtoPatterns on OnboardingProfileUpdateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingProfileUpdateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingProfileUpdateDto value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingProfileUpdateDto value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? investingExperience,  bool? notificationsEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto() when $default != null:
return $default(_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? investingExperience,  bool? notificationsEnabled)  $default,) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto():
return $default(_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? investingExperience,  bool? notificationsEnabled)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdateDto() when $default != null:
return $default(_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _OnboardingProfileUpdateDto extends OnboardingProfileUpdateDto {
  const _OnboardingProfileUpdateDto({this.name, this.investingExperience, this.notificationsEnabled}): super._();
  factory _OnboardingProfileUpdateDto.fromJson(Map<String, dynamic> json) => _$OnboardingProfileUpdateDtoFromJson(json);

@override final  String? name;
@override final  String? investingExperience;
@override final  bool? notificationsEnabled;

/// Create a copy of OnboardingProfileUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingProfileUpdateDtoCopyWith<_OnboardingProfileUpdateDto> get copyWith => __$OnboardingProfileUpdateDtoCopyWithImpl<_OnboardingProfileUpdateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingProfileUpdateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingProfileUpdateDto&&(identical(other.name, name) || other.name == name)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,investingExperience,notificationsEnabled);
}

@override
String toString() {
    return 'OnboardingProfileUpdateDto(name: $name, investingExperience: $investingExperience, notificationsEnabled: $notificationsEnabled)';
}


}

/// @nodoc
abstract mixin class _$OnboardingProfileUpdateDtoCopyWith<$Res> implements $OnboardingProfileUpdateDtoCopyWith<$Res> {
  factory _$OnboardingProfileUpdateDtoCopyWith(_OnboardingProfileUpdateDto value, $Res Function(_OnboardingProfileUpdateDto) _then) = __$OnboardingProfileUpdateDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? investingExperience, bool? notificationsEnabled
});




}
/// @nodoc
class __$OnboardingProfileUpdateDtoCopyWithImpl<$Res>
    implements _$OnboardingProfileUpdateDtoCopyWith<$Res> {
  __$OnboardingProfileUpdateDtoCopyWithImpl(this._self, this._then);

  final _OnboardingProfileUpdateDto _self;
  final $Res Function(_OnboardingProfileUpdateDto) _then;

/// Create a copy of OnboardingProfileUpdateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? investingExperience = freezed,Object? notificationsEnabled = freezed,}) {
  return _then(_OnboardingProfileUpdateDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,investingExperience: freezed == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as String?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
