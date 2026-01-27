// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityDetails {

 String get ticker; String get name; String get sector; String get industry; String get description; String get currency; bool get isEtf; bool get isFund; bool get isActivelyTrading; double? get price; double? get changesPercentage; double? get change; double? get marketCap; double? get peRatioTTM; double? get priceToFreeCashFlowTTM; double? get beta; String? get image; String? get exchangeShortName; String? get country; String? get ipoDate; String? get website;
/// Create a copy of SecurityDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityDetailsCopyWith<SecurityDetails> get copyWith => _$SecurityDetailsCopyWithImpl<SecurityDetails>(this as SecurityDetails, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityDetails&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund)&&(identical(other.isActivelyTrading, isActivelyTrading) || other.isActivelyTrading == isActivelyTrading)&&(identical(other.price, price) || other.price == price)&&(identical(other.changesPercentage, changesPercentage) || other.changesPercentage == changesPercentage)&&(identical(other.change, change) || other.change == change)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.peRatioTTM, peRatioTTM) || other.peRatioTTM == peRatioTTM)&&(identical(other.priceToFreeCashFlowTTM, priceToFreeCashFlowTTM) || other.priceToFreeCashFlowTTM == priceToFreeCashFlowTTM)&&(identical(other.beta, beta) || other.beta == beta)&&(identical(other.image, image) || other.image == image)&&(identical(other.exchangeShortName, exchangeShortName) || other.exchangeShortName == exchangeShortName)&&(identical(other.country, country) || other.country == country)&&(identical(other.ipoDate, ipoDate) || other.ipoDate == ipoDate)&&(identical(other.website, website) || other.website == website));
}


@override
int get hashCode => Object.hashAll([runtimeType,ticker,name,sector,industry,description,currency,isEtf,isFund,isActivelyTrading,price,changesPercentage,change,marketCap,peRatioTTM,priceToFreeCashFlowTTM,beta,image,exchangeShortName,country,ipoDate,website]);

@override
String toString() {
  return 'SecurityDetails(ticker: $ticker, name: $name, sector: $sector, industry: $industry, description: $description, currency: $currency, isEtf: $isEtf, isFund: $isFund, isActivelyTrading: $isActivelyTrading, price: $price, changesPercentage: $changesPercentage, change: $change, marketCap: $marketCap, peRatioTTM: $peRatioTTM, priceToFreeCashFlowTTM: $priceToFreeCashFlowTTM, beta: $beta, image: $image, exchangeShortName: $exchangeShortName, country: $country, ipoDate: $ipoDate, website: $website)';
}


}

