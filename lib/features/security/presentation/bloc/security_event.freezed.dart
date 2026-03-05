// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent()';
}


}

/// @nodoc
class $SecurityEventCopyWith<$Res>  {
$SecurityEventCopyWith(SecurityEvent _, $Res Function(SecurityEvent) __);
}


/// Adds pattern-matching-related methods to [SecurityEvent].
extension SecurityEventPatterns on SecurityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( LockoutActionTaken value)?  lockoutActionTaken,TResult Function( ThreatDetected value)?  threatDetected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LockoutActionTaken() when lockoutActionTaken != null:
return lockoutActionTaken(_that);case ThreatDetected() when threatDetected != null:
return threatDetected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( LockoutActionTaken value)  lockoutActionTaken,required TResult Function( ThreatDetected value)  threatDetected,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case LockoutActionTaken():
return lockoutActionTaken(_that);case ThreatDetected():
return threatDetected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( LockoutActionTaken value)?  lockoutActionTaken,TResult? Function( ThreatDetected value)?  threatDetected,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case LockoutActionTaken() when lockoutActionTaken != null:
return lockoutActionTaken(_that);case ThreatDetected() when threatDetected != null:
return threatDetected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( SecurityLockoutAction action)?  lockoutActionTaken,TResult Function( SecurityThreatType type,  bool isCritical)?  threatDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LockoutActionTaken() when lockoutActionTaken != null:
return lockoutActionTaken(_that.action);case ThreatDetected() when threatDetected != null:
return threatDetected(_that.type,_that.isCritical);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( SecurityLockoutAction action)  lockoutActionTaken,required TResult Function( SecurityThreatType type,  bool isCritical)  threatDetected,}) {final _that = this;
switch (_that) {
case Started():
return started();case LockoutActionTaken():
return lockoutActionTaken(_that.action);case ThreatDetected():
return threatDetected(_that.type,_that.isCritical);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( SecurityLockoutAction action)?  lockoutActionTaken,TResult? Function( SecurityThreatType type,  bool isCritical)?  threatDetected,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case LockoutActionTaken() when lockoutActionTaken != null:
return lockoutActionTaken(_that.action);case ThreatDetected() when threatDetected != null:
return threatDetected(_that.type,_that.isCritical);case _:
  return null;

}
}

}

/// @nodoc


class Started implements SecurityEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.started()';
}


}




/// @nodoc


class LockoutActionTaken implements SecurityEvent {
  const LockoutActionTaken(this.action);
  

 final  SecurityLockoutAction action;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockoutActionTakenCopyWith<LockoutActionTaken> get copyWith => _$LockoutActionTakenCopyWithImpl<LockoutActionTaken>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockoutActionTaken&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,action);

@override
String toString() {
  return 'SecurityEvent.lockoutActionTaken(action: $action)';
}


}

/// @nodoc
abstract mixin class $LockoutActionTakenCopyWith<$Res> implements $SecurityEventCopyWith<$Res> {
  factory $LockoutActionTakenCopyWith(LockoutActionTaken value, $Res Function(LockoutActionTaken) _then) = _$LockoutActionTakenCopyWithImpl;
@useResult
$Res call({
 SecurityLockoutAction action
});




}
/// @nodoc
class _$LockoutActionTakenCopyWithImpl<$Res>
    implements $LockoutActionTakenCopyWith<$Res> {
  _$LockoutActionTakenCopyWithImpl(this._self, this._then);

  final LockoutActionTaken _self;
  final $Res Function(LockoutActionTaken) _then;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? action = null,}) {
  return _then(LockoutActionTaken(
null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SecurityLockoutAction,
  ));
}


}

/// @nodoc


class ThreatDetected implements SecurityEvent {
  const ThreatDetected({required this.type, required this.isCritical});
  

 final  SecurityThreatType type;
 final  bool isCritical;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThreatDetectedCopyWith<ThreatDetected> get copyWith => _$ThreatDetectedCopyWithImpl<ThreatDetected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThreatDetected&&(identical(other.type, type) || other.type == type)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical));
}


@override
int get hashCode => Object.hash(runtimeType,type,isCritical);

@override
String toString() {
  return 'SecurityEvent.threatDetected(type: $type, isCritical: $isCritical)';
}


}

/// @nodoc
abstract mixin class $ThreatDetectedCopyWith<$Res> implements $SecurityEventCopyWith<$Res> {
  factory $ThreatDetectedCopyWith(ThreatDetected value, $Res Function(ThreatDetected) _then) = _$ThreatDetectedCopyWithImpl;
@useResult
$Res call({
 SecurityThreatType type, bool isCritical
});




}
/// @nodoc
class _$ThreatDetectedCopyWithImpl<$Res>
    implements $ThreatDetectedCopyWith<$Res> {
  _$ThreatDetectedCopyWithImpl(this._self, this._then);

  final ThreatDetected _self;
  final $Res Function(ThreatDetected) _then;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? isCritical = null,}) {
  return _then(ThreatDetected(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SecurityThreatType,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
