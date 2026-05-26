// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_sse_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatSseEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSseEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatSseEvent()';
}


}

/// @nodoc
class $ChatSseEventCopyWith<$Res>  {
$ChatSseEventCopyWith(ChatSseEvent _, $Res Function(ChatSseEvent) __);
}


/// Adds pattern-matching-related methods to [ChatSseEvent].
extension ChatSseEventPatterns on ChatSseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatTokenEvent value)?  token,TResult Function( ChatDoneEvent value)?  done,TResult Function( ChatErrorEvent value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatTokenEvent() when token != null:
return token(_that);case ChatDoneEvent() when done != null:
return done(_that);case ChatErrorEvent() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatTokenEvent value)  token,required TResult Function( ChatDoneEvent value)  done,required TResult Function( ChatErrorEvent value)  error,}){
final _that = this;
switch (_that) {
case ChatTokenEvent():
return token(_that);case ChatDoneEvent():
return done(_that);case ChatErrorEvent():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatTokenEvent value)?  token,TResult? Function( ChatDoneEvent value)?  done,TResult? Function( ChatErrorEvent value)?  error,}){
final _that = this;
switch (_that) {
case ChatTokenEvent() when token != null:
return token(_that);case ChatDoneEvent() when done != null:
return done(_that);case ChatErrorEvent() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String token)?  token,TResult Function( List<String> followUps,  String? source,  String? routePath)?  done,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatTokenEvent() when token != null:
return token(_that.token);case ChatDoneEvent() when done != null:
return done(_that.followUps,_that.source,_that.routePath);case ChatErrorEvent() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String token)  token,required TResult Function( List<String> followUps,  String? source,  String? routePath)  done,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChatTokenEvent():
return token(_that.token);case ChatDoneEvent():
return done(_that.followUps,_that.source,_that.routePath);case ChatErrorEvent():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String token)?  token,TResult? Function( List<String> followUps,  String? source,  String? routePath)?  done,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChatTokenEvent() when token != null:
return token(_that.token);case ChatDoneEvent() when done != null:
return done(_that.followUps,_that.source,_that.routePath);case ChatErrorEvent() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatTokenEvent implements ChatSseEvent {
  const ChatTokenEvent({required this.token});
  

 final  String token;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTokenEventCopyWith<ChatTokenEvent> get copyWith => _$ChatTokenEventCopyWithImpl<ChatTokenEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTokenEvent&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'ChatSseEvent.token(token: $token)';
}


}

/// @nodoc
abstract mixin class $ChatTokenEventCopyWith<$Res> implements $ChatSseEventCopyWith<$Res> {
  factory $ChatTokenEventCopyWith(ChatTokenEvent value, $Res Function(ChatTokenEvent) _then) = _$ChatTokenEventCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class _$ChatTokenEventCopyWithImpl<$Res>
    implements $ChatTokenEventCopyWith<$Res> {
  _$ChatTokenEventCopyWithImpl(this._self, this._then);

  final ChatTokenEvent _self;
  final $Res Function(ChatTokenEvent) _then;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(ChatTokenEvent(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatDoneEvent implements ChatSseEvent {
  const ChatDoneEvent({required final  List<String> followUps, this.source, this.routePath}): _followUps = followUps;
  

 final  List<String> _followUps;
 List<String> get followUps {
  if (_followUps is EqualUnmodifiableListView) return _followUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followUps);
}

 final  String? source;
 final  String? routePath;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDoneEventCopyWith<ChatDoneEvent> get copyWith => _$ChatDoneEventCopyWithImpl<ChatDoneEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDoneEvent&&const DeepCollectionEquality().equals(other._followUps, _followUps)&&(identical(other.source, source) || other.source == source)&&(identical(other.routePath, routePath) || other.routePath == routePath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_followUps),source,routePath);

@override
String toString() {
  return 'ChatSseEvent.done(followUps: $followUps, source: $source, routePath: $routePath)';
}


}

/// @nodoc
abstract mixin class $ChatDoneEventCopyWith<$Res> implements $ChatSseEventCopyWith<$Res> {
  factory $ChatDoneEventCopyWith(ChatDoneEvent value, $Res Function(ChatDoneEvent) _then) = _$ChatDoneEventCopyWithImpl;
@useResult
$Res call({
 List<String> followUps, String? source, String? routePath
});




}
/// @nodoc
class _$ChatDoneEventCopyWithImpl<$Res>
    implements $ChatDoneEventCopyWith<$Res> {
  _$ChatDoneEventCopyWithImpl(this._self, this._then);

  final ChatDoneEvent _self;
  final $Res Function(ChatDoneEvent) _then;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? followUps = null,Object? source = freezed,Object? routePath = freezed,}) {
  return _then(ChatDoneEvent(
followUps: null == followUps ? _self._followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,routePath: freezed == routePath ? _self.routePath : routePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChatErrorEvent implements ChatSseEvent {
  const ChatErrorEvent({required this.message});
  

 final  String message;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatErrorEventCopyWith<ChatErrorEvent> get copyWith => _$ChatErrorEventCopyWithImpl<ChatErrorEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatErrorEvent&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatSseEvent.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatErrorEventCopyWith<$Res> implements $ChatSseEventCopyWith<$Res> {
  factory $ChatErrorEventCopyWith(ChatErrorEvent value, $Res Function(ChatErrorEvent) _then) = _$ChatErrorEventCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatErrorEventCopyWithImpl<$Res>
    implements $ChatErrorEventCopyWith<$Res> {
  _$ChatErrorEventCopyWithImpl(this._self, this._then);

  final ChatErrorEvent _self;
  final $Res Function(ChatErrorEvent) _then;

/// Create a copy of ChatSseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatErrorEvent(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
