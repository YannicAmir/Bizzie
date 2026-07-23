// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_stock_price_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchlistStockPriceDto {

 String get ticker; String get companyName; double get price; double? get previousClose; double? get change; double? get changePercent; String get sessionDate; List<StockPricePointDto> get series; bool get closeFinalized;
/// Create a copy of WatchlistStockPriceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistStockPriceDtoCopyWith<WatchlistStockPriceDto> get copyWith => _$WatchlistStockPriceDtoCopyWithImpl<WatchlistStockPriceDto>(this as WatchlistStockPriceDto, _$identity);

  /// Serializes this WatchlistStockPriceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistStockPriceDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.price, price) || other.price == price)&&(identical(other.previousClose, previousClose) || other.previousClose == previousClose)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&const DeepCollectionEquality().equals(other.series, series)&&(identical(other.closeFinalized, closeFinalized) || other.closeFinalized == closeFinalized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,price,previousClose,change,changePercent,sessionDate,const DeepCollectionEquality().hash(series),closeFinalized);

@override
String toString() {
  return 'WatchlistStockPriceDto(ticker: $ticker, companyName: $companyName, price: $price, previousClose: $previousClose, change: $change, changePercent: $changePercent, sessionDate: $sessionDate, series: $series, closeFinalized: $closeFinalized)';
}


}

/// @nodoc
abstract mixin class $WatchlistStockPriceDtoCopyWith<$Res>  {
  factory $WatchlistStockPriceDtoCopyWith(WatchlistStockPriceDto value, $Res Function(WatchlistStockPriceDto) _then) = _$WatchlistStockPriceDtoCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, double price, double? previousClose, double? change, double? changePercent, String sessionDate, List<StockPricePointDto> series, bool closeFinalized
});




}
/// @nodoc
class _$WatchlistStockPriceDtoCopyWithImpl<$Res>
    implements $WatchlistStockPriceDtoCopyWith<$Res> {
  _$WatchlistStockPriceDtoCopyWithImpl(this._self, this._then);

  final WatchlistStockPriceDto _self;
  final $Res Function(WatchlistStockPriceDto) _then;

/// Create a copy of WatchlistStockPriceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? companyName = null,Object? price = null,Object? previousClose = freezed,Object? change = freezed,Object? changePercent = freezed,Object? sessionDate = null,Object? series = null,Object? closeFinalized = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,previousClose: freezed == previousClose ? _self.previousClose : previousClose // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as List<StockPricePointDto>,closeFinalized: null == closeFinalized ? _self.closeFinalized : closeFinalized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistStockPriceDto].
extension WatchlistStockPriceDtoPatterns on WatchlistStockPriceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistStockPriceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistStockPriceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistStockPriceDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPriceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistStockPriceDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPriceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<StockPricePointDto> series,  bool closeFinalized)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistStockPriceDto() when $default != null:
return $default(_that.ticker,_that.companyName,_that.price,_that.previousClose,_that.change,_that.changePercent,_that.sessionDate,_that.series,_that.closeFinalized);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<StockPricePointDto> series,  bool closeFinalized)  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPriceDto():
return $default(_that.ticker,_that.companyName,_that.price,_that.previousClose,_that.change,_that.changePercent,_that.sessionDate,_that.series,_that.closeFinalized);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<StockPricePointDto> series,  bool closeFinalized)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPriceDto() when $default != null:
return $default(_that.ticker,_that.companyName,_that.price,_that.previousClose,_that.change,_that.changePercent,_that.sessionDate,_that.series,_that.closeFinalized);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistStockPriceDto extends WatchlistStockPriceDto {
  const _WatchlistStockPriceDto({required this.ticker, required this.companyName, required this.price, this.previousClose, this.change, this.changePercent, required this.sessionDate, final  List<StockPricePointDto> series = const [], this.closeFinalized = false}): _series = series,super._();
  factory _WatchlistStockPriceDto.fromJson(Map<String, dynamic> json) => _$WatchlistStockPriceDtoFromJson(json);

@override final  String ticker;
@override final  String companyName;
@override final  double price;
@override final  double? previousClose;
@override final  double? change;
@override final  double? changePercent;
@override final  String sessionDate;
 final  List<StockPricePointDto> _series;
@override@JsonKey() List<StockPricePointDto> get series {
  if (_series is EqualUnmodifiableListView) return _series;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_series);
}

@override@JsonKey() final  bool closeFinalized;

/// Create a copy of WatchlistStockPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistStockPriceDtoCopyWith<_WatchlistStockPriceDto> get copyWith => __$WatchlistStockPriceDtoCopyWithImpl<_WatchlistStockPriceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistStockPriceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistStockPriceDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.price, price) || other.price == price)&&(identical(other.previousClose, previousClose) || other.previousClose == previousClose)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&const DeepCollectionEquality().equals(other._series, _series)&&(identical(other.closeFinalized, closeFinalized) || other.closeFinalized == closeFinalized));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,price,previousClose,change,changePercent,sessionDate,const DeepCollectionEquality().hash(_series),closeFinalized);

