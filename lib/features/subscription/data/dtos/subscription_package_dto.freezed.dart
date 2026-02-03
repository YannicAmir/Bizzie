// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_package_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPackageDto {

 String get id; String get identifier; String get productId; String get packageType; String get title; String get description; String get priceString; double get price; String get currencyCode; bool get isEligibleForTrial;
/// Create a copy of SubscriptionPackageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPackageDtoCopyWith<SubscriptionPackageDto> get copyWith => _$SubscriptionPackageDtoCopyWithImpl<SubscriptionPackageDto>(this as SubscriptionPackageDto, _$identity);

  /// Serializes this SubscriptionPackageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPackageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.packageType, packageType) || other.packageType == packageType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.isEligibleForTrial, isEligibleForTrial) || other.isEligibleForTrial == isEligibleForTrial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,identifier,productId,packageType,title,description,priceString,price,currencyCode,isEligibleForTrial);

@override
String toString() {
  return 'SubscriptionPackageDto(id: $id, identifier: $identifier, productId: $productId, packageType: $packageType, title: $title, description: $description, priceString: $priceString, price: $price, currencyCode: $currencyCode, isEligibleForTrial: $isEligibleForTrial)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPackageDtoCopyWith<$Res>  {
  factory $SubscriptionPackageDtoCopyWith(SubscriptionPackageDto value, $Res Function(SubscriptionPackageDto) _then) = _$SubscriptionPackageDtoCopyWithImpl;
@useResult
$Res call({
 String id, String identifier, String productId, String packageType, String title, String description, String priceString, double price, String currencyCode, bool isEligibleForTrial
});




}
/// @nodoc
class _$SubscriptionPackageDtoCopyWithImpl<$Res>
    implements $SubscriptionPackageDtoCopyWith<$Res> {
  _$SubscriptionPackageDtoCopyWithImpl(this._self, this._then);

  final SubscriptionPackageDto _self;
  final $Res Function(SubscriptionPackageDto) _then;

/// Create a copy of SubscriptionPackageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? identifier = null,Object? productId = null,Object? packageType = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? isEligibleForTrial = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,isEligibleForTrial: null == isEligibleForTrial ? _self.isEligibleForTrial : isEligibleForTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPackageDto].
extension SubscriptionPackageDtoPatterns on SubscriptionPackageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPackageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPackageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPackageDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPackageDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPackageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String identifier,  String productId,  String packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPackageDto() when $default != null:
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String identifier,  String productId,  String packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackageDto():
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String identifier,  String productId,  String packageType,  String title,  String description,  String priceString,  double price,  String currencyCode,  bool isEligibleForTrial)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPackageDto() when $default != null:
return $default(_that.id,_that.identifier,_that.productId,_that.packageType,_that.title,_that.description,_that.priceString,_that.price,_that.currencyCode,_that.isEligibleForTrial);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPackageDto extends SubscriptionPackageDto {
  const _SubscriptionPackageDto({required this.id, required this.identifier, required this.productId, required this.packageType, required this.title, required this.description, required this.priceString, required this.price, required this.currencyCode, this.isEligibleForTrial = false}): super._();
  factory _SubscriptionPackageDto.fromJson(Map<String, dynamic> json) => _$SubscriptionPackageDtoFromJson(json);

@override final  String id;
@override final  String identifier;
@override final  String productId;
@override final  String packageType;
@override final  String title;
@override final  String description;
@override final  String priceString;
@override final  double price;
@override final  String currencyCode;
@override@JsonKey() final  bool isEligibleForTrial;

/// Create a copy of SubscriptionPackageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPackageDtoCopyWith<_SubscriptionPackageDto> get copyWith => __$SubscriptionPackageDtoCopyWithImpl<_SubscriptionPackageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPackageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPackageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.packageType, packageType) || other.packageType == packageType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priceString, priceString) || other.priceString == priceString)&&(identical(other.price, price) || other.price == price)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.isEligibleForTrial, isEligibleForTrial) || other.isEligibleForTrial == isEligibleForTrial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,identifier,productId,packageType,title,description,priceString,price,currencyCode,isEligibleForTrial);

@override
String toString() {
  return 'SubscriptionPackageDto(id: $id, identifier: $identifier, productId: $productId, packageType: $packageType, title: $title, description: $description, priceString: $priceString, price: $price, currencyCode: $currencyCode, isEligibleForTrial: $isEligibleForTrial)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPackageDtoCopyWith<$Res> implements $SubscriptionPackageDtoCopyWith<$Res> {
  factory _$SubscriptionPackageDtoCopyWith(_SubscriptionPackageDto value, $Res Function(_SubscriptionPackageDto) _then) = __$SubscriptionPackageDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String identifier, String productId, String packageType, String title, String description, String priceString, double price, String currencyCode, bool isEligibleForTrial
});




}
/// @nodoc
class __$SubscriptionPackageDtoCopyWithImpl<$Res>
    implements _$SubscriptionPackageDtoCopyWith<$Res> {
  __$SubscriptionPackageDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionPackageDto _self;
  final $Res Function(_SubscriptionPackageDto) _then;

/// Create a copy of SubscriptionPackageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? identifier = null,Object? productId = null,Object? packageType = null,Object? title = null,Object? description = null,Object? priceString = null,Object? price = null,Object? currencyCode = null,Object? isEligibleForTrial = null,}) {
  return _then(_SubscriptionPackageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,packageType: null == packageType ? _self.packageType : packageType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priceString: null == priceString ? _self.priceString : priceString // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,isEligibleForTrial: null == isEligibleForTrial ? _self.isEligibleForTrial : isEligibleForTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
