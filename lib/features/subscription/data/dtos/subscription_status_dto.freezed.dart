// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_status_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionStatusDto {

 bool get isSubscribed; Set<String> get activeEntitlements; DateTime? get expirationDate;
/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusDtoCopyWith<SubscriptionStatusDto> get copyWith => _$SubscriptionStatusDtoCopyWithImpl<SubscriptionStatusDto>(this as SubscriptionStatusDto, _$identity);

  /// Serializes this SubscriptionStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusDto&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other.activeEntitlements, activeEntitlements)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSubscribed,const DeepCollectionEquality().hash(activeEntitlements),expirationDate);

@override
String toString() {
  return 'SubscriptionStatusDto(isSubscribed: $isSubscribed, activeEntitlements: $activeEntitlements, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusDtoCopyWith<$Res>  {
  factory $SubscriptionStatusDtoCopyWith(SubscriptionStatusDto value, $Res Function(SubscriptionStatusDto) _then) = _$SubscriptionStatusDtoCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed, Set<String> activeEntitlements, DateTime? expirationDate
});




}
/// @nodoc
class _$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements $SubscriptionStatusDtoCopyWith<$Res> {
  _$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final SubscriptionStatusDto _self;
  final $Res Function(SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscribed = null,Object? activeEntitlements = null,Object? expirationDate = freezed,}) {
  return _then(_self.copyWith(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlements: null == activeEntitlements ? _self.activeEntitlements : activeEntitlements // ignore: cast_nullable_to_non_nullable
as Set<String>,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionStatusDto].
extension SubscriptionStatusDtoPatterns on SubscriptionStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubscribed,  Set<String> activeEntitlements,  DateTime? expirationDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.isSubscribed,_that.activeEntitlements,_that.expirationDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubscribed,  Set<String> activeEntitlements,  DateTime? expirationDate)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto():
return $default(_that.isSubscribed,_that.activeEntitlements,_that.expirationDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubscribed,  Set<String> activeEntitlements,  DateTime? expirationDate)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionStatusDto() when $default != null:
return $default(_that.isSubscribed,_that.activeEntitlements,_that.expirationDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionStatusDto extends SubscriptionStatusDto {
  const _SubscriptionStatusDto({required this.isSubscribed, required final  Set<String> activeEntitlements, this.expirationDate}): _activeEntitlements = activeEntitlements,super._();
  factory _SubscriptionStatusDto.fromJson(Map<String, dynamic> json) => _$SubscriptionStatusDtoFromJson(json);

@override final  bool isSubscribed;
 final  Set<String> _activeEntitlements;
@override Set<String> get activeEntitlements {
  if (_activeEntitlements is EqualUnmodifiableSetView) return _activeEntitlements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeEntitlements);
}

@override final  DateTime? expirationDate;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStatusDtoCopyWith<_SubscriptionStatusDto> get copyWith => __$SubscriptionStatusDtoCopyWithImpl<_SubscriptionStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionStatusDto&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed)&&const DeepCollectionEquality().equals(other._activeEntitlements, _activeEntitlements)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isSubscribed,const DeepCollectionEquality().hash(_activeEntitlements),expirationDate);

@override
String toString() {
  return 'SubscriptionStatusDto(isSubscribed: $isSubscribed, activeEntitlements: $activeEntitlements, expirationDate: $expirationDate)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStatusDtoCopyWith<$Res> implements $SubscriptionStatusDtoCopyWith<$Res> {
  factory _$SubscriptionStatusDtoCopyWith(_SubscriptionStatusDto value, $Res Function(_SubscriptionStatusDto) _then) = __$SubscriptionStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isSubscribed, Set<String> activeEntitlements, DateTime? expirationDate
});




}
/// @nodoc
class __$SubscriptionStatusDtoCopyWithImpl<$Res>
    implements _$SubscriptionStatusDtoCopyWith<$Res> {
  __$SubscriptionStatusDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionStatusDto _self;
  final $Res Function(_SubscriptionStatusDto) _then;

/// Create a copy of SubscriptionStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,Object? activeEntitlements = null,Object? expirationDate = freezed,}) {
  return _then(_SubscriptionStatusDto(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,activeEntitlements: null == activeEntitlements ? _self._activeEntitlements : activeEntitlements // ignore: cast_nullable_to_non_nullable
as Set<String>,expirationDate: freezed == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
