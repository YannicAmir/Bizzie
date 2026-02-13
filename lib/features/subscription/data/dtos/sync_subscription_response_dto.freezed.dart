// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_subscription_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncSubscriptionResponseDto {

 bool get active; String? get status; String? get expirationDate;
/// Create a copy of SyncSubscriptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSubscriptionResponseDtoCopyWith<SyncSubscriptionResponseDto> get copyWith => _$SyncSubscriptionResponseDtoCopyWithImpl<SyncSubscriptionResponseDto>(this as SyncSubscriptionResponseDto, _$identity);

  /// Serializes this SyncSubscriptionResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSubscriptionResponseDto&&(identical(other.active, active) || other.active == active)&&(identical(other.status, status) || other.status == status)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,active,status,expirationDate);

@override
String toString() {
  return 'SyncSubscriptionResponseDto(active: $active, status: $status, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class $SyncSubscriptionResponseDtoCopyWith<$Res>  {
  factory $SyncSubscriptionResponseDtoCopyWith(SyncSubscriptionResponseDto value, $Res Function(SyncSubscriptionResponseDto) _then) = _$SyncSubscriptionResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool active, String? status, String? expirationDate
});




}
/// @nodoc
class _$SyncSubscriptionResponseDtoCopyWithImpl<$Res>
    implements $SyncSubscriptionResponseDtoCopyWith<$Res> {
  _$SyncSubscriptionResponseDtoCopyWithImpl(this._self, this._then);

  final SyncSubscriptionResponseDto _self;
  final $Res Function(SyncSubscriptionResponseDto) _then;

/// Create a copy of SyncSubscriptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? status = freezed,Object? expirationDate = freezed,}) {
  return _then(_self.copyWith(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSubscriptionResponseDto].
extension SyncSubscriptionResponseDtoPatterns on SyncSubscriptionResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSubscriptionResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSubscriptionResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSubscriptionResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool active,  String? status,  String? expirationDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto() when $default != null:
return $default(_that.active,_that.status,_that.expirationDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool active,  String? status,  String? expirationDate)  $default,) {final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto():
return $default(_that.active,_that.status,_that.expirationDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool active,  String? status,  String? expirationDate)?  $default,) {final _that = this;
switch (_that) {
case _SyncSubscriptionResponseDto() when $default != null:
return $default(_that.active,_that.status,_that.expirationDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncSubscriptionResponseDto extends SyncSubscriptionResponseDto {
  const _SyncSubscriptionResponseDto({required this.active, this.status, this.expirationDate}): super._();
  factory _SyncSubscriptionResponseDto.fromJson(Map<String, dynamic> json) => _$SyncSubscriptionResponseDtoFromJson(json);

@override final  bool active;
@override final  String? status;
@override final  String? expirationDate;

/// Create a copy of SyncSubscriptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSubscriptionResponseDtoCopyWith<_SyncSubscriptionResponseDto> get copyWith => __$SyncSubscriptionResponseDtoCopyWithImpl<_SyncSubscriptionResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncSubscriptionResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSubscriptionResponseDto&&(identical(other.active, active) || other.active == active)&&(identical(other.status, status) || other.status == status)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,active,status,expirationDate);

@override
String toString() {
  return 'SyncSubscriptionResponseDto(active: $active, status: $status, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class _$SyncSubscriptionResponseDtoCopyWith<$Res> implements $SyncSubscriptionResponseDtoCopyWith<$Res> {
  factory _$SyncSubscriptionResponseDtoCopyWith(_SyncSubscriptionResponseDto value, $Res Function(_SyncSubscriptionResponseDto) _then) = __$SyncSubscriptionResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool active, String? status, String? expirationDate
});




}
/// @nodoc
class __$SyncSubscriptionResponseDtoCopyWithImpl<$Res>
    implements _$SyncSubscriptionResponseDtoCopyWith<$Res> {
  __$SyncSubscriptionResponseDtoCopyWithImpl(this._self, this._then);

  final _SyncSubscriptionResponseDto _self;
  final $Res Function(_SyncSubscriptionResponseDto) _then;

/// Create a copy of SyncSubscriptionResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? active = null,Object? status = freezed,Object? expirationDate = freezed,}) {
  return _then(_SyncSubscriptionResponseDto(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
