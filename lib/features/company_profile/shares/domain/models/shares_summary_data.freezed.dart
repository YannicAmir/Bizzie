// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shares_summary_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SharesSummaryData {

 double get currentValue; double get growthPercentage; double get absoluteDelta; bool get isPositive; String get referenceLabel;
/// Create a copy of SharesSummaryData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharesSummaryDataCopyWith<SharesSummaryData> get copyWith => _$SharesSummaryDataCopyWithImpl<SharesSummaryData>(this as SharesSummaryData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharesSummaryData&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.absoluteDelta, absoluteDelta) || other.absoluteDelta == absoluteDelta)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.referenceLabel, referenceLabel) || other.referenceLabel == referenceLabel));
}


@override
int get hashCode => Object.hash(runtimeType,currentValue,growthPercentage,absoluteDelta,isPositive,referenceLabel);

@override
String toString() {
  return 'SharesSummaryData(currentValue: $currentValue, growthPercentage: $growthPercentage, absoluteDelta: $absoluteDelta, isPositive: $isPositive, referenceLabel: $referenceLabel)';
}


}

/// @nodoc
abstract mixin class $SharesSummaryDataCopyWith<$Res>  {
  factory $SharesSummaryDataCopyWith(SharesSummaryData value, $Res Function(SharesSummaryData) _then) = _$SharesSummaryDataCopyWithImpl;
@useResult
$Res call({
 double currentValue, double growthPercentage, double absoluteDelta, bool isPositive, String referenceLabel
});




}
/// @nodoc
class _$SharesSummaryDataCopyWithImpl<$Res>
    implements $SharesSummaryDataCopyWith<$Res> {
  _$SharesSummaryDataCopyWithImpl(this._self, this._then);

  final SharesSummaryData _self;
  final $Res Function(SharesSummaryData) _then;

/// Create a copy of SharesSummaryData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentValue = null,Object? growthPercentage = null,Object? absoluteDelta = null,Object? isPositive = null,Object? referenceLabel = null,}) {
  return _then(_self.copyWith(
currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as double,absoluteDelta: null == absoluteDelta ? _self.absoluteDelta : absoluteDelta // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,referenceLabel: null == referenceLabel ? _self.referenceLabel : referenceLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SharesSummaryData].
extension SharesSummaryDataPatterns on SharesSummaryData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharesSummaryData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharesSummaryData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharesSummaryData value)  $default,){
final _that = this;
switch (_that) {
case _SharesSummaryData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharesSummaryData value)?  $default,){
final _that = this;
switch (_that) {
case _SharesSummaryData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharesSummaryData() when $default != null:
return $default(_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel)  $default,) {final _that = this;
switch (_that) {
case _SharesSummaryData():
return $default(_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel)?  $default,) {final _that = this;
switch (_that) {
case _SharesSummaryData() when $default != null:
return $default(_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel);case _:
  return null;

}
}

}

/// @nodoc


class _SharesSummaryData implements SharesSummaryData {
  const _SharesSummaryData({required this.currentValue, required this.growthPercentage, required this.absoluteDelta, required this.isPositive, required this.referenceLabel});
  

@override final  double currentValue;
@override final  double growthPercentage;
@override final  double absoluteDelta;
@override final  bool isPositive;
@override final  String referenceLabel;

/// Create a copy of SharesSummaryData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharesSummaryDataCopyWith<_SharesSummaryData> get copyWith => __$SharesSummaryDataCopyWithImpl<_SharesSummaryData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharesSummaryData&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.absoluteDelta, absoluteDelta) || other.absoluteDelta == absoluteDelta)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.referenceLabel, referenceLabel) || other.referenceLabel == referenceLabel));
}


@override
int get hashCode => Object.hash(runtimeType,currentValue,growthPercentage,absoluteDelta,isPositive,referenceLabel);

@override
String toString() {
  return 'SharesSummaryData(currentValue: $currentValue, growthPercentage: $growthPercentage, absoluteDelta: $absoluteDelta, isPositive: $isPositive, referenceLabel: $referenceLabel)';
}


}

/// @nodoc
abstract mixin class _$SharesSummaryDataCopyWith<$Res> implements $SharesSummaryDataCopyWith<$Res> {
  factory _$SharesSummaryDataCopyWith(_SharesSummaryData value, $Res Function(_SharesSummaryData) _then) = __$SharesSummaryDataCopyWithImpl;
@override @useResult
$Res call({
 double currentValue, double growthPercentage, double absoluteDelta, bool isPositive, String referenceLabel
});




}
/// @nodoc
class __$SharesSummaryDataCopyWithImpl<$Res>
    implements _$SharesSummaryDataCopyWith<$Res> {
  __$SharesSummaryDataCopyWithImpl(this._self, this._then);

  final _SharesSummaryData _self;
  final $Res Function(_SharesSummaryData) _then;

/// Create a copy of SharesSummaryData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentValue = null,Object? growthPercentage = null,Object? absoluteDelta = null,Object? isPositive = null,Object? referenceLabel = null,}) {
  return _then(_SharesSummaryData(
currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as double,absoluteDelta: null == absoluteDelta ? _self.absoluteDelta : absoluteDelta // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,referenceLabel: null == referenceLabel ? _self.referenceLabel : referenceLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
