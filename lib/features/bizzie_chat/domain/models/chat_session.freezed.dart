// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatSession {

 String get id; String get title; String get ticker; String get companyName; DateTime get createdAt; DateTime get updatedAt; int get messageCount;
/// Create a copy of ChatSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSessionCopyWith<ChatSession> get copyWith => _$ChatSessionCopyWithImpl<ChatSession>(this as ChatSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSession&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,ticker,companyName,createdAt,updatedAt,messageCount);

@override
String toString() {
  return 'ChatSession(id: $id, title: $title, ticker: $ticker, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt, messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class $ChatSessionCopyWith<$Res>  {
  factory $ChatSessionCopyWith(ChatSession value, $Res Function(ChatSession) _then) = _$ChatSessionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ticker, String companyName, DateTime createdAt, DateTime updatedAt, int messageCount
});




}
/// @nodoc
class _$ChatSessionCopyWithImpl<$Res>
    implements $ChatSessionCopyWith<$Res> {
  _$ChatSessionCopyWithImpl(this._self, this._then);

  final ChatSession _self;
  final $Res Function(ChatSession) _then;

/// Create a copy of ChatSession
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


/// Adds pattern-matching-related methods to [ChatSession].
extension ChatSessionPatterns on ChatSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatSession value)  $default,){
final _that = this;
switch (_that) {
case _ChatSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatSession value)?  $default,){
final _that = this;
switch (_that) {
case _ChatSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ticker,  String companyName,  DateTime createdAt,  DateTime updatedAt,  int messageCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatSession() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ticker,  String companyName,  DateTime createdAt,  DateTime updatedAt,  int messageCount)  $default,) {final _that = this;
switch (_that) {
case _ChatSession():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ticker,  String companyName,  DateTime createdAt,  DateTime updatedAt,  int messageCount)?  $default,) {final _that = this;
switch (_that) {
case _ChatSession() when $default != null:
return $default(_that.id,_that.title,_that.ticker,_that.companyName,_that.createdAt,_that.updatedAt,_that.messageCount);case _:
  return null;

}
}

}

/// @nodoc


class _ChatSession implements ChatSession {
  const _ChatSession({required this.id, required this.title, required this.ticker, required this.companyName, required this.createdAt, required this.updatedAt, required this.messageCount});
  

@override final  String id;
@override final  String title;
@override final  String ticker;
@override final  String companyName;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int messageCount;

/// Create a copy of ChatSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatSessionCopyWith<_ChatSession> get copyWith => __$ChatSessionCopyWithImpl<_ChatSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatSession&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,ticker,companyName,createdAt,updatedAt,messageCount);

@override
String toString() {
  return 'ChatSession(id: $id, title: $title, ticker: $ticker, companyName: $companyName, createdAt: $createdAt, updatedAt: $updatedAt, messageCount: $messageCount)';
}


}

/// @nodoc
abstract mixin class _$ChatSessionCopyWith<$Res> implements $ChatSessionCopyWith<$Res> {
  factory _$ChatSessionCopyWith(_ChatSession value, $Res Function(_ChatSession) _then) = __$ChatSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ticker, String companyName, DateTime createdAt, DateTime updatedAt, int messageCount
});




}
/// @nodoc
class __$ChatSessionCopyWithImpl<$Res>
    implements _$ChatSessionCopyWith<$Res> {
  __$ChatSessionCopyWithImpl(this._self, this._then);

  final _ChatSession _self;
  final $Res Function(_ChatSession) _then;

/// Create a copy of ChatSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ticker = null,Object? companyName = null,Object? createdAt = null,Object? updatedAt = null,Object? messageCount = null,}) {
  return _then(_ChatSession(
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
