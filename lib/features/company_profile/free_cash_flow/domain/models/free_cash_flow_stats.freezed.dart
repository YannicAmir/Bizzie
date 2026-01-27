// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'free_cash_flow_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FreeCashFlowStats {

 String get reportedCurrency; List<FinancialDataPoint> get annualFcf; List<FinancialDataPoint> get quarterlyFcf;
/// Create a copy of FreeCashFlowStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FreeCashFlowStatsCopyWith<FreeCashFlowStats> get copyWith => _$FreeCashFlowStatsCopyWithImpl<FreeCashFlowStats>(this as FreeCashFlowStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeCashFlowStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.annualFcf, annualFcf)&&const DeepCollectionEquality().equals(other.quarterlyFcf, quarterlyFcf));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(annualFcf),const DeepCollectionEquality().hash(quarterlyFcf));

@override
String toString() {
  return 'FreeCashFlowStats(reportedCurrency: $reportedCurrency, annualFcf: $annualFcf, quarterlyFcf: $quarterlyFcf)';
}


}

/// @nodoc
abstract mixin class $FreeCashFlowStatsCopyWith<$Res>  {
  factory $FreeCashFlowStatsCopyWith(FreeCashFlowStats value, $Res Function(FreeCashFlowStats) _then) = _$FreeCashFlowStatsCopyWithImpl;
@useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualFcf, List<FinancialDataPoint> quarterlyFcf
});




}
/// @nodoc
class _$FreeCashFlowStatsCopyWithImpl<$Res>
    implements $FreeCashFlowStatsCopyWith<$Res> {
  _$FreeCashFlowStatsCopyWithImpl(this._self, this._then);

  final FreeCashFlowStats _self;
  final $Res Function(FreeCashFlowStats) _then;

/// Create a copy of FreeCashFlowStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportedCurrency = null,Object? annualFcf = null,Object? quarterlyFcf = null,}) {
  return _then(_self.copyWith(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualFcf: null == annualFcf ? _self.annualFcf : annualFcf // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyFcf: null == quarterlyFcf ? _self.quarterlyFcf : quarterlyFcf // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [FreeCashFlowStats].
extension FreeCashFlowStatsPatterns on FreeCashFlowStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FreeCashFlowStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FreeCashFlowStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FreeCashFlowStats value)  $default,){
final _that = this;
switch (_that) {
case _FreeCashFlowStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FreeCashFlowStats value)?  $default,){
final _that = this;
switch (_that) {
case _FreeCashFlowStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualFcf,  List<FinancialDataPoint> quarterlyFcf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FreeCashFlowStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualFcf,_that.quarterlyFcf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualFcf,  List<FinancialDataPoint> quarterlyFcf)  $default,) {final _that = this;
switch (_that) {
case _FreeCashFlowStats():
return $default(_that.reportedCurrency,_that.annualFcf,_that.quarterlyFcf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportedCurrency,  List<FinancialDataPoint> annualFcf,  List<FinancialDataPoint> quarterlyFcf)?  $default,) {final _that = this;
switch (_that) {
case _FreeCashFlowStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualFcf,_that.quarterlyFcf);case _:
  return null;

}
}

}

/// @nodoc


class _FreeCashFlowStats implements FreeCashFlowStats {
  const _FreeCashFlowStats({required this.reportedCurrency, required final  List<FinancialDataPoint> annualFcf, required final  List<FinancialDataPoint> quarterlyFcf}): _annualFcf = annualFcf,_quarterlyFcf = quarterlyFcf;
  

@override final  String reportedCurrency;
 final  List<FinancialDataPoint> _annualFcf;
@override List<FinancialDataPoint> get annualFcf {
  if (_annualFcf is EqualUnmodifiableListView) return _annualFcf;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualFcf);
}

 final  List<FinancialDataPoint> _quarterlyFcf;
@override List<FinancialDataPoint> get quarterlyFcf {
  if (_quarterlyFcf is EqualUnmodifiableListView) return _quarterlyFcf;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyFcf);
}


/// Create a copy of FreeCashFlowStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FreeCashFlowStatsCopyWith<_FreeCashFlowStats> get copyWith => __$FreeCashFlowStatsCopyWithImpl<_FreeCashFlowStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FreeCashFlowStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._annualFcf, _annualFcf)&&const DeepCollectionEquality().equals(other._quarterlyFcf, _quarterlyFcf));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(_annualFcf),const DeepCollectionEquality().hash(_quarterlyFcf));

@override
String toString() {
  return 'FreeCashFlowStats(reportedCurrency: $reportedCurrency, annualFcf: $annualFcf, quarterlyFcf: $quarterlyFcf)';
}


}

/// @nodoc
abstract mixin class _$FreeCashFlowStatsCopyWith<$Res> implements $FreeCashFlowStatsCopyWith<$Res> {
  factory _$FreeCashFlowStatsCopyWith(_FreeCashFlowStats value, $Res Function(_FreeCashFlowStats) _then) = __$FreeCashFlowStatsCopyWithImpl;
@override @useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualFcf, List<FinancialDataPoint> quarterlyFcf
});




}
/// @nodoc
class __$FreeCashFlowStatsCopyWithImpl<$Res>
    implements _$FreeCashFlowStatsCopyWith<$Res> {
  __$FreeCashFlowStatsCopyWithImpl(this._self, this._then);

  final _FreeCashFlowStats _self;
  final $Res Function(_FreeCashFlowStats) _then;

/// Create a copy of FreeCashFlowStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportedCurrency = null,Object? annualFcf = null,Object? quarterlyFcf = null,}) {
  return _then(_FreeCashFlowStats(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualFcf: null == annualFcf ? _self._annualFcf : annualFcf // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyFcf: null == quarterlyFcf ? _self._quarterlyFcf : quarterlyFcf // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}


}

// dart format on
