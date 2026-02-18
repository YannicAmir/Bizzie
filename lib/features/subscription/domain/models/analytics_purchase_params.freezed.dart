// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_purchase_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnalyticsPurchaseParams {

 String get productId; SubscriptionPackageType get packageType; SubscriptionPeriodType get periodType; PaywallSource get source;
/// Create a copy of AnalyticsPurchaseParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsPurchaseParamsCopyWith<AnalyticsPurchaseParams> get copyWith => _$AnalyticsPurchaseParamsCopyWithImpl<AnalyticsPurchaseParams>(this as AnalyticsPurchaseParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsPurchaseParams&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.packageType, packageType) || other.packageType == packageType)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,productId,packageType,periodType,source);

@override
String toString() {
  return 'AnalyticsPurchaseParams(productId: $productId, packageType: $packageType, periodType: $periodType, source: $source)';
}


}

/// @nodoc
abstract mixin class $AnalyticsPurchaseParamsCopyWith<$Res>  {
  factory $AnalyticsPurchaseParamsCopyWith(AnalyticsPurchaseParams value, $Res Function(AnalyticsPurchaseParams) _then) = _$AnalyticsPurchaseParamsCopyWithImpl;
@useResult
$Res call({
 String productId, SubscriptionPackageType packageType, SubscriptionPeriodType periodType, PaywallSource source
});




}
/// @nodoc
class _$AnalyticsPurchaseParamsCopyWithImpl<$Res>
    implements $AnalyticsPurchaseParamsCopyWith<$Res> {
  _$AnalyticsPurchaseParamsCopyWithImpl(this._self, this._then);

  final AnalyticsPurchaseParams _self;
  final $Res Function(AnalyticsPurchaseParams) _then;

/// Create a copy of AnalyticsPurchaseParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? packageType = null,Object? periodType = null,Object? source = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as SubscriptionPackageType,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as SubscriptionPeriodType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PaywallSource,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyticsPurchaseParams].
extension AnalyticsPurchaseParamsPatterns on AnalyticsPurchaseParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyticsPurchaseParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsPurchaseParams value)  $default,){
final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsPurchaseParams value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  SubscriptionPackageType packageType,  SubscriptionPeriodType periodType,  PaywallSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams() when $default != null:
return $default(_that.productId,_that.packageType,_that.periodType,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  SubscriptionPackageType packageType,  SubscriptionPeriodType periodType,  PaywallSource source)  $default,) {final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams():
return $default(_that.productId,_that.packageType,_that.periodType,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  SubscriptionPackageType packageType,  SubscriptionPeriodType periodType,  PaywallSource source)?  $default,) {final _that = this;
switch (_that) {
case _AnalyticsPurchaseParams() when $default != null:
return $default(_that.productId,_that.packageType,_that.periodType,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _AnalyticsPurchaseParams extends AnalyticsPurchaseParams {
  const _AnalyticsPurchaseParams({required this.productId, required this.packageType, required this.periodType, required this.source}): super._();
  

@override final  String productId;
@override final  SubscriptionPackageType packageType;
@override final  SubscriptionPeriodType periodType;
@override final  PaywallSource source;

/// Create a copy of AnalyticsPurchaseParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyticsPurchaseParamsCopyWith<_AnalyticsPurchaseParams> get copyWith => __$AnalyticsPurchaseParamsCopyWithImpl<_AnalyticsPurchaseParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyticsPurchaseParams&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.packageType, packageType) || other.packageType == packageType)&&(identical(other.periodType, periodType) || other.periodType == periodType)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,productId,packageType,periodType,source);

@override
String toString() {
  return 'AnalyticsPurchaseParams(productId: $productId, packageType: $packageType, periodType: $periodType, source: $source)';
}


}

/// @nodoc
abstract mixin class _$AnalyticsPurchaseParamsCopyWith<$Res> implements $AnalyticsPurchaseParamsCopyWith<$Res> {
  factory _$AnalyticsPurchaseParamsCopyWith(_AnalyticsPurchaseParams value, $Res Function(_AnalyticsPurchaseParams) _then) = __$AnalyticsPurchaseParamsCopyWithImpl;
@override @useResult
$Res call({
 String productId, SubscriptionPackageType packageType, SubscriptionPeriodType periodType, PaywallSource source
});




}
/// @nodoc
class __$AnalyticsPurchaseParamsCopyWithImpl<$Res>
    implements _$AnalyticsPurchaseParamsCopyWith<$Res> {
  __$AnalyticsPurchaseParamsCopyWithImpl(this._self, this._then);

  final _AnalyticsPurchaseParams _self;
  final $Res Function(_AnalyticsPurchaseParams) _then;

/// Create a copy of AnalyticsPurchaseParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? packageType = null,Object? periodType = null,Object? source = null,}) {
  return _then(_AnalyticsPurchaseParams(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as SubscriptionPackageType,periodType: null == periodType ? _self.periodType : periodType // ignore: cast_nullable_to_non_nullable
as SubscriptionPeriodType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PaywallSource,
  ));
}


}

// dart format on
