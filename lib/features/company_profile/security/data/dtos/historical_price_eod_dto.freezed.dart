// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historical_price_eod_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoricalPriceEodDto {

 String get symbol; String get date; double get price; double get volume;
/// Create a copy of HistoricalPriceEodDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPriceEodDtoCopyWith<HistoricalPriceEodDto> get copyWith => _$HistoricalPriceEodDtoCopyWithImpl<HistoricalPriceEodDto>(this as HistoricalPriceEodDto, _$identity);

  /// Serializes this HistoricalPriceEodDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPriceEodDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPriceEodDto(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $HistoricalPriceEodDtoCopyWith<$Res>  {
  factory $HistoricalPriceEodDtoCopyWith(HistoricalPriceEodDto value, $Res Function(HistoricalPriceEodDto) _then) = _$HistoricalPriceEodDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, double price, double volume
});




}
/// @nodoc
class _$HistoricalPriceEodDtoCopyWithImpl<$Res>
    implements $HistoricalPriceEodDtoCopyWith<$Res> {
  _$HistoricalPriceEodDtoCopyWithImpl(this._self, this._then);

  final HistoricalPriceEodDto _self;
  final $Res Function(HistoricalPriceEodDto) _then;

/// Create a copy of HistoricalPriceEodDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalPriceEodDto].
extension HistoricalPriceEodDtoPatterns on HistoricalPriceEodDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPriceEodDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPriceEodDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPriceEodDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceEodDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPriceEodDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceEodDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  double price,  double volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalPriceEodDto() when $default != null:
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  double price,  double volume)  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceEodDto():
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  double price,  double volume)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceEodDto() when $default != null:
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalPriceEodDto implements HistoricalPriceEodDto {
  const _HistoricalPriceEodDto({required this.symbol, required this.date, required this.price, required this.volume});
  factory _HistoricalPriceEodDto.fromJson(Map<String, dynamic> json) => _$HistoricalPriceEodDtoFromJson(json);

@override final  String symbol;
@override final  String date;
@override final  double price;
@override final  double volume;

/// Create a copy of HistoricalPriceEodDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPriceEodDtoCopyWith<_HistoricalPriceEodDto> get copyWith => __$HistoricalPriceEodDtoCopyWithImpl<_HistoricalPriceEodDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalPriceEodDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPriceEodDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPriceEodDto(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPriceEodDtoCopyWith<$Res> implements $HistoricalPriceEodDtoCopyWith<$Res> {
  factory _$HistoricalPriceEodDtoCopyWith(_HistoricalPriceEodDto value, $Res Function(_HistoricalPriceEodDto) _then) = __$HistoricalPriceEodDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, double price, double volume
});




}
/// @nodoc
class __$HistoricalPriceEodDtoCopyWithImpl<$Res>
    implements _$HistoricalPriceEodDtoCopyWith<$Res> {
  __$HistoricalPriceEodDtoCopyWithImpl(this._self, this._then);

  final _HistoricalPriceEodDto _self;
  final $Res Function(_HistoricalPriceEodDto) _then;

/// Create a copy of HistoricalPriceEodDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_HistoricalPriceEodDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
