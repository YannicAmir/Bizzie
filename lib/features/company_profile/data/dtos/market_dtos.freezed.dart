// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DividendDto {

 String get date; double? get dividend; double? get adjDividend; String? get recordDate; String? get paymentDate; String? get declarationDate; double? get yield; String? get frequency;
/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DividendDtoCopyWith<DividendDto> get copyWith => _$DividendDtoCopyWithImpl<DividendDto>(this as DividendDto, _$identity);

  /// Serializes this DividendDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DividendDto&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,recordDate,paymentDate,declarationDate,yield,frequency);

@override
String toString() {
  return 'DividendDto(date: $date, dividend: $dividend, adjDividend: $adjDividend, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, yield: $yield, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class $DividendDtoCopyWith<$Res>  {
  factory $DividendDtoCopyWith(DividendDto value, $Res Function(DividendDto) _then) = _$DividendDtoCopyWithImpl;
@useResult
$Res call({
 String date, double? dividend, double? adjDividend, String? recordDate, String? paymentDate, String? declarationDate, double? yield, String? frequency
});




}
/// @nodoc
class _$DividendDtoCopyWithImpl<$Res>
    implements $DividendDtoCopyWith<$Res> {
  _$DividendDtoCopyWithImpl(this._self, this._then);

  final DividendDto _self;
  final $Res Function(DividendDto) _then;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dividend = freezed,Object? adjDividend = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? yield = freezed,Object? frequency = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: freezed == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double?,adjDividend: freezed == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DividendDto].
extension DividendDtoPatterns on DividendDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DividendDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DividendDto value)  $default,){
final _that = this;
switch (_that) {
case _DividendDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DividendDto value)?  $default,){
final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)  $default,) {final _that = this;
switch (_that) {
case _DividendDto():
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)?  $default,) {final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DividendDto implements DividendDto {
  const _DividendDto({required this.date, this.dividend, this.adjDividend, this.recordDate, this.paymentDate, this.declarationDate, this.yield, this.frequency});
  factory _DividendDto.fromJson(Map<String, dynamic> json) => _$DividendDtoFromJson(json);

@override final  String date;
@override final  double? dividend;
@override final  double? adjDividend;
@override final  String? recordDate;
@override final  String? paymentDate;
@override final  String? declarationDate;
@override final  double? yield;
@override final  String? frequency;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DividendDtoCopyWith<_DividendDto> get copyWith => __$DividendDtoCopyWithImpl<_DividendDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DividendDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DividendDto&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,recordDate,paymentDate,declarationDate,yield,frequency);

@override
String toString() {
  return 'DividendDto(date: $date, dividend: $dividend, adjDividend: $adjDividend, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, yield: $yield, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class _$DividendDtoCopyWith<$Res> implements $DividendDtoCopyWith<$Res> {
  factory _$DividendDtoCopyWith(_DividendDto value, $Res Function(_DividendDto) _then) = __$DividendDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, double? dividend, double? adjDividend, String? recordDate, String? paymentDate, String? declarationDate, double? yield, String? frequency
});




}
/// @nodoc
class __$DividendDtoCopyWithImpl<$Res>
    implements _$DividendDtoCopyWith<$Res> {
  __$DividendDtoCopyWithImpl(this._self, this._then);

  final _DividendDto _self;
  final $Res Function(_DividendDto) _then;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dividend = freezed,Object? adjDividend = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? yield = freezed,Object? frequency = freezed,}) {
  return _then(_DividendDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: freezed == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double?,adjDividend: freezed == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$NewsDto {

 String get symbol; String get publishedDate; String get title; String? get image; String get site; String get url; String? get text;
/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsDtoCopyWith<NewsDto> get copyWith => _$NewsDtoCopyWithImpl<NewsDto>(this as NewsDto, _$identity);

  /// Serializes this NewsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,publishedDate,title,image,site,url,text);

@override
String toString() {
  return 'NewsDto(symbol: $symbol, publishedDate: $publishedDate, title: $title, image: $image, site: $site, url: $url, text: $text)';
}


}

/// @nodoc
abstract mixin class $NewsDtoCopyWith<$Res>  {
  factory $NewsDtoCopyWith(NewsDto value, $Res Function(NewsDto) _then) = _$NewsDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String publishedDate, String title, String? image, String site, String url, String? text
});




}
/// @nodoc
class _$NewsDtoCopyWithImpl<$Res>
    implements $NewsDtoCopyWith<$Res> {
  _$NewsDtoCopyWithImpl(this._self, this._then);

  final NewsDto _self;
  final $Res Function(NewsDto) _then;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? publishedDate = null,Object? title = null,Object? image = freezed,Object? site = null,Object? url = null,Object? text = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsDto].
