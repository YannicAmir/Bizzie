// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( ToggledNotifications value)?  toggledNotifications,TResult Function( SignedOut value)?  signedOut,TResult Function( GuestLogoutPromptResolved value)?  guestLogoutPromptResolved,TResult Function( OpenUrl value)?  openUrl,TResult Function( OpenedSettings value)?  openedSettings,TResult Function( PermissionPromptProcessed value)?  permissionPromptProcessed,TResult Function( EditProfileClicked value)?  editProfileClicked,TResult Function( FeedbackClicked value)?  feedbackClicked,TResult Function( MembershipClicked value)?  membershipClicked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case GuestLogoutPromptResolved() when guestLogoutPromptResolved != null:
return guestLogoutPromptResolved(_that);case OpenUrl() when openUrl != null:
return openUrl(_that);case OpenedSettings() when openedSettings != null:
return openedSettings(_that);case PermissionPromptProcessed() when permissionPromptProcessed != null:
return permissionPromptProcessed(_that);case EditProfileClicked() when editProfileClicked != null:
return editProfileClicked(_that);case FeedbackClicked() when feedbackClicked != null:
return feedbackClicked(_that);case MembershipClicked() when membershipClicked != null:
return membershipClicked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( ToggledNotifications value)  toggledNotifications,required TResult Function( SignedOut value)  signedOut,required TResult Function( GuestLogoutPromptResolved value)  guestLogoutPromptResolved,required TResult Function( OpenUrl value)  openUrl,required TResult Function( OpenedSettings value)  openedSettings,required TResult Function( PermissionPromptProcessed value)  permissionPromptProcessed,required TResult Function( EditProfileClicked value)  editProfileClicked,required TResult Function( FeedbackClicked value)  feedbackClicked,required TResult Function( MembershipClicked value)  membershipClicked,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case ToggledNotifications():
return toggledNotifications(_that);case SignedOut():
return signedOut(_that);case GuestLogoutPromptResolved():
return guestLogoutPromptResolved(_that);case OpenUrl():
return openUrl(_that);case OpenedSettings():
return openedSettings(_that);case PermissionPromptProcessed():
return permissionPromptProcessed(_that);case EditProfileClicked():
return editProfileClicked(_that);case FeedbackClicked():
return feedbackClicked(_that);case MembershipClicked():
return membershipClicked(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( ToggledNotifications value)?  toggledNotifications,TResult? Function( SignedOut value)?  signedOut,TResult? Function( GuestLogoutPromptResolved value)?  guestLogoutPromptResolved,TResult? Function( OpenUrl value)?  openUrl,TResult? Function( OpenedSettings value)?  openedSettings,TResult? Function( PermissionPromptProcessed value)?  permissionPromptProcessed,TResult? Function( EditProfileClicked value)?  editProfileClicked,TResult? Function( FeedbackClicked value)?  feedbackClicked,TResult? Function( MembershipClicked value)?  membershipClicked,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that);case SignedOut() when signedOut != null:
return signedOut(_that);case GuestLogoutPromptResolved() when guestLogoutPromptResolved != null:
return guestLogoutPromptResolved(_that);case OpenUrl() when openUrl != null:
return openUrl(_that);case OpenedSettings() when openedSettings != null:
return openedSettings(_that);case PermissionPromptProcessed() when permissionPromptProcessed != null:
return permissionPromptProcessed(_that);case EditProfileClicked() when editProfileClicked != null:
return editProfileClicked(_that);case FeedbackClicked() when feedbackClicked != null:
return feedbackClicked(_that);case MembershipClicked() when membershipClicked != null:
return membershipClicked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool enable)?  toggledNotifications,TResult Function()?  signedOut,TResult Function( GuestLogoutChoice choice)?  guestLogoutPromptResolved,TResult Function( String url,  SettingsLinkType type)?  openUrl,TResult Function()?  openedSettings,TResult Function()?  permissionPromptProcessed,TResult Function()?  editProfileClicked,TResult Function()?  feedbackClicked,TResult Function( bool isSubscribed)?  membershipClicked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case SignedOut() when signedOut != null:
return signedOut();case GuestLogoutPromptResolved() when guestLogoutPromptResolved != null:
return guestLogoutPromptResolved(_that.choice);case OpenUrl() when openUrl != null:
return openUrl(_that.url,_that.type);case OpenedSettings() when openedSettings != null:
return openedSettings();case PermissionPromptProcessed() when permissionPromptProcessed != null:
return permissionPromptProcessed();case EditProfileClicked() when editProfileClicked != null:
return editProfileClicked();case FeedbackClicked() when feedbackClicked != null:
return feedbackClicked();case MembershipClicked() when membershipClicked != null:
return membershipClicked(_that.isSubscribed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool enable)  toggledNotifications,required TResult Function()  signedOut,required TResult Function( GuestLogoutChoice choice)  guestLogoutPromptResolved,required TResult Function( String url,  SettingsLinkType type)  openUrl,required TResult Function()  openedSettings,required TResult Function()  permissionPromptProcessed,required TResult Function()  editProfileClicked,required TResult Function()  feedbackClicked,required TResult Function( bool isSubscribed)  membershipClicked,}) {final _that = this;
switch (_that) {
case Started():
return started();case ToggledNotifications():
return toggledNotifications(_that.enable);case SignedOut():
return signedOut();case GuestLogoutPromptResolved():
return guestLogoutPromptResolved(_that.choice);case OpenUrl():
return openUrl(_that.url,_that.type);case OpenedSettings():
return openedSettings();case PermissionPromptProcessed():
return permissionPromptProcessed();case EditProfileClicked():
return editProfileClicked();case FeedbackClicked():
return feedbackClicked();case MembershipClicked():
return membershipClicked(_that.isSubscribed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool enable)?  toggledNotifications,TResult? Function()?  signedOut,TResult? Function( GuestLogoutChoice choice)?  guestLogoutPromptResolved,TResult? Function( String url,  SettingsLinkType type)?  openUrl,TResult? Function()?  openedSettings,TResult? Function()?  permissionPromptProcessed,TResult? Function()?  editProfileClicked,TResult? Function()?  feedbackClicked,TResult? Function( bool isSubscribed)?  membershipClicked,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case ToggledNotifications() when toggledNotifications != null:
return toggledNotifications(_that.enable);case SignedOut() when signedOut != null:
return signedOut();case GuestLogoutPromptResolved() when guestLogoutPromptResolved != null:
return guestLogoutPromptResolved(_that.choice);case OpenUrl() when openUrl != null:
return openUrl(_that.url,_that.type);case OpenedSettings() when openedSettings != null:
return openedSettings();case PermissionPromptProcessed() when permissionPromptProcessed != null:
return permissionPromptProcessed();case EditProfileClicked() when editProfileClicked != null:
return editProfileClicked();case FeedbackClicked() when feedbackClicked != null:
return feedbackClicked();case MembershipClicked() when membershipClicked != null:
return membershipClicked(_that.isSubscribed);case _:
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
  const ToggledNotifications({required this.enable});
  

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
int get hashCode {
    return Object.hash(runtimeType,enable);
}

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
enable: null == enable ? _self.enable : enable // ignore: cast_nullable_to_non_nullable
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


class GuestLogoutPromptResolved implements SettingsEvent {
  const GuestLogoutPromptResolved(this.choice);
  

 final  GuestLogoutChoice choice;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestLogoutPromptResolvedCopyWith<GuestLogoutPromptResolved> get copyWith => _$GuestLogoutPromptResolvedCopyWithImpl<GuestLogoutPromptResolved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestLogoutPromptResolved&&(identical(other.choice, choice) || other.choice == choice));
}


@override
int get hashCode {
    return Object.hash(runtimeType,choice);
}

@override
String toString() {
    return 'SettingsEvent.guestLogoutPromptResolved(choice: $choice)';
}


}

