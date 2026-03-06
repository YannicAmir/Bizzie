// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationSetupRequested value)?  setupRequested,TResult Function( NotificationSubscribeToTopicRequested value)?  subscribeToTopicRequested,TResult Function( NotificationUnsubscribeFromTopicRequested value)?  unsubscribeFromTopicRequested,TResult Function( NotificationMessageReceived value)?  messageReceived,TResult Function( NotificationInteractionReceived value)?  interactionReceived,TResult Function( NotificationReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested(_that);case NotificationSubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that);case NotificationUnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that);case NotificationMessageReceived() when messageReceived != null:
return messageReceived(_that);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that);case NotificationReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationSetupRequested value)  setupRequested,required TResult Function( NotificationSubscribeToTopicRequested value)  subscribeToTopicRequested,required TResult Function( NotificationUnsubscribeFromTopicRequested value)  unsubscribeFromTopicRequested,required TResult Function( NotificationMessageReceived value)  messageReceived,required TResult Function( NotificationInteractionReceived value)  interactionReceived,required TResult Function( NotificationReset value)  reset,}){
final _that = this;
switch (_that) {
case NotificationSetupRequested():
return setupRequested(_that);case NotificationSubscribeToTopicRequested():
return subscribeToTopicRequested(_that);case NotificationUnsubscribeFromTopicRequested():
return unsubscribeFromTopicRequested(_that);case NotificationMessageReceived():
return messageReceived(_that);case NotificationInteractionReceived():
return interactionReceived(_that);case NotificationReset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationSetupRequested value)?  setupRequested,TResult? Function( NotificationSubscribeToTopicRequested value)?  subscribeToTopicRequested,TResult? Function( NotificationUnsubscribeFromTopicRequested value)?  unsubscribeFromTopicRequested,TResult? Function( NotificationMessageReceived value)?  messageReceived,TResult? Function( NotificationInteractionReceived value)?  interactionReceived,TResult? Function( NotificationReset value)?  reset,}){
final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested(_that);case NotificationSubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that);case NotificationUnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that);case NotificationMessageReceived() when messageReceived != null:
return messageReceived(_that);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that);case NotificationReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  setupRequested,TResult Function( String topic)?  subscribeToTopicRequested,TResult Function( String topic)?  unsubscribeFromTopicRequested,TResult Function( NotificationMessage message)?  messageReceived,TResult Function( Map<String, dynamic> payload)?  interactionReceived,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested();case NotificationSubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that.topic);case NotificationUnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that.topic);case NotificationMessageReceived() when messageReceived != null:
return messageReceived(_that.message);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that.payload);case NotificationReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  setupRequested,required TResult Function( String topic)  subscribeToTopicRequested,required TResult Function( String topic)  unsubscribeFromTopicRequested,required TResult Function( NotificationMessage message)  messageReceived,required TResult Function( Map<String, dynamic> payload)  interactionReceived,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case NotificationSetupRequested():
return setupRequested();case NotificationSubscribeToTopicRequested():
return subscribeToTopicRequested(_that.topic);case NotificationUnsubscribeFromTopicRequested():
return unsubscribeFromTopicRequested(_that.topic);case NotificationMessageReceived():
return messageReceived(_that.message);case NotificationInteractionReceived():
return interactionReceived(_that.payload);case NotificationReset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  setupRequested,TResult? Function( String topic)?  subscribeToTopicRequested,TResult? Function( String topic)?  unsubscribeFromTopicRequested,TResult? Function( NotificationMessage message)?  messageReceived,TResult? Function( Map<String, dynamic> payload)?  interactionReceived,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested();case NotificationSubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that.topic);case NotificationUnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that.topic);case NotificationMessageReceived() when messageReceived != null:
return messageReceived(_that.message);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that.payload);case NotificationReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class NotificationSetupRequested implements NotificationEvent {
  const NotificationSetupRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSetupRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.setupRequested()';
}


}




/// @nodoc


class NotificationSubscribeToTopicRequested implements NotificationEvent {
  const NotificationSubscribeToTopicRequested(this.topic);
  

 final  String topic;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSubscribeToTopicRequestedCopyWith<NotificationSubscribeToTopicRequested> get copyWith => _$NotificationSubscribeToTopicRequestedCopyWithImpl<NotificationSubscribeToTopicRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSubscribeToTopicRequested&&(identical(other.topic, topic) || other.topic == topic));
}


