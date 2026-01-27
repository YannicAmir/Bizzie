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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SetupRequested value)?  setupRequested,TResult Function( _SubscribeToTopicRequested value)?  subscribeToTopicRequested,TResult Function( _UnsubscribeFromTopicRequested value)?  unsubscribeFromTopicRequested,TResult Function( _MessageReceived value)?  messageReceived,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupRequested() when setupRequested != null:
return setupRequested(_that);case _SubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that);case _UnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SetupRequested value)  setupRequested,required TResult Function( _SubscribeToTopicRequested value)  subscribeToTopicRequested,required TResult Function( _UnsubscribeFromTopicRequested value)  unsubscribeFromTopicRequested,required TResult Function( _MessageReceived value)  messageReceived,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _SetupRequested():
return setupRequested(_that);case _SubscribeToTopicRequested():
return subscribeToTopicRequested(_that);case _UnsubscribeFromTopicRequested():
return unsubscribeFromTopicRequested(_that);case _MessageReceived():
return messageReceived(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SetupRequested value)?  setupRequested,TResult? Function( _SubscribeToTopicRequested value)?  subscribeToTopicRequested,TResult? Function( _UnsubscribeFromTopicRequested value)?  unsubscribeFromTopicRequested,TResult? Function( _MessageReceived value)?  messageReceived,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _SetupRequested() when setupRequested != null:
return setupRequested(_that);case _SubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that);case _UnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  setupRequested,TResult Function( String topic)?  subscribeToTopicRequested,TResult Function( String topic)?  unsubscribeFromTopicRequested,TResult Function( NotificationMessage message)?  messageReceived,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupRequested() when setupRequested != null:
return setupRequested();case _SubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that.topic);case _UnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that.topic);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  setupRequested,required TResult Function( String topic)  subscribeToTopicRequested,required TResult Function( String topic)  unsubscribeFromTopicRequested,required TResult Function( NotificationMessage message)  messageReceived,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _SetupRequested():
return setupRequested();case _SubscribeToTopicRequested():
return subscribeToTopicRequested(_that.topic);case _UnsubscribeFromTopicRequested():
return unsubscribeFromTopicRequested(_that.topic);case _MessageReceived():
return messageReceived(_that.message);case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  setupRequested,TResult? Function( String topic)?  subscribeToTopicRequested,TResult? Function( String topic)?  unsubscribeFromTopicRequested,TResult? Function( NotificationMessage message)?  messageReceived,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _SetupRequested() when setupRequested != null:
return setupRequested();case _SubscribeToTopicRequested() when subscribeToTopicRequested != null:
return subscribeToTopicRequested(_that.topic);case _UnsubscribeFromTopicRequested() when unsubscribeFromTopicRequested != null:
return unsubscribeFromTopicRequested(_that.topic);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _SetupRequested implements NotificationEvent {
  const _SetupRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.setupRequested()';
}


}




/// @nodoc


class _SubscribeToTopicRequested implements NotificationEvent {
  const _SubscribeToTopicRequested(this.topic);
  

 final  String topic;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscribeToTopicRequestedCopyWith<_SubscribeToTopicRequested> get copyWith => __$SubscribeToTopicRequestedCopyWithImpl<_SubscribeToTopicRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscribeToTopicRequested&&(identical(other.topic, topic) || other.topic == topic));
}


@override
int get hashCode => Object.hash(runtimeType,topic);

@override
String toString() {
  return 'NotificationEvent.subscribeToTopicRequested(topic: $topic)';
}


}

