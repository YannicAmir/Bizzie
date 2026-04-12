// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageDto {

 String get id; String get role; String get content;@TimestampConverter() DateTime get createdAt; List<String>? get followUps; String? get source; String? get routePath;
/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageDtoCopyWith<ChatMessageDto> get copyWith => _$ChatMessageDtoCopyWithImpl<ChatMessageDto>(this as ChatMessageDto, _$identity);

  /// Serializes this ChatMessageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.followUps, followUps)&&(identical(other.source, source) || other.source == source)&&(identical(other.routePath, routePath) || other.routePath == routePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,content,createdAt,const DeepCollectionEquality().hash(followUps),source,routePath);

@override
String toString() {
  return 'ChatMessageDto(id: $id, role: $role, content: $content, createdAt: $createdAt, followUps: $followUps, source: $source, routePath: $routePath)';
}


}

/// @nodoc
abstract mixin class $ChatMessageDtoCopyWith<$Res>  {
  factory $ChatMessageDtoCopyWith(ChatMessageDto value, $Res Function(ChatMessageDto) _then) = _$ChatMessageDtoCopyWithImpl;
@useResult
$Res call({
 String id, String role, String content,@TimestampConverter() DateTime createdAt, List<String>? followUps, String? source, String? routePath
});




}
/// @nodoc
class _$ChatMessageDtoCopyWithImpl<$Res>
    implements $ChatMessageDtoCopyWith<$Res> {
  _$ChatMessageDtoCopyWithImpl(this._self, this._then);

  final ChatMessageDto _self;
  final $Res Function(ChatMessageDto) _then;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? content = null,Object? createdAt = null,Object? followUps = freezed,Object? source = freezed,Object? routePath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,followUps: freezed == followUps ? _self.followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,routePath: freezed == routePath ? _self.routePath : routePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageDto].
extension ChatMessageDtoPatterns on ChatMessageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageDto value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String role,  String content, @TimestampConverter()  DateTime createdAt,  List<String>? followUps,  String? source,  String? routePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.createdAt,_that.followUps,_that.source,_that.routePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String role,  String content, @TimestampConverter()  DateTime createdAt,  List<String>? followUps,  String? source,  String? routePath)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageDto():
return $default(_that.id,_that.role,_that.content,_that.createdAt,_that.followUps,_that.source,_that.routePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String role,  String content, @TimestampConverter()  DateTime createdAt,  List<String>? followUps,  String? source,  String? routePath)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageDto() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.createdAt,_that.followUps,_that.source,_that.routePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageDto extends ChatMessageDto {
  const _ChatMessageDto({required this.id, required this.role, required this.content, @TimestampConverter() required this.createdAt, final  List<String>? followUps, this.source, this.routePath}): _followUps = followUps,super._();
  factory _ChatMessageDto.fromJson(Map<String, dynamic> json) => _$ChatMessageDtoFromJson(json);

@override final  String id;
@override final  String role;
@override final  String content;
@override@TimestampConverter() final  DateTime createdAt;
 final  List<String>? _followUps;
@override List<String>? get followUps {
  final value = _followUps;
  if (value == null) return null;
  if (_followUps is EqualUnmodifiableListView) return _followUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? source;
@override final  String? routePath;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageDtoCopyWith<_ChatMessageDto> get copyWith => __$ChatMessageDtoCopyWithImpl<_ChatMessageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._followUps, _followUps)&&(identical(other.source, source) || other.source == source)&&(identical(other.routePath, routePath) || other.routePath == routePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,role,content,createdAt,const DeepCollectionEquality().hash(_followUps),source,routePath);

@override
String toString() {
  return 'ChatMessageDto(id: $id, role: $role, content: $content, createdAt: $createdAt, followUps: $followUps, source: $source, routePath: $routePath)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageDtoCopyWith<$Res> implements $ChatMessageDtoCopyWith<$Res> {
  factory _$ChatMessageDtoCopyWith(_ChatMessageDto value, $Res Function(_ChatMessageDto) _then) = __$ChatMessageDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String role, String content,@TimestampConverter() DateTime createdAt, List<String>? followUps, String? source, String? routePath
});




}
/// @nodoc
class __$ChatMessageDtoCopyWithImpl<$Res>
    implements _$ChatMessageDtoCopyWith<$Res> {
  __$ChatMessageDtoCopyWithImpl(this._self, this._then);

  final _ChatMessageDto _self;
  final $Res Function(_ChatMessageDto) _then;

/// Create a copy of ChatMessageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? content = null,Object? createdAt = null,Object? followUps = freezed,Object? source = freezed,Object? routePath = freezed,}) {
  return _then(_ChatMessageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,followUps: freezed == followUps ? _self._followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,routePath: freezed == routePath ? _self.routePath : routePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