extension NewsDtoPatterns on NewsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsDto value)  $default,){
final _that = this;
switch (_that) {
case _NewsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsDto value)?  $default,){
final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)  $default,) {final _that = this;
switch (_that) {
case _NewsDto():
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String publishedDate,  String title,  String? image,  String site,  String url,  String? text)?  $default,) {final _that = this;
switch (_that) {
case _NewsDto() when $default != null:
return $default(_that.symbol,_that.publishedDate,_that.title,_that.image,_that.site,_that.url,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsDto implements NewsDto {
  const _NewsDto({required this.symbol, required this.publishedDate, required this.title, this.image, required this.site, required this.url, this.text});
  factory _NewsDto.fromJson(Map<String, dynamic> json) => _$NewsDtoFromJson(json);

@override final  String symbol;
@override final  String publishedDate;
@override final  String title;
@override final  String? image;
@override final  String site;
@override final  String url;
@override final  String? text;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsDtoCopyWith<_NewsDto> get copyWith => __$NewsDtoCopyWithImpl<_NewsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&(identical(other.site, site) || other.site == site)&&(identical(other.url, url) || other.url == url)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,publishedDate,title,image,site,url,text);

@override
String toString() {
  return 'NewsDto(symbol: $symbol, publishedDate: $publishedDate, title: $title, image: $image, site: $site, url: $url, text: $text)';
}


}

/// @nodoc
abstract mixin class _$NewsDtoCopyWith<$Res> implements $NewsDtoCopyWith<$Res> {
  factory _$NewsDtoCopyWith(_NewsDto value, $Res Function(_NewsDto) _then) = __$NewsDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String publishedDate, String title, String? image, String site, String url, String? text
});




}
/// @nodoc
class __$NewsDtoCopyWithImpl<$Res>
    implements _$NewsDtoCopyWith<$Res> {
  __$NewsDtoCopyWithImpl(this._self, this._then);

  final _NewsDto _self;
  final $Res Function(_NewsDto) _then;

/// Create a copy of NewsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? publishedDate = null,Object? title = null,Object? image = freezed,Object? site = null,Object? url = null,Object? text = freezed,}) {
  return _then(_NewsDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HistoricalPriceDto {

 String get date; double? get price; double? get close; double? get volume;
/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPriceDtoCopyWith<HistoricalPriceDto> get copyWith => _$HistoricalPriceDtoCopyWithImpl<HistoricalPriceDto>(this as HistoricalPriceDto, _$identity);

  /// Serializes this HistoricalPriceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPriceDto&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,price,close,volume);

@override
String toString() {
  return 'HistoricalPriceDto(date: $date, price: $price, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $HistoricalPriceDtoCopyWith<$Res>  {
  factory $HistoricalPriceDtoCopyWith(HistoricalPriceDto value, $Res Function(HistoricalPriceDto) _then) = _$HistoricalPriceDtoCopyWithImpl;
@useResult
$Res call({
 String date, double? price, double? close, double? volume
});




}
/// @nodoc
class _$HistoricalPriceDtoCopyWithImpl<$Res>
    implements $HistoricalPriceDtoCopyWith<$Res> {
  _$HistoricalPriceDtoCopyWithImpl(this._self, this._then);

  final HistoricalPriceDto _self;
  final $Res Function(HistoricalPriceDto) _then;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? price = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalPriceDto].
extension HistoricalPriceDtoPatterns on HistoricalPriceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPriceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPriceDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPriceDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double? price,  double? close,  double? volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
return $default(_that.date,_that.price,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double? price,  double? close,  double? volume)  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceDto():
return $default(_that.date,_that.price,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double? price,  double? close,  double? volume)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalPriceDto() when $default != null:
return $default(_that.date,_that.price,_that.close,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalPriceDto implements HistoricalPriceDto {
  const _HistoricalPriceDto({required this.date, this.price, this.close, this.volume});
  factory _HistoricalPriceDto.fromJson(Map<String, dynamic> json) => _$HistoricalPriceDtoFromJson(json);

@override final  String date;
@override final  double? price;
@override final  double? close;
@override final  double? volume;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPriceDtoCopyWith<_HistoricalPriceDto> get copyWith => __$HistoricalPriceDtoCopyWithImpl<_HistoricalPriceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalPriceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPriceDto&&(identical(other.date, date) || other.date == date)&&(identical(other.price, price) || other.price == price)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,price,close,volume);

@override
String toString() {
  return 'HistoricalPriceDto(date: $date, price: $price, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPriceDtoCopyWith<$Res> implements $HistoricalPriceDtoCopyWith<$Res> {
  factory _$HistoricalPriceDtoCopyWith(_HistoricalPriceDto value, $Res Function(_HistoricalPriceDto) _then) = __$HistoricalPriceDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, double? price, double? close, double? volume
});




}
/// @nodoc
class __$HistoricalPriceDtoCopyWithImpl<$Res>
    implements _$HistoricalPriceDtoCopyWith<$Res> {
  __$HistoricalPriceDtoCopyWithImpl(this._self, this._then);

  final _HistoricalPriceDto _self;
  final $Res Function(_HistoricalPriceDto) _then;

/// Create a copy of HistoricalPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? price = freezed,Object? close = freezed,Object? volume = freezed,}) {
  return _then(_HistoricalPriceDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,close: freezed == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
