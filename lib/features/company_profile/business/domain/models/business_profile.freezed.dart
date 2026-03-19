// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessProfile {

 String get symbol; String get companyName; String get sector; String get industry; String get description; String get ceo; String get website; String get address; String get city; String get state; String get zip; String get phone; String get fullTimeEmployees; String? get def14aUrl; bool get isForeignCompany; String get proxyFilingFormType; List<SecFiling> get annualFilings; List<SecFiling> get quarterlyFilings;
/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<BusinessProfile> get copyWith => _$BusinessProfileCopyWithImpl<BusinessProfile>(this as BusinessProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfile&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.ceo, ceo) || other.ceo == ceo)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.fullTimeEmployees, fullTimeEmployees) || other.fullTimeEmployees == fullTimeEmployees)&&(identical(other.def14aUrl, def14aUrl) || other.def14aUrl == def14aUrl)&&(identical(other.isForeignCompany, isForeignCompany) || other.isForeignCompany == isForeignCompany)&&(identical(other.proxyFilingFormType, proxyFilingFormType) || other.proxyFilingFormType == proxyFilingFormType)&&const DeepCollectionEquality().equals(other.annualFilings, annualFilings)&&const DeepCollectionEquality().equals(other.quarterlyFilings, quarterlyFilings));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,companyName,sector,industry,description,ceo,website,address,city,state,zip,phone,fullTimeEmployees,def14aUrl,isForeignCompany,proxyFilingFormType,const DeepCollectionEquality().hash(annualFilings),const DeepCollectionEquality().hash(quarterlyFilings));

