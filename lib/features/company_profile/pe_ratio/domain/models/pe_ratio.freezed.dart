// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pe_ratio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeRatio {

 String get symbol; String get date; String get period; double get priceToEarningsRatio;
/// Create a copy of PeRatio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeRatioCopyWith<PeRatio> get copyWith => _$PeRatioCopyWithImpl<PeRatio>(this as PeRatio, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeRatio&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToEarningsRatio, priceToEarningsRatio) || other.priceToEarningsRatio == priceToEarningsRatio));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToEarningsRatio);

@override
String toString() {
  return 'PeRatio(symbol: $symbol, date: $date, period: $period, priceToEarningsRatio: $priceToEarningsRatio)';
}


}

/// @nodoc
abstract mixin class $PeRatioCopyWith<$Res>  {
  factory $PeRatioCopyWith(PeRatio value, $Res Function(PeRatio) _then) = _$PeRatioCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, String period, double priceToEarningsRatio
});




}
/// @nodoc
class _$PeRatioCopyWithImpl<$Res>
    implements $PeRatioCopyWith<$Res> {
  _$PeRatioCopyWithImpl(this._self, this._then);

  final PeRatio _self;
  final $Res Function(PeRatio) _then;

/// Create a copy of PeRatio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? priceToEarningsRatio = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,priceToEarningsRatio: null == priceToEarningsRatio ? _self.priceToEarningsRatio : priceToEarningsRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PeRatio].
extension PeRatioPatterns on PeRatio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeRatio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeRatio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeRatio value)  $default,){
final _that = this;
switch (_that) {
case _PeRatio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeRatio value)?  $default,){
final _that = this;
switch (_that) {
case _PeRatio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double priceToEarningsRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeRatio() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double priceToEarningsRatio)  $default,) {final _that = this;
switch (_that) {
case _PeRatio():
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  String period,  double priceToEarningsRatio)?  $default,) {final _that = this;
switch (_that) {
case _PeRatio() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio);case _:
  return null;

}
}

}

/// @nodoc


class _PeRatio implements PeRatio {
  const _PeRatio({required this.symbol, required this.date, required this.period, required this.priceToEarningsRatio});
  

@override final  String symbol;
@override final  String date;
@override final  String period;
@override final  double priceToEarningsRatio;

/// Create a copy of PeRatio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeRatioCopyWith<_PeRatio> get copyWith => __$PeRatioCopyWithImpl<_PeRatio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeRatio&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToEarningsRatio, priceToEarningsRatio) || other.priceToEarningsRatio == priceToEarningsRatio));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToEarningsRatio);

@override
String toString() {
  return 'PeRatio(symbol: $symbol, date: $date, period: $period, priceToEarningsRatio: $priceToEarningsRatio)';
}


}

/// @nodoc
abstract mixin class _$PeRatioCopyWith<$Res> implements $PeRatioCopyWith<$Res> {
  factory _$PeRatioCopyWith(_PeRatio value, $Res Function(_PeRatio) _then) = __$PeRatioCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, String period, double priceToEarningsRatio
});




}
/// @nodoc
class __$PeRatioCopyWithImpl<$Res>
    implements _$PeRatioCopyWith<$Res> {
  __$PeRatioCopyWithImpl(this._self, this._then);

  final _PeRatio _self;
  final $Res Function(_PeRatio) _then;

/// Create a copy of PeRatio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? priceToEarningsRatio = null,}) {
  return _then(_PeRatio(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,priceToEarningsRatio: null == priceToEarningsRatio ? _self.priceToEarningsRatio : priceToEarningsRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
