// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bizzie_chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BizzieChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BizzieChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BizzieChatEvent()';
}


}

/// @nodoc
class $BizzieChatEventCopyWith<$Res>  {
$BizzieChatEventCopyWith(BizzieChatEvent _, $Res Function(BizzieChatEvent) __);
}


/// Adds pattern-matching-related methods to [BizzieChatEvent].
extension BizzieChatEventPatterns on BizzieChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SessionStarted value)?  sessionStarted,TResult Function( _MessageSent value)?  messageSent,TResult Function( _Reset value)?  reset,TResult Function( _MessagesLoaded value)?  messagesLoaded,TResult Function( _MessagesLoadFailed value)?  messagesLoadFailed,TResult Function( _SseTokenReceived value)?  sseTokenReceived,TResult Function( _SseDone value)?  sseDone,TResult Function( _SseFailed value)?  sseFailed,TResult Function( _MessageRated value)?  messageRated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionStarted() when sessionStarted != null:
return sessionStarted(_that);case _MessageSent() when messageSent != null:
return messageSent(_that);case _Reset() when reset != null:
return reset(_that);case _MessagesLoaded() when messagesLoaded != null:
return messagesLoaded(_that);case _MessagesLoadFailed() when messagesLoadFailed != null:
return messagesLoadFailed(_that);case _SseTokenReceived() when sseTokenReceived != null:
return sseTokenReceived(_that);case _SseDone() when sseDone != null:
return sseDone(_that);case _SseFailed() when sseFailed != null:
return sseFailed(_that);case _MessageRated() when messageRated != null:
return messageRated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SessionStarted value)  sessionStarted,required TResult Function( _MessageSent value)  messageSent,required TResult Function( _Reset value)  reset,required TResult Function( _MessagesLoaded value)  messagesLoaded,required TResult Function( _MessagesLoadFailed value)  messagesLoadFailed,required TResult Function( _SseTokenReceived value)  sseTokenReceived,required TResult Function( _SseDone value)  sseDone,required TResult Function( _SseFailed value)  sseFailed,required TResult Function( _MessageRated value)  messageRated,}){
final _that = this;
switch (_that) {
case _SessionStarted():
return sessionStarted(_that);case _MessageSent():
return messageSent(_that);case _Reset():
return reset(_that);case _MessagesLoaded():
return messagesLoaded(_that);case _MessagesLoadFailed():
return messagesLoadFailed(_that);case _SseTokenReceived():
return sseTokenReceived(_that);case _SseDone():
return sseDone(_that);case _SseFailed():
return sseFailed(_that);case _MessageRated():
return messageRated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SessionStarted value)?  sessionStarted,TResult? Function( _MessageSent value)?  messageSent,TResult? Function( _Reset value)?  reset,TResult? Function( _MessagesLoaded value)?  messagesLoaded,TResult? Function( _MessagesLoadFailed value)?  messagesLoadFailed,TResult? Function( _SseTokenReceived value)?  sseTokenReceived,TResult? Function( _SseDone value)?  sseDone,TResult? Function( _SseFailed value)?  sseFailed,TResult? Function( _MessageRated value)?  messageRated,}){
final _that = this;
switch (_that) {
case _SessionStarted() when sessionStarted != null:
return sessionStarted(_that);case _MessageSent() when messageSent != null:
return messageSent(_that);case _Reset() when reset != null:
return reset(_that);case _MessagesLoaded() when messagesLoaded != null:
return messagesLoaded(_that);case _MessagesLoadFailed() when messagesLoadFailed != null:
return messagesLoadFailed(_that);case _SseTokenReceived() when sseTokenReceived != null:
return sseTokenReceived(_that);case _SseDone() when sseDone != null:
return sseDone(_that);case _SseFailed() when sseFailed != null:
return sseFailed(_that);case _MessageRated() when messageRated != null:
return messageRated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String uid,  String ticker,  String companyName,  String? sessionId)?  sessionStarted,TResult Function( String query)?  messageSent,TResult Function()?  reset,TResult Function( List<ChatMessage> messages)?  messagesLoaded,TResult Function( Failure failure)?  messagesLoadFailed,TResult Function( String token)?  sseTokenReceived,TResult Function( List<String> followUps,  String? source)?  sseDone,TResult Function( String message)?  sseFailed,TResult Function( RatingType rating,  String question,  String aiResponse,  String companyName,  String companyTicker)?  messageRated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionStarted() when sessionStarted != null:
return sessionStarted(_that.uid,_that.ticker,_that.companyName,_that.sessionId);case _MessageSent() when messageSent != null:
return messageSent(_that.query);case _Reset() when reset != null:
return reset();case _MessagesLoaded() when messagesLoaded != null:
return messagesLoaded(_that.messages);case _MessagesLoadFailed() when messagesLoadFailed != null:
return messagesLoadFailed(_that.failure);case _SseTokenReceived() when sseTokenReceived != null:
return sseTokenReceived(_that.token);case _SseDone() when sseDone != null:
return sseDone(_that.followUps,_that.source);case _SseFailed() when sseFailed != null:
return sseFailed(_that.message);case _MessageRated() when messageRated != null:
return messageRated(_that.rating,_that.question,_that.aiResponse,_that.companyName,_that.companyTicker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String uid,  String ticker,  String companyName,  String? sessionId)  sessionStarted,required TResult Function( String query)  messageSent,required TResult Function()  reset,required TResult Function( List<ChatMessage> messages)  messagesLoaded,required TResult Function( Failure failure)  messagesLoadFailed,required TResult Function( String token)  sseTokenReceived,required TResult Function( List<String> followUps,  String? source)  sseDone,required TResult Function( String message)  sseFailed,required TResult Function( RatingType rating,  String question,  String aiResponse,  String companyName,  String companyTicker)  messageRated,}) {final _that = this;
switch (_that) {
case _SessionStarted():
return sessionStarted(_that.uid,_that.ticker,_that.companyName,_that.sessionId);case _MessageSent():
return messageSent(_that.query);case _Reset():
return reset();case _MessagesLoaded():
return messagesLoaded(_that.messages);case _MessagesLoadFailed():
return messagesLoadFailed(_that.failure);case _SseTokenReceived():
return sseTokenReceived(_that.token);case _SseDone():
return sseDone(_that.followUps,_that.source);case _SseFailed():
return sseFailed(_that.message);case _MessageRated():
return messageRated(_that.rating,_that.question,_that.aiResponse,_that.companyName,_that.companyTicker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String uid,  String ticker,  String companyName,  String? sessionId)?  sessionStarted,TResult? Function( String query)?  messageSent,TResult? Function()?  reset,TResult? Function( List<ChatMessage> messages)?  messagesLoaded,TResult? Function( Failure failure)?  messagesLoadFailed,TResult? Function( String token)?  sseTokenReceived,TResult? Function( List<String> followUps,  String? source)?  sseDone,TResult? Function( String message)?  sseFailed,TResult? Function( RatingType rating,  String question,  String aiResponse,  String companyName,  String companyTicker)?  messageRated,}) {final _that = this;
switch (_that) {
case _SessionStarted() when sessionStarted != null:
return sessionStarted(_that.uid,_that.ticker,_that.companyName,_that.sessionId);case _MessageSent() when messageSent != null:
return messageSent(_that.query);case _Reset() when reset != null:
return reset();case _MessagesLoaded() when messagesLoaded != null:
return messagesLoaded(_that.messages);case _MessagesLoadFailed() when messagesLoadFailed != null:
return messagesLoadFailed(_that.failure);case _SseTokenReceived() when sseTokenReceived != null:
return sseTokenReceived(_that.token);case _SseDone() when sseDone != null:
return sseDone(_that.followUps,_that.source);case _SseFailed() when sseFailed != null:
return sseFailed(_that.message);case _MessageRated() when messageRated != null:
return messageRated(_that.rating,_that.question,_that.aiResponse,_that.companyName,_that.companyTicker);case _:
  return null;

}
}

}

