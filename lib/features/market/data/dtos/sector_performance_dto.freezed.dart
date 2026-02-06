// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sector_performance_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectorPerformanceDto {

 String get date; String get sector; String get exchange; double get averageChange;
/// Create a copy of SectorPerformanceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorPerformanceDtoCopyWith<SectorPerformanceDto> get copyWith => _$SectorPerformanceDtoCopyWithImpl<SectorPerformanceDto>(this as SectorPerformanceDto, _$identity);

  /// Serializes this SectorPerformanceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorPerformanceDto&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,averageChange);

@override
String toString() {
  return 'SectorPerformanceDto(date: $date, sector: $sector, exchange: $exchange, averageChange: $averageChange)';
}


}

/// @nodoc
abstract mixin class $SectorPerformanceDtoCopyWith<$Res>  {
  factory $SectorPerformanceDtoCopyWith(SectorPerformanceDto value, $Res Function(SectorPerformanceDto) _then) = _$SectorPerformanceDtoCopyWithImpl;
@useResult
$Res call({
 String date, String sector, String exchange, double averageChange
});




}
/// @nodoc
class _$SectorPerformanceDtoCopyWithImpl<$Res>
    implements $SectorPerformanceDtoCopyWith<$Res> {
  _$SectorPerformanceDtoCopyWithImpl(this._self, this._then);

  final SectorPerformanceDto _self;
  final $Res Function(SectorPerformanceDto) _then;

/// Create a copy of SectorPerformanceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? averageChange = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorPerformanceDto].
extension SectorPerformanceDtoPatterns on SectorPerformanceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorPerformanceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorPerformanceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorPerformanceDto value)  $default,){
final _that = this;
switch (_that) {
case _SectorPerformanceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorPerformanceDto value)?  $default,){
final _that = this;
switch (_that) {
case _SectorPerformanceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double averageChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorPerformanceDto() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double averageChange)  $default,) {final _that = this;
switch (_that) {
case _SectorPerformanceDto():
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String sector,  String exchange,  double averageChange)?  $default,) {final _that = this;
switch (_that) {
case _SectorPerformanceDto() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectorPerformanceDto extends SectorPerformanceDto {
  const _SectorPerformanceDto({required this.date, required this.sector, required this.exchange, required this.averageChange}): super._();
  factory _SectorPerformanceDto.fromJson(Map<String, dynamic> json) => _$SectorPerformanceDtoFromJson(json);

@override final  String date;
@override final  String sector;
@override final  String exchange;
@override final  double averageChange;

/// Create a copy of SectorPerformanceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorPerformanceDtoCopyWith<_SectorPerformanceDto> get copyWith => __$SectorPerformanceDtoCopyWithImpl<_SectorPerformanceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectorPerformanceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorPerformanceDto&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,averageChange);

@override
String toString() {
  return 'SectorPerformanceDto(date: $date, sector: $sector, exchange: $exchange, averageChange: $averageChange)';
}


}

/// @nodoc
abstract mixin class _$SectorPerformanceDtoCopyWith<$Res> implements $SectorPerformanceDtoCopyWith<$Res> {
  factory _$SectorPerformanceDtoCopyWith(_SectorPerformanceDto value, $Res Function(_SectorPerformanceDto) _then) = __$SectorPerformanceDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String sector, String exchange, double averageChange
});




}
/// @nodoc
class __$SectorPerformanceDtoCopyWithImpl<$Res>
    implements _$SectorPerformanceDtoCopyWith<$Res> {
  __$SectorPerformanceDtoCopyWithImpl(this._self, this._then);

  final _SectorPerformanceDto _self;
  final $Res Function(_SectorPerformanceDto) _then;

/// Create a copy of SectorPerformanceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? averageChange = null,}) {
  return _then(_SectorPerformanceDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