@override
String toString() {
  return 'BusinessProfile(symbol: $symbol, companyName: $companyName, sector: $sector, industry: $industry, description: $description, ceo: $ceo, website: $website, address: $address, city: $city, state: $state, zip: $zip, phone: $phone, fullTimeEmployees: $fullTimeEmployees, def14aUrl: $def14aUrl, isForeignCompany: $isForeignCompany, proxyFilingFormType: $proxyFilingFormType, annualFilings: $annualFilings, quarterlyFilings: $quarterlyFilings)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileCopyWith<$Res>  {
  factory $BusinessProfileCopyWith(BusinessProfile value, $Res Function(BusinessProfile) _then) = _$BusinessProfileCopyWithImpl;
@useResult
$Res call({
 String symbol, String companyName, String sector, String industry, String description, String ceo, String website, String address, String city, String state, String zip, String phone, String fullTimeEmployees, String? def14aUrl, bool isForeignCompany, String proxyFilingFormType, List<SecFiling> annualFilings, List<SecFiling> quarterlyFilings
});




}
/// @nodoc
class _$BusinessProfileCopyWithImpl<$Res>
    implements $BusinessProfileCopyWith<$Res> {
  _$BusinessProfileCopyWithImpl(this._self, this._then);

  final BusinessProfile _self;
  final $Res Function(BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? companyName = null,Object? sector = null,Object? industry = null,Object? description = null,Object? ceo = null,Object? website = null,Object? address = null,Object? city = null,Object? state = null,Object? zip = null,Object? phone = null,Object? fullTimeEmployees = null,Object? def14aUrl = freezed,Object? isForeignCompany = null,Object? proxyFilingFormType = null,Object? annualFilings = null,Object? quarterlyFilings = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ceo: null == ceo ? _self.ceo : ceo // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,fullTimeEmployees: null == fullTimeEmployees ? _self.fullTimeEmployees : fullTimeEmployees // ignore: cast_nullable_to_non_nullable
as String,def14aUrl: freezed == def14aUrl ? _self.def14aUrl : def14aUrl // ignore: cast_nullable_to_non_nullable
as String?,isForeignCompany: null == isForeignCompany ? _self.isForeignCompany : isForeignCompany // ignore: cast_nullable_to_non_nullable
as bool,proxyFilingFormType: null == proxyFilingFormType ? _self.proxyFilingFormType : proxyFilingFormType // ignore: cast_nullable_to_non_nullable
as String,annualFilings: null == annualFilings ? _self.annualFilings : annualFilings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,quarterlyFilings: null == quarterlyFilings ? _self.quarterlyFilings : quarterlyFilings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessProfile].
extension BusinessProfilePatterns on BusinessProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessProfile value)  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String companyName,  String sector,  String industry,  String description,  String ceo,  String website,  String address,  String city,  String state,  String zip,  String phone,  String fullTimeEmployees,  String? def14aUrl,  bool isForeignCompany,  String proxyFilingFormType,  List<SecFiling> annualFilings,  List<SecFiling> quarterlyFilings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.symbol,_that.companyName,_that.sector,_that.industry,_that.description,_that.ceo,_that.website,_that.address,_that.city,_that.state,_that.zip,_that.phone,_that.fullTimeEmployees,_that.def14aUrl,_that.isForeignCompany,_that.proxyFilingFormType,_that.annualFilings,_that.quarterlyFilings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String companyName,  String sector,  String industry,  String description,  String ceo,  String website,  String address,  String city,  String state,  String zip,  String phone,  String fullTimeEmployees,  String? def14aUrl,  bool isForeignCompany,  String proxyFilingFormType,  List<SecFiling> annualFilings,  List<SecFiling> quarterlyFilings)  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile():
return $default(_that.symbol,_that.companyName,_that.sector,_that.industry,_that.description,_that.ceo,_that.website,_that.address,_that.city,_that.state,_that.zip,_that.phone,_that.fullTimeEmployees,_that.def14aUrl,_that.isForeignCompany,_that.proxyFilingFormType,_that.annualFilings,_that.quarterlyFilings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String companyName,  String sector,  String industry,  String description,  String ceo,  String website,  String address,  String city,  String state,  String zip,  String phone,  String fullTimeEmployees,  String? def14aUrl,  bool isForeignCompany,  String proxyFilingFormType,  List<SecFiling> annualFilings,  List<SecFiling> quarterlyFilings)?  $default,) {final _that = this;
switch (_that) {
case _BusinessProfile() when $default != null:
return $default(_that.symbol,_that.companyName,_that.sector,_that.industry,_that.description,_that.ceo,_that.website,_that.address,_that.city,_that.state,_that.zip,_that.phone,_that.fullTimeEmployees,_that.def14aUrl,_that.isForeignCompany,_that.proxyFilingFormType,_that.annualFilings,_that.quarterlyFilings);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessProfile implements BusinessProfile {
  const _BusinessProfile({required this.symbol, required this.companyName, required this.sector, required this.industry, required this.description, required this.ceo, required this.website, required this.address, required this.city, required this.state, required this.zip, required this.phone, required this.fullTimeEmployees, this.def14aUrl, this.isForeignCompany = false, this.proxyFilingFormType = 'DEF 14A', final  List<SecFiling> annualFilings = const [], final  List<SecFiling> quarterlyFilings = const []}): _annualFilings = annualFilings,_quarterlyFilings = quarterlyFilings;
  

@override final  String symbol;
@override final  String companyName;
@override final  String sector;
@override final  String industry;
@override final  String description;
@override final  String ceo;
@override final  String website;
@override final  String address;
@override final  String city;
@override final  String state;
@override final  String zip;
@override final  String phone;
@override final  String fullTimeEmployees;
@override final  String? def14aUrl;
@override@JsonKey() final  bool isForeignCompany;
@override@JsonKey() final  String proxyFilingFormType;
 final  List<SecFiling> _annualFilings;
@override@JsonKey() List<SecFiling> get annualFilings {
  if (_annualFilings is EqualUnmodifiableListView) return _annualFilings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualFilings);
}

 final  List<SecFiling> _quarterlyFilings;
@override@JsonKey() List<SecFiling> get quarterlyFilings {
  if (_quarterlyFilings is EqualUnmodifiableListView) return _quarterlyFilings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyFilings);
}


/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileCopyWith<_BusinessProfile> get copyWith => __$BusinessProfileCopyWithImpl<_BusinessProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfile&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.ceo, ceo) || other.ceo == ceo)&&(identical(other.website, website) || other.website == website)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.zip, zip) || other.zip == zip)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.fullTimeEmployees, fullTimeEmployees) || other.fullTimeEmployees == fullTimeEmployees)&&(identical(other.def14aUrl, def14aUrl) || other.def14aUrl == def14aUrl)&&(identical(other.isForeignCompany, isForeignCompany) || other.isForeignCompany == isForeignCompany)&&(identical(other.proxyFilingFormType, proxyFilingFormType) || other.proxyFilingFormType == proxyFilingFormType)&&const DeepCollectionEquality().equals(other._annualFilings, _annualFilings)&&const DeepCollectionEquality().equals(other._quarterlyFilings, _quarterlyFilings));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,companyName,sector,industry,description,ceo,website,address,city,state,zip,phone,fullTimeEmployees,def14aUrl,isForeignCompany,proxyFilingFormType,const DeepCollectionEquality().hash(_annualFilings),const DeepCollectionEquality().hash(_quarterlyFilings));

