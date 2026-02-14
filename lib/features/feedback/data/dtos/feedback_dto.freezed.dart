// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackDto {

 String get userId; String get userName; String get message;@TimestampConverter() DateTime get timestamp; String? get userEmail; String? get fcmToken; bool get isSubscribed; bool get notificationsEnabled;
/// Create a copy of FeedbackDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackDtoCopyWith<FeedbackDto> get copyWith => _$FeedbackDtoCopyWithImpl<FeedbackDto>(this as FeedbackDto, _$identity);

  /// Serializes this FeedbackDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,message,timestamp,userEmail,fcmToken,isSubscribed,notificationsEnabled);

@override
String toString() {
  return 'FeedbackDto(userId: $userId, userName: $userName, message: $message, timestamp: $timestamp, userEmail: $userEmail, fcmToken: $fcmToken, isSubscribed: $isSubscribed, notificationsEnabled: $notificationsEnabled)';
}


}

/// @nodoc
abstract mixin class $FeedbackDtoCopyWith<$Res>  {
  factory $FeedbackDtoCopyWith(FeedbackDto value, $Res Function(FeedbackDto) _then) = _$FeedbackDtoCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, String message,@TimestampConverter() DateTime timestamp, String? userEmail, String? fcmToken, bool isSubscribed, bool notificationsEnabled
});




}
/// @nodoc
class _$FeedbackDtoCopyWithImpl<$Res>
    implements $FeedbackDtoCopyWith<$Res> {
  _$FeedbackDtoCopyWithImpl(this._self, this._then);

  final FeedbackDto _self;
  final $Res Function(FeedbackDto) _then;

/// Create a copy of FeedbackDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? message = null,Object? timestamp = null,Object? userEmail = freezed,Object? fcmToken = freezed,Object? isSubscribed = null,Object? notificationsEnabled = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,userEmail: freezed == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackDto].
extension FeedbackDtoPatterns on FeedbackDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackDto value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackDto value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  String message, @TimestampConverter()  DateTime timestamp,  String? userEmail,  String? fcmToken,  bool isSubscribed,  bool notificationsEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackDto() when $default != null:
return $default(_that.userId,_that.userName,_that.message,_that.timestamp,_that.userEmail,_that.fcmToken,_that.isSubscribed,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  String message, @TimestampConverter()  DateTime timestamp,  String? userEmail,  String? fcmToken,  bool isSubscribed,  bool notificationsEnabled)  $default,) {final _that = this;
switch (_that) {
case _FeedbackDto():
return $default(_that.userId,_that.userName,_that.message,_that.timestamp,_that.userEmail,_that.fcmToken,_that.isSubscribed,_that.notificationsEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  String message, @TimestampConverter()  DateTime timestamp,  String? userEmail,  String? fcmToken,  bool isSubscribed,  bool notificationsEnabled)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackDto() when $default != null:
return $default(_that.userId,_that.userName,_that.message,_that.timestamp,_that.userEmail,_that.fcmToken,_that.isSubscribed,_that.notificationsEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackDto extends FeedbackDto {
  const _FeedbackDto({required this.userId, required this.userName, required this.message, @TimestampConverter() required this.timestamp, this.userEmail, this.fcmToken, required this.isSubscribed, required this.notificationsEnabled}): super._();
  factory _FeedbackDto.fromJson(Map<String, dynamic> json) => _$FeedbackDtoFromJson(json);

@override final  String userId;
@override final  String userName;
@override final  String message;
@override@TimestampConverter() final  DateTime timestamp;
@override final  String? userEmail;
@override final  String? fcmToken;
@override final  bool isSubscribed;
@override final  bool notificationsEnabled;

/// Create a copy of FeedbackDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackDtoCopyWith<_FeedbackDto> get copyWith => __$FeedbackDtoCopyWithImpl<_FeedbackDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.userEmail, userEmail) || other.userEmail == userEmail)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,message,timestamp,userEmail,fcmToken,isSubscribed,notificationsEnabled);

@override
String toString() {
  return 'FeedbackDto(userId: $userId, userName: $userName, message: $message, timestamp: $timestamp, userEmail: $userEmail, fcmToken: $fcmToken, isSubscribed: $isSubscribed, notificationsEnabled: $notificationsEnabled)';
}


}

/// @nodoc
abstract mixin class _$FeedbackDtoCopyWith<$Res> implements $FeedbackDtoCopyWith<$Res> {
  factory _$FeedbackDtoCopyWith(_FeedbackDto value, $Res Function(_FeedbackDto) _then) = __$FeedbackDtoCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, String message,@TimestampConverter() DateTime timestamp, String? userEmail, String? fcmToken, bool isSubscribed, bool notificationsEnabled
});




}
/// @nodoc
class __$FeedbackDtoCopyWithImpl<$Res>
    implements _$FeedbackDtoCopyWith<$Res> {
  __$FeedbackDtoCopyWithImpl(this._self, this._then);

  final _FeedbackDto _self;
  final $Res Function(_FeedbackDto) _then;

/// Create a copy of FeedbackDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? message = null,Object? timestamp = null,Object? userEmail = freezed,Object? fcmToken = freezed,Object? isSubscribed = null,Object? notificationsEnabled = null,}) {
  return _then(_FeedbackDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,userEmail: freezed == userEmail ? _self.userEmail : userEmail // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
