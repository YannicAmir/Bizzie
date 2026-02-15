// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_event_status_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchlistEventStatusDto {

 String get badgeText; String get badgeType;// Store enum as String
 DateTime get eventDate; DateTime get lastUpdated;
/// Create a copy of WatchlistEventStatusDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistEventStatusDtoCopyWith<WatchlistEventStatusDto> get copyWith => _$WatchlistEventStatusDtoCopyWithImpl<WatchlistEventStatusDto>(this as WatchlistEventStatusDto, _$identity);

  /// Serializes this WatchlistEventStatusDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistEventStatusDto&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,badgeText,badgeType,eventDate,lastUpdated);

@override
String toString() {
  return 'WatchlistEventStatusDto(badgeText: $badgeText, badgeType: $badgeType, eventDate: $eventDate, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $WatchlistEventStatusDtoCopyWith<$Res>  {
  factory $WatchlistEventStatusDtoCopyWith(WatchlistEventStatusDto value, $Res Function(WatchlistEventStatusDto) _then) = _$WatchlistEventStatusDtoCopyWithImpl;
@useResult
$Res call({
 String badgeText, String badgeType, DateTime eventDate, DateTime lastUpdated
});




}
/// @nodoc
class _$WatchlistEventStatusDtoCopyWithImpl<$Res>
    implements $WatchlistEventStatusDtoCopyWith<$Res> {
  _$WatchlistEventStatusDtoCopyWithImpl(this._self, this._then);

  final WatchlistEventStatusDto _self;
  final $Res Function(WatchlistEventStatusDto) _then;

/// Create a copy of WatchlistEventStatusDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? badgeText = null,Object? badgeType = null,Object? eventDate = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,badgeType: null == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as String,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistEventStatusDto].
extension WatchlistEventStatusDtoPatterns on WatchlistEventStatusDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistEventStatusDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistEventStatusDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistEventStatusDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistEventStatusDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistEventStatusDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistEventStatusDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String badgeText,  String badgeType,  DateTime eventDate,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistEventStatusDto() when $default != null:
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String badgeText,  String badgeType,  DateTime eventDate,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _WatchlistEventStatusDto():
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String badgeText,  String badgeType,  DateTime eventDate,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistEventStatusDto() when $default != null:
return $default(_that.badgeText,_that.badgeType,_that.eventDate,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistEventStatusDto extends WatchlistEventStatusDto {
  const _WatchlistEventStatusDto({required this.badgeText, required this.badgeType, required this.eventDate, required this.lastUpdated}): super._();
  factory _WatchlistEventStatusDto.fromJson(Map<String, dynamic> json) => _$WatchlistEventStatusDtoFromJson(json);

@override final  String badgeText;
@override final  String badgeType;
// Store enum as String
@override final  DateTime eventDate;
@override final  DateTime lastUpdated;

/// Create a copy of WatchlistEventStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistEventStatusDtoCopyWith<_WatchlistEventStatusDto> get copyWith => __$WatchlistEventStatusDtoCopyWithImpl<_WatchlistEventStatusDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistEventStatusDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistEventStatusDto&&(identical(other.badgeText, badgeText) || other.badgeText == badgeText)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,badgeText,badgeType,eventDate,lastUpdated);

@override
String toString() {
  return 'WatchlistEventStatusDto(badgeText: $badgeText, badgeType: $badgeType, eventDate: $eventDate, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$WatchlistEventStatusDtoCopyWith<$Res> implements $WatchlistEventStatusDtoCopyWith<$Res> {
  factory _$WatchlistEventStatusDtoCopyWith(_WatchlistEventStatusDto value, $Res Function(_WatchlistEventStatusDto) _then) = __$WatchlistEventStatusDtoCopyWithImpl;
@override @useResult
$Res call({
 String badgeText, String badgeType, DateTime eventDate, DateTime lastUpdated
});




}
/// @nodoc
class __$WatchlistEventStatusDtoCopyWithImpl<$Res>
    implements _$WatchlistEventStatusDtoCopyWith<$Res> {
  __$WatchlistEventStatusDtoCopyWithImpl(this._self, this._then);

  final _WatchlistEventStatusDto _self;
  final $Res Function(_WatchlistEventStatusDto) _then;

/// Create a copy of WatchlistEventStatusDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? badgeText = null,Object? badgeType = null,Object? eventDate = null,Object? lastUpdated = null,}) {
  return _then(_WatchlistEventStatusDto(
badgeText: null == badgeText ? _self.badgeText : badgeText // ignore: cast_nullable_to_non_nullable
as String,badgeType: null == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as String,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
