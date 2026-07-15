// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'more_feature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MoreFeature {

 String get label; String get analyticsName; Widget Function(String ticker) get builder;
/// Create a copy of MoreFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MoreFeatureCopyWith<MoreFeature> get copyWith => _$MoreFeatureCopyWithImpl<MoreFeature>(this as MoreFeature, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MoreFeature&&(identical(other.label, label) || other.label == label)&&(identical(other.analyticsName, analyticsName) || other.analyticsName == analyticsName)&&(identical(other.builder, builder) || other.builder == builder));
}


@override
int get hashCode => Object.hash(runtimeType,label,analyticsName,builder);

@override
String toString() {
  return 'MoreFeature(label: $label, analyticsName: $analyticsName, builder: $builder)';
}


}

/// @nodoc
abstract mixin class $MoreFeatureCopyWith<$Res>  {
  factory $MoreFeatureCopyWith(MoreFeature value, $Res Function(MoreFeature) _then) = _$MoreFeatureCopyWithImpl;
@useResult
$Res call({
 String label, String analyticsName, Widget Function(String ticker) builder
});




}
/// @nodoc
class _$MoreFeatureCopyWithImpl<$Res>
    implements $MoreFeatureCopyWith<$Res> {
  _$MoreFeatureCopyWithImpl(this._self, this._then);

  final MoreFeature _self;
  final $Res Function(MoreFeature) _then;

/// Create a copy of MoreFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? analyticsName = null,Object? builder = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,analyticsName: null == analyticsName ? _self.analyticsName : analyticsName // ignore: cast_nullable_to_non_nullable
as String,builder: null == builder ? _self.builder : builder // ignore: cast_nullable_to_non_nullable
as Widget Function(String ticker),
  ));
}

}


/// Adds pattern-matching-related methods to [MoreFeature].
extension MoreFeaturePatterns on MoreFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MoreFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MoreFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MoreFeature value)  $default,){
final _that = this;
switch (_that) {
case _MoreFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MoreFeature value)?  $default,){
final _that = this;
switch (_that) {
case _MoreFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String analyticsName,  Widget Function(String ticker) builder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MoreFeature() when $default != null:
return $default(_that.label,_that.analyticsName,_that.builder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String analyticsName,  Widget Function(String ticker) builder)  $default,) {final _that = this;
switch (_that) {
case _MoreFeature():
return $default(_that.label,_that.analyticsName,_that.builder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String analyticsName,  Widget Function(String ticker) builder)?  $default,) {final _that = this;
switch (_that) {
case _MoreFeature() when $default != null:
return $default(_that.label,_that.analyticsName,_that.builder);case _:
  return null;

}
}

}

/// @nodoc


class _MoreFeature implements MoreFeature {
  const _MoreFeature({required this.label, required this.analyticsName, required this.builder});
  

@override final  String label;
@override final  String analyticsName;
@override final  Widget Function(String ticker) builder;

/// Create a copy of MoreFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MoreFeatureCopyWith<_MoreFeature> get copyWith => __$MoreFeatureCopyWithImpl<_MoreFeature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MoreFeature&&(identical(other.label, label) || other.label == label)&&(identical(other.analyticsName, analyticsName) || other.analyticsName == analyticsName)&&(identical(other.builder, builder) || other.builder == builder));
}


@override
int get hashCode => Object.hash(runtimeType,label,analyticsName,builder);

@override
String toString() {
  return 'MoreFeature(label: $label, analyticsName: $analyticsName, builder: $builder)';
}


}

/// @nodoc
abstract mixin class _$MoreFeatureCopyWith<$Res> implements $MoreFeatureCopyWith<$Res> {
  factory _$MoreFeatureCopyWith(_MoreFeature value, $Res Function(_MoreFeature) _then) = __$MoreFeatureCopyWithImpl;
@override @useResult
$Res call({
 String label, String analyticsName, Widget Function(String ticker) builder
});




}
/// @nodoc
class __$MoreFeatureCopyWithImpl<$Res>
    implements _$MoreFeatureCopyWith<$Res> {
  __$MoreFeatureCopyWithImpl(this._self, this._then);

  final _MoreFeature _self;
  final $Res Function(_MoreFeature) _then;

/// Create a copy of MoreFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? analyticsName = null,Object? builder = null,}) {
  return _then(_MoreFeature(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,analyticsName: null == analyticsName ? _self.analyticsName : analyticsName // ignore: cast_nullable_to_non_nullable
as String,builder: null == builder ? _self.builder : builder // ignore: cast_nullable_to_non_nullable
as Widget Function(String ticker),
  ));
}


}

// dart format on