@override
String toString() {
  return 'WatchlistStockPriceDto(ticker: $ticker, companyName: $companyName, price: $price, previousClose: $previousClose, change: $change, changePercent: $changePercent, sessionDate: $sessionDate, series: $series, closeFinalized: $closeFinalized)';
}


}

/// @nodoc
abstract mixin class _$WatchlistStockPriceDtoCopyWith<$Res> implements $WatchlistStockPriceDtoCopyWith<$Res> {
  factory _$WatchlistStockPriceDtoCopyWith(_WatchlistStockPriceDto value, $Res Function(_WatchlistStockPriceDto) _then) = __$WatchlistStockPriceDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String companyName, double price, double? previousClose, double? change, double? changePercent, String sessionDate, List<StockPricePointDto> series, bool closeFinalized
});




}
/// @nodoc
class __$WatchlistStockPriceDtoCopyWithImpl<$Res>
    implements _$WatchlistStockPriceDtoCopyWith<$Res> {
  __$WatchlistStockPriceDtoCopyWithImpl(this._self, this._then);

  final _WatchlistStockPriceDto _self;
  final $Res Function(_WatchlistStockPriceDto) _then;

/// Create a copy of WatchlistStockPriceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? price = null,Object? previousClose = freezed,Object? change = freezed,Object? changePercent = freezed,Object? sessionDate = null,Object? series = null,Object? closeFinalized = null,}) {
  return _then(_WatchlistStockPriceDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,previousClose: freezed == previousClose ? _self.previousClose : previousClose // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self._series : series // ignore: cast_nullable_to_non_nullable
as List<StockPricePointDto>,closeFinalized: null == closeFinalized ? _self.closeFinalized : closeFinalized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$StockPricePointDto {

 String get t; double get c;
/// Create a copy of StockPricePointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockPricePointDtoCopyWith<StockPricePointDto> get copyWith => _$StockPricePointDtoCopyWithImpl<StockPricePointDto>(this as StockPricePointDto, _$identity);

  /// Serializes this StockPricePointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockPricePointDto&&(identical(other.t, t) || other.t == t)&&(identical(other.c, c) || other.c == c));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t,c);

@override
String toString() {
  return 'StockPricePointDto(t: $t, c: $c)';
}


}

/// @nodoc
abstract mixin class $StockPricePointDtoCopyWith<$Res>  {
  factory $StockPricePointDtoCopyWith(StockPricePointDto value, $Res Function(StockPricePointDto) _then) = _$StockPricePointDtoCopyWithImpl;
@useResult
$Res call({
 String t, double c
});




}
/// @nodoc
class _$StockPricePointDtoCopyWithImpl<$Res>
    implements $StockPricePointDtoCopyWith<$Res> {
  _$StockPricePointDtoCopyWithImpl(this._self, this._then);

  final StockPricePointDto _self;
  final $Res Function(StockPricePointDto) _then;

/// Create a copy of StockPricePointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? t = null,Object? c = null,}) {
  return _then(_self.copyWith(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,c: null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [StockPricePointDto].
extension StockPricePointDtoPatterns on StockPricePointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockPricePointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockPricePointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockPricePointDto value)  $default,){
final _that = this;
switch (_that) {
case _StockPricePointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockPricePointDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockPricePointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String t,  double c)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockPricePointDto() when $default != null:
return $default(_that.t,_that.c);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String t,  double c)  $default,) {final _that = this;
switch (_that) {
case _StockPricePointDto():
return $default(_that.t,_that.c);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String t,  double c)?  $default,) {final _that = this;
switch (_that) {
case _StockPricePointDto() when $default != null:
return $default(_that.t,_that.c);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockPricePointDto extends StockPricePointDto {
  const _StockPricePointDto({required this.t, required this.c}): super._();
  factory _StockPricePointDto.fromJson(Map<String, dynamic> json) => _$StockPricePointDtoFromJson(json);

@override final  String t;
@override final  double c;

/// Create a copy of StockPricePointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockPricePointDtoCopyWith<_StockPricePointDto> get copyWith => __$StockPricePointDtoCopyWithImpl<_StockPricePointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockPricePointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockPricePointDto&&(identical(other.t, t) || other.t == t)&&(identical(other.c, c) || other.c == c));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t,c);

@override
String toString() {
  return 'StockPricePointDto(t: $t, c: $c)';
}


}

/// @nodoc
abstract mixin class _$StockPricePointDtoCopyWith<$Res> implements $StockPricePointDtoCopyWith<$Res> {
  factory _$StockPricePointDtoCopyWith(_StockPricePointDto value, $Res Function(_StockPricePointDto) _then) = __$StockPricePointDtoCopyWithImpl;
@override @useResult
$Res call({
 String t, double c
});




}
/// @nodoc
class __$StockPricePointDtoCopyWithImpl<$Res>
    implements _$StockPricePointDtoCopyWith<$Res> {
  __$StockPricePointDtoCopyWithImpl(this._self, this._then);

  final _StockPricePointDto _self;
  final $Res Function(_StockPricePointDto) _then;

/// Create a copy of StockPricePointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? t = null,Object? c = null,}) {
  return _then(_StockPricePointDto(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,c: null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
