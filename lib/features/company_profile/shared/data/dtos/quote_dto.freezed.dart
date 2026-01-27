// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteDto {

 String get symbol; String get name; double? get price; double? get change; double? get changesPercentage; double? get marketCap; double? get pe; double? get eps; double? get volume; double? get sharesOutstanding;
/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteDtoCopyWith<QuoteDto> get copyWith => _$QuoteDtoCopyWithImpl<QuoteDto>(this as QuoteDto, _$identity);

  /// Serializes this QuoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changesPercentage, changesPercentage) || other.changesPercentage == changesPercentage)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.pe, pe) || other.pe == pe)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.sharesOutstanding, sharesOutstanding) || other.sharesOutstanding == sharesOutstanding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,change,changesPercentage,marketCap,pe,eps,volume,sharesOutstanding);

@override
String toString() {
  return 'QuoteDto(symbol: $symbol, name: $name, price: $price, change: $change, changesPercentage: $changesPercentage, marketCap: $marketCap, pe: $pe, eps: $eps, volume: $volume, sharesOutstanding: $sharesOutstanding)';
}


}

/// @nodoc
abstract mixin class $QuoteDtoCopyWith<$Res>  {
  factory $QuoteDtoCopyWith(QuoteDto value, $Res Function(QuoteDto) _then) = _$QuoteDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String name, double? price, double? change, double? changesPercentage, double? marketCap, double? pe, double? eps, double? volume, double? sharesOutstanding
});




}
/// @nodoc
class _$QuoteDtoCopyWithImpl<$Res>
    implements $QuoteDtoCopyWith<$Res> {
  _$QuoteDtoCopyWithImpl(this._self, this._then);

  final QuoteDto _self;
  final $Res Function(QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? name = null,Object? price = freezed,Object? change = freezed,Object? changesPercentage = freezed,Object? marketCap = freezed,Object? pe = freezed,Object? eps = freezed,Object? volume = freezed,Object? sharesOutstanding = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changesPercentage: freezed == changesPercentage ? _self.changesPercentage : changesPercentage // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,pe: freezed == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,sharesOutstanding: freezed == sharesOutstanding ? _self.sharesOutstanding : sharesOutstanding // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteDto].
extension QuoteDtoPatterns on QuoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteDto value)  $default,){
final _that = this;
switch (_that) {
case _QuoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String name,  double? price,  double? change,  double? changesPercentage,  double? marketCap,  double? pe,  double? eps,  double? volume,  double? sharesOutstanding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changesPercentage,_that.marketCap,_that.pe,_that.eps,_that.volume,_that.sharesOutstanding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String name,  double? price,  double? change,  double? changesPercentage,  double? marketCap,  double? pe,  double? eps,  double? volume,  double? sharesOutstanding)  $default,) {final _that = this;
switch (_that) {
case _QuoteDto():
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changesPercentage,_that.marketCap,_that.pe,_that.eps,_that.volume,_that.sharesOutstanding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String name,  double? price,  double? change,  double? changesPercentage,  double? marketCap,  double? pe,  double? eps,  double? volume,  double? sharesOutstanding)?  $default,) {final _that = this;
switch (_that) {
case _QuoteDto() when $default != null:
return $default(_that.symbol,_that.name,_that.price,_that.change,_that.changesPercentage,_that.marketCap,_that.pe,_that.eps,_that.volume,_that.sharesOutstanding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteDto extends QuoteDto {
  const _QuoteDto({required this.symbol, required this.name, this.price, this.change, this.changesPercentage, this.marketCap, this.pe, this.eps, this.volume, this.sharesOutstanding}): super._();
  factory _QuoteDto.fromJson(Map<String, dynamic> json) => _$QuoteDtoFromJson(json);

@override final  String symbol;
@override final  String name;
@override final  double? price;
@override final  double? change;
@override final  double? changesPercentage;
@override final  double? marketCap;
@override final  double? pe;
@override final  double? eps;
@override final  double? volume;
@override final  double? sharesOutstanding;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteDtoCopyWith<_QuoteDto> get copyWith => __$QuoteDtoCopyWithImpl<_QuoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changesPercentage, changesPercentage) || other.changesPercentage == changesPercentage)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.pe, pe) || other.pe == pe)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.sharesOutstanding, sharesOutstanding) || other.sharesOutstanding == sharesOutstanding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,price,change,changesPercentage,marketCap,pe,eps,volume,sharesOutstanding);

@override
String toString() {
  return 'QuoteDto(symbol: $symbol, name: $name, price: $price, change: $change, changesPercentage: $changesPercentage, marketCap: $marketCap, pe: $pe, eps: $eps, volume: $volume, sharesOutstanding: $sharesOutstanding)';
}


}

/// @nodoc
abstract mixin class _$QuoteDtoCopyWith<$Res> implements $QuoteDtoCopyWith<$Res> {
  factory _$QuoteDtoCopyWith(_QuoteDto value, $Res Function(_QuoteDto) _then) = __$QuoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String name, double? price, double? change, double? changesPercentage, double? marketCap, double? pe, double? eps, double? volume, double? sharesOutstanding
});




}
/// @nodoc
class __$QuoteDtoCopyWithImpl<$Res>
    implements _$QuoteDtoCopyWith<$Res> {
  __$QuoteDtoCopyWithImpl(this._self, this._then);

  final _QuoteDto _self;
  final $Res Function(_QuoteDto) _then;

/// Create a copy of QuoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? name = null,Object? price = freezed,Object? change = freezed,Object? changesPercentage = freezed,Object? marketCap = freezed,Object? pe = freezed,Object? eps = freezed,Object? volume = freezed,Object? sharesOutstanding = freezed,}) {
  return _then(_QuoteDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changesPercentage: freezed == changesPercentage ? _self.changesPercentage : changesPercentage // ignore: cast_nullable_to_non_nullable
as double?,marketCap: freezed == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double?,pe: freezed == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,sharesOutstanding: freezed == sharesOutstanding ? _self.sharesOutstanding : sharesOutstanding // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
