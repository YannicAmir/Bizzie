// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RevenueStats {

 String get reportedCurrency; List<FinancialDataPoint> get annualRevenue; List<FinancialDataPoint> get quarterlyRevenue;
/// Create a copy of RevenueStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueStatsCopyWith<RevenueStats> get copyWith => _$RevenueStatsCopyWithImpl<RevenueStats>(this as RevenueStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.annualRevenue, annualRevenue)&&const DeepCollectionEquality().equals(other.quarterlyRevenue, quarterlyRevenue));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(annualRevenue),const DeepCollectionEquality().hash(quarterlyRevenue));

@override
String toString() {
  return 'RevenueStats(reportedCurrency: $reportedCurrency, annualRevenue: $annualRevenue, quarterlyRevenue: $quarterlyRevenue)';
}


}

/// @nodoc
abstract mixin class $RevenueStatsCopyWith<$Res>  {
  factory $RevenueStatsCopyWith(RevenueStats value, $Res Function(RevenueStats) _then) = _$RevenueStatsCopyWithImpl;
@useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualRevenue, List<FinancialDataPoint> quarterlyRevenue
});




}
/// @nodoc
class _$RevenueStatsCopyWithImpl<$Res>
    implements $RevenueStatsCopyWith<$Res> {
  _$RevenueStatsCopyWithImpl(this._self, this._then);

  final RevenueStats _self;
  final $Res Function(RevenueStats) _then;

/// Create a copy of RevenueStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportedCurrency = null,Object? annualRevenue = null,Object? quarterlyRevenue = null,}) {
  return _then(_self.copyWith(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualRevenue: null == annualRevenue ? _self.annualRevenue : annualRevenue // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyRevenue: null == quarterlyRevenue ? _self.quarterlyRevenue : quarterlyRevenue // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueStats].
extension RevenueStatsPatterns on RevenueStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueStats value)  $default,){
final _that = this;
switch (_that) {
case _RevenueStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueStats value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualRevenue,  List<FinancialDataPoint> quarterlyRevenue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualRevenue,_that.quarterlyRevenue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualRevenue,  List<FinancialDataPoint> quarterlyRevenue)  $default,) {final _that = this;
switch (_that) {
case _RevenueStats():
return $default(_that.reportedCurrency,_that.annualRevenue,_that.quarterlyRevenue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportedCurrency,  List<FinancialDataPoint> annualRevenue,  List<FinancialDataPoint> quarterlyRevenue)?  $default,) {final _that = this;
switch (_that) {
case _RevenueStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualRevenue,_that.quarterlyRevenue);case _:
  return null;

}
}

}

/// @nodoc


class _RevenueStats implements RevenueStats {
  const _RevenueStats({required this.reportedCurrency, required final  List<FinancialDataPoint> annualRevenue, required final  List<FinancialDataPoint> quarterlyRevenue}): _annualRevenue = annualRevenue,_quarterlyRevenue = quarterlyRevenue;
  

@override final  String reportedCurrency;
 final  List<FinancialDataPoint> _annualRevenue;
@override List<FinancialDataPoint> get annualRevenue {
  if (_annualRevenue is EqualUnmodifiableListView) return _annualRevenue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualRevenue);
}

 final  List<FinancialDataPoint> _quarterlyRevenue;
@override List<FinancialDataPoint> get quarterlyRevenue {
  if (_quarterlyRevenue is EqualUnmodifiableListView) return _quarterlyRevenue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyRevenue);
}


/// Create a copy of RevenueStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueStatsCopyWith<_RevenueStats> get copyWith => __$RevenueStatsCopyWithImpl<_RevenueStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._annualRevenue, _annualRevenue)&&const DeepCollectionEquality().equals(other._quarterlyRevenue, _quarterlyRevenue));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(_annualRevenue),const DeepCollectionEquality().hash(_quarterlyRevenue));

@override
String toString() {
  return 'RevenueStats(reportedCurrency: $reportedCurrency, annualRevenue: $annualRevenue, quarterlyRevenue: $quarterlyRevenue)';
}


}

/// @nodoc
abstract mixin class _$RevenueStatsCopyWith<$Res> implements $RevenueStatsCopyWith<$Res> {
  factory _$RevenueStatsCopyWith(_RevenueStats value, $Res Function(_RevenueStats) _then) = __$RevenueStatsCopyWithImpl;
@override @useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualRevenue, List<FinancialDataPoint> quarterlyRevenue
});




}
/// @nodoc
class __$RevenueStatsCopyWithImpl<$Res>
    implements _$RevenueStatsCopyWith<$Res> {
  __$RevenueStatsCopyWithImpl(this._self, this._then);

  final _RevenueStats _self;
  final $Res Function(_RevenueStats) _then;

/// Create a copy of RevenueStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportedCurrency = null,Object? annualRevenue = null,Object? quarterlyRevenue = null,}) {
  return _then(_RevenueStats(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualRevenue: null == annualRevenue ? _self._annualRevenue : annualRevenue // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyRevenue: null == quarterlyRevenue ? _self._quarterlyRevenue : quarterlyRevenue // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}


}

// dart format on
