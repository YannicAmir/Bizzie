// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_metric_labels.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyMetricLabels {

 String get metricLabel; String? get modalMetricLabel; String get ttmTitle; String get chartKeyPrefix;
/// Create a copy of CurrencyMetricLabels
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyMetricLabelsCopyWith<CurrencyMetricLabels> get copyWith => _$CurrencyMetricLabelsCopyWithImpl<CurrencyMetricLabels>(this as CurrencyMetricLabels, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyMetricLabels&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.modalMetricLabel, modalMetricLabel) || other.modalMetricLabel == modalMetricLabel)&&(identical(other.ttmTitle, ttmTitle) || other.ttmTitle == ttmTitle)&&(identical(other.chartKeyPrefix, chartKeyPrefix) || other.chartKeyPrefix == chartKeyPrefix));
}


@override
int get hashCode => Object.hash(runtimeType,metricLabel,modalMetricLabel,ttmTitle,chartKeyPrefix);

@override
String toString() {
  return 'CurrencyMetricLabels(metricLabel: $metricLabel, modalMetricLabel: $modalMetricLabel, ttmTitle: $ttmTitle, chartKeyPrefix: $chartKeyPrefix)';
}


}

/// @nodoc
abstract mixin class $CurrencyMetricLabelsCopyWith<$Res>  {
  factory $CurrencyMetricLabelsCopyWith(CurrencyMetricLabels value, $Res Function(CurrencyMetricLabels) _then) = _$CurrencyMetricLabelsCopyWithImpl;
@useResult
$Res call({
 String metricLabel, String? modalMetricLabel, String ttmTitle, String chartKeyPrefix
});




}
/// @nodoc
class _$CurrencyMetricLabelsCopyWithImpl<$Res>
    implements $CurrencyMetricLabelsCopyWith<$Res> {
  _$CurrencyMetricLabelsCopyWithImpl(this._self, this._then);

  final CurrencyMetricLabels _self;
  final $Res Function(CurrencyMetricLabels) _then;

/// Create a copy of CurrencyMetricLabels
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metricLabel = null,Object? modalMetricLabel = freezed,Object? ttmTitle = null,Object? chartKeyPrefix = null,}) {
  return _then(_self.copyWith(
metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,modalMetricLabel: freezed == modalMetricLabel ? _self.modalMetricLabel : modalMetricLabel // ignore: cast_nullable_to_non_nullable
as String?,ttmTitle: null == ttmTitle ? _self.ttmTitle : ttmTitle // ignore: cast_nullable_to_non_nullable
as String,chartKeyPrefix: null == chartKeyPrefix ? _self.chartKeyPrefix : chartKeyPrefix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrencyMetricLabels].
extension CurrencyMetricLabelsPatterns on CurrencyMetricLabels {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrencyMetricLabels value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrencyMetricLabels() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrencyMetricLabels value)  $default,){
final _that = this;
switch (_that) {
case _CurrencyMetricLabels():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrencyMetricLabels value)?  $default,){
final _that = this;
switch (_that) {
case _CurrencyMetricLabels() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String metricLabel,  String? modalMetricLabel,  String ttmTitle,  String chartKeyPrefix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrencyMetricLabels() when $default != null:
return $default(_that.metricLabel,_that.modalMetricLabel,_that.ttmTitle,_that.chartKeyPrefix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String metricLabel,  String? modalMetricLabel,  String ttmTitle,  String chartKeyPrefix)  $default,) {final _that = this;
switch (_that) {
case _CurrencyMetricLabels():
return $default(_that.metricLabel,_that.modalMetricLabel,_that.ttmTitle,_that.chartKeyPrefix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String metricLabel,  String? modalMetricLabel,  String ttmTitle,  String chartKeyPrefix)?  $default,) {final _that = this;
switch (_that) {
case _CurrencyMetricLabels() when $default != null:
return $default(_that.metricLabel,_that.modalMetricLabel,_that.ttmTitle,_that.chartKeyPrefix);case _:
  return null;

}
}

}

/// @nodoc


class _CurrencyMetricLabels implements CurrencyMetricLabels {
  const _CurrencyMetricLabels({required this.metricLabel, this.modalMetricLabel, required this.ttmTitle, required this.chartKeyPrefix});
  

@override final  String metricLabel;
@override final  String? modalMetricLabel;
@override final  String ttmTitle;
@override final  String chartKeyPrefix;

/// Create a copy of CurrencyMetricLabels
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyMetricLabelsCopyWith<_CurrencyMetricLabels> get copyWith => __$CurrencyMetricLabelsCopyWithImpl<_CurrencyMetricLabels>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrencyMetricLabels&&(identical(other.metricLabel, metricLabel) || other.metricLabel == metricLabel)&&(identical(other.modalMetricLabel, modalMetricLabel) || other.modalMetricLabel == modalMetricLabel)&&(identical(other.ttmTitle, ttmTitle) || other.ttmTitle == ttmTitle)&&(identical(other.chartKeyPrefix, chartKeyPrefix) || other.chartKeyPrefix == chartKeyPrefix));
}


@override
int get hashCode => Object.hash(runtimeType,metricLabel,modalMetricLabel,ttmTitle,chartKeyPrefix);

@override
String toString() {
  return 'CurrencyMetricLabels(metricLabel: $metricLabel, modalMetricLabel: $modalMetricLabel, ttmTitle: $ttmTitle, chartKeyPrefix: $chartKeyPrefix)';
}


}

/// @nodoc
abstract mixin class _$CurrencyMetricLabelsCopyWith<$Res> implements $CurrencyMetricLabelsCopyWith<$Res> {
  factory _$CurrencyMetricLabelsCopyWith(_CurrencyMetricLabels value, $Res Function(_CurrencyMetricLabels) _then) = __$CurrencyMetricLabelsCopyWithImpl;
@override @useResult
$Res call({
 String metricLabel, String? modalMetricLabel, String ttmTitle, String chartKeyPrefix
});




}
/// @nodoc
class __$CurrencyMetricLabelsCopyWithImpl<$Res>
    implements _$CurrencyMetricLabelsCopyWith<$Res> {
  __$CurrencyMetricLabelsCopyWithImpl(this._self, this._then);

  final _CurrencyMetricLabels _self;
  final $Res Function(_CurrencyMetricLabels) _then;

/// Create a copy of CurrencyMetricLabels
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metricLabel = null,Object? modalMetricLabel = freezed,Object? ttmTitle = null,Object? chartKeyPrefix = null,}) {
  return _then(_CurrencyMetricLabels(
metricLabel: null == metricLabel ? _self.metricLabel : metricLabel // ignore: cast_nullable_to_non_nullable
as String,modalMetricLabel: freezed == modalMetricLabel ? _self.modalMetricLabel : modalMetricLabel // ignore: cast_nullable_to_non_nullable
as String?,ttmTitle: null == ttmTitle ? _self.ttmTitle : ttmTitle // ignore: cast_nullable_to_non_nullable
as String,chartKeyPrefix: null == chartKeyPrefix ? _self.chartKeyPrefix : chartKeyPrefix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