/// @nodoc
abstract mixin class $SecurityDetailsCopyWith<$Res>  {
  factory $SecurityDetailsCopyWith(SecurityDetails value, $Res Function(SecurityDetails) _then) = _$SecurityDetailsCopyWithImpl;
@useResult
$Res call({
 String ticker, String name, String sector, String industry, String description, String currency, bool isEtf, bool isFund, bool isActivelyTrading, double? price, double? changesPercentage, double? change, double? marketCap, double? peRatioTTM, double? priceToFreeCashFlowTTM, double? beta, String? image, String? exchangeShortName, String? country, String? ipoDate, String? website
});




}
/// @nodoc
class _$SecurityDetailsCopyWithImpl<$Res>
    implements $SecurityDetailsCopyWith<$Res> {
  _$SecurityDetailsCopyWithImpl(this._self, this._then);

  final SecurityDetails _self;
  final $Res Function(SecurityDetails) _then;

/// Create a copy of SecurityDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? name = null,Object? sector = null,Object? industry = null,Object? description = null,Object? currency = null,Object? isEtf = null,Object? isFund = null,Object? isActivelyTrading = null,Object? price = freezed,Object? changesPercentage = freezed,Object? change = freezed,Object? marketCap = freezed,Object? peRatioTTM = freezed,Object? priceToFreeCashFlowTTM = freezed,Object? beta = freezed,Object? image = freezed,Object? exchangeShortName = freezed,Object? country = freezed,Object? ipoDate = freezed,Object? website = freezed,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,isActivelyTrading: null == isActivelyTrading ? _self.isActivelyTrading : isActivelyTrading // ignore: cast_nullable_to_non_nullable
as bool,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,changesPercentage: freezed == changesPercentage ? _self.changesPercentage : changesPercentage // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,peRatioTTM: freezed == peRatioTTM ? _self.peRatioTTM : peRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowTTM: freezed == priceToFreeCashFlowTTM ? _self.priceToFreeCashFlowTTM : priceToFreeCashFlowTTM // ignore: cast_nullable_to_non_nullable
as double?,beta: freezed == beta ? _self.beta : beta // ignore: cast_nullable_to_non_nullable
as double?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,exchangeShortName: freezed == exchangeShortName ? _self.exchangeShortName : exchangeShortName // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,ipoDate: freezed == ipoDate ? _self.ipoDate : ipoDate // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityDetails].
extension SecurityDetailsPatterns on SecurityDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityDetails value)  $default,){
final _that = this;
switch (_that) {
case _SecurityDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String name,  String sector,  String industry,  String description,  String currency,  bool isEtf,  bool isFund,  bool isActivelyTrading,  double? price,  double? changesPercentage,  double? change,  double? marketCap,  double? peRatioTTM,  double? priceToFreeCashFlowTTM,  double? beta,  String? image,  String? exchangeShortName,  String? country,  String? ipoDate,  String? website)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityDetails() when $default != null:
return $default(_that.ticker,_that.name,_that.sector,_that.industry,_that.description,_that.currency,_that.isEtf,_that.isFund,_that.isActivelyTrading,_that.price,_that.changesPercentage,_that.change,_that.marketCap,_that.peRatioTTM,_that.priceToFreeCashFlowTTM,_that.beta,_that.image,_that.exchangeShortName,_that.country,_that.ipoDate,_that.website);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String name,  String sector,  String industry,  String description,  String currency,  bool isEtf,  bool isFund,  bool isActivelyTrading,  double? price,  double? changesPercentage,  double? change,  double? marketCap,  double? peRatioTTM,  double? priceToFreeCashFlowTTM,  double? beta,  String? image,  String? exchangeShortName,  String? country,  String? ipoDate,  String? website)  $default,) {final _that = this;
switch (_that) {
case _SecurityDetails():
return $default(_that.ticker,_that.name,_that.sector,_that.industry,_that.description,_that.currency,_that.isEtf,_that.isFund,_that.isActivelyTrading,_that.price,_that.changesPercentage,_that.change,_that.marketCap,_that.peRatioTTM,_that.priceToFreeCashFlowTTM,_that.beta,_that.image,_that.exchangeShortName,_that.country,_that.ipoDate,_that.website);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String name,  String sector,  String industry,  String description,  String currency,  bool isEtf,  bool isFund,  bool isActivelyTrading,  double? price,  double? changesPercentage,  double? change,  double? marketCap,  double? peRatioTTM,  double? priceToFreeCashFlowTTM,  double? beta,  String? image,  String? exchangeShortName,  String? country,  String? ipoDate,  String? website)?  $default,) {final _that = this;
switch (_that) {
case _SecurityDetails() when $default != null:
return $default(_that.ticker,_that.name,_that.sector,_that.industry,_that.description,_that.currency,_that.isEtf,_that.isFund,_that.isActivelyTrading,_that.price,_that.changesPercentage,_that.change,_that.marketCap,_that.peRatioTTM,_that.priceToFreeCashFlowTTM,_that.beta,_that.image,_that.exchangeShortName,_that.country,_that.ipoDate,_that.website);case _:
  return null;

}
}

}

/// @nodoc


class _SecurityDetails extends SecurityDetails {
  const _SecurityDetails({required this.ticker, required this.name, required this.sector, required this.industry, required this.description, required this.currency, required this.isEtf, required this.isFund, required this.isActivelyTrading, this.price, this.changesPercentage, this.change, this.marketCap, this.peRatioTTM, this.priceToFreeCashFlowTTM, this.beta, this.image, this.exchangeShortName, this.country, this.ipoDate, this.website}): super._();
  

@override final  String ticker;
@override final  String name;
@override final  String sector;
@override final  String industry;
@override final  String description;
@override final  String currency;
@override final  bool isEtf;
@override final  bool isFund;
@override final  bool isActivelyTrading;
@override final  double? price;
@override final  double? changesPercentage;
@override final  double? change;
@override final  double? marketCap;
@override final  double? peRatioTTM;
@override final  double? priceToFreeCashFlowTTM;
@override final  double? beta;
@override final  String? image;
@override final  String? exchangeShortName;
@override final  String? country;
@override final  String? ipoDate;
@override final  String? website;

/// Create a copy of SecurityDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityDetailsCopyWith<_SecurityDetails> get copyWith => __$SecurityDetailsCopyWithImpl<_SecurityDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityDetails&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund)&&(identical(other.isActivelyTrading, isActivelyTrading) || other.isActivelyTrading == isActivelyTrading)&&(identical(other.price, price) || other.price == price)&&(identical(other.changesPercentage, changesPercentage) || other.changesPercentage == changesPercentage)&&(identical(other.change, change) || other.change == change)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.peRatioTTM, peRatioTTM) || other.peRatioTTM == peRatioTTM)&&(identical(other.priceToFreeCashFlowTTM, priceToFreeCashFlowTTM) || other.priceToFreeCashFlowTTM == priceToFreeCashFlowTTM)&&(identical(other.beta, beta) || other.beta == beta)&&(identical(other.image, image) || other.image == image)&&(identical(other.exchangeShortName, exchangeShortName) || other.exchangeShortName == exchangeShortName)&&(identical(other.country, country) || other.country == country)&&(identical(other.ipoDate, ipoDate) || other.ipoDate == ipoDate)&&(identical(other.website, website) || other.website == website));
}


