// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historical_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoricalPrice {

 String get symbol; String get date; double get price; int get volume;
/// Create a copy of HistoricalPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPriceCopyWith<HistoricalPrice> get copyWith => _$HistoricalPriceCopyWithImpl<HistoricalPrice>(this as HistoricalPrice, _$identity);

  /// Serializes this HistoricalPrice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPrice&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPrice(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $HistoricalPriceCopyWith<$Res>  {
  factory $HistoricalPriceCopyWith(HistoricalPrice value, $Res Function(HistoricalPrice) _then) = _$HistoricalPriceCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, double price, int volume
});




}
/// @nodoc
class _$HistoricalPriceCopyWithImpl<$Res>
    implements $HistoricalPriceCopyWith<$Res> {
  _$HistoricalPriceCopyWithImpl(this._self, this._then);

  final HistoricalPrice _self;
  final $Res Function(HistoricalPrice) _then;

/// Create a copy of HistoricalPrice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalPrice].
extension HistoricalPricePatterns on HistoricalPrice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPrice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPrice value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPrice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPrice value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPrice() when $default != null:
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
case _HistoricalPrice() when $default != null:
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
case _HistoricalPrice():
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
case _HistoricalPrice() when $default != null:
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalPrice implements HistoricalPrice {
  const _HistoricalPrice({required this.symbol, required this.date, required this.price, required this.volume});
  factory _HistoricalPrice.fromJson(Map<String, dynamic> json) => _$HistoricalPriceFromJson(json);

@override final  String symbol;
@override final  String date;
@override final  double price;
@override final  int volume;

/// Create a copy of HistoricalPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPriceCopyWith<_HistoricalPrice> get copyWith => __$HistoricalPriceCopyWithImpl<_HistoricalPrice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalPriceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPrice&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPrice(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPriceCopyWith<$Res> implements $HistoricalPriceCopyWith<$Res> {
  factory _$HistoricalPriceCopyWith(_HistoricalPrice value, $Res Function(_HistoricalPrice) _then) = __$HistoricalPriceCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, double price, int volume
});




}
/// @nodoc
class __$HistoricalPriceCopyWithImpl<$Res>
    implements _$HistoricalPriceCopyWith<$Res> {
  __$HistoricalPriceCopyWithImpl(this._self, this._then);

  final _HistoricalPrice _self;
  final $Res Function(_HistoricalPrice) _then;

/// Create a copy of HistoricalPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_HistoricalPrice(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
