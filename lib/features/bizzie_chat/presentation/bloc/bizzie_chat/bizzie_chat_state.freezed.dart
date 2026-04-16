// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bizzie_chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BizzieChatState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BizzieChatState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BizzieChatState()';
}


}

/// @nodoc
class $BizzieChatStateCopyWith<$Res>  {
$BizzieChatStateCopyWith(BizzieChatState _, $Res Function(BizzieChatState) __);
}


/// Adds pattern-matching-related methods to [BizzieChatState].
extension BizzieChatStatePatterns on BizzieChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Active value)?  active,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Active() when active != null:
return active(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Active value)  active,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Active():
return active(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Active value)?  active,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Active() when active != null:
return active(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String sessionId,  String uid,  String ticker,  String companyName)?  loading,TResult Function( String sessionId,  String uid,  String ticker,  String companyName,  List<ChatMessage> messages,  List<String> followUps,  bool isStreaming,  String? streamingContent,  String? sseError,  RatingType? rating)?  active,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.sessionId,_that.uid,_that.ticker,_that.companyName);case _Active() when active != null:
return active(_that.sessionId,_that.uid,_that.ticker,_that.companyName,_that.messages,_that.followUps,_that.isStreaming,_that.streamingContent,_that.sseError,_that.rating);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String sessionId,  String uid,  String ticker,  String companyName)  loading,required TResult Function( String sessionId,  String uid,  String ticker,  String companyName,  List<ChatMessage> messages,  List<String> followUps,  bool isStreaming,  String? streamingContent,  String? sseError,  RatingType? rating)  active,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.sessionId,_that.uid,_that.ticker,_that.companyName);case _Active():
return active(_that.sessionId,_that.uid,_that.ticker,_that.companyName,_that.messages,_that.followUps,_that.isStreaming,_that.streamingContent,_that.sseError,_that.rating);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String sessionId,  String uid,  String ticker,  String companyName)?  loading,TResult? Function( String sessionId,  String uid,  String ticker,  String companyName,  List<ChatMessage> messages,  List<String> followUps,  bool isStreaming,  String? streamingContent,  String? sseError,  RatingType? rating)?  active,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.sessionId,_that.uid,_that.ticker,_that.companyName);case _Active() when active != null:
return active(_that.sessionId,_that.uid,_that.ticker,_that.companyName,_that.messages,_that.followUps,_that.isStreaming,_that.streamingContent,_that.sseError,_that.rating);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BizzieChatState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BizzieChatState.initial()';
}


}




/// @nodoc


class _Loading implements BizzieChatState {
  const _Loading({required this.sessionId, required this.uid, required this.ticker, required this.companyName});
  

 final  String sessionId;
 final  String uid;
 final  String ticker;
 final  String companyName;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,uid,ticker,companyName);

@override
String toString() {
  return 'BizzieChatState.loading(sessionId: $sessionId, uid: $uid, ticker: $ticker, companyName: $companyName)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $BizzieChatStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 String sessionId, String uid, String ticker, String companyName
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? uid = null,Object? ticker = null,Object? companyName = null,}) {
  return _then(_Loading(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Active implements BizzieChatState {
  const _Active({required this.sessionId, required this.uid, required this.ticker, required this.companyName, required final  List<ChatMessage> messages, final  List<String> followUps = const <String>[], this.isStreaming = false, this.streamingContent, this.sseError, this.rating}): _messages = messages,_followUps = followUps;
  

 final  String sessionId;
 final  String uid;
 final  String ticker;
 final  String companyName;
 final  List<ChatMessage> _messages;
 List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  List<String> _followUps;
@JsonKey() List<String> get followUps {
  if (_followUps is EqualUnmodifiableListView) return _followUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followUps);
}

@JsonKey() final  bool isStreaming;
 final  String? streamingContent;
 final  String? sseError;
 final  RatingType? rating;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveCopyWith<_Active> get copyWith => __$ActiveCopyWithImpl<_Active>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Active&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&const DeepCollectionEquality().equals(other._messages, _messages)&&const DeepCollectionEquality().equals(other._followUps, _followUps)&&(identical(other.isStreaming, isStreaming) || other.isStreaming == isStreaming)&&(identical(other.streamingContent, streamingContent) || other.streamingContent == streamingContent)&&(identical(other.sseError, sseError) || other.sseError == sseError)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,uid,ticker,companyName,const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_followUps),isStreaming,streamingContent,sseError,rating);

@override
String toString() {
  return 'BizzieChatState.active(sessionId: $sessionId, uid: $uid, ticker: $ticker, companyName: $companyName, messages: $messages, followUps: $followUps, isStreaming: $isStreaming, streamingContent: $streamingContent, sseError: $sseError, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$ActiveCopyWith<$Res> implements $BizzieChatStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) _then) = __$ActiveCopyWithImpl;
@useResult
$Res call({
 String sessionId, String uid, String ticker, String companyName, List<ChatMessage> messages, List<String> followUps, bool isStreaming, String? streamingContent, String? sseError, RatingType? rating
});




}
/// @nodoc
class __$ActiveCopyWithImpl<$Res>
    implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(this._self, this._then);

  final _Active _self;
  final $Res Function(_Active) _then;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? uid = null,Object? ticker = null,Object? companyName = null,Object? messages = null,Object? followUps = null,Object? isStreaming = null,Object? streamingContent = freezed,Object? sseError = freezed,Object? rating = freezed,}) {
  return _then(_Active(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,followUps: null == followUps ? _self._followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>,isStreaming: null == isStreaming ? _self.isStreaming : isStreaming // ignore: cast_nullable_to_non_nullable
as bool,streamingContent: freezed == streamingContent ? _self.streamingContent : streamingContent // ignore: cast_nullable_to_non_nullable
as String?,sseError: freezed == sseError ? _self.sseError : sseError // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingType?,
  ));
}


}

/// @nodoc


class _Failure implements BizzieChatState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'BizzieChatState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $BizzieChatStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of BizzieChatState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
