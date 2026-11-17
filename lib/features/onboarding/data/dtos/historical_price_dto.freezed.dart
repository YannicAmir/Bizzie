// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historical_price_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoricalPriceDto {

 String get symbol; String get date; double get price; int get volume;
/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPriceDtoCopyWith<HistoricalPriceDto> get copyWith => _$HistoricalPriceDtoCopyWithImpl<HistoricalPriceDto>(this as HistoricalPriceDto, _$identity);

  /// Serializes this HistoricalPriceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as HistoricalPriceDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPriceDto&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.volume, _this.volume) || other.volume == _this.volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as HistoricalPriceDto;
  return Object.hash(runtimeType,_this.symbol,_this.date,_this.price,_this.volume);
}

@override
String toString() {
  final _this = this as HistoricalPriceDto;
  return 'HistoricalPriceDto(symbol: ${_this.symbol}, date: ${_this.date}, price: ${_this.price}, volume: ${_this.volume})';
}


}

/// @nodoc
abstract mixin class $HistoricalPriceDtoCopyWith<$Res>  {
  factory $HistoricalPriceDtoCopyWith(HistoricalPriceDto value, $Res Function(HistoricalPriceDto) _then) = _$HistoricalPriceDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, double price, int volume
});




}
/// @nodoc
class _$HistoricalPriceDtoCopyWithImpl<$Res>
    implements $HistoricalPriceDtoCopyWith<$Res> {
  _$HistoricalPriceDtoCopyWithImpl(this._self, this._then);

  final HistoricalPriceDto _self;
  final $Res Function(HistoricalPriceDto) _then;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(HistoricalPriceDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalPriceDto].
extension HistoricalPriceDtoPatterns on HistoricalPriceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPriceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPriceDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPriceDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  double price,  int volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  double price,  int volume)  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  double price,  int volume)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalPriceDto extends HistoricalPriceDto {
  const _HistoricalPriceDto({required this.symbol, required this.date, required this.price, required this.volume}): super._();
  factory _HistoricalPriceDto.fromJson(Map<String, dynamic> json) => _$HistoricalPriceDtoFromJson(json);

@override final  String symbol;
@override final  String date;
@override final  double price;
@override final  int volume;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPriceDtoCopyWith<_HistoricalPriceDto> get copyWith => __$HistoricalPriceDtoCopyWithImpl<_HistoricalPriceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalPriceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPriceDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,symbol,date,price,volume);
}

@override
String toString() {
    return 'HistoricalPriceDto(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPriceDtoCopyWith<$Res> implements $HistoricalPriceDtoCopyWith<$Res> {
  factory _$HistoricalPriceDtoCopyWith(_HistoricalPriceDto value, $Res Function(_HistoricalPriceDto) _then) = __$HistoricalPriceDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, double price, int volume
});




}
/// @nodoc
class __$HistoricalPriceDtoCopyWithImpl<$Res>
    implements _$HistoricalPriceDtoCopyWith<$Res> {
  __$HistoricalPriceDtoCopyWithImpl(this._self, this._then);

  final _HistoricalPriceDto _self;
  final $Res Function(_HistoricalPriceDto) _then;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_HistoricalPriceDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
