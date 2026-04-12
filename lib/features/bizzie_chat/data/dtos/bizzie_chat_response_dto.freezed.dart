// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bizzie_chat_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BizzieChatResponseDto {

 String get message; List<String> get followUps; String? get source; BizzieChatResponseMetadataDto get metadata;
/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BizzieChatResponseDtoCopyWith<BizzieChatResponseDto> get copyWith => _$BizzieChatResponseDtoCopyWithImpl<BizzieChatResponseDto>(this as BizzieChatResponseDto, _$identity);

  /// Serializes this BizzieChatResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BizzieChatResponseDto&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.followUps, followUps)&&(identical(other.source, source) || other.source == source)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(followUps),source,metadata);

@override
String toString() {
  return 'BizzieChatResponseDto(message: $message, followUps: $followUps, source: $source, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $BizzieChatResponseDtoCopyWith<$Res>  {
  factory $BizzieChatResponseDtoCopyWith(BizzieChatResponseDto value, $Res Function(BizzieChatResponseDto) _then) = _$BizzieChatResponseDtoCopyWithImpl;
@useResult
$Res call({
 String message, List<String> followUps, String? source, BizzieChatResponseMetadataDto metadata
});


$BizzieChatResponseMetadataDtoCopyWith<$Res> get metadata;

}
/// @nodoc
class _$BizzieChatResponseDtoCopyWithImpl<$Res>
    implements $BizzieChatResponseDtoCopyWith<$Res> {
  _$BizzieChatResponseDtoCopyWithImpl(this._self, this._then);

  final BizzieChatResponseDto _self;
  final $Res Function(BizzieChatResponseDto) _then;

/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? followUps = null,Object? source = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,followUps: null == followUps ? _self.followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as BizzieChatResponseMetadataDto,
  ));
}
/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BizzieChatResponseMetadataDtoCopyWith<$Res> get metadata {
  
  return $BizzieChatResponseMetadataDtoCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [BizzieChatResponseDto].
extension BizzieChatResponseDtoPatterns on BizzieChatResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BizzieChatResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BizzieChatResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BizzieChatResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _BizzieChatResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BizzieChatResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _BizzieChatResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  List<String> followUps,  String? source,  BizzieChatResponseMetadataDto metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BizzieChatResponseDto() when $default != null:
return $default(_that.message,_that.followUps,_that.source,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  List<String> followUps,  String? source,  BizzieChatResponseMetadataDto metadata)  $default,) {final _that = this;
switch (_that) {
case _BizzieChatResponseDto():
return $default(_that.message,_that.followUps,_that.source,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  List<String> followUps,  String? source,  BizzieChatResponseMetadataDto metadata)?  $default,) {final _that = this;
switch (_that) {
case _BizzieChatResponseDto() when $default != null:
return $default(_that.message,_that.followUps,_that.source,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BizzieChatResponseDto extends BizzieChatResponseDto {
  const _BizzieChatResponseDto({required this.message, required final  List<String> followUps, this.source, required this.metadata}): _followUps = followUps,super._();
  factory _BizzieChatResponseDto.fromJson(Map<String, dynamic> json) => _$BizzieChatResponseDtoFromJson(json);

@override final  String message;
 final  List<String> _followUps;
@override List<String> get followUps {
  if (_followUps is EqualUnmodifiableListView) return _followUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followUps);
}

@override final  String? source;
@override final  BizzieChatResponseMetadataDto metadata;

/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BizzieChatResponseDtoCopyWith<_BizzieChatResponseDto> get copyWith => __$BizzieChatResponseDtoCopyWithImpl<_BizzieChatResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BizzieChatResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BizzieChatResponseDto&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._followUps, _followUps)&&(identical(other.source, source) || other.source == source)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(_followUps),source,metadata);

@override
String toString() {
  return 'BizzieChatResponseDto(message: $message, followUps: $followUps, source: $source, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$BizzieChatResponseDtoCopyWith<$Res> implements $BizzieChatResponseDtoCopyWith<$Res> {
  factory _$BizzieChatResponseDtoCopyWith(_BizzieChatResponseDto value, $Res Function(_BizzieChatResponseDto) _then) = __$BizzieChatResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String message, List<String> followUps, String? source, BizzieChatResponseMetadataDto metadata
});


@override $BizzieChatResponseMetadataDtoCopyWith<$Res> get metadata;

}
/// @nodoc
class __$BizzieChatResponseDtoCopyWithImpl<$Res>
    implements _$BizzieChatResponseDtoCopyWith<$Res> {
  __$BizzieChatResponseDtoCopyWithImpl(this._self, this._then);

  final _BizzieChatResponseDto _self;
  final $Res Function(_BizzieChatResponseDto) _then;

/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? followUps = null,Object? source = freezed,Object? metadata = null,}) {
  return _then(_BizzieChatResponseDto(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,followUps: null == followUps ? _self._followUps : followUps // ignore: cast_nullable_to_non_nullable
as List<String>,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as BizzieChatResponseMetadataDto,
  ));
}

