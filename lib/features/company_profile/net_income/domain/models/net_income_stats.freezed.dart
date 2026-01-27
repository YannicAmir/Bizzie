// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'net_income_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetIncomeStats {

 String get reportedCurrency; List<FinancialDataPoint> get annualNetIncome; List<FinancialDataPoint> get quarterlyNetIncome;
/// Create a copy of NetIncomeStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetIncomeStatsCopyWith<NetIncomeStats> get copyWith => _$NetIncomeStatsCopyWithImpl<NetIncomeStats>(this as NetIncomeStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetIncomeStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.annualNetIncome, annualNetIncome)&&const DeepCollectionEquality().equals(other.quarterlyNetIncome, quarterlyNetIncome));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(annualNetIncome),const DeepCollectionEquality().hash(quarterlyNetIncome));

@override
String toString() {
  return 'NetIncomeStats(reportedCurrency: $reportedCurrency, annualNetIncome: $annualNetIncome, quarterlyNetIncome: $quarterlyNetIncome)';
}


}

/// @nodoc
abstract mixin class $NetIncomeStatsCopyWith<$Res>  {
  factory $NetIncomeStatsCopyWith(NetIncomeStats value, $Res Function(NetIncomeStats) _then) = _$NetIncomeStatsCopyWithImpl;
@useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualNetIncome, List<FinancialDataPoint> quarterlyNetIncome
});




}
/// @nodoc
class _$NetIncomeStatsCopyWithImpl<$Res>
    implements $NetIncomeStatsCopyWith<$Res> {
  _$NetIncomeStatsCopyWithImpl(this._self, this._then);

  final NetIncomeStats _self;
  final $Res Function(NetIncomeStats) _then;

/// Create a copy of NetIncomeStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportedCurrency = null,Object? annualNetIncome = null,Object? quarterlyNetIncome = null,}) {
  return _then(_self.copyWith(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualNetIncome: null == annualNetIncome ? _self.annualNetIncome : annualNetIncome // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyNetIncome: null == quarterlyNetIncome ? _self.quarterlyNetIncome : quarterlyNetIncome // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [NetIncomeStats].
extension NetIncomeStatsPatterns on NetIncomeStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetIncomeStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetIncomeStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetIncomeStats value)  $default,){
final _that = this;
switch (_that) {
case _NetIncomeStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetIncomeStats value)?  $default,){
final _that = this;
switch (_that) {
case _NetIncomeStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualNetIncome,  List<FinancialDataPoint> quarterlyNetIncome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetIncomeStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualNetIncome,_that.quarterlyNetIncome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualNetIncome,  List<FinancialDataPoint> quarterlyNetIncome)  $default,) {final _that = this;
switch (_that) {
case _NetIncomeStats():
return $default(_that.reportedCurrency,_that.annualNetIncome,_that.quarterlyNetIncome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportedCurrency,  List<FinancialDataPoint> annualNetIncome,  List<FinancialDataPoint> quarterlyNetIncome)?  $default,) {final _that = this;
switch (_that) {
case _NetIncomeStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualNetIncome,_that.quarterlyNetIncome);case _:
  return null;

}
}

}

/// @nodoc


class _NetIncomeStats implements NetIncomeStats {
  const _NetIncomeStats({required this.reportedCurrency, required final  List<FinancialDataPoint> annualNetIncome, required final  List<FinancialDataPoint> quarterlyNetIncome}): _annualNetIncome = annualNetIncome,_quarterlyNetIncome = quarterlyNetIncome;
  

@override final  String reportedCurrency;
 final  List<FinancialDataPoint> _annualNetIncome;
@override List<FinancialDataPoint> get annualNetIncome {
  if (_annualNetIncome is EqualUnmodifiableListView) return _annualNetIncome;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualNetIncome);
}

 final  List<FinancialDataPoint> _quarterlyNetIncome;
@override List<FinancialDataPoint> get quarterlyNetIncome {
  if (_quarterlyNetIncome is EqualUnmodifiableListView) return _quarterlyNetIncome;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyNetIncome);
}


/// Create a copy of NetIncomeStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetIncomeStatsCopyWith<_NetIncomeStats> get copyWith => __$NetIncomeStatsCopyWithImpl<_NetIncomeStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetIncomeStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._annualNetIncome, _annualNetIncome)&&const DeepCollectionEquality().equals(other._quarterlyNetIncome, _quarterlyNetIncome));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(_annualNetIncome),const DeepCollectionEquality().hash(_quarterlyNetIncome));

@override
String toString() {
  return 'NetIncomeStats(reportedCurrency: $reportedCurrency, annualNetIncome: $annualNetIncome, quarterlyNetIncome: $quarterlyNetIncome)';
}


}

/// @nodoc
abstract mixin class _$NetIncomeStatsCopyWith<$Res> implements $NetIncomeStatsCopyWith<$Res> {
  factory _$NetIncomeStatsCopyWith(_NetIncomeStats value, $Res Function(_NetIncomeStats) _then) = __$NetIncomeStatsCopyWithImpl;
@override @useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualNetIncome, List<FinancialDataPoint> quarterlyNetIncome
});




}
/// @nodoc
class __$NetIncomeStatsCopyWithImpl<$Res>
    implements _$NetIncomeStatsCopyWith<$Res> {
  __$NetIncomeStatsCopyWithImpl(this._self, this._then);

  final _NetIncomeStats _self;
  final $Res Function(_NetIncomeStats) _then;

/// Create a copy of NetIncomeStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportedCurrency = null,Object? annualNetIncome = null,Object? quarterlyNetIncome = null,}) {
  return _then(_NetIncomeStats(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualNetIncome: null == annualNetIncome ? _self._annualNetIncome : annualNetIncome // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyNetIncome: null == quarterlyNetIncome ? _self._quarterlyNetIncome : quarterlyNetIncome // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}


}

// dart format on