@override
String toString() {
  return 'BusinessProfile(symbol: $symbol, companyName: $companyName, sector: $sector, industry: $industry, description: $description, ceo: $ceo, website: $website, address: $address, city: $city, state: $state, zip: $zip, phone: $phone, fullTimeEmployees: $fullTimeEmployees, def14aUrl: $def14aUrl, isForeignCompany: $isForeignCompany, proxyFilingFormType: $proxyFilingFormType, annualFilings: $annualFilings, quarterlyFilings: $quarterlyFilings)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileCopyWith<$Res> implements $BusinessProfileCopyWith<$Res> {
  factory _$BusinessProfileCopyWith(_BusinessProfile value, $Res Function(_BusinessProfile) _then) = __$BusinessProfileCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String companyName, String sector, String industry, String description, String ceo, String website, String address, String city, String state, String zip, String phone, String fullTimeEmployees, String? def14aUrl, bool isForeignCompany, String proxyFilingFormType, List<SecFiling> annualFilings, List<SecFiling> quarterlyFilings
});




}
/// @nodoc
class __$BusinessProfileCopyWithImpl<$Res>
    implements _$BusinessProfileCopyWith<$Res> {
  __$BusinessProfileCopyWithImpl(this._self, this._then);

  final _BusinessProfile _self;
  final $Res Function(_BusinessProfile) _then;

/// Create a copy of BusinessProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? companyName = null,Object? sector = null,Object? industry = null,Object? description = null,Object? ceo = null,Object? website = null,Object? address = null,Object? city = null,Object? state = null,Object? zip = null,Object? phone = null,Object? fullTimeEmployees = null,Object? def14aUrl = freezed,Object? isForeignCompany = null,Object? proxyFilingFormType = null,Object? annualFilings = null,Object? quarterlyFilings = null,}) {
  return _then(_BusinessProfile(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ceo: null == ceo ? _self.ceo : ceo // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,zip: null == zip ? _self.zip : zip // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,fullTimeEmployees: null == fullTimeEmployees ? _self.fullTimeEmployees : fullTimeEmployees // ignore: cast_nullable_to_non_nullable
as String,def14aUrl: freezed == def14aUrl ? _self.def14aUrl : def14aUrl // ignore: cast_nullable_to_non_nullable
as String?,isForeignCompany: null == isForeignCompany ? _self.isForeignCompany : isForeignCompany // ignore: cast_nullable_to_non_nullable
as bool,proxyFilingFormType: null == proxyFilingFormType ? _self.proxyFilingFormType : proxyFilingFormType // ignore: cast_nullable_to_non_nullable
as String,annualFilings: null == annualFilings ? _self._annualFilings : annualFilings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,quarterlyFilings: null == quarterlyFilings ? _self._quarterlyFilings : quarterlyFilings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,
  ));
}


}

// dart format on
