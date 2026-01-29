// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eps_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EpsStats {

 String get reportedCurrency; List<FinancialDataPoint> get annualEps; List<FinancialDataPoint> get quarterlyEps;
/// Create a copy of EpsStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpsStatsCopyWith<EpsStats> get copyWith => _$EpsStatsCopyWithImpl<EpsStats>(this as EpsStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpsStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.annualEps, annualEps)&&const DeepCollectionEquality().equals(other.quarterlyEps, quarterlyEps));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(annualEps),const DeepCollectionEquality().hash(quarterlyEps));

@override
String toString() {
  return 'EpsStats(reportedCurrency: $reportedCurrency, annualEps: $annualEps, quarterlyEps: $quarterlyEps)';
}


}

/// @nodoc
abstract mixin class $EpsStatsCopyWith<$Res>  {
  factory $EpsStatsCopyWith(EpsStats value, $Res Function(EpsStats) _then) = _$EpsStatsCopyWithImpl;
@useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualEps, List<FinancialDataPoint> quarterlyEps
});




}
/// @nodoc
class _$EpsStatsCopyWithImpl<$Res>
    implements $EpsStatsCopyWith<$Res> {
  _$EpsStatsCopyWithImpl(this._self, this._then);

  final EpsStats _self;
  final $Res Function(EpsStats) _then;

/// Create a copy of EpsStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportedCurrency = null,Object? annualEps = null,Object? quarterlyEps = null,}) {
  return _then(_self.copyWith(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualEps: null == annualEps ? _self.annualEps : annualEps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyEps: null == quarterlyEps ? _self.quarterlyEps : quarterlyEps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [EpsStats].
extension EpsStatsPatterns on EpsStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpsStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpsStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpsStats value)  $default,){
final _that = this;
switch (_that) {
case _EpsStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpsStats value)?  $default,){
final _that = this;
switch (_that) {
case _EpsStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualEps,  List<FinancialDataPoint> quarterlyEps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpsStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualEps,_that.quarterlyEps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportedCurrency,  List<FinancialDataPoint> annualEps,  List<FinancialDataPoint> quarterlyEps)  $default,) {final _that = this;
switch (_that) {
case _EpsStats():
return $default(_that.reportedCurrency,_that.annualEps,_that.quarterlyEps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportedCurrency,  List<FinancialDataPoint> annualEps,  List<FinancialDataPoint> quarterlyEps)?  $default,) {final _that = this;
switch (_that) {
case _EpsStats() when $default != null:
return $default(_that.reportedCurrency,_that.annualEps,_that.quarterlyEps);case _:
  return null;

}
}

}

/// @nodoc


class _EpsStats implements EpsStats {
  const _EpsStats({required this.reportedCurrency, required final  List<FinancialDataPoint> annualEps, required final  List<FinancialDataPoint> quarterlyEps}): _annualEps = annualEps,_quarterlyEps = quarterlyEps;
  

@override final  String reportedCurrency;
 final  List<FinancialDataPoint> _annualEps;
@override List<FinancialDataPoint> get annualEps {
  if (_annualEps is EqualUnmodifiableListView) return _annualEps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualEps);
}

 final  List<FinancialDataPoint> _quarterlyEps;
@override List<FinancialDataPoint> get quarterlyEps {
  if (_quarterlyEps is EqualUnmodifiableListView) return _quarterlyEps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyEps);
}


/// Create a copy of EpsStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpsStatsCopyWith<_EpsStats> get copyWith => __$EpsStatsCopyWithImpl<_EpsStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpsStats&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._annualEps, _annualEps)&&const DeepCollectionEquality().equals(other._quarterlyEps, _quarterlyEps));
}


@override
int get hashCode => Object.hash(runtimeType,reportedCurrency,const DeepCollectionEquality().hash(_annualEps),const DeepCollectionEquality().hash(_quarterlyEps));

@override
String toString() {
  return 'EpsStats(reportedCurrency: $reportedCurrency, annualEps: $annualEps, quarterlyEps: $quarterlyEps)';
}


}

/// @nodoc
abstract mixin class _$EpsStatsCopyWith<$Res> implements $EpsStatsCopyWith<$Res> {
  factory _$EpsStatsCopyWith(_EpsStats value, $Res Function(_EpsStats) _then) = __$EpsStatsCopyWithImpl;
@override @useResult
$Res call({
 String reportedCurrency, List<FinancialDataPoint> annualEps, List<FinancialDataPoint> quarterlyEps
});




}
/// @nodoc
class __$EpsStatsCopyWithImpl<$Res>
    implements _$EpsStatsCopyWith<$Res> {
  __$EpsStatsCopyWithImpl(this._self, this._then);

  final _EpsStats _self;
  final $Res Function(_EpsStats) _then;

/// Create a copy of EpsStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportedCurrency = null,Object? annualEps = null,Object? quarterlyEps = null,}) {
  return _then(_EpsStats(
reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annualEps: null == annualEps ? _self._annualEps : annualEps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyEps: null == quarterlyEps ? _self._quarterlyEps : quarterlyEps // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}


}

// dart format on