/// @nodoc


class _SessionStarted implements BizzieChatEvent {
  const _SessionStarted({required this.uid, required this.ticker, required this.companyName, this.sessionId});
  

 final  String uid;
 final  String ticker;
 final  String companyName;
 final  String? sessionId;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionStartedCopyWith<_SessionStarted> get copyWith => __$SessionStartedCopyWithImpl<_SessionStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionStarted&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,uid,ticker,companyName,sessionId);

@override
String toString() {
  return 'BizzieChatEvent.sessionStarted(uid: $uid, ticker: $ticker, companyName: $companyName, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$SessionStartedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$SessionStartedCopyWith(_SessionStarted value, $Res Function(_SessionStarted) _then) = __$SessionStartedCopyWithImpl;
@useResult
$Res call({
 String uid, String ticker, String companyName, String? sessionId
});




}
/// @nodoc
class __$SessionStartedCopyWithImpl<$Res>
    implements _$SessionStartedCopyWith<$Res> {
  __$SessionStartedCopyWithImpl(this._self, this._then);

  final _SessionStarted _self;
  final $Res Function(_SessionStarted) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? ticker = null,Object? companyName = null,Object? sessionId = freezed,}) {
  return _then(_SessionStarted(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _MessageSent implements BizzieChatEvent {
  const _MessageSent({required this.query});
  

 final  String query;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageSentCopyWith<_MessageSent> get copyWith => __$MessageSentCopyWithImpl<_MessageSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageSent&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'BizzieChatEvent.messageSent(query: $query)';
}


}

/// @nodoc
abstract mixin class _$MessageSentCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$MessageSentCopyWith(_MessageSent value, $Res Function(_MessageSent) _then) = __$MessageSentCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$MessageSentCopyWithImpl<$Res>
    implements _$MessageSentCopyWith<$Res> {
  __$MessageSentCopyWithImpl(this._self, this._then);

  final _MessageSent _self;
  final $Res Function(_MessageSent) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_MessageSent(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Reset implements BizzieChatEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BizzieChatEvent.reset()';
}


}




/// @nodoc


class _MessagesLoaded implements BizzieChatEvent {
  const _MessagesLoaded(final  List<ChatMessage> messages): _messages = messages;
  

 final  List<ChatMessage> _messages;
 List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesLoadedCopyWith<_MessagesLoaded> get copyWith => __$MessagesLoadedCopyWithImpl<_MessagesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesLoaded&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'BizzieChatEvent.messagesLoaded(messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$MessagesLoadedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$MessagesLoadedCopyWith(_MessagesLoaded value, $Res Function(_MessagesLoaded) _then) = __$MessagesLoadedCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class __$MessagesLoadedCopyWithImpl<$Res>
    implements _$MessagesLoadedCopyWith<$Res> {
  __$MessagesLoadedCopyWithImpl(this._self, this._then);

  final _MessagesLoaded _self;
  final $Res Function(_MessagesLoaded) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(_MessagesLoaded(
null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}


}

/// @nodoc


class _MessagesLoadFailed implements BizzieChatEvent {
  const _MessagesLoadFailed(this.failure);
  

 final  Failure failure;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesLoadFailedCopyWith<_MessagesLoadFailed> get copyWith => __$MessagesLoadFailedCopyWithImpl<_MessagesLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesLoadFailed&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'BizzieChatEvent.messagesLoadFailed(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$MessagesLoadFailedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$MessagesLoadFailedCopyWith(_MessagesLoadFailed value, $Res Function(_MessagesLoadFailed) _then) = __$MessagesLoadFailedCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$MessagesLoadFailedCopyWithImpl<$Res>
    implements _$MessagesLoadFailedCopyWith<$Res> {
  __$MessagesLoadFailedCopyWithImpl(this._self, this._then);

  final _MessagesLoadFailed _self;
  final $Res Function(_MessagesLoadFailed) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_MessagesLoadFailed(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class _SseTokenReceived implements BizzieChatEvent {
  const _SseTokenReceived(this.token);
  

 final  String token;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SseTokenReceivedCopyWith<_SseTokenReceived> get copyWith => __$SseTokenReceivedCopyWithImpl<_SseTokenReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SseTokenReceived&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode => Object.hash(runtimeType,token);

@override
String toString() {
  return 'BizzieChatEvent.sseTokenReceived(token: $token)';
}


}

/// @nodoc
abstract mixin class _$SseTokenReceivedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$SseTokenReceivedCopyWith(_SseTokenReceived value, $Res Function(_SseTokenReceived) _then) = __$SseTokenReceivedCopyWithImpl;
@useResult
$Res call({
 String token
});




}
/// @nodoc
class __$SseTokenReceivedCopyWithImpl<$Res>
    implements _$SseTokenReceivedCopyWith<$Res> {
  __$SseTokenReceivedCopyWithImpl(this._self, this._then);

  final _SseTokenReceived _self;
  final $Res Function(_SseTokenReceived) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,}) {
  return _then(_SseTokenReceived(
null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SseDone implements BizzieChatEvent {
  const _SseDone({required final  List<String> followUps, this.source}): _followUps = followUps;
  

 final  List<String> _followUps;
 List<String> get followUps {
  if (_followUps is EqualUnmodifiableListView) return _followUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followUps);
}

 final  String? source;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SseDoneCopyWith<_SseDone> get copyWith => __$SseDoneCopyWithImpl<_SseDone>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SseDone&&const DeepCollectionEquality().equals(other._followUps, _followUps)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_followUps),source);

@override
String toString() {
  return 'BizzieChatEvent.sseDone(followUps: $followUps, source: $source)';
}


}

/// @nodoc
abstract mixin class _$SseDoneCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$SseDoneCopyWith(_SseDone value, $Res Function(_SseDone) _then) = __$SseDoneCopyWithImpl;
@useResult
$Res call({
 List<String> followUps, String? source
});




}
/// @nodoc
class __$SseDoneCopyWithImpl<$Res>
    implements _$SseDoneCopyWith<$Res> {
  __$SseDoneCopyWithImpl(this._self, this._then);

  final _SseDone _self;
  final $Res Function(_SseDone) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? followUps = null,Object? source = freezed,}) {
  return _then(_SseDone(
followUps: null == followUps ? _self._followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SseFailed implements BizzieChatEvent {
  const _SseFailed(this.message);
  

 final  String message;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SseFailedCopyWith<_SseFailed> get copyWith => __$SseFailedCopyWithImpl<_SseFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SseFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BizzieChatEvent.sseFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SseFailedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$SseFailedCopyWith(_SseFailed value, $Res Function(_SseFailed) _then) = __$SseFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SseFailedCopyWithImpl<$Res>
    implements _$SseFailedCopyWith<$Res> {
  __$SseFailedCopyWithImpl(this._self, this._then);

  final _SseFailed _self;
  final $Res Function(_SseFailed) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SseFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MessageRated implements BizzieChatEvent {
  const _MessageRated({required this.rating, required this.question, required this.aiResponse, required this.companyName, required this.companyTicker});
  

 final  RatingType rating;
 final  String question;
 final  String aiResponse;
 final  String companyName;
 final  String companyTicker;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageRatedCopyWith<_MessageRated> get copyWith => __$MessageRatedCopyWithImpl<_MessageRated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageRated&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.question, question) || other.question == question)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker));
}


@override
int get hashCode => Object.hash(runtimeType,rating,question,aiResponse,companyName,companyTicker);

@override
String toString() {
  return 'BizzieChatEvent.messageRated(rating: $rating, question: $question, aiResponse: $aiResponse, companyName: $companyName, companyTicker: $companyTicker)';
}


}

/// @nodoc
abstract mixin class _$MessageRatedCopyWith<$Res> implements $BizzieChatEventCopyWith<$Res> {
  factory _$MessageRatedCopyWith(_MessageRated value, $Res Function(_MessageRated) _then) = __$MessageRatedCopyWithImpl;
@useResult
$Res call({
 RatingType rating, String question, String aiResponse, String companyName, String companyTicker
});




}
/// @nodoc
class __$MessageRatedCopyWithImpl<$Res>
    implements _$MessageRatedCopyWith<$Res> {
  __$MessageRatedCopyWithImpl(this._self, this._then);

  final _MessageRated _self;
  final $Res Function(_MessageRated) _then;

/// Create a copy of BizzieChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? question = null,Object? aiResponse = null,Object? companyName = null,Object? companyTicker = null,}) {
  return _then(_MessageRated(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingType,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,aiResponse: null == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyTicker: null == companyTicker ? _self.companyTicker : companyTicker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
