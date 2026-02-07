// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_display_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsDisplayData {

 UserModel get user; SubscriptionStatus get subscriptionStatus; bool get isAppNotificationsEnabled; bool get isSystemNotificationsEnabled; String get appVersion;
/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDisplayDataCopyWith<SettingsDisplayData> get copyWith => _$SettingsDisplayDataCopyWithImpl<SettingsDisplayData>(this as SettingsDisplayData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsDisplayData&&(identical(other.user, user) || other.user == user)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.isAppNotificationsEnabled, isAppNotificationsEnabled) || other.isAppNotificationsEnabled == isAppNotificationsEnabled)&&(identical(other.isSystemNotificationsEnabled, isSystemNotificationsEnabled) || other.isSystemNotificationsEnabled == isSystemNotificationsEnabled)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,user,subscriptionStatus,isAppNotificationsEnabled,isSystemNotificationsEnabled,appVersion);

@override
String toString() {
  return 'SettingsDisplayData(user: $user, subscriptionStatus: $subscriptionStatus, isAppNotificationsEnabled: $isAppNotificationsEnabled, isSystemNotificationsEnabled: $isSystemNotificationsEnabled, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $SettingsDisplayDataCopyWith<$Res>  {
  factory $SettingsDisplayDataCopyWith(SettingsDisplayData value, $Res Function(SettingsDisplayData) _then) = _$SettingsDisplayDataCopyWithImpl;
@useResult
$Res call({
 UserModel user, SubscriptionStatus subscriptionStatus, bool isAppNotificationsEnabled, bool isSystemNotificationsEnabled, String appVersion
});


$UserModelCopyWith<$Res> get user;$SubscriptionStatusCopyWith<$Res> get subscriptionStatus;

}
/// @nodoc
class _$SettingsDisplayDataCopyWithImpl<$Res>
    implements $SettingsDisplayDataCopyWith<$Res> {
  _$SettingsDisplayDataCopyWithImpl(this._self, this._then);

  final SettingsDisplayData _self;
  final $Res Function(SettingsDisplayData) _then;

/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? subscriptionStatus = null,Object? isAppNotificationsEnabled = null,Object? isSystemNotificationsEnabled = null,Object? appVersion = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,subscriptionStatus: null == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isAppNotificationsEnabled: null == isAppNotificationsEnabled ? _self.isAppNotificationsEnabled : isAppNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSystemNotificationsEnabled: null == isSystemNotificationsEnabled ? _self.isSystemNotificationsEnabled : isSystemNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get subscriptionStatus {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.subscriptionStatus, (value) {
    return _then(_self.copyWith(subscriptionStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsDisplayData].
extension SettingsDisplayDataPatterns on SettingsDisplayData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsDisplayData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsDisplayData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsDisplayData value)  $default,){
final _that = this;
switch (_that) {
case _SettingsDisplayData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsDisplayData value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsDisplayData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserModel user,  SubscriptionStatus subscriptionStatus,  bool isAppNotificationsEnabled,  bool isSystemNotificationsEnabled,  String appVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsDisplayData() when $default != null:
return $default(_that.user,_that.subscriptionStatus,_that.isAppNotificationsEnabled,_that.isSystemNotificationsEnabled,_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserModel user,  SubscriptionStatus subscriptionStatus,  bool isAppNotificationsEnabled,  bool isSystemNotificationsEnabled,  String appVersion)  $default,) {final _that = this;
switch (_that) {
case _SettingsDisplayData():
return $default(_that.user,_that.subscriptionStatus,_that.isAppNotificationsEnabled,_that.isSystemNotificationsEnabled,_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserModel user,  SubscriptionStatus subscriptionStatus,  bool isAppNotificationsEnabled,  bool isSystemNotificationsEnabled,  String appVersion)?  $default,) {final _that = this;
switch (_that) {
case _SettingsDisplayData() when $default != null:
return $default(_that.user,_that.subscriptionStatus,_that.isAppNotificationsEnabled,_that.isSystemNotificationsEnabled,_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsDisplayData implements SettingsDisplayData {
  const _SettingsDisplayData({required this.user, required this.subscriptionStatus, required this.isAppNotificationsEnabled, required this.isSystemNotificationsEnabled, required this.appVersion});
  

@override final  UserModel user;
@override final  SubscriptionStatus subscriptionStatus;
@override final  bool isAppNotificationsEnabled;
@override final  bool isSystemNotificationsEnabled;
@override final  String appVersion;

/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDisplayDataCopyWith<_SettingsDisplayData> get copyWith => __$SettingsDisplayDataCopyWithImpl<_SettingsDisplayData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsDisplayData&&(identical(other.user, user) || other.user == user)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.isAppNotificationsEnabled, isAppNotificationsEnabled) || other.isAppNotificationsEnabled == isAppNotificationsEnabled)&&(identical(other.isSystemNotificationsEnabled, isSystemNotificationsEnabled) || other.isSystemNotificationsEnabled == isSystemNotificationsEnabled)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}


@override
int get hashCode => Object.hash(runtimeType,user,subscriptionStatus,isAppNotificationsEnabled,isSystemNotificationsEnabled,appVersion);

@override
String toString() {
  return 'SettingsDisplayData(user: $user, subscriptionStatus: $subscriptionStatus, isAppNotificationsEnabled: $isAppNotificationsEnabled, isSystemNotificationsEnabled: $isSystemNotificationsEnabled, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$SettingsDisplayDataCopyWith<$Res> implements $SettingsDisplayDataCopyWith<$Res> {
  factory _$SettingsDisplayDataCopyWith(_SettingsDisplayData value, $Res Function(_SettingsDisplayData) _then) = __$SettingsDisplayDataCopyWithImpl;
@override @useResult
$Res call({
 UserModel user, SubscriptionStatus subscriptionStatus, bool isAppNotificationsEnabled, bool isSystemNotificationsEnabled, String appVersion
});


@override $UserModelCopyWith<$Res> get user;@override $SubscriptionStatusCopyWith<$Res> get subscriptionStatus;

}
/// @nodoc
class __$SettingsDisplayDataCopyWithImpl<$Res>
    implements _$SettingsDisplayDataCopyWith<$Res> {
  __$SettingsDisplayDataCopyWithImpl(this._self, this._then);

  final _SettingsDisplayData _self;
  final $Res Function(_SettingsDisplayData) _then;

/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? subscriptionStatus = null,Object? isAppNotificationsEnabled = null,Object? isSystemNotificationsEnabled = null,Object? appVersion = null,}) {
  return _then(_SettingsDisplayData(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,subscriptionStatus: null == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isAppNotificationsEnabled: null == isAppNotificationsEnabled ? _self.isAppNotificationsEnabled : isAppNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSystemNotificationsEnabled: null == isSystemNotificationsEnabled ? _self.isSystemNotificationsEnabled : isSystemNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of SettingsDisplayData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get subscriptionStatus {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.subscriptionStatus, (value) {
    return _then(_self.copyWith(subscriptionStatus: value));
  });
}
}

// dart format on