@override
int get hashCode => Object.hash(runtimeType,topic);

@override
String toString() {
  return 'NotificationEvent.subscribeToTopicRequested(topic: $topic)';
}


}

/// @nodoc
abstract mixin class $NotificationSubscribeToTopicRequestedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationSubscribeToTopicRequestedCopyWith(NotificationSubscribeToTopicRequested value, $Res Function(NotificationSubscribeToTopicRequested) _then) = _$NotificationSubscribeToTopicRequestedCopyWithImpl;
@useResult
$Res call({
 String topic
});




}
/// @nodoc
class _$NotificationSubscribeToTopicRequestedCopyWithImpl<$Res>
    implements $NotificationSubscribeToTopicRequestedCopyWith<$Res> {
  _$NotificationSubscribeToTopicRequestedCopyWithImpl(this._self, this._then);

  final NotificationSubscribeToTopicRequested _self;
  final $Res Function(NotificationSubscribeToTopicRequested) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topic = null,}) {
  return _then(NotificationSubscribeToTopicRequested(
null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationUnsubscribeFromTopicRequested implements NotificationEvent {
  const NotificationUnsubscribeFromTopicRequested(this.topic);
  

 final  String topic;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationUnsubscribeFromTopicRequestedCopyWith<NotificationUnsubscribeFromTopicRequested> get copyWith => _$NotificationUnsubscribeFromTopicRequestedCopyWithImpl<NotificationUnsubscribeFromTopicRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationUnsubscribeFromTopicRequested&&(identical(other.topic, topic) || other.topic == topic));
}


@override
int get hashCode => Object.hash(runtimeType,topic);

@override
String toString() {
  return 'NotificationEvent.unsubscribeFromTopicRequested(topic: $topic)';
}


}

/// @nodoc
abstract mixin class $NotificationUnsubscribeFromTopicRequestedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationUnsubscribeFromTopicRequestedCopyWith(NotificationUnsubscribeFromTopicRequested value, $Res Function(NotificationUnsubscribeFromTopicRequested) _then) = _$NotificationUnsubscribeFromTopicRequestedCopyWithImpl;
@useResult
$Res call({
 String topic
});




}
/// @nodoc
class _$NotificationUnsubscribeFromTopicRequestedCopyWithImpl<$Res>
    implements $NotificationUnsubscribeFromTopicRequestedCopyWith<$Res> {
  _$NotificationUnsubscribeFromTopicRequestedCopyWithImpl(this._self, this._then);

  final NotificationUnsubscribeFromTopicRequested _self;
  final $Res Function(NotificationUnsubscribeFromTopicRequested) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topic = null,}) {
  return _then(NotificationUnsubscribeFromTopicRequested(
null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationMessageReceived implements NotificationEvent {
  const NotificationMessageReceived(this.message);
  

 final  NotificationMessage message;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationMessageReceivedCopyWith<NotificationMessageReceived> get copyWith => _$NotificationMessageReceivedCopyWithImpl<NotificationMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationMessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationEvent.messageReceived(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationMessageReceivedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationMessageReceivedCopyWith(NotificationMessageReceived value, $Res Function(NotificationMessageReceived) _then) = _$NotificationMessageReceivedCopyWithImpl;
@useResult
$Res call({
 NotificationMessage message
});


$NotificationMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$NotificationMessageReceivedCopyWithImpl<$Res>
    implements $NotificationMessageReceivedCopyWith<$Res> {
  _$NotificationMessageReceivedCopyWithImpl(this._self, this._then);

  final NotificationMessageReceived _self;
  final $Res Function(NotificationMessageReceived) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationMessageReceived(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as NotificationMessage,
  ));
}

/// Create a copy of NotificationEvent
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


class NotificationInteractionReceived implements NotificationEvent {
  const NotificationInteractionReceived(final  Map<String, dynamic> payload): _payload = payload;
  

 final  Map<String, dynamic> _payload;
 Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationInteractionReceivedCopyWith<NotificationInteractionReceived> get copyWith => _$NotificationInteractionReceivedCopyWithImpl<NotificationInteractionReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationInteractionReceived&&const DeepCollectionEquality().equals(other._payload, _payload));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'NotificationEvent.interactionReceived(payload: $payload)';
}


}

/// @nodoc
abstract mixin class $NotificationInteractionReceivedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationInteractionReceivedCopyWith(NotificationInteractionReceived value, $Res Function(NotificationInteractionReceived) _then) = _$NotificationInteractionReceivedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> payload
});




}
/// @nodoc
class _$NotificationInteractionReceivedCopyWithImpl<$Res>
    implements $NotificationInteractionReceivedCopyWith<$Res> {
  _$NotificationInteractionReceivedCopyWithImpl(this._self, this._then);

  final NotificationInteractionReceived _self;
  final $Res Function(NotificationInteractionReceived) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payload = null,}) {
  return _then(NotificationInteractionReceived(
null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class NotificationReset implements NotificationEvent {
  const NotificationReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.reset()';
}


}




/// @nodoc
mixin _$NotificationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState()';
}


}

