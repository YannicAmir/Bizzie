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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( ToggledNotifications value)?  toggledNotifications,TResult Function( SignedOut value)?  signedOut,TResult Function( RefreshSubscription value)?  refreshSubscription,TResult Function( OpenUrl value)?  openUrl,TResult Function( SubmitFeedback value)?  submitFeedback,TResult Function( ResetPassword value)?  resetPassword,TResult Function( OpenedSettings value)?  openedSettings,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case RefreshSubscription() when refreshSubscription != null:
return refreshSubscription(_that);case OpenUrl() when openUrl != null:
return openUrl(_that);case SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that);case ResetPassword() when resetPassword != null:
return resetPassword(_that);case OpenedSettings() when openedSettings != null:
return openedSettings(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( ToggledNotifications value)  toggledNotifications,required TResult Function( SignedOut value)  signedOut,required TResult Function( RefreshSubscription value)  refreshSubscription,required TResult Function( OpenUrl value)  openUrl,required TResult Function( SubmitFeedback value)  submitFeedback,required TResult Function( ResetPassword value)  resetPassword,required TResult Function( OpenedSettings value)  openedSettings,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case ToggledNotifications():
return toggledNotifications(_that);case SignedOut():
return signedOut(_that);case RefreshSubscription():
return refreshSubscription(_that);case OpenUrl():
return openUrl(_that);case SubmitFeedback():
return submitFeedback(_that);case ResetPassword():
return resetPassword(_that);case OpenedSettings():
return openedSettings(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( ToggledNotifications value)?  toggledNotifications,TResult? Function( SignedOut value)?  signedOut,TResult? Function( RefreshSubscription value)?  refreshSubscription,TResult? Function( OpenUrl value)?  openUrl,TResult? Function( SubmitFeedback value)?  submitFeedback,TResult? Function( ResetPassword value)?  resetPassword,TResult? Function( OpenedSettings value)?  openedSettings,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case RefreshSubscription() when refreshSubscription != null:
return refreshSubscription(_that);case OpenUrl() when openUrl != null:
return openUrl(_that);case SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that);case ResetPassword() when resetPassword != null:
return resetPassword(_that);case OpenedSettings() when openedSettings != null:
return openedSettings(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool enable)?  toggledNotifications,TResult Function()?  signedOut,TResult Function()?  refreshSubscription,TResult Function( String url)?  openUrl,TResult Function( String message)?  submitFeedback,TResult Function()?  resetPassword,TResult Function()?  openedSettings,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case SignedOut() when signedOut != null:
return signedOut();case RefreshSubscription() when refreshSubscription != null:
return refreshSubscription();case OpenUrl() when openUrl != null:
return openUrl(_that.url);case SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that.message);case ResetPassword() when resetPassword != null:
return resetPassword();case OpenedSettings() when openedSettings != null:
return openedSettings();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool enable)  toggledNotifications,required TResult Function()  signedOut,required TResult Function()  refreshSubscription,required TResult Function( String url)  openUrl,required TResult Function( String message)  submitFeedback,required TResult Function()  resetPassword,required TResult Function()  openedSettings,}) {final _that = this;
switch (_that) {
case Started():
return started();case ToggledNotifications():
return toggledNotifications(_that.enable);case SignedOut():
return signedOut();case RefreshSubscription():
return refreshSubscription();case OpenUrl():
return openUrl(_that.url);case SubmitFeedback():
return submitFeedback(_that.message);case ResetPassword():
return resetPassword();case OpenedSettings():
return openedSettings();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool enable)?  toggledNotifications,TResult? Function()?  signedOut,TResult? Function()?  refreshSubscription,TResult? Function( String url)?  openUrl,TResult? Function( String message)?  submitFeedback,TResult? Function()?  resetPassword,TResult? Function()?  openedSettings,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case SignedOut() when signedOut != null:
return signedOut();case RefreshSubscription() when refreshSubscription != null:
return refreshSubscription();case OpenUrl() when openUrl != null:
return openUrl(_that.url);case SubmitFeedback() when submitFeedback != null:
return submitFeedback(_that.message);case ResetPassword() when resetPassword != null:
return resetPassword();case OpenedSettings() when openedSettings != null:
return openedSettings();case _:
  return null;

}
}

}

/// @nodoc


class Started implements SettingsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class ToggledNotifications implements SettingsEvent {
  const ToggledNotifications(this.enable);
  

 final  bool enable;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggledNotificationsCopyWith<ToggledNotifications> get copyWith => _$ToggledNotificationsCopyWithImpl<ToggledNotifications>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggledNotifications&&(identical(other.enable, enable) || other.enable == enable));
}


@override
int get hashCode => Object.hash(runtimeType,enable);

@override
String toString() {
  return 'SettingsEvent.toggledNotifications(enable: $enable)';
}


}

/// @nodoc
abstract mixin class $ToggledNotificationsCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $ToggledNotificationsCopyWith(ToggledNotifications value, $Res Function(ToggledNotifications) _then) = _$ToggledNotificationsCopyWithImpl;
@useResult
$Res call({
 bool enable
});




}
/// @nodoc
class _$ToggledNotificationsCopyWithImpl<$Res>
    implements $ToggledNotificationsCopyWith<$Res> {
  _$ToggledNotificationsCopyWithImpl(this._self, this._then);

  final ToggledNotifications _self;
  final $Res Function(ToggledNotifications) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enable = null,}) {
  return _then(ToggledNotifications(
null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SignedOut implements SettingsEvent {
  const SignedOut();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignedOut);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.signedOut()';
}


}




/// @nodoc


class RefreshSubscription implements SettingsEvent {
  const RefreshSubscription();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshSubscription);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.refreshSubscription()';
}


}




/// @nodoc


class OpenUrl implements SettingsEvent {
  const OpenUrl(this.url);
  

 final  String url;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenUrlCopyWith<OpenUrl> get copyWith => _$OpenUrlCopyWithImpl<OpenUrl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenUrl&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'SettingsEvent.openUrl(url: $url)';
}


}

/// @nodoc
abstract mixin class $OpenUrlCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $OpenUrlCopyWith(OpenUrl value, $Res Function(OpenUrl) _then) = _$OpenUrlCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$OpenUrlCopyWithImpl<$Res>
    implements $OpenUrlCopyWith<$Res> {
  _$OpenUrlCopyWithImpl(this._self, this._then);

  final OpenUrl _self;
  final $Res Function(OpenUrl) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(OpenUrl(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SubmitFeedback implements SettingsEvent {
  const SubmitFeedback(this.message);
  

 final  String message;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitFeedbackCopyWith<SubmitFeedback> get copyWith => _$SubmitFeedbackCopyWithImpl<SubmitFeedback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitFeedback&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SettingsEvent.submitFeedback(message: $message)';
}


}

/// @nodoc
abstract mixin class $SubmitFeedbackCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $SubmitFeedbackCopyWith(SubmitFeedback value, $Res Function(SubmitFeedback) _then) = _$SubmitFeedbackCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SubmitFeedbackCopyWithImpl<$Res>
    implements $SubmitFeedbackCopyWith<$Res> {
  _$SubmitFeedbackCopyWithImpl(this._self, this._then);

  final SubmitFeedback _self;
  final $Res Function(SubmitFeedback) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SubmitFeedback(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPassword implements SettingsEvent {
  const ResetPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.resetPassword()';
}


}




/// @nodoc


class OpenedSettings implements SettingsEvent {
  const OpenedSettings();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenedSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.openedSettings()';
}


}




// dart format on
