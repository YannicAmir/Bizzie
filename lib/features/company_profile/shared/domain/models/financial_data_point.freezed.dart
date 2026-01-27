// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_data_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialDataPoint {

 String get date; String get period; double get value;
/// Create a copy of FinancialDataPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialDataPointCopyWith<FinancialDataPoint> get copyWith => _$FinancialDataPointCopyWithImpl<FinancialDataPoint>(this as FinancialDataPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialDataPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,date,period,value);

@override
String toString() {
  return 'FinancialDataPoint(date: $date, period: $period, value: $value)';
}


}

/// @nodoc
abstract mixin class $FinancialDataPointCopyWith<$Res>  {
  factory $FinancialDataPointCopyWith(FinancialDataPoint value, $Res Function(FinancialDataPoint) _then) = _$FinancialDataPointCopyWithImpl;
@useResult
$Res call({
 String date, String period, double value
});




}
/// @nodoc
class _$FinancialDataPointCopyWithImpl<$Res>
    implements $FinancialDataPointCopyWith<$Res> {
  _$FinancialDataPointCopyWithImpl(this._self, this._then);

  final FinancialDataPoint _self;
  final $Res Function(FinancialDataPoint) _then;

/// Create a copy of FinancialDataPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? period = null,Object? value = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialDataPoint].
extension FinancialDataPointPatterns on FinancialDataPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialDataPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialDataPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialDataPoint value)  $default,){
final _that = this;
switch (_that) {
case _FinancialDataPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialDataPoint value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialDataPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String period,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialDataPoint() when $default != null:
return $default(_that.date,_that.period,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String period,  double value)  $default,) {final _that = this;
switch (_that) {
case _FinancialDataPoint():
return $default(_that.date,_that.period,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String period,  double value)?  $default,) {final _that = this;
switch (_that) {
case _FinancialDataPoint() when $default != null:
return $default(_that.date,_that.period,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialDataPoint implements FinancialDataPoint {
  const _FinancialDataPoint({required this.date, required this.period, required this.value});
  

@override final  String date;
@override final  String period;
@override final  double value;

/// Create a copy of FinancialDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialDataPointCopyWith<_FinancialDataPoint> get copyWith => __$FinancialDataPointCopyWithImpl<_FinancialDataPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialDataPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,date,period,value);

@override
String toString() {
  return 'FinancialDataPoint(date: $date, period: $period, value: $value)';
}


}

/// @nodoc
abstract mixin class _$FinancialDataPointCopyWith<$Res> implements $FinancialDataPointCopyWith<$Res> {
  factory _$FinancialDataPointCopyWith(_FinancialDataPoint value, $Res Function(_FinancialDataPoint) _then) = __$FinancialDataPointCopyWithImpl;
@override @useResult
$Res call({
 String date, String period, double value
});




}
/// @nodoc
class __$FinancialDataPointCopyWithImpl<$Res>
    implements _$FinancialDataPointCopyWith<$Res> {
  __$FinancialDataPointCopyWithImpl(this._self, this._then);

  final _FinancialDataPoint _self;
  final $Res Function(_FinancialDataPoint) _then;

/// Create a copy of FinancialDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? period = null,Object? value = null,}) {
  return _then(_FinancialDataPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
