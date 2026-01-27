// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcps_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FcpsStats {

 List<FinancialDataPoint> get annualFcps; List<FinancialDataPoint> get quarterlyFcps; String get reportedCurrency;
/// Create a copy of FcpsStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FcpsStatsCopyWith<FcpsStats> get copyWith => _$FcpsStatsCopyWithImpl<FcpsStats>(this as FcpsStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FcpsStats&&const DeepCollectionEquality().equals(other.annualFcps, annualFcps)&&const DeepCollectionEquality().equals(other.quarterlyFcps, quarterlyFcps)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(annualFcps),const DeepCollectionEquality().hash(quarterlyFcps),reportedCurrency);

@override
String toString() {
  return 'FcpsStats(annualFcps: $annualFcps, quarterlyFcps: $quarterlyFcps, reportedCurrency: $reportedCurrency)';
}


}

/// @nodoc
abstract mixin class $FcpsStatsCopyWith<$Res>  {
  factory $FcpsStatsCopyWith(FcpsStats value, $Res Function(FcpsStats) _then) = _$FcpsStatsCopyWithImpl;
@useResult
$Res call({
 List<FinancialDataPoint> annualFcps, List<FinancialDataPoint> quarterlyFcps, String reportedCurrency
});




}
/// @nodoc
class _$FcpsStatsCopyWithImpl<$Res>
    implements $FcpsStatsCopyWith<$Res> {
  _$FcpsStatsCopyWithImpl(this._self, this._then);

  final FcpsStats _self;
  final $Res Function(FcpsStats) _then;

/// Create a copy of FcpsStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annualFcps = null,Object? quarterlyFcps = null,Object? reportedCurrency = null,}) {
  return _then(_self.copyWith(
annualFcps: null == annualFcps ? _self.annualFcps : annualFcps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyFcps: null == quarterlyFcps ? _self.quarterlyFcps : quarterlyFcps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FcpsStats].
extension FcpsStatsPatterns on FcpsStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FcpsStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FcpsStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FcpsStats value)  $default,){
final _that = this;
switch (_that) {
case _FcpsStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FcpsStats value)?  $default,){
final _that = this;
switch (_that) {
case _FcpsStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FinancialDataPoint> annualFcps,  List<FinancialDataPoint> quarterlyFcps,  String reportedCurrency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FcpsStats() when $default != null:
return $default(_that.annualFcps,_that.quarterlyFcps,_that.reportedCurrency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FinancialDataPoint> annualFcps,  List<FinancialDataPoint> quarterlyFcps,  String reportedCurrency)  $default,) {final _that = this;
switch (_that) {
case _FcpsStats():
return $default(_that.annualFcps,_that.quarterlyFcps,_that.reportedCurrency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FinancialDataPoint> annualFcps,  List<FinancialDataPoint> quarterlyFcps,  String reportedCurrency)?  $default,) {final _that = this;
switch (_that) {
case _FcpsStats() when $default != null:
return $default(_that.annualFcps,_that.quarterlyFcps,_that.reportedCurrency);case _:
  return null;

}
}

}

/// @nodoc


class _FcpsStats implements FcpsStats {
  const _FcpsStats({required final  List<FinancialDataPoint> annualFcps, required final  List<FinancialDataPoint> quarterlyFcps, required this.reportedCurrency}): _annualFcps = annualFcps,_quarterlyFcps = quarterlyFcps;
  

 final  List<FinancialDataPoint> _annualFcps;
@override List<FinancialDataPoint> get annualFcps {
  if (_annualFcps is EqualUnmodifiableListView) return _annualFcps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualFcps);
}

 final  List<FinancialDataPoint> _quarterlyFcps;
@override List<FinancialDataPoint> get quarterlyFcps {
  if (_quarterlyFcps is EqualUnmodifiableListView) return _quarterlyFcps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyFcps);
}

@override final  String reportedCurrency;

/// Create a copy of FcpsStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FcpsStatsCopyWith<_FcpsStats> get copyWith => __$FcpsStatsCopyWithImpl<_FcpsStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FcpsStats&&const DeepCollectionEquality().equals(other._annualFcps, _annualFcps)&&const DeepCollectionEquality().equals(other._quarterlyFcps, _quarterlyFcps)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_annualFcps),const DeepCollectionEquality().hash(_quarterlyFcps),reportedCurrency);

@override
String toString() {
  return 'FcpsStats(annualFcps: $annualFcps, quarterlyFcps: $quarterlyFcps, reportedCurrency: $reportedCurrency)';
}


}

/// @nodoc
abstract mixin class _$FcpsStatsCopyWith<$Res> implements $FcpsStatsCopyWith<$Res> {
  factory _$FcpsStatsCopyWith(_FcpsStats value, $Res Function(_FcpsStats) _then) = __$FcpsStatsCopyWithImpl;
@override @useResult
$Res call({
 List<FinancialDataPoint> annualFcps, List<FinancialDataPoint> quarterlyFcps, String reportedCurrency
});




}
/// @nodoc
class __$FcpsStatsCopyWithImpl<$Res>
    implements _$FcpsStatsCopyWith<$Res> {
  __$FcpsStatsCopyWithImpl(this._self, this._then);

  final _FcpsStats _self;
  final $Res Function(_FcpsStats) _then;

/// Create a copy of FcpsStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? annualFcps = null,Object? quarterlyFcps = null,Object? reportedCurrency = null,}) {
  return _then(_FcpsStats(
annualFcps: null == annualFcps ? _self._annualFcps : annualFcps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyFcps: null == quarterlyFcps ? _self._quarterlyFcps : quarterlyFcps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