/// @nodoc
abstract mixin class $GuestLogoutPromptResolvedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $GuestLogoutPromptResolvedCopyWith(GuestLogoutPromptResolved value, $Res Function(GuestLogoutPromptResolved) _then) = _$GuestLogoutPromptResolvedCopyWithImpl;
@useResult
$Res call({
 GuestLogoutChoice choice
});




}
/// @nodoc
class _$GuestLogoutPromptResolvedCopyWithImpl<$Res>
    implements $GuestLogoutPromptResolvedCopyWith<$Res> {
  _$GuestLogoutPromptResolvedCopyWithImpl(this._self, this._then);

  final GuestLogoutPromptResolved _self;
  final $Res Function(GuestLogoutPromptResolved) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? choice = null,}) {
  return _then(GuestLogoutPromptResolved(
null == choice ? _self.choice : choice // ignore: cast_nullable_to_non_nullable
as GuestLogoutChoice,
  ));
}


}

/// @nodoc


class OpenUrl implements SettingsEvent {
  const OpenUrl(this.url, this.type);
  

 final  String url;
 final  SettingsLinkType type;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenUrlCopyWith<OpenUrl> get copyWith => _$OpenUrlCopyWithImpl<OpenUrl>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenUrl&&(identical(other.url, url) || other.url == url)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode {
    return Object.hash(runtimeType,url,type);
}

@override
String toString() {
    return 'SettingsEvent.openUrl(url: $url, type: $type)';
}


}

/// @nodoc
abstract mixin class $OpenUrlCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $OpenUrlCopyWith(OpenUrl value, $Res Function(OpenUrl) _then) = _$OpenUrlCopyWithImpl;
@useResult
$Res call({
 String url, SettingsLinkType type
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
@pragma('vm:prefer-inline') $Res call({Object? url = null,Object? type = null,}) {
  return _then(OpenUrl(
null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SettingsLinkType,
  ));
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




/// @nodoc


class PermissionPromptProcessed implements SettingsEvent {
  const PermissionPromptProcessed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionPromptProcessed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SettingsEvent.permissionPromptProcessed()';
}


}




/// @nodoc


class EditProfileClicked implements SettingsEvent {
  const EditProfileClicked();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileClicked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SettingsEvent.editProfileClicked()';
}


}




/// @nodoc


class FeedbackClicked implements SettingsEvent {
  const FeedbackClicked();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackClicked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SettingsEvent.feedbackClicked()';
}


}




/// @nodoc


class MembershipClicked implements SettingsEvent {
  const MembershipClicked({required this.isSubscribed});
  

 final  bool isSubscribed;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipClickedCopyWith<MembershipClicked> get copyWith => _$MembershipClickedCopyWithImpl<MembershipClicked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipClicked&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isSubscribed);
}

@override
String toString() {
    return 'SettingsEvent.membershipClicked(isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class $MembershipClickedCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $MembershipClickedCopyWith(MembershipClicked value, $Res Function(MembershipClicked) _then) = _$MembershipClickedCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed
});




}
/// @nodoc
class _$MembershipClickedCopyWithImpl<$Res>
    implements $MembershipClickedCopyWith<$Res> {
  _$MembershipClickedCopyWithImpl(this._self, this._then);

  final MembershipClicked _self;
  final $Res Function(MembershipClicked) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,}) {
  return _then(MembershipClicked(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
