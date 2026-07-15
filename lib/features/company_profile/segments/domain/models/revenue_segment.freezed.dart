// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_segment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RevenueSegment {

 String get date; int get fiscalYear; String get period; String get reportedCurrency; Map<String, double> get data;
/// Create a copy of RevenueSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueSegmentCopyWith<RevenueSegment> get copyWith => _$RevenueSegmentCopyWithImpl<RevenueSegment>(this as RevenueSegment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueSegment&&(identical(other.date, date) || other.date == date)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,date,fiscalYear,period,reportedCurrency,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'RevenueSegment(date: $date, fiscalYear: $fiscalYear, period: $period, reportedCurrency: $reportedCurrency, data: $data)';
}


}

/// @nodoc
abstract mixin class $RevenueSegmentCopyWith<$Res>  {
  factory $RevenueSegmentCopyWith(RevenueSegment value, $Res Function(RevenueSegment) _then) = _$RevenueSegmentCopyWithImpl;
@useResult
$Res call({
 String date, int fiscalYear, String period, String reportedCurrency, Map<String, double> data
});




}
/// @nodoc
class _$RevenueSegmentCopyWithImpl<$Res>
    implements $RevenueSegmentCopyWith<$Res> {
  _$RevenueSegmentCopyWithImpl(this._self, this._then);

  final RevenueSegment _self;
  final $Res Function(RevenueSegment) _then;

/// Create a copy of RevenueSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? fiscalYear = null,Object? period = null,Object? reportedCurrency = null,Object? data = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,fiscalYear: null == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueSegment].
extension RevenueSegmentPatterns on RevenueSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueSegment value)  $default,){
final _that = this;
switch (_that) {
case _RevenueSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueSegment value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  int fiscalYear,  String period,  String reportedCurrency,  Map<String, double> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueSegment() when $default != null:
return $default(_that.date,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  int fiscalYear,  String period,  String reportedCurrency,  Map<String, double> data)  $default,) {final _that = this;
switch (_that) {
case _RevenueSegment():
return $default(_that.date,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  int fiscalYear,  String period,  String reportedCurrency,  Map<String, double> data)?  $default,) {final _that = this;
switch (_that) {
case _RevenueSegment() when $default != null:
return $default(_that.date,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _RevenueSegment implements RevenueSegment {
  const _RevenueSegment({required this.date, required this.fiscalYear, required this.period, required this.reportedCurrency, required final  Map<String, double> data}): _data = data;
  

@override final  String date;
@override final  int fiscalYear;
@override final  String period;
@override final  String reportedCurrency;
 final  Map<String, double> _data;
@override Map<String, double> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of RevenueSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueSegmentCopyWith<_RevenueSegment> get copyWith => __$RevenueSegmentCopyWithImpl<_RevenueSegment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueSegment&&(identical(other.date, date) || other.date == date)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,date,fiscalYear,period,reportedCurrency,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'RevenueSegment(date: $date, fiscalYear: $fiscalYear, period: $period, reportedCurrency: $reportedCurrency, data: $data)';
}


}

/// @nodoc
abstract mixin class _$RevenueSegmentCopyWith<$Res> implements $RevenueSegmentCopyWith<$Res> {
  factory _$RevenueSegmentCopyWith(_RevenueSegment value, $Res Function(_RevenueSegment) _then) = __$RevenueSegmentCopyWithImpl;
@override @useResult
$Res call({
 String date, int fiscalYear, String period, String reportedCurrency, Map<String, double> data
});




}
/// @nodoc
class __$RevenueSegmentCopyWithImpl<$Res>
    implements _$RevenueSegmentCopyWith<$Res> {
  __$RevenueSegmentCopyWithImpl(this._self, this._then);

  final _RevenueSegment _self;
  final $Res Function(_RevenueSegment) _then;

/// Create a copy of RevenueSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? fiscalYear = null,Object? period = null,Object? reportedCurrency = null,Object? data = null,}) {
  return _then(_RevenueSegment(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,fiscalYear: null == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as int,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
