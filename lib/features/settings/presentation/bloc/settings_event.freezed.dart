// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _ToggledNotifications value)?  toggledNotifications,TResult Function( _SignedOut value)?  signedOut,TResult Function( _RefreshSubscription value)?  refreshSubscription,TResult Function( _OpenUrl value)?  openUrl,TResult Function( _SubmitFeedback value)?  submitFeedback,TResult Function( _ResetPassword value)?  resetPassword,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case _SignedOut() when signedOut != null:
return signedOut(_that);case _RefreshSubscription() when refreshSubscription != null:
return refreshSubscription(_that);case _OpenUrl() when openUrl != null:
return openUrl(_that);case _SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that);case _ResetPassword() when resetPassword != null:
return resetPassword(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _ToggledNotifications value)  toggledNotifications,required TResult Function( _SignedOut value)  signedOut,required TResult Function( _RefreshSubscription value)  refreshSubscription,required TResult Function( _OpenUrl value)  openUrl,required TResult Function( _SubmitFeedback value)  submitFeedback,required TResult Function( _ResetPassword value)  resetPassword,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _ToggledNotifications():
return toggledNotifications(_that);case _SignedOut():
return signedOut(_that);case _RefreshSubscription():
return refreshSubscription(_that);case _OpenUrl():
return openUrl(_that);case _SubmitFeedback():
return submitFeedback(_that);case _ResetPassword():
return resetPassword(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _ToggledNotifications value)?  toggledNotifications,TResult? Function( _SignedOut value)?  signedOut,TResult? Function( _RefreshSubscription value)?  refreshSubscription,TResult? Function( _OpenUrl value)?  openUrl,TResult? Function( _SubmitFeedback value)?  submitFeedback,TResult? Function( _ResetPassword value)?  resetPassword,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case _SignedOut() when signedOut != null:
return signedOut(_that);case _RefreshSubscription() when refreshSubscription != null:
return refreshSubscription(_that);case _OpenUrl() when openUrl != null:
return openUrl(_that);case _SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that);case _ResetPassword() when resetPassword != null:
return resetPassword(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool enable)?  toggledNotifications,TResult Function()?  signedOut,TResult Function()?  refreshSubscription,TResult Function( String url)?  openUrl,TResult Function( String message)?  submitFeedback,TResult Function()?  resetPassword,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case _SignedOut() when signedOut != null:
return signedOut();case _RefreshSubscription() when refreshSubscription != null:
return refreshSubscription();case _OpenUrl() when openUrl != null:
return openUrl(_that.url);case _SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that.message);case _ResetPassword() when resetPassword != null:
return resetPassword();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool enable)  toggledNotifications,required TResult Function()  signedOut,required TResult Function()  refreshSubscription,required TResult Function( String url)  openUrl,required TResult Function( String message)  submitFeedback,required TResult Function()  resetPassword,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _ToggledNotifications():
return toggledNotifications(_that.enable);case _SignedOut():
return signedOut();case _RefreshSubscription():
return refreshSubscription();case _OpenUrl():
return openUrl(_that.url);case _SubmitFeedback():
return submitFeedback(_that.message);case _ResetPassword():
return resetPassword();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool enable)?  toggledNotifications,TResult? Function()?  signedOut,TResult? Function()?  refreshSubscription,TResult? Function( String url)?  openUrl,TResult? Function( String message)?  submitFeedback,TResult? Function()?  resetPassword,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case _SignedOut() when signedOut != null:
return signedOut();case _RefreshSubscription() when refreshSubscription != null:
return refreshSubscription();case _OpenUrl() when openUrl != null:
return openUrl(_that.url);case _SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that.message);case _ResetPassword() when resetPassword != null:
return resetPassword();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SettingsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class _ToggledNotifications implements SettingsEvent {
  const _ToggledNotifications(this.enable);
  

 final  bool enable;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggledNotificationsCopyWith<_ToggledNotifications> get copyWith => __$ToggledNotificationsCopyWithImpl<_ToggledNotifications>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggledNotifications&&(identical(other.enable, enable) || other.enable == enable));
}


@override
int get hashCode => Object.hash(runtimeType,enable);

@override
String toString() {
  return 'SettingsEvent.toggledNotifications(enable: $enable)';
}


}

/// @nodoc
abstract mixin class _$ToggledNotificationsCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$ToggledNotificationsCopyWith(_ToggledNotifications value, $Res Function(_ToggledNotifications) _then) = __$ToggledNotificationsCopyWithImpl;
@useResult
$Res call({
 bool enable
});




}
/// @nodoc
class __$ToggledNotificationsCopyWithImpl<$Res>
    implements _$ToggledNotificationsCopyWith<$Res> {
  __$ToggledNotificationsCopyWithImpl(this._self, this._then);

  final _ToggledNotifications _self;
  final $Res Function(_ToggledNotifications) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enable = null,}) {
  return _then(_ToggledNotifications(
null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SignedOut implements SettingsEvent {
  const _SignedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.signedOut()';
}


}




/// @nodoc


class _RefreshSubscription implements SettingsEvent {
  const _RefreshSubscription();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshSubscription);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.refreshSubscription()';
}


}




/// @nodoc


class _OpenUrl implements SettingsEvent {
  const _OpenUrl(this.url);
  

 final  String url;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenUrlCopyWith<_OpenUrl> get copyWith => __$OpenUrlCopyWithImpl<_OpenUrl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenUrl&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'SettingsEvent.openUrl(url: $url)';
}


}

/// @nodoc
abstract mixin class _$OpenUrlCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$OpenUrlCopyWith(_OpenUrl value, $Res Function(_OpenUrl) _then) = __$OpenUrlCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class __$OpenUrlCopyWithImpl<$Res>
    implements _$OpenUrlCopyWith<$Res> {
  __$OpenUrlCopyWithImpl(this._self, this._then);

  final _OpenUrl _self;
  final $Res Function(_OpenUrl) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_OpenUrl(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SubmitFeedback implements SettingsEvent {
  const _SubmitFeedback(this.message);
  

 final  String message;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitFeedbackCopyWith<_SubmitFeedback> get copyWith => __$SubmitFeedbackCopyWithImpl<_SubmitFeedback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitFeedback&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SettingsEvent.submitFeedback(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SubmitFeedbackCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory _$SubmitFeedbackCopyWith(_SubmitFeedback value, $Res Function(_SubmitFeedback) _then) = __$SubmitFeedbackCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SubmitFeedbackCopyWithImpl<$Res>
    implements _$SubmitFeedbackCopyWith<$Res> {
  __$SubmitFeedbackCopyWithImpl(this._self, this._then);

  final _SubmitFeedback _self;
  final $Res Function(_SubmitFeedback) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SubmitFeedback(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetPassword implements SettingsEvent {
  const _ResetPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.resetPassword()';
}


}




// dart format on
