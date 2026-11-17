// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_profile_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingProfileUpdate {

 String get uid; String? get name; InvestingExperience? get investingExperience; bool? get notificationsEnabled;
/// Create a copy of OnboardingProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingProfileUpdateCopyWith<OnboardingProfileUpdate> get copyWith => _$OnboardingProfileUpdateCopyWithImpl<OnboardingProfileUpdate>(this as OnboardingProfileUpdate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OnboardingProfileUpdate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingProfileUpdate&&(identical(other.uid, _this.uid) || other.uid == _this.uid)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.investingExperience, _this.investingExperience) || other.investingExperience == _this.investingExperience)&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled));
}


@override
int get hashCode {
  final _this = this as OnboardingProfileUpdate;
  return Object.hash(runtimeType,_this.uid,_this.name,_this.investingExperience,_this.notificationsEnabled);
}

@override
String toString() {
  final _this = this as OnboardingProfileUpdate;
  return 'OnboardingProfileUpdate(uid: ${_this.uid}, name: ${_this.name}, investingExperience: ${_this.investingExperience}, notificationsEnabled: ${_this.notificationsEnabled})';
}


}

/// @nodoc
abstract mixin class $OnboardingProfileUpdateCopyWith<$Res>  {
  factory $OnboardingProfileUpdateCopyWith(OnboardingProfileUpdate value, $Res Function(OnboardingProfileUpdate) _then) = _$OnboardingProfileUpdateCopyWithImpl;
@useResult
$Res call({
 String uid, String? name, InvestingExperience? investingExperience, bool? notificationsEnabled
});




}
/// @nodoc
class _$OnboardingProfileUpdateCopyWithImpl<$Res>
    implements $OnboardingProfileUpdateCopyWith<$Res> {
  _$OnboardingProfileUpdateCopyWithImpl(this._self, this._then);

  final OnboardingProfileUpdate _self;
  final $Res Function(OnboardingProfileUpdate) _then;

/// Create a copy of OnboardingProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? name = freezed,Object? investingExperience = freezed,Object? notificationsEnabled = freezed,}) {
  return _then(OnboardingProfileUpdate(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,investingExperience: freezed == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingProfileUpdate].
extension OnboardingProfileUpdatePatterns on OnboardingProfileUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingProfileUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingProfileUpdate value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingProfileUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingProfileUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String? name,  InvestingExperience? investingExperience,  bool? notificationsEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdate() when $default != null:
return $default(_that.uid,_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String? name,  InvestingExperience? investingExperience,  bool? notificationsEnabled)  $default,) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdate():
return $default(_that.uid,_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String? name,  InvestingExperience? investingExperience,  bool? notificationsEnabled)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingProfileUpdate() when $default != null:
return $default(_that.uid,_that.name,_that.investingExperience,_that.notificationsEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingProfileUpdate implements OnboardingProfileUpdate {
  const _OnboardingProfileUpdate({required this.uid, this.name, this.investingExperience, this.notificationsEnabled});
  

@override final  String uid;
@override final  String? name;
@override final  InvestingExperience? investingExperience;
@override final  bool? notificationsEnabled;

/// Create a copy of OnboardingProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingProfileUpdateCopyWith<_OnboardingProfileUpdate> get copyWith => __$OnboardingProfileUpdateCopyWithImpl<_OnboardingProfileUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingProfileUpdate&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.name, name) || other.name == name)&&(identical(other.investingExperience, investingExperience) || other.investingExperience == investingExperience)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,uid,name,investingExperience,notificationsEnabled);
}

@override
String toString() {
    return 'OnboardingProfileUpdate(uid: $uid, name: $name, investingExperience: $investingExperience, notificationsEnabled: $notificationsEnabled)';
}


}

/// @nodoc
abstract mixin class _$OnboardingProfileUpdateCopyWith<$Res> implements $OnboardingProfileUpdateCopyWith<$Res> {
  factory _$OnboardingProfileUpdateCopyWith(_OnboardingProfileUpdate value, $Res Function(_OnboardingProfileUpdate) _then) = __$OnboardingProfileUpdateCopyWithImpl;
@override @useResult
$Res call({
 String uid, String? name, InvestingExperience? investingExperience, bool? notificationsEnabled
});




}
/// @nodoc
class __$OnboardingProfileUpdateCopyWithImpl<$Res>
    implements _$OnboardingProfileUpdateCopyWith<$Res> {
  __$OnboardingProfileUpdateCopyWithImpl(this._self, this._then);

  final _OnboardingProfileUpdate _self;
  final $Res Function(_OnboardingProfileUpdate) _then;

/// Create a copy of OnboardingProfileUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? name = freezed,Object? investingExperience = freezed,Object? notificationsEnabled = freezed,}) {
  return _then(_OnboardingProfileUpdate(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,investingExperience: freezed == investingExperience ? _self.investingExperience : investingExperience // ignore: cast_nullable_to_non_nullable
as InvestingExperience?,notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
