// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShareStats {

 double get currentSharesOutstanding; List<FinancialDataPoint> get annualWeightedAverageShares; List<FinancialDataPoint> get quarterlyWeightedAverageShares;
/// Create a copy of ShareStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareStatsCopyWith<ShareStats> get copyWith => _$ShareStatsCopyWithImpl<ShareStats>(this as ShareStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareStats&&(identical(other.currentSharesOutstanding, currentSharesOutstanding) || other.currentSharesOutstanding == currentSharesOutstanding)&&const DeepCollectionEquality().equals(other.annualWeightedAverageShares, annualWeightedAverageShares)&&const DeepCollectionEquality().equals(other.quarterlyWeightedAverageShares, quarterlyWeightedAverageShares));
}


@override
int get hashCode => Object.hash(runtimeType,currentSharesOutstanding,const DeepCollectionEquality().hash(annualWeightedAverageShares),const DeepCollectionEquality().hash(quarterlyWeightedAverageShares));

@override
String toString() {
  return 'ShareStats(currentSharesOutstanding: $currentSharesOutstanding, annualWeightedAverageShares: $annualWeightedAverageShares, quarterlyWeightedAverageShares: $quarterlyWeightedAverageShares)';
}


}

/// @nodoc
abstract mixin class $ShareStatsCopyWith<$Res>  {
  factory $ShareStatsCopyWith(ShareStats value, $Res Function(ShareStats) _then) = _$ShareStatsCopyWithImpl;
@useResult
$Res call({
 double currentSharesOutstanding, List<FinancialDataPoint> annualWeightedAverageShares, List<FinancialDataPoint> quarterlyWeightedAverageShares
});




}
/// @nodoc
class _$ShareStatsCopyWithImpl<$Res>
    implements $ShareStatsCopyWith<$Res> {
  _$ShareStatsCopyWithImpl(this._self, this._then);

  final ShareStats _self;
  final $Res Function(ShareStats) _then;

/// Create a copy of ShareStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentSharesOutstanding = null,Object? annualWeightedAverageShares = null,Object? quarterlyWeightedAverageShares = null,}) {
  return _then(_self.copyWith(
currentSharesOutstanding: null == currentSharesOutstanding ? _self.currentSharesOutstanding : currentSharesOutstanding // ignore: cast_nullable_to_non_nullable
as double,annualWeightedAverageShares: null == annualWeightedAverageShares ? _self.annualWeightedAverageShares : annualWeightedAverageShares // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyWeightedAverageShares: null == quarterlyWeightedAverageShares ? _self.quarterlyWeightedAverageShares : quarterlyWeightedAverageShares // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareStats].
extension ShareStatsPatterns on ShareStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareStats value)  $default,){
final _that = this;
switch (_that) {
case _ShareStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareStats value)?  $default,){
final _that = this;
switch (_that) {
case _ShareStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentSharesOutstanding,  List<FinancialDataPoint> annualWeightedAverageShares,  List<FinancialDataPoint> quarterlyWeightedAverageShares)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareStats() when $default != null:
return $default(_that.currentSharesOutstanding,_that.annualWeightedAverageShares,_that.quarterlyWeightedAverageShares);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentSharesOutstanding,  List<FinancialDataPoint> annualWeightedAverageShares,  List<FinancialDataPoint> quarterlyWeightedAverageShares)  $default,) {final _that = this;
switch (_that) {
case _ShareStats():
return $default(_that.currentSharesOutstanding,_that.annualWeightedAverageShares,_that.quarterlyWeightedAverageShares);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentSharesOutstanding,  List<FinancialDataPoint> annualWeightedAverageShares,  List<FinancialDataPoint> quarterlyWeightedAverageShares)?  $default,) {final _that = this;
switch (_that) {
case _ShareStats() when $default != null:
return $default(_that.currentSharesOutstanding,_that.annualWeightedAverageShares,_that.quarterlyWeightedAverageShares);case _:
  return null;

}
}

}

/// @nodoc


class _ShareStats implements ShareStats {
  const _ShareStats({required this.currentSharesOutstanding, required final  List<FinancialDataPoint> annualWeightedAverageShares, required final  List<FinancialDataPoint> quarterlyWeightedAverageShares}): _annualWeightedAverageShares = annualWeightedAverageShares,_quarterlyWeightedAverageShares = quarterlyWeightedAverageShares;
  

@override final  double currentSharesOutstanding;
 final  List<FinancialDataPoint> _annualWeightedAverageShares;
@override List<FinancialDataPoint> get annualWeightedAverageShares {
  if (_annualWeightedAverageShares is EqualUnmodifiableListView) return _annualWeightedAverageShares;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualWeightedAverageShares);
}

 final  List<FinancialDataPoint> _quarterlyWeightedAverageShares;
@override List<FinancialDataPoint> get quarterlyWeightedAverageShares {
  if (_quarterlyWeightedAverageShares is EqualUnmodifiableListView) return _quarterlyWeightedAverageShares;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyWeightedAverageShares);
}


/// Create a copy of ShareStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareStatsCopyWith<_ShareStats> get copyWith => __$ShareStatsCopyWithImpl<_ShareStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareStats&&(identical(other.currentSharesOutstanding, currentSharesOutstanding) || other.currentSharesOutstanding == currentSharesOutstanding)&&const DeepCollectionEquality().equals(other._annualWeightedAverageShares, _annualWeightedAverageShares)&&const DeepCollectionEquality().equals(other._quarterlyWeightedAverageShares, _quarterlyWeightedAverageShares));
}


@override
int get hashCode => Object.hash(runtimeType,currentSharesOutstanding,const DeepCollectionEquality().hash(_annualWeightedAverageShares),const DeepCollectionEquality().hash(_quarterlyWeightedAverageShares));

@override
String toString() {
  return 'ShareStats(currentSharesOutstanding: $currentSharesOutstanding, annualWeightedAverageShares: $annualWeightedAverageShares, quarterlyWeightedAverageShares: $quarterlyWeightedAverageShares)';
}


}

/// @nodoc
abstract mixin class _$ShareStatsCopyWith<$Res> implements $ShareStatsCopyWith<$Res> {
  factory _$ShareStatsCopyWith(_ShareStats value, $Res Function(_ShareStats) _then) = __$ShareStatsCopyWithImpl;
@override @useResult
$Res call({
 double currentSharesOutstanding, List<FinancialDataPoint> annualWeightedAverageShares, List<FinancialDataPoint> quarterlyWeightedAverageShares
});




}
/// @nodoc
class __$ShareStatsCopyWithImpl<$Res>
    implements _$ShareStatsCopyWith<$Res> {
  __$ShareStatsCopyWithImpl(this._self, this._then);

  final _ShareStats _self;
  final $Res Function(_ShareStats) _then;

/// Create a copy of ShareStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentSharesOutstanding = null,Object? annualWeightedAverageShares = null,Object? quarterlyWeightedAverageShares = null,}) {
  return _then(_ShareStats(
currentSharesOutstanding: null == currentSharesOutstanding ? _self.currentSharesOutstanding : currentSharesOutstanding // ignore: cast_nullable_to_non_nullable
as double,annualWeightedAverageShares: null == annualWeightedAverageShares ? _self._annualWeightedAverageShares : annualWeightedAverageShares // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,quarterlyWeightedAverageShares: null == quarterlyWeightedAverageShares ? _self._quarterlyWeightedAverageShares : quarterlyWeightedAverageShares // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,
  ));
}


}

// dart format on
