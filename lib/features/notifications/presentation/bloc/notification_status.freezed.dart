// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationStatus()';
}


}

/// @nodoc
class $NotificationStatusCopyWith<$Res>  {
$NotificationStatusCopyWith(NotificationStatus _, $Res Function(NotificationStatus) __);
}


/// Adds pattern-matching-related methods to [NotificationStatus].
extension NotificationStatusPatterns on NotificationStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationStatusInitial value)?  initial,TResult Function( NotificationStatusLoading value)?  loading,TResult Function( NotificationStatusSuccess value)?  success,TResult Function( NotificationStatusFailure value)?  failure,TResult Function( NotificationStatusMessageReceived value)?  messageReceived,TResult Function( NotificationStatusNavigationRequested value)?  navigationRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationStatusInitial() when initial != null:
return initial(_that);case NotificationStatusLoading() when loading != null:
return loading(_that);case NotificationStatusSuccess() when success != null:
return success(_that);case NotificationStatusFailure() when failure != null:
return failure(_that);case NotificationStatusMessageReceived() when messageReceived != null:
return messageReceived(_that);case NotificationStatusNavigationRequested() when navigationRequested != null:
return navigationRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationStatusInitial value)  initial,required TResult Function( NotificationStatusLoading value)  loading,required TResult Function( NotificationStatusSuccess value)  success,required TResult Function( NotificationStatusFailure value)  failure,required TResult Function( NotificationStatusMessageReceived value)  messageReceived,required TResult Function( NotificationStatusNavigationRequested value)  navigationRequested,}){
final _that = this;
switch (_that) {
case NotificationStatusInitial():
return initial(_that);case NotificationStatusLoading():
return loading(_that);case NotificationStatusSuccess():
return success(_that);case NotificationStatusFailure():
return failure(_that);case NotificationStatusMessageReceived():
return messageReceived(_that);case NotificationStatusNavigationRequested():
return navigationRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationStatusInitial value)?  initial,TResult? Function( NotificationStatusLoading value)?  loading,TResult? Function( NotificationStatusSuccess value)?  success,TResult? Function( NotificationStatusFailure value)?  failure,TResult? Function( NotificationStatusMessageReceived value)?  messageReceived,TResult? Function( NotificationStatusNavigationRequested value)?  navigationRequested,}){
final _that = this;
switch (_that) {
case NotificationStatusInitial() when initial != null:
return initial(_that);case NotificationStatusLoading() when loading != null:
return loading(_that);case NotificationStatusSuccess() when success != null:
return success(_that);case NotificationStatusFailure() when failure != null:
return failure(_that);case NotificationStatusMessageReceived() when messageReceived != null:
return messageReceived(_that);case NotificationStatusNavigationRequested() when navigationRequested != null:
return navigationRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String? fcmToken)?  success,TResult Function( String message)?  failure,TResult Function( NotificationMessage message)?  messageReceived,TResult Function( NotificationIntent intent,  int timestamp)?  navigationRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationStatusInitial() when initial != null:
return initial();case NotificationStatusLoading() when loading != null:
return loading();case NotificationStatusSuccess() when success != null:
return success(_that.fcmToken);case NotificationStatusFailure() when failure != null:
return failure(_that.message);case NotificationStatusMessageReceived() when messageReceived != null:
return messageReceived(_that.message);case NotificationStatusNavigationRequested() when navigationRequested != null:
return navigationRequested(_that.intent,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String? fcmToken)  success,required TResult Function( String message)  failure,required TResult Function( NotificationMessage message)  messageReceived,required TResult Function( NotificationIntent intent,  int timestamp)  navigationRequested,}) {final _that = this;
switch (_that) {
case NotificationStatusInitial():
return initial();case NotificationStatusLoading():
return loading();case NotificationStatusSuccess():
return success(_that.fcmToken);case NotificationStatusFailure():
return failure(_that.message);case NotificationStatusMessageReceived():
return messageReceived(_that.message);case NotificationStatusNavigationRequested():
return navigationRequested(_that.intent,_that.timestamp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String? fcmToken)?  success,TResult? Function( String message)?  failure,TResult? Function( NotificationMessage message)?  messageReceived,TResult? Function( NotificationIntent intent,  int timestamp)?  navigationRequested,}) {final _that = this;
switch (_that) {
case NotificationStatusInitial() when initial != null:
return initial();case NotificationStatusLoading() when loading != null:
return loading();case NotificationStatusSuccess() when success != null:
return success(_that.fcmToken);case NotificationStatusFailure() when failure != null:
return failure(_that.message);case NotificationStatusMessageReceived() when messageReceived != null:
return messageReceived(_that.message);case NotificationStatusNavigationRequested() when navigationRequested != null:
return navigationRequested(_that.intent,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class NotificationStatusInitial implements NotificationStatus {
  const NotificationStatusInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationStatus.initial()';
}


}




/// @nodoc


class NotificationStatusLoading implements NotificationStatus {
  const NotificationStatusLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationStatus.loading()';
}


}




/// @nodoc


class NotificationStatusSuccess implements NotificationStatus {
  const NotificationStatusSuccess(this.fcmToken);
  

 final  String? fcmToken;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatusSuccessCopyWith<NotificationStatusSuccess> get copyWith => _$NotificationStatusSuccessCopyWithImpl<NotificationStatusSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusSuccess&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}


@override
int get hashCode => Object.hash(runtimeType,fcmToken);

@override
String toString() {
  return 'NotificationStatus.success(fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $NotificationStatusSuccessCopyWith<$Res> implements $NotificationStatusCopyWith<$Res> {
  factory $NotificationStatusSuccessCopyWith(NotificationStatusSuccess value, $Res Function(NotificationStatusSuccess) _then) = _$NotificationStatusSuccessCopyWithImpl;
@useResult
$Res call({
 String? fcmToken
});




}
/// @nodoc
class _$NotificationStatusSuccessCopyWithImpl<$Res>
    implements $NotificationStatusSuccessCopyWith<$Res> {
  _$NotificationStatusSuccessCopyWithImpl(this._self, this._then);

  final NotificationStatusSuccess _self;
  final $Res Function(NotificationStatusSuccess) _then;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fcmToken = freezed,}) {
  return _then(NotificationStatusSuccess(
freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotificationStatusFailure implements NotificationStatus {
  const NotificationStatusFailure(this.message);
  

 final  String message;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatusFailureCopyWith<NotificationStatusFailure> get copyWith => _$NotificationStatusFailureCopyWithImpl<NotificationStatusFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationStatus.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationStatusFailureCopyWith<$Res> implements $NotificationStatusCopyWith<$Res> {
  factory $NotificationStatusFailureCopyWith(NotificationStatusFailure value, $Res Function(NotificationStatusFailure) _then) = _$NotificationStatusFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationStatusFailureCopyWithImpl<$Res>
    implements $NotificationStatusFailureCopyWith<$Res> {
  _$NotificationStatusFailureCopyWithImpl(this._self, this._then);

  final NotificationStatusFailure _self;
  final $Res Function(NotificationStatusFailure) _then;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationStatusFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationStatusMessageReceived implements NotificationStatus {
  const NotificationStatusMessageReceived(this.message);
  

 final  NotificationMessage message;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatusMessageReceivedCopyWith<NotificationStatusMessageReceived> get copyWith => _$NotificationStatusMessageReceivedCopyWithImpl<NotificationStatusMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusMessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationStatus.messageReceived(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationStatusMessageReceivedCopyWith<$Res> implements $NotificationStatusCopyWith<$Res> {
  factory $NotificationStatusMessageReceivedCopyWith(NotificationStatusMessageReceived value, $Res Function(NotificationStatusMessageReceived) _then) = _$NotificationStatusMessageReceivedCopyWithImpl;
@useResult
$Res call({
 NotificationMessage message
});


$NotificationMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$NotificationStatusMessageReceivedCopyWithImpl<$Res>
    implements $NotificationStatusMessageReceivedCopyWith<$Res> {
  _$NotificationStatusMessageReceivedCopyWithImpl(this._self, this._then);

  final NotificationStatusMessageReceived _self;
  final $Res Function(NotificationStatusMessageReceived) _then;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationStatusMessageReceived(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as NotificationMessage,
  ));
}

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationMessageCopyWith<$Res> get message {
  
  return $NotificationMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}

/// @nodoc


class NotificationStatusNavigationRequested implements NotificationStatus {
  const NotificationStatusNavigationRequested(this.intent, this.timestamp);
  

 final  NotificationIntent intent;
 final  int timestamp;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStatusNavigationRequestedCopyWith<NotificationStatusNavigationRequested> get copyWith => _$NotificationStatusNavigationRequestedCopyWithImpl<NotificationStatusNavigationRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationStatusNavigationRequested&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,intent,timestamp);

@override
String toString() {
  return 'NotificationStatus.navigationRequested(intent: $intent, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $NotificationStatusNavigationRequestedCopyWith<$Res> implements $NotificationStatusCopyWith<$Res> {
  factory $NotificationStatusNavigationRequestedCopyWith(NotificationStatusNavigationRequested value, $Res Function(NotificationStatusNavigationRequested) _then) = _$NotificationStatusNavigationRequestedCopyWithImpl;
@useResult
$Res call({
 NotificationIntent intent, int timestamp
});


$NotificationIntentCopyWith<$Res> get intent;

}
/// @nodoc
class _$NotificationStatusNavigationRequestedCopyWithImpl<$Res>
    implements $NotificationStatusNavigationRequestedCopyWith<$Res> {
  _$NotificationStatusNavigationRequestedCopyWithImpl(this._self, this._then);

  final NotificationStatusNavigationRequested _self;
  final $Res Function(NotificationStatusNavigationRequested) _then;

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? timestamp = null,}) {
  return _then(NotificationStatusNavigationRequested(
null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as NotificationIntent,null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NotificationStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<$Res> get intent {
  
  return $NotificationIntentCopyWith<$Res>(_self.intent, (value) {
    return _then(_self.copyWith(intent: value));
  });
}
}

// dart format on