@override
int get hashCode => Object.hashAll([runtimeType,ticker,name,sector,industry,description,currency,isEtf,isFund,isActivelyTrading,price,changesPercentage,change,marketCap,peRatioTTM,priceToFreeCashFlowTTM,beta,image,exchangeShortName,country,ipoDate,website]);

@override
String toString() {
  return 'SecurityDetails(ticker: $ticker, name: $name, sector: $sector, industry: $industry, description: $description, currency: $currency, isEtf: $isEtf, isFund: $isFund, isActivelyTrading: $isActivelyTrading, price: $price, changesPercentage: $changesPercentage, change: $change, marketCap: $marketCap, peRatioTTM: $peRatioTTM, priceToFreeCashFlowTTM: $priceToFreeCashFlowTTM, beta: $beta, image: $image, exchangeShortName: $exchangeShortName, country: $country, ipoDate: $ipoDate, website: $website)';
}


}

/// @nodoc
abstract mixin class _$SecurityDetailsCopyWith<$Res> implements $SecurityDetailsCopyWith<$Res> {
  factory _$SecurityDetailsCopyWith(_SecurityDetails value, $Res Function(_SecurityDetails) _then) = __$SecurityDetailsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String name, String sector, String industry, String description, String currency, bool isEtf, bool isFund, bool isActivelyTrading, double? price, double? changesPercentage, double? change, double? marketCap, double? peRatioTTM, double? priceToFreeCashFlowTTM, double? beta, String? image, String? exchangeShortName, String? country, String? ipoDate, String? website
});




}
/// @nodoc
class __$SecurityDetailsCopyWithImpl<$Res>
    implements _$SecurityDetailsCopyWith<$Res> {
  __$SecurityDetailsCopyWithImpl(this._self, this._then);

  final _SecurityDetails _self;
  final $Res Function(_SecurityDetails) _then;

/// Create a copy of SecurityDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? name = null,Object? sector = null,Object? industry = null,Object? description = null,Object? currency = null,Object? isEtf = null,Object? isFund = null,Object? isActivelyTrading = null,Object? price = freezed,Object? changesPercentage = freezed,Object? change = freezed,Object? marketCap = freezed,Object? peRatioTTM = freezed,Object? priceToFreeCashFlowTTM = freezed,Object? beta = freezed,Object? image = freezed,Object? exchangeShortName = freezed,Object? country = freezed,Object? ipoDate = freezed,Object? website = freezed,}) {
  return _then(_SecurityDetails(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,isActivelyTrading: null == isActivelyTrading ? _self.isActivelyTrading : isActivelyTrading // ignore: cast_nullable_to_non_nullable
as bool,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,changesPercentage: freezed == changesPercentage ? _self.changesPercentage : changesPercentage // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,peRatioTTM: freezed == peRatioTTM ? _self.peRatioTTM : peRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowTTM: freezed == priceToFreeCashFlowTTM ? _self.priceToFreeCashFlowTTM : priceToFreeCashFlowTTM // ignore: cast_nullable_to_non_nullable
as double?,beta: freezed == beta ? _self.beta : beta // ignore: cast_nullable_to_non_nullable
as double?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,exchangeShortName: freezed == exchangeShortName ? _self.exchangeShortName : exchangeShortName // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,ipoDate: freezed == ipoDate ? _self.ipoDate : ipoDate // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
