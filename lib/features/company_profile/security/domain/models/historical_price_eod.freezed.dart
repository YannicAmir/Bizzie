// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'historical_price_eod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoricalPriceEod {

 String get symbol; String get date; double get price; double get volume;
/// Create a copy of HistoricalPriceEod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPriceEodCopyWith<HistoricalPriceEod> get copyWith => _$HistoricalPriceEodCopyWithImpl<HistoricalPriceEod>(this as HistoricalPriceEod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPriceEod&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPriceEod(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $HistoricalPriceEodCopyWith<$Res>  {
  factory $HistoricalPriceEodCopyWith(HistoricalPriceEod value, $Res Function(HistoricalPriceEod) _then) = _$HistoricalPriceEodCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, double price, double volume
});




}
/// @nodoc
class _$HistoricalPriceEodCopyWithImpl<$Res>
    implements $HistoricalPriceEodCopyWith<$Res> {
  _$HistoricalPriceEodCopyWithImpl(this._self, this._then);

  final HistoricalPriceEod _self;
  final $Res Function(HistoricalPriceEod) _then;

/// Create a copy of HistoricalPriceEod
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


/// Adds pattern-matching-related methods to [HistoricalPriceEod].
extension HistoricalPriceEodPatterns on HistoricalPriceEod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPriceEod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPriceEod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPriceEod value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceEod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPriceEod value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceEod() when $default != null:
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
case _HistoricalPriceEod() when $default != null:
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
case _HistoricalPriceEod():
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
case _HistoricalPriceEod() when $default != null:
return $default(_that.symbol,_that.date,_that.price,_that.volume);case _:
  return null;

}
}

}

/// @nodoc


class _HistoricalPriceEod implements HistoricalPriceEod {
  const _HistoricalPriceEod({required this.symbol, required this.date, required this.price, required this.volume});
  

@override final  String symbol;
@override final  String date;
@override final  double price;
@override final  double volume;

/// Create a copy of HistoricalPriceEod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPriceEodCopyWith<_HistoricalPriceEod> get copyWith => __$HistoricalPriceEodCopyWithImpl<_HistoricalPriceEod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPriceEod&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,price,volume);

@override
String toString() {
  return 'HistoricalPriceEod(symbol: $symbol, date: $date, price: $price, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPriceEodCopyWith<$Res> implements $HistoricalPriceEodCopyWith<$Res> {
  factory _$HistoricalPriceEodCopyWith(_HistoricalPriceEod value, $Res Function(_HistoricalPriceEod) _then) = __$HistoricalPriceEodCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, double price, double volume
});




}
/// @nodoc
class __$HistoricalPriceEodCopyWithImpl<$Res>
    implements _$HistoricalPriceEodCopyWith<$Res> {
  __$HistoricalPriceEodCopyWithImpl(this._self, this._then);

  final _HistoricalPriceEod _self;
  final $Res Function(_HistoricalPriceEod) _then;

/// Create a copy of HistoricalPriceEod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? price = null,Object? volume = null,}) {
  return _then(_HistoricalPriceEod(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
