// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatRating {

 RatingType get rating; String get question; String get aiResponse; DateTime get time; String get companyName; String get companyTicker; String get userId; String get assistantMessageId;
/// Create a copy of ChatRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRatingCopyWith<ChatRating> get copyWith => _$ChatRatingCopyWithImpl<ChatRating>(this as ChatRating, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRating&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.question, question) || other.question == question)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.time, time) || other.time == time)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.assistantMessageId, assistantMessageId) || other.assistantMessageId == assistantMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,rating,question,aiResponse,time,companyName,companyTicker,userId,assistantMessageId);

@override
String toString() {
  return 'ChatRating(rating: $rating, question: $question, aiResponse: $aiResponse, time: $time, companyName: $companyName, companyTicker: $companyTicker, userId: $userId, assistantMessageId: $assistantMessageId)';
}


}

/// @nodoc
abstract mixin class $ChatRatingCopyWith<$Res>  {
  factory $ChatRatingCopyWith(ChatRating value, $Res Function(ChatRating) _then) = _$ChatRatingCopyWithImpl;
@useResult
$Res call({
 RatingType rating, String question, String aiResponse, DateTime time, String companyName, String companyTicker, String userId, String assistantMessageId
});




}
/// @nodoc
class _$ChatRatingCopyWithImpl<$Res>
    implements $ChatRatingCopyWith<$Res> {
  _$ChatRatingCopyWithImpl(this._self, this._then);

  final ChatRating _self;
  final $Res Function(ChatRating) _then;

/// Create a copy of ChatRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? question = null,Object? aiResponse = null,Object? time = null,Object? companyName = null,Object? companyTicker = null,Object? userId = null,Object? assistantMessageId = null,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingType,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ChatRating].
extension ChatRatingPatterns on ChatRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRating value)  $default,){
final _that = this;
switch (_that) {
case _ChatRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRating value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RatingType rating,  String question,  String aiResponse,  DateTime time,  String companyName,  String companyTicker,  String userId,  String assistantMessageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRating() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RatingType rating,  String question,  String aiResponse,  DateTime time,  String companyName,  String companyTicker,  String userId,  String assistantMessageId)  $default,) {final _that = this;
switch (_that) {
case _ChatRating():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RatingType rating,  String question,  String aiResponse,  DateTime time,  String companyName,  String companyTicker,  String userId,  String assistantMessageId)?  $default,) {final _that = this;
switch (_that) {
case _ChatRating() when $default != null:
return $default(_that.rating,_that.question,_that.aiResponse,_that.time,_that.companyName,_that.companyTicker,_that.userId,_that.assistantMessageId);case _:
  return null;

}
}

}

/// @nodoc


class _ChatRating implements ChatRating {
  const _ChatRating({required this.rating, required this.question, required this.aiResponse, required this.time, required this.companyName, required this.companyTicker, required this.userId, required this.assistantMessageId});
  

@override final  RatingType rating;
@override final  String question;
@override final  String aiResponse;
@override final  DateTime time;
@override final  String companyName;
@override final  String companyTicker;
@override final  String userId;
@override final  String assistantMessageId;

/// Create a copy of ChatRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRatingCopyWith<_ChatRating> get copyWith => __$ChatRatingCopyWithImpl<_ChatRating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRating&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.question, question) || other.question == question)&&(identical(other.aiResponse, aiResponse) || other.aiResponse == aiResponse)&&(identical(other.time, time) || other.time == time)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.assistantMessageId, assistantMessageId) || other.assistantMessageId == assistantMessageId));
}


@override
int get hashCode => Object.hash(runtimeType,rating,question,aiResponse,time,companyName,companyTicker,userId,assistantMessageId);

@override
String toString() {
  return 'ChatRating(rating: $rating, question: $question, aiResponse: $aiResponse, time: $time, companyName: $companyName, companyTicker: $companyTicker, userId: $userId, assistantMessageId: $assistantMessageId)';
}


}

/// @nodoc
abstract mixin class _$ChatRatingCopyWith<$Res> implements $ChatRatingCopyWith<$Res> {
  factory _$ChatRatingCopyWith(_ChatRating value, $Res Function(_ChatRating) _then) = __$ChatRatingCopyWithImpl;
@override @useResult
$Res call({
 RatingType rating, String question, String aiResponse, DateTime time, String companyName, String companyTicker, String userId, String assistantMessageId
});




}
/// @nodoc
class __$ChatRatingCopyWithImpl<$Res>
    implements _$ChatRatingCopyWith<$Res> {
  __$ChatRatingCopyWithImpl(this._self, this._then);

  final _ChatRating _self;
  final $Res Function(_ChatRating) _then;

/// Create a copy of ChatRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? question = null,Object? aiResponse = null,Object? time = null,Object? companyName = null,Object? companyTicker = null,Object? userId = null,Object? assistantMessageId = null,}) {
  return _then(_ChatRating(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RatingType,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
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
