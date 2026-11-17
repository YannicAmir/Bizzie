// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_field_sources.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingFieldSources {

 OnboardingValueSource get name; OnboardingValueSource get sector; OnboardingValueSource get companies; OnboardingValueSource get experience; OnboardingValueSource get notifications;
/// Create a copy of OnboardingFieldSources
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<OnboardingFieldSources> get copyWith => _$OnboardingFieldSourcesCopyWithImpl<OnboardingFieldSources>(this as OnboardingFieldSources, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OnboardingFieldSources;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingFieldSources&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.sector, _this.sector) || other.sector == _this.sector)&&(identical(other.companies, _this.companies) || other.companies == _this.companies)&&(identical(other.experience, _this.experience) || other.experience == _this.experience)&&(identical(other.notifications, _this.notifications) || other.notifications == _this.notifications));
}


@override
int get hashCode {
  final _this = this as OnboardingFieldSources;
  return Object.hash(runtimeType,_this.name,_this.sector,_this.companies,_this.experience,_this.notifications);
}

@override
String toString() {
  final _this = this as OnboardingFieldSources;
  return 'OnboardingFieldSources(name: ${_this.name}, sector: ${_this.sector}, companies: ${_this.companies}, experience: ${_this.experience}, notifications: ${_this.notifications})';
}


}

/// @nodoc
abstract mixin class $OnboardingFieldSourcesCopyWith<$Res>  {
  factory $OnboardingFieldSourcesCopyWith(OnboardingFieldSources value, $Res Function(OnboardingFieldSources) _then) = _$OnboardingFieldSourcesCopyWithImpl;
@useResult
$Res call({
 OnboardingValueSource name, OnboardingValueSource sector, OnboardingValueSource companies, OnboardingValueSource experience, OnboardingValueSource notifications
});




}
/// @nodoc
class _$OnboardingFieldSourcesCopyWithImpl<$Res>
    implements $OnboardingFieldSourcesCopyWith<$Res> {
  _$OnboardingFieldSourcesCopyWithImpl(this._self, this._then);

  final OnboardingFieldSources _self;
  final $Res Function(OnboardingFieldSources) _then;

/// Create a copy of OnboardingFieldSources
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? sector = null,Object? companies = null,Object? experience = null,Object? notifications = null,}) {
  return _then(OnboardingFieldSources(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,companies: null == companies ? _self.companies : companies // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingFieldSources].
extension OnboardingFieldSourcesPatterns on OnboardingFieldSources {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingFieldSources value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingFieldSources() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingFieldSources value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingFieldSources():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingFieldSources value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingFieldSources() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingValueSource name,  OnboardingValueSource sector,  OnboardingValueSource companies,  OnboardingValueSource experience,  OnboardingValueSource notifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingFieldSources() when $default != null:
return $default(_that.name,_that.sector,_that.companies,_that.experience,_that.notifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingValueSource name,  OnboardingValueSource sector,  OnboardingValueSource companies,  OnboardingValueSource experience,  OnboardingValueSource notifications)  $default,) {final _that = this;
switch (_that) {
case _OnboardingFieldSources():
return $default(_that.name,_that.sector,_that.companies,_that.experience,_that.notifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingValueSource name,  OnboardingValueSource sector,  OnboardingValueSource companies,  OnboardingValueSource experience,  OnboardingValueSource notifications)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingFieldSources() when $default != null:
return $default(_that.name,_that.sector,_that.companies,_that.experience,_that.notifications);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingFieldSources implements OnboardingFieldSources {
  const _OnboardingFieldSources({required this.name, required this.sector, required this.companies, required this.experience, required this.notifications});
  

@override final  OnboardingValueSource name;
@override final  OnboardingValueSource sector;
@override final  OnboardingValueSource companies;
@override final  OnboardingValueSource experience;
@override final  OnboardingValueSource notifications;

/// Create a copy of OnboardingFieldSources
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingFieldSourcesCopyWith<_OnboardingFieldSources> get copyWith => __$OnboardingFieldSourcesCopyWithImpl<_OnboardingFieldSources>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingFieldSources&&(identical(other.name, name) || other.name == name)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.companies, companies) || other.companies == companies)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.notifications, notifications) || other.notifications == notifications));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,sector,companies,experience,notifications);
}

@override
String toString() {
    return 'OnboardingFieldSources(name: $name, sector: $sector, companies: $companies, experience: $experience, notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class _$OnboardingFieldSourcesCopyWith<$Res> implements $OnboardingFieldSourcesCopyWith<$Res> {
  factory _$OnboardingFieldSourcesCopyWith(_OnboardingFieldSources value, $Res Function(_OnboardingFieldSources) _then) = __$OnboardingFieldSourcesCopyWithImpl;
@override @useResult
$Res call({
 OnboardingValueSource name, OnboardingValueSource sector, OnboardingValueSource companies, OnboardingValueSource experience, OnboardingValueSource notifications
});




}
/// @nodoc
class __$OnboardingFieldSourcesCopyWithImpl<$Res>
    implements _$OnboardingFieldSourcesCopyWith<$Res> {
  __$OnboardingFieldSourcesCopyWithImpl(this._self, this._then);

  final _OnboardingFieldSources _self;
  final $Res Function(_OnboardingFieldSources) _then;

/// Create a copy of OnboardingFieldSources
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? sector = null,Object? companies = null,Object? experience = null,Object? notifications = null,}) {
  return _then(_OnboardingFieldSources(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,companies: null == companies ? _self.companies : companies // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,
  ));
}


}

// dart format on
