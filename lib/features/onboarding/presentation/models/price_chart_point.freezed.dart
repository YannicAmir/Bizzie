// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_chart_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceChartPoint {

 DateTime get date; double get price;
/// Create a copy of PriceChartPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceChartPointCopyWith<PriceChartPoint> get copyWith => _$PriceChartPointCopyWithImpl<PriceChartPoint>(this as PriceChartPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceChartPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,date,price);

@override
String toString() {
  return 'PriceChartPoint(date: $date, price: $price)';
}


}

/// @nodoc
abstract mixin class $PriceChartPointCopyWith<$Res>  {
  factory $PriceChartPointCopyWith(PriceChartPoint value, $Res Function(PriceChartPoint) _then) = _$PriceChartPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double price
});




}
/// @nodoc
class _$PriceChartPointCopyWithImpl<$Res>
    implements $PriceChartPointCopyWith<$Res> {
  _$PriceChartPointCopyWithImpl(this._self, this._then);

  final PriceChartPoint _self;
  final $Res Function(PriceChartPoint) _then;

/// Create a copy of PriceChartPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? price = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceChartPoint].
extension PriceChartPointPatterns on PriceChartPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceChartPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceChartPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceChartPoint value)  $default,){
final _that = this;
switch (_that) {
case _PriceChartPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceChartPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PriceChartPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceChartPoint() when $default != null:
return $default(_that.date,_that.price);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double price)  $default,) {final _that = this;
switch (_that) {
case _PriceChartPoint():
return $default(_that.date,_that.price);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double price)?  $default,) {final _that = this;
switch (_that) {
case _PriceChartPoint() when $default != null:
return $default(_that.date,_that.price);case _:
  return null;

}
}

}

/// @nodoc


class _PriceChartPoint implements PriceChartPoint {
  const _PriceChartPoint({required this.date, required this.price});
  

@override final  DateTime date;
@override final  double price;

/// Create a copy of PriceChartPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceChartPointCopyWith<_PriceChartPoint> get copyWith => __$PriceChartPointCopyWithImpl<_PriceChartPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceChartPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price));
}


@override
int get hashCode => Object.hash(runtimeType,date,price);

@override
String toString() {
  return 'PriceChartPoint(date: $date, price: $price)';
}


}

/// @nodoc
abstract mixin class _$PriceChartPointCopyWith<$Res> implements $PriceChartPointCopyWith<$Res> {
  factory _$PriceChartPointCopyWith(_PriceChartPoint value, $Res Function(_PriceChartPoint) _then) = __$PriceChartPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double price
});




}
/// @nodoc
class __$PriceChartPointCopyWithImpl<$Res>
    implements _$PriceChartPointCopyWith<$Res> {
  __$PriceChartPointCopyWithImpl(this._self, this._then);

  final _PriceChartPoint _self;
  final $Res Function(_PriceChartPoint) _then;

/// Create a copy of PriceChartPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? price = null,}) {
  return _then(_PriceChartPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
