// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_price_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityPriceSummary {

 String get priceFormatted; double? get price; String get changeFormatted; bool get isPositiveChange; String get sessionDate;
/// Create a copy of SecurityPriceSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityPriceSummaryCopyWith<SecurityPriceSummary> get copyWith => _$SecurityPriceSummaryCopyWithImpl<SecurityPriceSummary>(this as SecurityPriceSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityPriceSummary&&(identical(other.priceFormatted, priceFormatted) || other.priceFormatted == priceFormatted)&&(identical(other.price, price) || other.price == price)&&(identical(other.changeFormatted, changeFormatted) || other.changeFormatted == changeFormatted)&&(identical(other.isPositiveChange, isPositiveChange) || other.isPositiveChange == isPositiveChange)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate));
}


@override
int get hashCode => Object.hash(runtimeType,priceFormatted,price,changeFormatted,isPositiveChange,sessionDate);

@override
String toString() {
  return 'SecurityPriceSummary(priceFormatted: $priceFormatted, price: $price, changeFormatted: $changeFormatted, isPositiveChange: $isPositiveChange, sessionDate: $sessionDate)';
}


}

/// @nodoc
abstract mixin class $SecurityPriceSummaryCopyWith<$Res>  {
  factory $SecurityPriceSummaryCopyWith(SecurityPriceSummary value, $Res Function(SecurityPriceSummary) _then) = _$SecurityPriceSummaryCopyWithImpl;
@useResult
$Res call({
 String priceFormatted, double? price, String changeFormatted, bool isPositiveChange, String sessionDate
});




}
/// @nodoc
class _$SecurityPriceSummaryCopyWithImpl<$Res>
    implements $SecurityPriceSummaryCopyWith<$Res> {
  _$SecurityPriceSummaryCopyWithImpl(this._self, this._then);

  final SecurityPriceSummary _self;
  final $Res Function(SecurityPriceSummary) _then;

/// Create a copy of SecurityPriceSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priceFormatted = null,Object? price = freezed,Object? changeFormatted = null,Object? isPositiveChange = null,Object? sessionDate = null,}) {
  return _then(_self.copyWith(
priceFormatted: null == priceFormatted ? _self.priceFormatted : priceFormatted // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,changeFormatted: null == changeFormatted ? _self.changeFormatted : changeFormatted // ignore: cast_nullable_to_non_nullable
as String,isPositiveChange: null == isPositiveChange ? _self.isPositiveChange : isPositiveChange // ignore: cast_nullable_to_non_nullable
as bool,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityPriceSummary].
extension SecurityPriceSummaryPatterns on SecurityPriceSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityPriceSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityPriceSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityPriceSummary value)  $default,){
final _that = this;
switch (_that) {
case _SecurityPriceSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityPriceSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityPriceSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String priceFormatted,  double? price,  String changeFormatted,  bool isPositiveChange,  String sessionDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityPriceSummary() when $default != null:
return $default(_that.priceFormatted,_that.price,_that.changeFormatted,_that.isPositiveChange,_that.sessionDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String priceFormatted,  double? price,  String changeFormatted,  bool isPositiveChange,  String sessionDate)  $default,) {final _that = this;
switch (_that) {
case _SecurityPriceSummary():
return $default(_that.priceFormatted,_that.price,_that.changeFormatted,_that.isPositiveChange,_that.sessionDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String priceFormatted,  double? price,  String changeFormatted,  bool isPositiveChange,  String sessionDate)?  $default,) {final _that = this;
switch (_that) {
case _SecurityPriceSummary() when $default != null:
return $default(_that.priceFormatted,_that.price,_that.changeFormatted,_that.isPositiveChange,_that.sessionDate);case _:
  return null;

}
}

}

/// @nodoc


class _SecurityPriceSummary implements SecurityPriceSummary {
  const _SecurityPriceSummary({required this.priceFormatted, required this.price, required this.changeFormatted, required this.isPositiveChange, required this.sessionDate});
  

@override final  String priceFormatted;
@override final  double? price;
@override final  String changeFormatted;
@override final  bool isPositiveChange;
@override final  String sessionDate;

/// Create a copy of SecurityPriceSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityPriceSummaryCopyWith<_SecurityPriceSummary> get copyWith => __$SecurityPriceSummaryCopyWithImpl<_SecurityPriceSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityPriceSummary&&(identical(other.priceFormatted, priceFormatted) || other.priceFormatted == priceFormatted)&&(identical(other.price, price) || other.price == price)&&(identical(other.changeFormatted, changeFormatted) || other.changeFormatted == changeFormatted)&&(identical(other.isPositiveChange, isPositiveChange) || other.isPositiveChange == isPositiveChange)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate));
}


@override
int get hashCode => Object.hash(runtimeType,priceFormatted,price,changeFormatted,isPositiveChange,sessionDate);

@override
String toString() {
  return 'SecurityPriceSummary(priceFormatted: $priceFormatted, price: $price, changeFormatted: $changeFormatted, isPositiveChange: $isPositiveChange, sessionDate: $sessionDate)';
}


}

/// @nodoc
abstract mixin class _$SecurityPriceSummaryCopyWith<$Res> implements $SecurityPriceSummaryCopyWith<$Res> {
  factory _$SecurityPriceSummaryCopyWith(_SecurityPriceSummary value, $Res Function(_SecurityPriceSummary) _then) = __$SecurityPriceSummaryCopyWithImpl;
@override @useResult
$Res call({
 String priceFormatted, double? price, String changeFormatted, bool isPositiveChange, String sessionDate
});




}
/// @nodoc
class __$SecurityPriceSummaryCopyWithImpl<$Res>
    implements _$SecurityPriceSummaryCopyWith<$Res> {
  __$SecurityPriceSummaryCopyWithImpl(this._self, this._then);

  final _SecurityPriceSummary _self;
  final $Res Function(_SecurityPriceSummary) _then;

/// Create a copy of SecurityPriceSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priceFormatted = null,Object? price = freezed,Object? changeFormatted = null,Object? isPositiveChange = null,Object? sessionDate = null,}) {
  return _then(_SecurityPriceSummary(
priceFormatted: null == priceFormatted ? _self.priceFormatted : priceFormatted // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,changeFormatted: null == changeFormatted ? _self.changeFormatted : changeFormatted // ignore: cast_nullable_to_non_nullable
as String,isPositiveChange: null == isPositiveChange ? _self.isPositiveChange : isPositiveChange // ignore: cast_nullable_to_non_nullable
as bool,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
