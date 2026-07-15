// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roe_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoeStats {

 List<FinancialDataPoint> get dataPoints; double get currentValue; double get growthPercentage; double get absoluteDelta; bool get isPositive; String get referenceDate;
/// Create a copy of RoeStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoeStatsCopyWith<RoeStats> get copyWith => _$RoeStatsCopyWithImpl<RoeStats>(this as RoeStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoeStats&&const DeepCollectionEquality().equals(other.dataPoints, dataPoints)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.absoluteDelta, absoluteDelta) || other.absoluteDelta == absoluteDelta)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.referenceDate, referenceDate) || other.referenceDate == referenceDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dataPoints),currentValue,growthPercentage,absoluteDelta,isPositive,referenceDate);

@override
String toString() {
  return 'RoeStats(dataPoints: $dataPoints, currentValue: $currentValue, growthPercentage: $growthPercentage, absoluteDelta: $absoluteDelta, isPositive: $isPositive, referenceDate: $referenceDate)';
}


}

/// @nodoc
abstract mixin class $RoeStatsCopyWith<$Res>  {
  factory $RoeStatsCopyWith(RoeStats value, $Res Function(RoeStats) _then) = _$RoeStatsCopyWithImpl;
@useResult
$Res call({
 List<FinancialDataPoint> dataPoints, double currentValue, double growthPercentage, double absoluteDelta, bool isPositive, String referenceDate
});




}
/// @nodoc
class _$RoeStatsCopyWithImpl<$Res>
    implements $RoeStatsCopyWith<$Res> {
  _$RoeStatsCopyWithImpl(this._self, this._then);

  final RoeStats _self;
  final $Res Function(RoeStats) _then;

/// Create a copy of RoeStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dataPoints = null,Object? currentValue = null,Object? growthPercentage = null,Object? absoluteDelta = null,Object? isPositive = null,Object? referenceDate = null,}) {
  return _then(_self.copyWith(
dataPoints: null == dataPoints ? _self.dataPoints : dataPoints // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as double,absoluteDelta: null == absoluteDelta ? _self.absoluteDelta : absoluteDelta // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,referenceDate: null == referenceDate ? _self.referenceDate : referenceDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoeStats].
extension RoeStatsPatterns on RoeStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoeStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoeStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoeStats value)  $default,){
final _that = this;
switch (_that) {
case _RoeStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoeStats value)?  $default,){
final _that = this;
switch (_that) {
case _RoeStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FinancialDataPoint> dataPoints,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoeStats() when $default != null:
return $default(_that.dataPoints,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FinancialDataPoint> dataPoints,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceDate)  $default,) {final _that = this;
switch (_that) {
case _RoeStats():
return $default(_that.dataPoints,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FinancialDataPoint> dataPoints,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceDate)?  $default,) {final _that = this;
switch (_that) {
case _RoeStats() when $default != null:
return $default(_that.dataPoints,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceDate);case _:
  return null;

}
}

}

/// @nodoc


class _RoeStats implements RoeStats {
  const _RoeStats({required final  List<FinancialDataPoint> dataPoints, required this.currentValue, required this.growthPercentage, required this.absoluteDelta, required this.isPositive, required this.referenceDate}): _dataPoints = dataPoints;
  

 final  List<FinancialDataPoint> _dataPoints;
@override List<FinancialDataPoint> get dataPoints {
  if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataPoints);
}

@override final  double currentValue;
@override final  double growthPercentage;
@override final  double absoluteDelta;
@override final  bool isPositive;
@override final  String referenceDate;

/// Create a copy of RoeStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoeStatsCopyWith<_RoeStats> get copyWith => __$RoeStatsCopyWithImpl<_RoeStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoeStats&&const DeepCollectionEquality().equals(other._dataPoints, _dataPoints)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.absoluteDelta, absoluteDelta) || other.absoluteDelta == absoluteDelta)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.referenceDate, referenceDate) || other.referenceDate == referenceDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dataPoints),currentValue,growthPercentage,absoluteDelta,isPositive,referenceDate);

@override
String toString() {
  return 'RoeStats(dataPoints: $dataPoints, currentValue: $currentValue, growthPercentage: $growthPercentage, absoluteDelta: $absoluteDelta, isPositive: $isPositive, referenceDate: $referenceDate)';
}


}

/// @nodoc
abstract mixin class _$RoeStatsCopyWith<$Res> implements $RoeStatsCopyWith<$Res> {
  factory _$RoeStatsCopyWith(_RoeStats value, $Res Function(_RoeStats) _then) = __$RoeStatsCopyWithImpl;
@override @useResult
$Res call({
 List<FinancialDataPoint> dataPoints, double currentValue, double growthPercentage, double absoluteDelta, bool isPositive, String referenceDate
});




}
/// @nodoc
class __$RoeStatsCopyWithImpl<$Res>
    implements _$RoeStatsCopyWith<$Res> {
  __$RoeStatsCopyWithImpl(this._self, this._then);

  final _RoeStats _self;
  final $Res Function(_RoeStats) _then;

/// Create a copy of RoeStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dataPoints = null,Object? currentValue = null,Object? growthPercentage = null,Object? absoluteDelta = null,Object? isPositive = null,Object? referenceDate = null,}) {
  return _then(_RoeStats(
dataPoints: null == dataPoints ? _self._dataPoints : dataPoints // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as double,absoluteDelta: null == absoluteDelta ? _self.absoluteDelta : absoluteDelta // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,referenceDate: null == referenceDate ? _self.referenceDate : referenceDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