/// Create a copy of BizzieChatResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BizzieChatResponseMetadataDtoCopyWith<$Res> get metadata {
  
  return $BizzieChatResponseMetadataDtoCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// @nodoc
mixin _$BizzieChatResponseMetadataDto {

 String get sessionId; String? get routePath;
/// Create a copy of BizzieChatResponseMetadataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BizzieChatResponseMetadataDtoCopyWith<BizzieChatResponseMetadataDto> get copyWith => _$BizzieChatResponseMetadataDtoCopyWithImpl<BizzieChatResponseMetadataDto>(this as BizzieChatResponseMetadataDto, _$identity);

  /// Serializes this BizzieChatResponseMetadataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BizzieChatResponseMetadataDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.routePath, routePath) || other.routePath == routePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,routePath);

@override
String toString() {
  return 'BizzieChatResponseMetadataDto(sessionId: $sessionId, routePath: $routePath)';
}


}

/// @nodoc
abstract mixin class $BizzieChatResponseMetadataDtoCopyWith<$Res>  {
  factory $BizzieChatResponseMetadataDtoCopyWith(BizzieChatResponseMetadataDto value, $Res Function(BizzieChatResponseMetadataDto) _then) = _$BizzieChatResponseMetadataDtoCopyWithImpl;
@useResult
$Res call({
 String sessionId, String? routePath
});




}
/// @nodoc
class _$BizzieChatResponseMetadataDtoCopyWithImpl<$Res>
    implements $BizzieChatResponseMetadataDtoCopyWith<$Res> {
  _$BizzieChatResponseMetadataDtoCopyWithImpl(this._self, this._then);

  final BizzieChatResponseMetadataDto _self;
  final $Res Function(BizzieChatResponseMetadataDto) _then;

/// Create a copy of BizzieChatResponseMetadataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? routePath = freezed,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,routePath: freezed == routePath ? _self.routePath : routePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BizzieChatResponseMetadataDto].
extension BizzieChatResponseMetadataDtoPatterns on BizzieChatResponseMetadataDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BizzieChatResponseMetadataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BizzieChatResponseMetadataDto value)  $default,){
final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BizzieChatResponseMetadataDto value)?  $default,){
final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String? routePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto() when $default != null:
return $default(_that.sessionId,_that.routePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String? routePath)  $default,) {final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto():
return $default(_that.sessionId,_that.routePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String? routePath)?  $default,) {final _that = this;
switch (_that) {
case _BizzieChatResponseMetadataDto() when $default != null:
return $default(_that.sessionId,_that.routePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BizzieChatResponseMetadataDto extends BizzieChatResponseMetadataDto {
  const _BizzieChatResponseMetadataDto({required this.sessionId, this.routePath}): super._();
  factory _BizzieChatResponseMetadataDto.fromJson(Map<String, dynamic> json) => _$BizzieChatResponseMetadataDtoFromJson(json);

@override final  String sessionId;
@override final  String? routePath;

/// Create a copy of BizzieChatResponseMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BizzieChatResponseMetadataDtoCopyWith<_BizzieChatResponseMetadataDto> get copyWith => __$BizzieChatResponseMetadataDtoCopyWithImpl<_BizzieChatResponseMetadataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BizzieChatResponseMetadataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BizzieChatResponseMetadataDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.routePath, routePath) || other.routePath == routePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,routePath);

@override
String toString() {
  return 'BizzieChatResponseMetadataDto(sessionId: $sessionId, routePath: $routePath)';
}


}

/// @nodoc
abstract mixin class _$BizzieChatResponseMetadataDtoCopyWith<$Res> implements $BizzieChatResponseMetadataDtoCopyWith<$Res> {
  factory _$BizzieChatResponseMetadataDtoCopyWith(_BizzieChatResponseMetadataDto value, $Res Function(_BizzieChatResponseMetadataDto) _then) = __$BizzieChatResponseMetadataDtoCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String? routePath
});




}
/// @nodoc
class __$BizzieChatResponseMetadataDtoCopyWithImpl<$Res>
    implements _$BizzieChatResponseMetadataDtoCopyWith<$Res> {
  __$BizzieChatResponseMetadataDtoCopyWithImpl(this._self, this._then);

  final _BizzieChatResponseMetadataDto _self;
  final $Res Function(_BizzieChatResponseMetadataDto) _then;

/// Create a copy of BizzieChatResponseMetadataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? routePath = freezed,}) {
  return _then(_BizzieChatResponseMetadataDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,routePath: freezed == routePath ? _self.routePath : routePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
