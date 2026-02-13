// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sector_pe_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectorPeDto {

 String get date; String get sector; String get exchange; double get pe;
/// Create a copy of SectorPeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorPeDtoCopyWith<SectorPeDto> get copyWith => _$SectorPeDtoCopyWithImpl<SectorPeDto>(this as SectorPeDto, _$identity);

  /// Serializes this SectorPeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorPeDto&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.pe, pe) || other.pe == pe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,pe);

@override
String toString() {
  return 'SectorPeDto(date: $date, sector: $sector, exchange: $exchange, pe: $pe)';
}


}

/// @nodoc
abstract mixin class $SectorPeDtoCopyWith<$Res>  {
  factory $SectorPeDtoCopyWith(SectorPeDto value, $Res Function(SectorPeDto) _then) = _$SectorPeDtoCopyWithImpl;
@useResult
$Res call({
 String date, String sector, String exchange, double pe
});




}
/// @nodoc
class _$SectorPeDtoCopyWithImpl<$Res>
    implements $SectorPeDtoCopyWith<$Res> {
  _$SectorPeDtoCopyWithImpl(this._self, this._then);

  final SectorPeDto _self;
  final $Res Function(SectorPeDto) _then;

/// Create a copy of SectorPeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? pe = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,pe: null == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorPeDto].
extension SectorPeDtoPatterns on SectorPeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorPeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorPeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorPeDto value)  $default,){
final _that = this;
switch (_that) {
case _SectorPeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorPeDto value)?  $default,){
final _that = this;
switch (_that) {
case _SectorPeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double pe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorPeDto() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double pe)  $default,) {final _that = this;
switch (_that) {
case _SectorPeDto():
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String sector,  String exchange,  double pe)?  $default,) {final _that = this;
switch (_that) {
case _SectorPeDto() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SectorPeDto extends SectorPeDto {
  const _SectorPeDto({required this.date, required this.sector, required this.exchange, required this.pe}): super._();
  factory _SectorPeDto.fromJson(Map<String, dynamic> json) => _$SectorPeDtoFromJson(json);

@override final  String date;
@override final  String sector;
@override final  String exchange;
@override final  double pe;

/// Create a copy of SectorPeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorPeDtoCopyWith<_SectorPeDto> get copyWith => __$SectorPeDtoCopyWithImpl<_SectorPeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SectorPeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorPeDto&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.pe, pe) || other.pe == pe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,pe);

@override
String toString() {
  return 'SectorPeDto(date: $date, sector: $sector, exchange: $exchange, pe: $pe)';
}


}

/// @nodoc
abstract mixin class _$SectorPeDtoCopyWith<$Res> implements $SectorPeDtoCopyWith<$Res> {
  factory _$SectorPeDtoCopyWith(_SectorPeDto value, $Res Function(_SectorPeDto) _then) = __$SectorPeDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String sector, String exchange, double pe
});




}
/// @nodoc
class __$SectorPeDtoCopyWithImpl<$Res>
    implements _$SectorPeDtoCopyWith<$Res> {
  __$SectorPeDtoCopyWithImpl(this._self, this._then);

  final _SectorPeDto _self;
  final $Res Function(_SectorPeDto) _then;

/// Create a copy of SectorPeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? pe = null,}) {
  return _then(_SectorPeDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,pe: null == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
