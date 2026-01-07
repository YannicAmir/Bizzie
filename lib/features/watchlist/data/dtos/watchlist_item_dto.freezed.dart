// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchlistItemDto {

 String get ticker; String get companyName;@TimestampConverter() DateTime get createdAt;
/// Create a copy of WatchlistItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistItemDtoCopyWith<WatchlistItemDto> get copyWith => _$WatchlistItemDtoCopyWithImpl<WatchlistItemDto>(this as WatchlistItemDto, _$identity);

  /// Serializes this WatchlistItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistItemDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,createdAt);

@override
String toString() {
  return 'WatchlistItemDto(ticker: $ticker, companyName: $companyName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WatchlistItemDtoCopyWith<$Res>  {
  factory $WatchlistItemDtoCopyWith(WatchlistItemDto value, $Res Function(WatchlistItemDto) _then) = _$WatchlistItemDtoCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$WatchlistItemDtoCopyWithImpl<$Res>
    implements $WatchlistItemDtoCopyWith<$Res> {
  _$WatchlistItemDtoCopyWithImpl(this._self, this._then);

  final WatchlistItemDto _self;
  final $Res Function(WatchlistItemDto) _then;

/// Create a copy of WatchlistItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? companyName = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistItemDto].
extension WatchlistItemDtoPatterns on WatchlistItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistItemDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String companyName, @TimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistItemDto() when $default != null:
return $default(_that.ticker,_that.companyName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String companyName, @TimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WatchlistItemDto():
return $default(_that.ticker,_that.companyName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String companyName, @TimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistItemDto() when $default != null:
return $default(_that.ticker,_that.companyName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistItemDto extends WatchlistItemDto {
  const _WatchlistItemDto({required this.ticker, required this.companyName, @TimestampConverter() required this.createdAt}): super._();
  factory _WatchlistItemDto.fromJson(Map<String, dynamic> json) => _$WatchlistItemDtoFromJson(json);

@override final  String ticker;
@override final  String companyName;
@override@TimestampConverter() final  DateTime createdAt;

/// Create a copy of WatchlistItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistItemDtoCopyWith<_WatchlistItemDto> get copyWith => __$WatchlistItemDtoCopyWithImpl<_WatchlistItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistItemDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,createdAt);

@override
String toString() {
  return 'WatchlistItemDto(ticker: $ticker, companyName: $companyName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WatchlistItemDtoCopyWith<$Res> implements $WatchlistItemDtoCopyWith<$Res> {
  factory _$WatchlistItemDtoCopyWith(_WatchlistItemDto value, $Res Function(_WatchlistItemDto) _then) = __$WatchlistItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String companyName,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$WatchlistItemDtoCopyWithImpl<$Res>
    implements _$WatchlistItemDtoCopyWith<$Res> {
  __$WatchlistItemDtoCopyWithImpl(this._self, this._then);

  final _WatchlistItemDto _self;
  final $Res Function(_WatchlistItemDto) _then;

/// Create a copy of WatchlistItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? createdAt = null,}) {
  return _then(_WatchlistItemDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
