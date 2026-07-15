// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_product_segments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RevenueProductSegments {

 String get symbol; String get reportedCurrency; List<RevenueSegment> get annual; List<RevenueSegment> get quarterly;
/// Create a copy of RevenueProductSegments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueProductSegmentsCopyWith<RevenueProductSegments> get copyWith => _$RevenueProductSegmentsCopyWithImpl<RevenueProductSegments>(this as RevenueProductSegments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueProductSegments&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other.annual, annual)&&const DeepCollectionEquality().equals(other.quarterly, quarterly));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,reportedCurrency,const DeepCollectionEquality().hash(annual),const DeepCollectionEquality().hash(quarterly));

@override
String toString() {
  return 'RevenueProductSegments(symbol: $symbol, reportedCurrency: $reportedCurrency, annual: $annual, quarterly: $quarterly)';
}


}

/// @nodoc
abstract mixin class $RevenueProductSegmentsCopyWith<$Res>  {
  factory $RevenueProductSegmentsCopyWith(RevenueProductSegments value, $Res Function(RevenueProductSegments) _then) = _$RevenueProductSegmentsCopyWithImpl;
@useResult
$Res call({
 String symbol, String reportedCurrency, List<RevenueSegment> annual, List<RevenueSegment> quarterly
});




}
/// @nodoc
class _$RevenueProductSegmentsCopyWithImpl<$Res>
    implements $RevenueProductSegmentsCopyWith<$Res> {
  _$RevenueProductSegmentsCopyWithImpl(this._self, this._then);

  final RevenueProductSegments _self;
  final $Res Function(RevenueProductSegments) _then;

/// Create a copy of RevenueProductSegments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? reportedCurrency = null,Object? annual = null,Object? quarterly = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annual: null == annual ? _self.annual : annual // ignore: cast_nullable_to_non_nullable
as List<RevenueSegment>,quarterly: null == quarterly ? _self.quarterly : quarterly // ignore: cast_nullable_to_non_nullable
as List<RevenueSegment>,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueProductSegments].
extension RevenueProductSegmentsPatterns on RevenueProductSegments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueProductSegments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueProductSegments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueProductSegments value)  $default,){
final _that = this;
switch (_that) {
case _RevenueProductSegments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueProductSegments value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueProductSegments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String reportedCurrency,  List<RevenueSegment> annual,  List<RevenueSegment> quarterly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueProductSegments() when $default != null:
return $default(_that.symbol,_that.reportedCurrency,_that.annual,_that.quarterly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String reportedCurrency,  List<RevenueSegment> annual,  List<RevenueSegment> quarterly)  $default,) {final _that = this;
switch (_that) {
case _RevenueProductSegments():
return $default(_that.symbol,_that.reportedCurrency,_that.annual,_that.quarterly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String reportedCurrency,  List<RevenueSegment> annual,  List<RevenueSegment> quarterly)?  $default,) {final _that = this;
switch (_that) {
case _RevenueProductSegments() when $default != null:
return $default(_that.symbol,_that.reportedCurrency,_that.annual,_that.quarterly);case _:
  return null;

}
}

}

/// @nodoc


class _RevenueProductSegments implements RevenueProductSegments {
  const _RevenueProductSegments({required this.symbol, required this.reportedCurrency, required final  List<RevenueSegment> annual, required final  List<RevenueSegment> quarterly}): _annual = annual,_quarterly = quarterly;
  

@override final  String symbol;
@override final  String reportedCurrency;
 final  List<RevenueSegment> _annual;
@override List<RevenueSegment> get annual {
  if (_annual is EqualUnmodifiableListView) return _annual;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annual);
}

 final  List<RevenueSegment> _quarterly;
@override List<RevenueSegment> get quarterly {
  if (_quarterly is EqualUnmodifiableListView) return _quarterly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterly);
}


/// Create a copy of RevenueProductSegments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueProductSegmentsCopyWith<_RevenueProductSegments> get copyWith => __$RevenueProductSegmentsCopyWithImpl<_RevenueProductSegments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueProductSegments&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&const DeepCollectionEquality().equals(other._annual, _annual)&&const DeepCollectionEquality().equals(other._quarterly, _quarterly));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,reportedCurrency,const DeepCollectionEquality().hash(_annual),const DeepCollectionEquality().hash(_quarterly));

@override
String toString() {
  return 'RevenueProductSegments(symbol: $symbol, reportedCurrency: $reportedCurrency, annual: $annual, quarterly: $quarterly)';
}


}

/// @nodoc
abstract mixin class _$RevenueProductSegmentsCopyWith<$Res> implements $RevenueProductSegmentsCopyWith<$Res> {
  factory _$RevenueProductSegmentsCopyWith(_RevenueProductSegments value, $Res Function(_RevenueProductSegments) _then) = __$RevenueProductSegmentsCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String reportedCurrency, List<RevenueSegment> annual, List<RevenueSegment> quarterly
});




}
/// @nodoc
class __$RevenueProductSegmentsCopyWithImpl<$Res>
    implements _$RevenueProductSegmentsCopyWith<$Res> {
  __$RevenueProductSegmentsCopyWithImpl(this._self, this._then);

  final _RevenueProductSegments _self;
  final $Res Function(_RevenueProductSegments) _then;

/// Create a copy of RevenueProductSegments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? reportedCurrency = null,Object? annual = null,Object? quarterly = null,}) {
  return _then(_RevenueProductSegments(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,annual: null == annual ? _self._annual : annual // ignore: cast_nullable_to_non_nullable
as List<RevenueSegment>,quarterly: null == quarterly ? _self._quarterly : quarterly // ignore: cast_nullable_to_non_nullable
as List<RevenueSegment>,
  ));
}


}

// dart format on
