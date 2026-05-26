// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_rating_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRatingDto {

 String get rating; String get question;@JsonKey(name: 'ai_response') String get aiResponse;@TimestampConverter() DateTime get time;@JsonKey(name: 'company_name') String get companyName;@JsonKey(name: 'company_ticker') String get companyTicker;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'assistant_message_id') String get assistantMessageId;
/// Create a copy of ChatRatingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRatingDtoCopyWith<ChatRatingDto> get copyWith => _$ChatRatingDtoCopyWithImpl<ChatRatingDto>(this as ChatRatingDto, _$identity);

  /// Serializes this ChatRatingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRatingDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.question, question) || other.question == question)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.time, time) || other.time == time)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.assistantMessageId, assistantMessageId) || other.assistantMessageId == assistantMessageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,question,aiResponse,time,companyName,companyTicker,userId,assistantMessageId);

@override
String toString() {
  return 'ChatRatingDto(rating: $rating, question: $question, aiResponse: $aiResponse, time: $time, companyName: $companyName, companyTicker: $companyTicker, userId: $userId, assistantMessageId: $assistantMessageId)';
}


}

/// @nodoc
abstract mixin class $ChatRatingDtoCopyWith<$Res>  {
  factory $ChatRatingDtoCopyWith(ChatRatingDto value, $Res Function(ChatRatingDto) _then) = _$ChatRatingDtoCopyWithImpl;
@useResult
$Res call({
 String rating, String question,@JsonKey(name: 'ai_response') String aiResponse,@TimestampConverter() DateTime time,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_ticker') String companyTicker,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'assistant_message_id') String assistantMessageId
});




}
/// @nodoc
class _$ChatRatingDtoCopyWithImpl<$Res>
    implements $ChatRatingDtoCopyWith<$Res> {
  _$ChatRatingDtoCopyWithImpl(this._self, this._then);

  final ChatRatingDto _self;
  final $Res Function(ChatRatingDto) _then;

/// Create a copy of ChatRatingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? question = null,Object? aiResponse = null,Object? time = null,Object? companyName = null,Object? companyTicker = null,Object? userId = null,Object? assistantMessageId = null,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,aiResponse: null == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyTicker: null == companyTicker ? _self.companyTicker : companyTicker // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,assistantMessageId: null == assistantMessageId ? _self.assistantMessageId : assistantMessageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRatingDto].
extension ChatRatingDtoPatterns on ChatRatingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRatingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRatingDto() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRatingDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatRatingDto():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRatingDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRatingDto() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String rating,  String question, @JsonKey(name: 'ai_response')  String aiResponse, @TimestampConverter()  DateTime time, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_ticker')  String companyTicker, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'assistant_message_id')  String assistantMessageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRatingDto() when $default != null:
return $default(_that.rating,_that.question,_that.aiResponse,_that.time,_that.companyName,_that.companyTicker,_that.userId,_that.assistantMessageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String rating,  String question, @JsonKey(name: 'ai_response')  String aiResponse, @TimestampConverter()  DateTime time, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_ticker')  String companyTicker, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'assistant_message_id')  String assistantMessageId)  $default,) {final _that = this;
switch (_that) {
case _ChatRatingDto():
return $default(_that.rating,_that.question,_that.aiResponse,_that.time,_that.companyName,_that.companyTicker,_that.userId,_that.assistantMessageId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String rating,  String question, @JsonKey(name: 'ai_response')  String aiResponse, @TimestampConverter()  DateTime time, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_ticker')  String companyTicker, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'assistant_message_id')  String assistantMessageId)?  $default,) {final _that = this;
switch (_that) {
case _ChatRatingDto() when $default != null:
return $default(_that.rating,_that.question,_that.aiResponse,_that.time,_that.companyName,_that.companyTicker,_that.userId,_that.assistantMessageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRatingDto extends ChatRatingDto {
  const _ChatRatingDto({required this.rating, required this.question, @JsonKey(name: 'ai_response') required this.aiResponse, @TimestampConverter() required this.time, @JsonKey(name: 'company_name') required this.companyName, @JsonKey(name: 'company_ticker') required this.companyTicker, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'assistant_message_id') required this.assistantMessageId}): super._();
  factory _ChatRatingDto.fromJson(Map<String, dynamic> json) => _$ChatRatingDtoFromJson(json);

@override final  String rating;
@override final  String question;
@override@JsonKey(name: 'ai_response') final  String aiResponse;
@override@TimestampConverter() final  DateTime time;
@override@JsonKey(name: 'company_name') final  String companyName;
@override@JsonKey(name: 'company_ticker') final  String companyTicker;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'assistant_message_id') final  String assistantMessageId;

/// Create a copy of ChatRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRatingDtoCopyWith<_ChatRatingDto> get copyWith => __$ChatRatingDtoCopyWithImpl<_ChatRatingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRatingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRatingDto&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.question, question) || other.question == question)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.time, time) || other.time == time)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.assistantMessageId, assistantMessageId) || other.assistantMessageId == assistantMessageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,question,aiResponse,time,companyName,companyTicker,userId,assistantMessageId);

@override
String toString() {
  return 'ChatRatingDto(rating: $rating, question: $question, aiResponse: $aiResponse, time: $time, companyName: $companyName, companyTicker: $companyTicker, userId: $userId, assistantMessageId: $assistantMessageId)';
}


}

/// @nodoc
abstract mixin class _$ChatRatingDtoCopyWith<$Res> implements $ChatRatingDtoCopyWith<$Res> {
  factory _$ChatRatingDtoCopyWith(_ChatRatingDto value, $Res Function(_ChatRatingDto) _then) = __$ChatRatingDtoCopyWithImpl;
@override @useResult
$Res call({
 String rating, String question,@JsonKey(name: 'ai_response') String aiResponse,@TimestampConverter() DateTime time,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_ticker') String companyTicker,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'assistant_message_id') String assistantMessageId
});




}
/// @nodoc
class __$ChatRatingDtoCopyWithImpl<$Res>
    implements _$ChatRatingDtoCopyWith<$Res> {
  __$ChatRatingDtoCopyWithImpl(this._self, this._then);

  final _ChatRatingDto _self;
  final $Res Function(_ChatRatingDto) _then;

/// Create a copy of ChatRatingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? question = null,Object? aiResponse = null,Object? time = null,Object? companyName = null,Object? companyTicker = null,Object? userId = null,Object? assistantMessageId = null,}) {
  return _then(_ChatRatingDto(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,aiResponse: null == aiResponse ? _self.aiResponse : aiResponse // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyTicker: null == companyTicker ? _self.companyTicker : companyTicker // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,assistantMessageId: null == assistantMessageId ? _self.assistantMessageId : assistantMessageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