/// @nodoc
abstract mixin class _$SubscribeToTopicRequestedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$SubscribeToTopicRequestedCopyWith(_SubscribeToTopicRequested value, $Res Function(_SubscribeToTopicRequested) _then) = __$SubscribeToTopicRequestedCopyWithImpl;
@useResult
$Res call({
 String topic
});




}
/// @nodoc
class __$SubscribeToTopicRequestedCopyWithImpl<$Res>
    implements _$SubscribeToTopicRequestedCopyWith<$Res> {
  __$SubscribeToTopicRequestedCopyWithImpl(this._self, this._then);

  final _SubscribeToTopicRequested _self;
  final $Res Function(_SubscribeToTopicRequested) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topic = null,}) {
  return _then(_SubscribeToTopicRequested(
null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UnsubscribeFromTopicRequested implements NotificationEvent {
  const _UnsubscribeFromTopicRequested(this.topic);
  

 final  String topic;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnsubscribeFromTopicRequestedCopyWith<_UnsubscribeFromTopicRequested> get copyWith => __$UnsubscribeFromTopicRequestedCopyWithImpl<_UnsubscribeFromTopicRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnsubscribeFromTopicRequested&&(identical(other.topic, topic) || other.topic == topic));
}


@override
int get hashCode => Object.hash(runtimeType,topic);

@override
String toString() {
  return 'NotificationEvent.unsubscribeFromTopicRequested(topic: $topic)';
}


}

/// @nodoc
abstract mixin class _$UnsubscribeFromTopicRequestedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$UnsubscribeFromTopicRequestedCopyWith(_UnsubscribeFromTopicRequested value, $Res Function(_UnsubscribeFromTopicRequested) _then) = __$UnsubscribeFromTopicRequestedCopyWithImpl;
@useResult
$Res call({
 String topic
});




}
/// @nodoc
class __$UnsubscribeFromTopicRequestedCopyWithImpl<$Res>
    implements _$UnsubscribeFromTopicRequestedCopyWith<$Res> {
  __$UnsubscribeFromTopicRequestedCopyWithImpl(this._self, this._then);

  final _UnsubscribeFromTopicRequested _self;
  final $Res Function(_UnsubscribeFromTopicRequested) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topic = null,}) {
  return _then(_UnsubscribeFromTopicRequested(
null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MessageReceived implements NotificationEvent {
  const _MessageReceived(this.message);
  

 final  NotificationMessage message;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageReceivedCopyWith<_MessageReceived> get copyWith => __$MessageReceivedCopyWithImpl<_MessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationEvent.messageReceived(message: $message)';
}


}

/// @nodoc
abstract mixin class _$MessageReceivedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$MessageReceivedCopyWith(_MessageReceived value, $Res Function(_MessageReceived) _then) = __$MessageReceivedCopyWithImpl;
@useResult
$Res call({
 NotificationMessage message
});


$NotificationMessageCopyWith<$Res> get message;

}
/// @nodoc
class __$MessageReceivedCopyWithImpl<$Res>
    implements _$MessageReceivedCopyWith<$Res> {
  __$MessageReceivedCopyWithImpl(this._self, this._then);

  final _MessageReceived _self;
  final $Res Function(_MessageReceived) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_MessageReceived(
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


class _Reset implements NotificationEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _MessageReceivedState value)?  messageReceivedState,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _MessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _MessageReceivedState value)  messageReceivedState,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _MessageReceivedState():
return messageReceivedState(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _MessageReceivedState value)?  messageReceivedState,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _MessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String? fcmToken)?  success,TResult Function( String message)?  failure,TResult Function( NotificationMessage message)?  messageReceivedState,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.fcmToken);case _Failure() when failure != null:
return failure(_that.message);case _MessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String? fcmToken)  success,required TResult Function( String message)  failure,required TResult Function( NotificationMessage message)  messageReceivedState,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.fcmToken);case _Failure():
return failure(_that.message);case _MessageReceivedState():
return messageReceivedState(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String? fcmToken)?  success,TResult? Function( String message)?  failure,TResult? Function( NotificationMessage message)?  messageReceivedState,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.fcmToken);case _Failure() when failure != null:
return failure(_that.message);case _MessageReceivedState() when messageReceivedState != null:
return messageReceivedState(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements NotificationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.initial()';
}


}




/// @nodoc


class _Loading implements NotificationState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.loading()';
}


}




/// @nodoc


class _Success implements NotificationState {
  const _Success(this.fcmToken);
  

 final  String? fcmToken;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}


@override
int get hashCode => Object.hash(runtimeType,fcmToken);

@override
String toString() {
  return 'NotificationState.success(fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String? fcmToken
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fcmToken = freezed,}) {
  return _then(_Success(
freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Failure implements NotificationState {
  const _Failure(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MessageReceivedState implements NotificationState {
  const _MessageReceivedState(this.message);
  

 final  NotificationMessage message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageReceivedStateCopyWith<_MessageReceivedState> get copyWith => __$MessageReceivedStateCopyWithImpl<_MessageReceivedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageReceivedState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.messageReceivedState(message: $message)';
}


}

/// @nodoc
abstract mixin class _$MessageReceivedStateCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$MessageReceivedStateCopyWith(_MessageReceivedState value, $Res Function(_MessageReceivedState) _then) = __$MessageReceivedStateCopyWithImpl;
@useResult
$Res call({
 NotificationMessage message
});


$NotificationMessageCopyWith<$Res> get message;

}
/// @nodoc
class __$MessageReceivedStateCopyWithImpl<$Res>
    implements _$MessageReceivedStateCopyWith<$Res> {
  __$MessageReceivedStateCopyWithImpl(this._self, this._then);

  final _MessageReceivedState _self;
  final $Res Function(_MessageReceivedState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_MessageReceivedState(
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

// dart format on
