// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Roe {

 String get symbol; String get date; String get period; double get returnOnEquity;
/// Create a copy of Roe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoeCopyWith<Roe> get copyWith => _$RoeCopyWithImpl<Roe>(this as Roe, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Roe&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.returnOnEquity, returnOnEquity) || other.returnOnEquity == returnOnEquity));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,returnOnEquity);

@override
String toString() {
  return 'Roe(symbol: $symbol, date: $date, period: $period, returnOnEquity: $returnOnEquity)';
}


}

/// @nodoc
abstract mixin class $RoeCopyWith<$Res>  {
  factory $RoeCopyWith(Roe value, $Res Function(Roe) _then) = _$RoeCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, String period, double returnOnEquity
});




}
/// @nodoc
class _$RoeCopyWithImpl<$Res>
    implements $RoeCopyWith<$Res> {
  _$RoeCopyWithImpl(this._self, this._then);

  final Roe _self;
  final $Res Function(Roe) _then;

/// Create a copy of Roe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? returnOnEquity = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,returnOnEquity: null == returnOnEquity ? _self.returnOnEquity : returnOnEquity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Roe].
extension RoePatterns on Roe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Roe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Roe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Roe value)  $default,){
final _that = this;
switch (_that) {
case _Roe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Roe value)?  $default,){
final _that = this;
switch (_that) {
case _Roe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double returnOnEquity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Roe() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  String period,  double returnOnEquity)  $default,) {final _that = this;
switch (_that) {
case _Roe():
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  String period,  double returnOnEquity)?  $default,) {final _that = this;
switch (_that) {
case _Roe() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
  return null;

}
}

}

/// @nodoc


class _Roe implements Roe {
  const _Roe({required this.symbol, required this.date, required this.period, required this.returnOnEquity});
  

@override final  String symbol;
@override final  String date;
@override final  String period;
@override final  double returnOnEquity;

/// Create a copy of Roe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoeCopyWith<_Roe> get copyWith => __$RoeCopyWithImpl<_Roe>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Roe&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.returnOnEquity, returnOnEquity) || other.returnOnEquity == returnOnEquity));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,returnOnEquity);

@override
String toString() {
  return 'Roe(symbol: $symbol, date: $date, period: $period, returnOnEquity: $returnOnEquity)';
}


}

/// @nodoc
abstract mixin class _$RoeCopyWith<$Res> implements $RoeCopyWith<$Res> {
  factory _$RoeCopyWith(_Roe value, $Res Function(_Roe) _then) = __$RoeCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, String period, double returnOnEquity
});




}
/// @nodoc
class __$RoeCopyWithImpl<$Res>
    implements _$RoeCopyWith<$Res> {
  __$RoeCopyWithImpl(this._self, this._then);

  final _Roe _self;
  final $Res Function(_Roe) _then;

/// Create a copy of Roe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? period = null,Object? returnOnEquity = null,}) {
  return _then(_Roe(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,returnOnEquity: null == returnOnEquity ? _self.returnOnEquity : returnOnEquity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
