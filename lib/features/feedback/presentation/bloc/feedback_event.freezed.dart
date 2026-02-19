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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedbackViewed value)?  viewed,TResult Function( FeedbackSubmit value)?  submit,TResult Function( FeedbackMessageChanged value)?  messageChanged,TResult Function( FeedbackCooldownEnded value)?  cooldownEnded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedbackViewed() when viewed != null:
return viewed(_that);case FeedbackSubmit() when submit != null:
return submit(_that);case FeedbackMessageChanged() when messageChanged != null:
return messageChanged(_that);case FeedbackCooldownEnded() when cooldownEnded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedbackViewed value)  viewed,required TResult Function( FeedbackSubmit value)  submit,required TResult Function( FeedbackMessageChanged value)  messageChanged,required TResult Function( FeedbackCooldownEnded value)  cooldownEnded,}){
final _that = this;
switch (_that) {
case FeedbackViewed():
return viewed(_that);case FeedbackSubmit():
return submit(_that);case FeedbackMessageChanged():
return messageChanged(_that);case FeedbackCooldownEnded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedbackViewed value)?  viewed,TResult? Function( FeedbackSubmit value)?  submit,TResult? Function( FeedbackMessageChanged value)?  messageChanged,TResult? Function( FeedbackCooldownEnded value)?  cooldownEnded,}){
final _that = this;
switch (_that) {
case FeedbackViewed() when viewed != null:
return viewed(_that);case FeedbackSubmit() when submit != null:
return submit(_that);case FeedbackMessageChanged() when messageChanged != null:
return messageChanged(_that);case FeedbackCooldownEnded() when cooldownEnded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? intentSource)?  viewed,TResult Function( String message)?  submit,TResult Function( String message)?  messageChanged,TResult Function()?  cooldownEnded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedbackViewed() when viewed != null:
return viewed(_that.intentSource);case FeedbackSubmit() when submit != null:
return submit(_that.message);case FeedbackMessageChanged() when messageChanged != null:
return messageChanged(_that.message);case FeedbackCooldownEnded() when cooldownEnded != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? intentSource)  viewed,required TResult Function( String message)  submit,required TResult Function( String message)  messageChanged,required TResult Function()  cooldownEnded,}) {final _that = this;
switch (_that) {
case FeedbackViewed():
return viewed(_that.intentSource);case FeedbackSubmit():
return submit(_that.message);case FeedbackMessageChanged():
return messageChanged(_that.message);case FeedbackCooldownEnded():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? intentSource)?  viewed,TResult? Function( String message)?  submit,TResult? Function( String message)?  messageChanged,TResult? Function()?  cooldownEnded,}) {final _that = this;
switch (_that) {
case FeedbackViewed() when viewed != null:
return viewed(_that.intentSource);case FeedbackSubmit() when submit != null:
return submit(_that.message);case FeedbackMessageChanged() when messageChanged != null:
return messageChanged(_that.message);case FeedbackCooldownEnded() when cooldownEnded != null:
return cooldownEnded();case _:
  return null;

}
}

}

/// @nodoc


class FeedbackViewed implements FeedbackEvent {
  const FeedbackViewed({this.intentSource});
  

 final  String? intentSource;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackViewedCopyWith<FeedbackViewed> get copyWith => _$FeedbackViewedCopyWithImpl<FeedbackViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackViewed&&(identical(other.intentSource, intentSource) || other.intentSource == intentSource));
}


@override
int get hashCode => Object.hash(runtimeType,intentSource);

@override
String toString() {
  return 'FeedbackEvent.viewed(intentSource: $intentSource)';
}


}

/// @nodoc
abstract mixin class $FeedbackViewedCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $FeedbackViewedCopyWith(FeedbackViewed value, $Res Function(FeedbackViewed) _then) = _$FeedbackViewedCopyWithImpl;
@useResult
$Res call({
 String? intentSource
});




}
/// @nodoc
class _$FeedbackViewedCopyWithImpl<$Res>
    implements $FeedbackViewedCopyWith<$Res> {
  _$FeedbackViewedCopyWithImpl(this._self, this._then);

  final FeedbackViewed _self;
  final $Res Function(FeedbackViewed) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? intentSource = freezed,}) {
  return _then(FeedbackViewed(
intentSource: freezed == intentSource ? _self.intentSource : intentSource // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FeedbackSubmit implements FeedbackEvent {
  const FeedbackSubmit(this.message);
  

 final  String message;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackSubmitCopyWith<FeedbackSubmit> get copyWith => _$FeedbackSubmitCopyWithImpl<FeedbackSubmit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackSubmit&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedbackEvent.submit(message: $message)';
}


}

/// @nodoc
abstract mixin class $FeedbackSubmitCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $FeedbackSubmitCopyWith(FeedbackSubmit value, $Res Function(FeedbackSubmit) _then) = _$FeedbackSubmitCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FeedbackSubmitCopyWithImpl<$Res>
    implements $FeedbackSubmitCopyWith<$Res> {
  _$FeedbackSubmitCopyWithImpl(this._self, this._then);

  final FeedbackSubmit _self;
  final $Res Function(FeedbackSubmit) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FeedbackSubmit(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FeedbackMessageChanged implements FeedbackEvent {
  const FeedbackMessageChanged(this.message);
  

 final  String message;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackMessageChangedCopyWith<FeedbackMessageChanged> get copyWith => _$FeedbackMessageChangedCopyWithImpl<FeedbackMessageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackMessageChanged&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedbackEvent.messageChanged(message: $message)';
}


}

/// @nodoc
abstract mixin class $FeedbackMessageChangedCopyWith<$Res> implements $FeedbackEventCopyWith<$Res> {
  factory $FeedbackMessageChangedCopyWith(FeedbackMessageChanged value, $Res Function(FeedbackMessageChanged) _then) = _$FeedbackMessageChangedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FeedbackMessageChangedCopyWithImpl<$Res>
    implements $FeedbackMessageChangedCopyWith<$Res> {
  _$FeedbackMessageChangedCopyWithImpl(this._self, this._then);

  final FeedbackMessageChanged _self;
  final $Res Function(FeedbackMessageChanged) _then;

/// Create a copy of FeedbackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FeedbackMessageChanged(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FeedbackCooldownEnded implements FeedbackEvent {
  const FeedbackCooldownEnded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackCooldownEnded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedbackEvent.cooldownEnded()';
}


}




// dart format on
