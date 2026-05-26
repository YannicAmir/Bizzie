// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatSessionDto {

 String get id; String get title; String get ticker; String get companyName;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; int get messageCount;
/// Create a copy of ChatSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSessionDtoCopyWith<ChatSessionDto> get copyWith => _$ChatSessionDtoCopyWithImpl<ChatSessionDto>(this as ChatSessionDto, _$identity);

  /// Serializes this ChatSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,ticker,companyName,createdAt,updatedAt,messageCount);

@override
String toString() {
  return 'ChatSessionDto(id: $id, title: $title, ticker: $ticker, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt, messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class $ChatSessionDtoCopyWith<$Res>  {
  factory $ChatSessionDtoCopyWith(ChatSessionDto value, $Res Function(ChatSessionDto) _then) = _$ChatSessionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ticker, String companyName,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, int messageCount
});




}
/// @nodoc
class _$ChatSessionDtoCopyWithImpl<$Res>
    implements $ChatSessionDtoCopyWith<$Res> {
  _$ChatSessionDtoCopyWithImpl(this._self, this._then);

  final ChatSessionDto _self;
  final $Res Function(ChatSessionDto) _then;

/// Create a copy of ChatSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? ticker = null,Object? companyName = null,Object? createdAt = null,Object? updatedAt = null,Object? messageCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatSessionDto].
extension ChatSessionDtoPatterns on ChatSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ticker,  String companyName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int messageCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSessionDto() when $default != null:
return $default(_that.id,_that.title,_that.ticker,_that.companyName,_that.createdAt,_that.updatedAt,_that.messageCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ticker,  String companyName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int messageCount)  $default,) {final _that = this;
switch (_that) {
case _ChatSessionDto():
return $default(_that.id,_that.title,_that.ticker,_that.companyName,_that.createdAt,_that.updatedAt,_that.messageCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ticker,  String companyName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int messageCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatSessionDto() when $default != null:
return $default(_that.id,_that.title,_that.ticker,_that.companyName,_that.createdAt,_that.updatedAt,_that.messageCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatSessionDto extends ChatSessionDto {
  const _ChatSessionDto({required this.id, required this.title, required this.ticker, required this.companyName, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.messageCount}): super._();
  factory _ChatSessionDto.fromJson(Map<String, dynamic> json) => _$ChatSessionDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String ticker;
@override final  String companyName;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  int messageCount;

/// Create a copy of ChatSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSessionDtoCopyWith<_ChatSessionDto> get copyWith => __$ChatSessionDtoCopyWithImpl<_ChatSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,ticker,companyName,createdAt,updatedAt,messageCount);

@override
String toString() {
  return 'ChatSessionDto(id: $id, title: $title, ticker: $ticker, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt, messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class _$ChatSessionDtoCopyWith<$Res> implements $ChatSessionDtoCopyWith<$Res> {
  factory _$ChatSessionDtoCopyWith(_ChatSessionDto value, $Res Function(_ChatSessionDto) _then) = __$ChatSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ticker, String companyName,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, int messageCount
});




}
/// @nodoc
class __$ChatSessionDtoCopyWithImpl<$Res>
    implements _$ChatSessionDtoCopyWith<$Res> {
  __$ChatSessionDtoCopyWithImpl(this._self, this._then);

  final _ChatSessionDto _self;
  final $Res Function(_ChatSessionDto) _then;

/// Create a copy of ChatSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ticker = null,Object? companyName = null,Object? createdAt = null,Object? updatedAt = null,Object? messageCount = null,}) {
  return _then(_ChatSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
