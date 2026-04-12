// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bizzie_chat_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BizzieChatRequestDto {

 String get idempotencyKey; String get query; String get companyTicker; String get companyName; String get sessionId; bool get stream;
/// Create a copy of BizzieChatRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BizzieChatRequestDtoCopyWith<BizzieChatRequestDto> get copyWith => _$BizzieChatRequestDtoCopyWithImpl<BizzieChatRequestDto>(this as BizzieChatRequestDto, _$identity);

  /// Serializes this BizzieChatRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BizzieChatRequestDto&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.query, query) || other.query == query)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.stream, stream) || other.stream == stream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idempotencyKey,query,companyTicker,companyName,sessionId,stream);

@override
String toString() {
  return 'BizzieChatRequestDto(idempotencyKey: $idempotencyKey, query: $query, companyTicker: $companyTicker, companyName: $companyName, sessionId: $sessionId, stream: $stream)';
}


}

/// @nodoc
abstract mixin class $BizzieChatRequestDtoCopyWith<$Res>  {
  factory $BizzieChatRequestDtoCopyWith(BizzieChatRequestDto value, $Res Function(BizzieChatRequestDto) _then) = _$BizzieChatRequestDtoCopyWithImpl;
@useResult
$Res call({
 String idempotencyKey, String query, String companyTicker, String companyName, String sessionId, bool stream
});




}
/// @nodoc
class _$BizzieChatRequestDtoCopyWithImpl<$Res>
    implements $BizzieChatRequestDtoCopyWith<$Res> {
  _$BizzieChatRequestDtoCopyWithImpl(this._self, this._then);

  final BizzieChatRequestDto _self;
  final $Res Function(BizzieChatRequestDto) _then;

/// Create a copy of BizzieChatRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idempotencyKey = null,Object? query = null,Object? companyTicker = null,Object? companyName = null,Object? sessionId = null,Object? stream = null,}) {
  return _then(_self.copyWith(
idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,companyTicker: null == companyTicker ? _self.companyTicker : companyTicker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BizzieChatRequestDto].
extension BizzieChatRequestDtoPatterns on BizzieChatRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BizzieChatRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BizzieChatRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BizzieChatRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _BizzieChatRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BizzieChatRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _BizzieChatRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idempotencyKey,  String query,  String companyTicker,  String companyName,  String sessionId,  bool stream)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BizzieChatRequestDto() when $default != null:
return $default(_that.idempotencyKey,_that.query,_that.companyTicker,_that.companyName,_that.sessionId,_that.stream);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idempotencyKey,  String query,  String companyTicker,  String companyName,  String sessionId,  bool stream)  $default,) {final _that = this;
switch (_that) {
case _BizzieChatRequestDto():
return $default(_that.idempotencyKey,_that.query,_that.companyTicker,_that.companyName,_that.sessionId,_that.stream);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idempotencyKey,  String query,  String companyTicker,  String companyName,  String sessionId,  bool stream)?  $default,) {final _that = this;
switch (_that) {
case _BizzieChatRequestDto() when $default != null:
return $default(_that.idempotencyKey,_that.query,_that.companyTicker,_that.companyName,_that.sessionId,_that.stream);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BizzieChatRequestDto extends BizzieChatRequestDto {
  const _BizzieChatRequestDto({required this.idempotencyKey, required this.query, required this.companyTicker, required this.companyName, required this.sessionId, this.stream = false}): super._();
  factory _BizzieChatRequestDto.fromJson(Map<String, dynamic> json) => _$BizzieChatRequestDtoFromJson(json);

@override final  String idempotencyKey;
@override final  String query;
@override final  String companyTicker;
@override final  String companyName;
@override final  String sessionId;
@override@JsonKey() final  bool stream;

/// Create a copy of BizzieChatRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BizzieChatRequestDtoCopyWith<_BizzieChatRequestDto> get copyWith => __$BizzieChatRequestDtoCopyWithImpl<_BizzieChatRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BizzieChatRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BizzieChatRequestDto&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.query, query) || other.query == query)&&(identical(other.companyTicker, companyTicker) || other.companyTicker == companyTicker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.stream, stream) || other.stream == stream));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idempotencyKey,query,companyTicker,companyName,sessionId,stream);

@override
String toString() {
  return 'BizzieChatRequestDto(idempotencyKey: $idempotencyKey, query: $query, companyTicker: $companyTicker, companyName: $companyName, sessionId: $sessionId, stream: $stream)';
}


}

/// @nodoc
abstract mixin class _$BizzieChatRequestDtoCopyWith<$Res> implements $BizzieChatRequestDtoCopyWith<$Res> {
  factory _$BizzieChatRequestDtoCopyWith(_BizzieChatRequestDto value, $Res Function(_BizzieChatRequestDto) _then) = __$BizzieChatRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String idempotencyKey, String query, String companyTicker, String companyName, String sessionId, bool stream
});




}
/// @nodoc
class __$BizzieChatRequestDtoCopyWithImpl<$Res>
    implements _$BizzieChatRequestDtoCopyWith<$Res> {
  __$BizzieChatRequestDtoCopyWithImpl(this._self, this._then);

  final _BizzieChatRequestDto _self;
  final $Res Function(_BizzieChatRequestDto) _then;

/// Create a copy of BizzieChatRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idempotencyKey = null,Object? query = null,Object? companyTicker = null,Object? companyName = null,Object? sessionId = null,Object? stream = null,}) {
  return _then(_BizzieChatRequestDto(
idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,companyTicker: null == companyTicker ? _self.companyTicker : companyTicker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
