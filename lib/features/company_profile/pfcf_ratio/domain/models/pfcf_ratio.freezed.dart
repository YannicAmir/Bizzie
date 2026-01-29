// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pfcf_ratio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PfcfRatio {

 String get symbol; String get date; String get period; double get priceToFreeCashFlowRatio;
/// Create a copy of PfcfRatio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PfcfRatioCopyWith<PfcfRatio> get copyWith => _$PfcfRatioCopyWithImpl<PfcfRatio>(this as PfcfRatio, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PfcfRatio&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToFreeCashFlowRatio, priceToFreeCashFlowRatio) || other.priceToFreeCashFlowRatio == priceToFreeCashFlowRatio));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToFreeCashFlowRatio);

@override
String toString() {
  return 'PfcfRatio(symbol: $symbol, date: $date, period: $period, priceToFreeCashFlowRatio: $priceToFreeCashFlowRatio)';
}


}

/// @nodoc
abstract mixin class $PfcfRatioCopyWith<$Res>  {
  factory $PfcfRatioCopyWith(PfcfRatio value, $Res Function(PfcfRatio) _then) = _$PfcfRatioCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, String period, double priceToFreeCashFlowRatio
});




}
/// @nodoc
class _$PfcfRatioCopyWithImpl<$Res>
    implements $PfcfRatioCopyWith<$Res> {
  _$PfcfRatioCopyWithImpl(this._self, this._then);

  final PfcfRatio _self;
  final $Res Function(PfcfRatio) _then;

/// Create a copy of PfcfRatio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? priceToFreeCashFlowRatio = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,priceToFreeCashFlowRatio: null == priceToFreeCashFlowRatio ? _self.priceToFreeCashFlowRatio : priceToFreeCashFlowRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PfcfRatio].
extension PfcfRatioPatterns on PfcfRatio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PfcfRatio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PfcfRatio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PfcfRatio value)  $default,){
final _that = this;
switch (_that) {
case _PfcfRatio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PfcfRatio value)?  $default,){
final _that = this;
switch (_that) {
case _PfcfRatio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double priceToFreeCashFlowRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PfcfRatio() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToFreeCashFlowRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double priceToFreeCashFlowRatio)  $default,) {final _that = this;
switch (_that) {
case _PfcfRatio():
return $default(_that.symbol,_that.date,_that.period,_that.priceToFreeCashFlowRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  String period,  double priceToFreeCashFlowRatio)?  $default,) {final _that = this;
switch (_that) {
case _PfcfRatio() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToFreeCashFlowRatio);case _:
  return null;

}
}

}

/// @nodoc


class _PfcfRatio implements PfcfRatio {
  const _PfcfRatio({required this.symbol, required this.date, required this.period, required this.priceToFreeCashFlowRatio});
  

@override final  String symbol;
@override final  String date;
@override final  String period;
@override final  double priceToFreeCashFlowRatio;

/// Create a copy of PfcfRatio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PfcfRatioCopyWith<_PfcfRatio> get copyWith => __$PfcfRatioCopyWithImpl<_PfcfRatio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PfcfRatio&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToFreeCashFlowRatio, priceToFreeCashFlowRatio) || other.priceToFreeCashFlowRatio == priceToFreeCashFlowRatio));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToFreeCashFlowRatio);

@override
String toString() {
  return 'PfcfRatio(symbol: $symbol, date: $date, period: $period, priceToFreeCashFlowRatio: $priceToFreeCashFlowRatio)';
}


}

/// @nodoc
abstract mixin class _$PfcfRatioCopyWith<$Res> implements $PfcfRatioCopyWith<$Res> {
  factory _$PfcfRatioCopyWith(_PfcfRatio value, $Res Function(_PfcfRatio) _then) = __$PfcfRatioCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, String period, double priceToFreeCashFlowRatio
});




}
/// @nodoc
class __$PfcfRatioCopyWithImpl<$Res>
    implements _$PfcfRatioCopyWith<$Res> {
  __$PfcfRatioCopyWithImpl(this._self, this._then);

  final _PfcfRatio _self;
  final $Res Function(_PfcfRatio) _then;

/// Create a copy of PfcfRatio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? priceToFreeCashFlowRatio = null,}) {
  return _then(_PfcfRatio(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,priceToFreeCashFlowRatio: null == priceToFreeCashFlowRatio ? _self.priceToFreeCashFlowRatio : priceToFreeCashFlowRatio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
