// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationSetupRequested value)?  setupRequested,TResult Function( NotificationSyncRequested value)?  syncRequested,TResult Function( NotificationInteractionReceived value)?  interactionReceived,TResult Function( NotificationReset value)?  reset,TResult Function( NotificationAppReadyForNavigation value)?  appReadyForNavigation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested(_that);case NotificationSyncRequested() when syncRequested != null:
return syncRequested(_that);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that);case NotificationReset() when reset != null:
return reset(_that);case NotificationAppReadyForNavigation() when appReadyForNavigation != null:
return appReadyForNavigation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationSetupRequested value)  setupRequested,required TResult Function( NotificationSyncRequested value)  syncRequested,required TResult Function( NotificationInteractionReceived value)  interactionReceived,required TResult Function( NotificationReset value)  reset,required TResult Function( NotificationAppReadyForNavigation value)  appReadyForNavigation,}){
final _that = this;
switch (_that) {
case NotificationSetupRequested():
return setupRequested(_that);case NotificationSyncRequested():
return syncRequested(_that);case NotificationInteractionReceived():
return interactionReceived(_that);case NotificationReset():
return reset(_that);case NotificationAppReadyForNavigation():
return appReadyForNavigation(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationSetupRequested value)?  setupRequested,TResult? Function( NotificationSyncRequested value)?  syncRequested,TResult? Function( NotificationInteractionReceived value)?  interactionReceived,TResult? Function( NotificationReset value)?  reset,TResult? Function( NotificationAppReadyForNavigation value)?  appReadyForNavigation,}){
final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested(_that);case NotificationSyncRequested() when syncRequested != null:
return syncRequested(_that);case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that);case NotificationReset() when reset != null:
return reset(_that);case NotificationAppReadyForNavigation() when appReadyForNavigation != null:
return appReadyForNavigation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  setupRequested,TResult Function()?  syncRequested,TResult Function( Map<String, dynamic> payload)?  interactionReceived,TResult Function()?  reset,TResult Function()?  appReadyForNavigation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested();case NotificationSyncRequested() when syncRequested != null:
return syncRequested();case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that.payload);case NotificationReset() when reset != null:
return reset();case NotificationAppReadyForNavigation() when appReadyForNavigation != null:
return appReadyForNavigation();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  setupRequested,required TResult Function()  syncRequested,required TResult Function( Map<String, dynamic> payload)  interactionReceived,required TResult Function()  reset,required TResult Function()  appReadyForNavigation,}) {final _that = this;
switch (_that) {
case NotificationSetupRequested():
return setupRequested();case NotificationSyncRequested():
return syncRequested();case NotificationInteractionReceived():
return interactionReceived(_that.payload);case NotificationReset():
return reset();case NotificationAppReadyForNavigation():
return appReadyForNavigation();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  setupRequested,TResult? Function()?  syncRequested,TResult? Function( Map<String, dynamic> payload)?  interactionReceived,TResult? Function()?  reset,TResult? Function()?  appReadyForNavigation,}) {final _that = this;
switch (_that) {
case NotificationSetupRequested() when setupRequested != null:
return setupRequested();case NotificationSyncRequested() when syncRequested != null:
return syncRequested();case NotificationInteractionReceived() when interactionReceived != null:
return interactionReceived(_that.payload);case NotificationReset() when reset != null:
return reset();case NotificationAppReadyForNavigation() when appReadyForNavigation != null:
return appReadyForNavigation();case _:
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


class NotificationSyncRequested implements NotificationEvent {
  const NotificationSyncRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSyncRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationEvent.syncRequested()';
}


}




/// @nodoc


class NotificationInteractionReceived implements NotificationEvent {
  const NotificationInteractionReceived( Map<String, dynamic> payload): _payload = payload;
  

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationInteractionReceived&&const DeepCollectionEquality().equals(other.payload, _payload));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_payload));
}

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


class NotificationAppReadyForNavigation implements NotificationEvent {
  const NotificationAppReadyForNavigation();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationAppReadyForNavigation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationEvent.appReadyForNavigation()';
}


}




// dart format on