/// @nodoc
class $NotificationStateCopyWith<$Res>  {
$NotificationStateCopyWith(NotificationState _, $Res Function(NotificationState) __);
}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationInitial value)?  initial,TResult Function( NotificationLoading value)?  loading,TResult Function( NotificationSuccess value)?  success,TResult Function( NotificationFailure value)?  failure,TResult Function( NotificationMessageReceivedState value)?  messageReceivedState,TResult Function( NotificationNavigationRequested value)?  navigationRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case NotificationSuccess() when success != null:
return success(_that);case NotificationFailure() when failure != null:
return failure(_that);case NotificationMessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that);case NotificationNavigationRequested() when navigationRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationInitial value)  initial,required TResult Function( NotificationLoading value)  loading,required TResult Function( NotificationSuccess value)  success,required TResult Function( NotificationFailure value)  failure,required TResult Function( NotificationMessageReceivedState value)  messageReceivedState,required TResult Function( NotificationNavigationRequested value)  navigationRequested,}){
final _that = this;
switch (_that) {
case NotificationInitial():
return initial(_that);case NotificationLoading():
return loading(_that);case NotificationSuccess():
return success(_that);case NotificationFailure():
return failure(_that);case NotificationMessageReceivedState():
return messageReceivedState(_that);case NotificationNavigationRequested():
return navigationRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationInitial value)?  initial,TResult? Function( NotificationLoading value)?  loading,TResult? Function( NotificationSuccess value)?  success,TResult? Function( NotificationFailure value)?  failure,TResult? Function( NotificationMessageReceivedState value)?  messageReceivedState,TResult? Function( NotificationNavigationRequested value)?  navigationRequested,}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case NotificationSuccess() when success != null:
return success(_that);case NotificationFailure() when failure != null:
return failure(_that);case NotificationMessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that);case NotificationNavigationRequested() when navigationRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String? fcmToken)?  success,TResult Function( String message)?  failure,TResult Function( NotificationMessage message)?  messageReceivedState,TResult Function( NotificationIntent intent,  int timestamp)?  navigationRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case NotificationSuccess() when success != null:
return success(_that.fcmToken);case NotificationFailure() when failure != null:
return failure(_that.message);case NotificationMessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that.message);case NotificationNavigationRequested() when navigationRequested != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String? fcmToken)  success,required TResult Function( String message)  failure,required TResult Function( NotificationMessage message)  messageReceivedState,required TResult Function( NotificationIntent intent,  int timestamp)  navigationRequested,}) {final _that = this;
switch (_that) {
case NotificationInitial():
return initial();case NotificationLoading():
return loading();case NotificationSuccess():
return success(_that.fcmToken);case NotificationFailure():
return failure(_that.message);case NotificationMessageReceivedState():
return messageReceivedState(_that.message);case NotificationNavigationRequested():
return navigationRequested(_that.intent,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String? fcmToken)?  success,TResult? Function( String message)?  failure,TResult? Function( NotificationMessage message)?  messageReceivedState,TResult? Function( NotificationIntent intent,  int timestamp)?  navigationRequested,}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case NotificationSuccess() when success != null:
return success(_that.fcmToken);case NotificationFailure() when failure != null:
return failure(_that.message);case NotificationMessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that.message);case NotificationNavigationRequested() when navigationRequested != null:
return navigationRequested(_that.intent,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class NotificationInitial implements NotificationState {
  const NotificationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.initial()';
}


}




