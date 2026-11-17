// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPackage {

 String get id; String get identifier; String get productId; SubscriptionPackageType get packageType; String get title; String get description; String get priceString; double get price; String get currencyCode; bool get isEligibleForTrial; bool get hasFreeTrial;
/// Create a copy of SubscriptionPackage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPackageCopyWith<SubscriptionPackage> get copyWith => _$SubscriptionPackageCopyWithImpl<SubscriptionPackage>(this as SubscriptionPackage, _$identity);

  /// Serializes this SubscriptionPackage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubscriptionPackage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPackage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.identifier, _this.identifier) || other.identifier == _this.identifier)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.packageType, _this.packageType) || other.packageType == _this.packageType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priceString, _this.priceString) || other.priceString == _this.priceString)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.currencyCode, _this.currencyCode) || other.currencyCode == _this.currencyCode)&&(identical(other.isEligibleForTrial, _this.isEligibleForTrial) || other.isEligibleForTrial == _this.isEligibleForTrial)&&(identical(other.hasFreeTrial, _this.hasFreeTrial) || other.hasFreeTrial == _this.hasFreeTrial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubscriptionPackage;
  return Object.hash(runtimeType,_this.id,_this.identifier,_this.productId,_this.packageType,_this.title,_this.description,_this.priceString,_this.price,_this.currencyCode,_this.isEligibleForTrial,_this.hasFreeTrial);
}

@override
String toString() {
  final _this = this as SubscriptionPackage;
  return 'SubscriptionPackage(id: ${_this.id}, identifier: ${_this.identifier}, productId: ${_this.productId}, packageType: ${_this.packageType}, title: ${_this.title}, description: ${_this.description}, priceString: ${_this.priceString}, price: ${_this.price}, currencyCode: ${_this.currencyCode}, isEligibleForTrial: ${_this.isEligibleForTrial}, hasFreeTrial: ${_this.hasFreeTrial})';
}


}

/// @nodoc
abstract mixin class $SubscriptionPackageCopyWith<$Res>  {
  factory $SubscriptionPackageCopyWith(SubscriptionPackage value, $Res Function(SubscriptionPackage) _then) = _$SubscriptionPackageCopyWithImpl;
@useResult
$Res call({
 String id, String identifier, String productId, SubscriptionPackageType packageType, String title, String description, String priceString, double price, String currencyCode, bool isEligibleForTrial, bool hasFreeTrial
});




}
/// @nodoc
class _$SubscriptionPackageCopyWithImpl<$Res>
    implements $SubscriptionPackageCopyWith<$Res> {
  _$SubscriptionPackageCopyWithImpl(this._self, this._then);

  final SubscriptionPackage _self;
  final $Res Function(SubscriptionPackage) _then;

/// Create a copy of SubscriptionPackage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? identifier = null,Object? productId = null,Object? packageType = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? isEligibleForTrial = null,Object? hasFreeTrial = null,}) {
  return _then(SubscriptionPackage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as SubscriptionPackageType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,isEligibleForTrial: null == isEligibleForTrial ? _self.isEligibleForTrial : isEligibleForTrial // ignore: cast_nullable_to_non_nullable
as bool,hasFreeTrial: null == hasFreeTrial ? _self.hasFreeTrial : hasFreeTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPackage].
extension SubscriptionPackagePatterns on SubscriptionPackage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPackage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPackage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPackage value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPackage value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String identifier,  String productId,  SubscriptionPackageType packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial,  bool hasFreeTrial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPackage() when $default != null:
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial,_that.hasFreeTrial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String identifier,  String productId,  SubscriptionPackageType packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial,  bool hasFreeTrial)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackage():
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial,_that.hasFreeTrial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String identifier,  String productId,  SubscriptionPackageType packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial,  bool hasFreeTrial)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackage() when $default != null:
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial,_that.hasFreeTrial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPackage implements SubscriptionPackage {
  const _SubscriptionPackage({required this.id, required this.identifier, required this.productId, required this.packageType, required this.title, required this.description, required this.priceString, required this.price, required this.currencyCode, this.isEligibleForTrial = false, this.hasFreeTrial = false});
  factory _SubscriptionPackage.fromJson(Map<String, dynamic> json) => _$SubscriptionPackageFromJson(json);

@override final  String id;
@override final  String identifier;
@override final  String productId;
@override final  SubscriptionPackageType packageType;
@override final  String title;
@override final  String description;
@override final  String priceString;
@override final  double price;
@override final  String currencyCode;
@override@JsonKey() final  bool isEligibleForTrial;
@override@JsonKey() final  bool hasFreeTrial;

/// Create a copy of SubscriptionPackage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPackageCopyWith<_SubscriptionPackage> get copyWith => __$SubscriptionPackageCopyWithImpl<_SubscriptionPackage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPackageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPackage&&(identical(other.id, id) || other.id == id)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.packageType, packageType) || other.packageType == packageType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.isEligibleForTrial, isEligibleForTrial) || other.isEligibleForTrial == isEligibleForTrial)&&(identical(other.hasFreeTrial, hasFreeTrial) || other.hasFreeTrial == hasFreeTrial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,identifier,productId,packageType,title,description,priceString,price,currencyCode,isEligibleForTrial,hasFreeTrial);
}

@override
String toString() {
    return 'SubscriptionPackage(id: $id, identifier: $identifier, productId: $productId, packageType: $packageType, title: $title, description: $description, priceString: $priceString, price: $price, currencyCode: $currencyCode, isEligibleForTrial: $isEligibleForTrial, hasFreeTrial: $hasFreeTrial)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPackageCopyWith<$Res> implements $SubscriptionPackageCopyWith<$Res> {
  factory _$SubscriptionPackageCopyWith(_SubscriptionPackage value, $Res Function(_SubscriptionPackage) _then) = __$SubscriptionPackageCopyWithImpl;
@override @useResult
$Res call({
 String id, String identifier, String productId, SubscriptionPackageType packageType, String title, String description, String priceString, double price, String currencyCode, bool isEligibleForTrial, bool hasFreeTrial
});




}
/// @nodoc
class __$SubscriptionPackageCopyWithImpl<$Res>
    implements _$SubscriptionPackageCopyWith<$Res> {
  __$SubscriptionPackageCopyWithImpl(this._self, this._then);

  final _SubscriptionPackage _self;
  final $Res Function(_SubscriptionPackage) _then;

/// Create a copy of SubscriptionPackage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? identifier = null,Object? productId = null,Object? packageType = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? isEligibleForTrial = null,Object? hasFreeTrial = null,}) {
  return _then(_SubscriptionPackage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as SubscriptionPackageType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,isEligibleForTrial: null == isEligibleForTrial ? _self.isEligibleForTrial : isEligibleForTrial // ignore: cast_nullable_to_non_nullable
as bool,hasFreeTrial: null == hasFreeTrial ? _self.hasFreeTrial : hasFreeTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
