// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedbackEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent()';
}


}

/// @nodoc
class $FeedbackEventCopyWith<$Res>  {
$FeedbackEventCopyWith(FeedbackEvent _, $Res Function(FeedbackEvent) __);
}


/// Adds pattern-matching-related methods to [FeedbackEvent].
extension FeedbackEventPatterns on FeedbackEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Submit value)?  submit,TResult Function( MessageChanged value)?  messageChanged,TResult Function( CooldownEnded value)?  cooldownEnded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Submit() when submit != null:
return submit(_that);case MessageChanged() when messageChanged != null:
return messageChanged(_that);case CooldownEnded() when cooldownEnded != null:
return cooldownEnded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Submit value)  submit,required TResult Function( MessageChanged value)  messageChanged,required TResult Function( CooldownEnded value)  cooldownEnded,}){
final _that = this;
switch (_that) {
case Submit():
return submit(_that);case MessageChanged():
return messageChanged(_that);case CooldownEnded():
return cooldownEnded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Submit value)?  submit,TResult? Function( MessageChanged value)?  messageChanged,TResult? Function( CooldownEnded value)?  cooldownEnded,}){
final _that = this;
switch (_that) {
case Submit() when submit != null:
return submit(_that);case MessageChanged() when messageChanged != null:
return messageChanged(_that);case CooldownEnded() when cooldownEnded != null:
return cooldownEnded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  submit,TResult Function( String message)?  messageChanged,TResult Function()?  cooldownEnded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Submit() when submit != null:
return submit(_that.message);case MessageChanged() when messageChanged != null:
return messageChanged(_that.message);case CooldownEnded() when cooldownEnded != null:
return cooldownEnded();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  submit,required TResult Function( String message)  messageChanged,required TResult Function()  cooldownEnded,}) {final _that = this;
switch (_that) {
case Submit():
return submit(_that.message);case MessageChanged():
return messageChanged(_that.message);case CooldownEnded():
return cooldownEnded();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  submit,TResult? Function( String message)?  messageChanged,TResult? Function()?  cooldownEnded,}) {final _that = this;
switch (_that) {
case Submit() when submit != null:
return submit(_that.message);case MessageChanged() when messageChanged != null:
return messageChanged(_that.message);case CooldownEnded() when cooldownEnded != null:
return cooldownEnded();case _:
  return null;

}
}

}

/// @nodoc


class Submit implements FeedbackEvent {
  const Submit(this.message);
  

 final  String message;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitCopyWith<Submit> get copyWith => _$SubmitCopyWithImpl<Submit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Submit&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedbackEvent.submit(message: $message)';
}


}

/// @nodoc
abstract mixin class $SubmitCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $SubmitCopyWith(Submit value, $Res Function(Submit) _then) = _$SubmitCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SubmitCopyWithImpl<$Res>
    implements $SubmitCopyWith<$Res> {
  _$SubmitCopyWithImpl(this._self, this._then);

  final Submit _self;
  final $Res Function(Submit) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Submit(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MessageChanged implements FeedbackEvent {
  const MessageChanged(this.message);
  

 final  String message;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageChangedCopyWith<MessageChanged> get copyWith => _$MessageChangedCopyWithImpl<MessageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageChanged&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedbackEvent.messageChanged(message: $message)';
}


}

/// @nodoc
abstract mixin class $MessageChangedCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $MessageChangedCopyWith(MessageChanged value, $Res Function(MessageChanged) _then) = _$MessageChangedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MessageChangedCopyWithImpl<$Res>
    implements $MessageChangedCopyWith<$Res> {
  _$MessageChangedCopyWithImpl(this._self, this._then);

  final MessageChanged _self;
  final $Res Function(MessageChanged) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MessageChanged(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CooldownEnded implements FeedbackEvent {
  const CooldownEnded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CooldownEnded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent.cooldownEnded()';
}


}




// dart format on