/// @nodoc


class NotificationLoading implements NotificationState {
  const NotificationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.loading()';
}


}




/// @nodoc


class NotificationSuccess implements NotificationState {
  const NotificationSuccess(this.fcmToken);
  

 final  String? fcmToken;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSuccessCopyWith<NotificationSuccess> get copyWith => _$NotificationSuccessCopyWithImpl<NotificationSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSuccess&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}


@override
int get hashCode => Object.hash(runtimeType,fcmToken);

@override
String toString() {
  return 'NotificationState.success(fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $NotificationSuccessCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationSuccessCopyWith(NotificationSuccess value, $Res Function(NotificationSuccess) _then) = _$NotificationSuccessCopyWithImpl;
@useResult
$Res call({
 String? fcmToken
});




}
/// @nodoc
class _$NotificationSuccessCopyWithImpl<$Res>
    implements $NotificationSuccessCopyWith<$Res> {
  _$NotificationSuccessCopyWithImpl(this._self, this._then);

  final NotificationSuccess _self;
  final $Res Function(NotificationSuccess) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fcmToken = freezed,}) {
  return _then(NotificationSuccess(
freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotificationFailure implements NotificationState {
  const NotificationFailure(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationFailureCopyWith<NotificationFailure> get copyWith => _$NotificationFailureCopyWithImpl<NotificationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationFailureCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationFailureCopyWith(NotificationFailure value, $Res Function(NotificationFailure) _then) = _$NotificationFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationFailureCopyWithImpl<$Res>
    implements $NotificationFailureCopyWith<$Res> {
  _$NotificationFailureCopyWithImpl(this._self, this._then);

  final NotificationFailure _self;
  final $Res Function(NotificationFailure) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationMessageReceivedState implements NotificationState {
  const NotificationMessageReceivedState(this.message);
  

 final  NotificationMessage message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationMessageReceivedStateCopyWith<NotificationMessageReceivedState> get copyWith => _$NotificationMessageReceivedStateCopyWithImpl<NotificationMessageReceivedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationMessageReceivedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.messageReceivedState(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationMessageReceivedStateCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationMessageReceivedStateCopyWith(NotificationMessageReceivedState value, $Res Function(NotificationMessageReceivedState) _then) = _$NotificationMessageReceivedStateCopyWithImpl;
@useResult
$Res call({
 NotificationMessage message
});


$NotificationMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$NotificationMessageReceivedStateCopyWithImpl<$Res>
    implements $NotificationMessageReceivedStateCopyWith<$Res> {
  _$NotificationMessageReceivedStateCopyWithImpl(this._self, this._then);

  final NotificationMessageReceivedState _self;
  final $Res Function(NotificationMessageReceivedState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationMessageReceivedState(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as NotificationMessage,
  ));
}

/// Create a copy of NotificationState
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


class NotificationNavigationRequested implements NotificationState {
  const NotificationNavigationRequested(this.intent, this.timestamp);
  

 final  NotificationIntent intent;
 final  int timestamp;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationNavigationRequestedCopyWith<NotificationNavigationRequested> get copyWith => _$NotificationNavigationRequestedCopyWithImpl<NotificationNavigationRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationNavigationRequested&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,intent,timestamp);

@override
String toString() {
  return 'NotificationState.navigationRequested(intent: $intent, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $NotificationNavigationRequestedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationNavigationRequestedCopyWith(NotificationNavigationRequested value, $Res Function(NotificationNavigationRequested) _then) = _$NotificationNavigationRequestedCopyWithImpl;
@useResult
$Res call({
 NotificationIntent intent, int timestamp
});


$NotificationIntentCopyWith<$Res> get intent;

}
/// @nodoc
class _$NotificationNavigationRequestedCopyWithImpl<$Res>
    implements $NotificationNavigationRequestedCopyWith<$Res> {
  _$NotificationNavigationRequestedCopyWithImpl(this._self, this._then);

  final NotificationNavigationRequested _self;
  final $Res Function(NotificationNavigationRequested) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? timestamp = null,}) {
  return _then(NotificationNavigationRequested(
null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as NotificationIntent,null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of NotificationState
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
