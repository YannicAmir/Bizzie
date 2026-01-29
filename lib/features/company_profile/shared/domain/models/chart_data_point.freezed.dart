// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartDataPoint {

 String get label; double get value;
/// Create a copy of ChartDataPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartDataPointCopyWith<ChartDataPoint> get copyWith => _$ChartDataPointCopyWithImpl<ChartDataPoint>(this as ChartDataPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartDataPoint&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'ChartDataPoint(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class $ChartDataPointCopyWith<$Res>  {
  factory $ChartDataPointCopyWith(ChartDataPoint value, $Res Function(ChartDataPoint) _then) = _$ChartDataPointCopyWithImpl;
@useResult
$Res call({
 String label, double value
});




}
/// @nodoc
class _$ChartDataPointCopyWithImpl<$Res>
    implements $ChartDataPointCopyWith<$Res> {
  _$ChartDataPointCopyWithImpl(this._self, this._then);

  final ChartDataPoint _self;
  final $Res Function(ChartDataPoint) _then;

/// Create a copy of ChartDataPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? value = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChartDataPoint].
extension ChartDataPointPatterns on ChartDataPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartDataPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartDataPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartDataPoint value)  $default,){
final _that = this;
switch (_that) {
case _ChartDataPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartDataPoint value)?  $default,){
final _that = this;
switch (_that) {
case _ChartDataPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartDataPoint() when $default != null:
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double value)  $default,) {final _that = this;
switch (_that) {
case _ChartDataPoint():
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double value)?  $default,) {final _that = this;
switch (_that) {
case _ChartDataPoint() when $default != null:
return $default(_that.label,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _ChartDataPoint implements ChartDataPoint {
  const _ChartDataPoint({required this.label, required this.value});
  

@override final  String label;
@override final  double value;

/// Create a copy of ChartDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartDataPointCopyWith<_ChartDataPoint> get copyWith => __$ChartDataPointCopyWithImpl<_ChartDataPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartDataPoint&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'ChartDataPoint(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ChartDataPointCopyWith<$Res> implements $ChartDataPointCopyWith<$Res> {
  factory _$ChartDataPointCopyWith(_ChartDataPoint value, $Res Function(_ChartDataPoint) _then) = __$ChartDataPointCopyWithImpl;
@override @useResult
$Res call({
 String label, double value
});




}
/// @nodoc
class __$ChartDataPointCopyWithImpl<$Res>
    implements _$ChartDataPointCopyWith<$Res> {
  __$ChartDataPointCopyWithImpl(this._self, this._then);

  final _ChartDataPoint _self;
  final $Res Function(_ChartDataPoint) _then;

/// Create a copy of ChartDataPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? value = null,}) {
  return _then(_ChartDataPoint(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
