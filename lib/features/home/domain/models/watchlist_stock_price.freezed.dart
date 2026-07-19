// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_stock_price.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistStockPrice {

 String get ticker; String get companyName; double get price; double? get previousClose; double? get change; double? get changePercent; String get sessionDate; List<WatchlistStockPricePoint> get series; bool get closeFinalized;
/// Create a copy of WatchlistStockPrice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistStockPriceCopyWith<WatchlistStockPrice> get copyWith => _$WatchlistStockPriceCopyWithImpl<WatchlistStockPrice>(this as WatchlistStockPrice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistStockPrice&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.price, price) || other.price == price)&&(identical(other.previousClose, previousClose) || other.previousClose == previousClose)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&const DeepCollectionEquality().equals(other.series, series)&&(identical(other.closeFinalized, closeFinalized) || other.closeFinalized == closeFinalized));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,price,previousClose,change,changePercent,sessionDate,const DeepCollectionEquality().hash(series),closeFinalized);

@override
String toString() {
  return 'WatchlistStockPrice(ticker: $ticker, companyName: $companyName, price: $price, previousClose: $previousClose, change: $change, changePercent: $changePercent, sessionDate: $sessionDate, series: $series, closeFinalized: $closeFinalized)';
}


}

/// @nodoc
abstract mixin class $WatchlistStockPriceCopyWith<$Res>  {
  factory $WatchlistStockPriceCopyWith(WatchlistStockPrice value, $Res Function(WatchlistStockPrice) _then) = _$WatchlistStockPriceCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, double price, double? previousClose, double? change, double? changePercent, String sessionDate, List<WatchlistStockPricePoint> series, bool closeFinalized
});




}
/// @nodoc
class _$WatchlistStockPriceCopyWithImpl<$Res>
    implements $WatchlistStockPriceCopyWith<$Res> {
  _$WatchlistStockPriceCopyWithImpl(this._self, this._then);

  final WatchlistStockPrice _self;
  final $Res Function(WatchlistStockPrice) _then;

/// Create a copy of WatchlistStockPrice
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
as List<WatchlistStockPricePoint>,closeFinalized: null == closeFinalized ? _self.closeFinalized : closeFinalized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistStockPrice].
extension WatchlistStockPricePatterns on WatchlistStockPrice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistStockPrice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistStockPrice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistStockPrice value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPrice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistStockPrice value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPrice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<WatchlistStockPricePoint> series,  bool closeFinalized)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistStockPrice() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<WatchlistStockPricePoint> series,  bool closeFinalized)  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPrice():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String companyName,  double price,  double? previousClose,  double? change,  double? changePercent,  String sessionDate,  List<WatchlistStockPricePoint> series,  bool closeFinalized)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPrice() when $default != null:
return $default(_that.ticker,_that.companyName,_that.price,_that.previousClose,_that.change,_that.changePercent,_that.sessionDate,_that.series,_that.closeFinalized);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistStockPrice implements WatchlistStockPrice {
  const _WatchlistStockPrice({required this.ticker, required this.companyName, required this.price, required this.previousClose, required this.change, required this.changePercent, required this.sessionDate, required final  List<WatchlistStockPricePoint> series, required this.closeFinalized}): _series = series;
  

@override final  String ticker;
@override final  String companyName;
@override final  double price;
@override final  double? previousClose;
@override final  double? change;
@override final  double? changePercent;
@override final  String sessionDate;
 final  List<WatchlistStockPricePoint> _series;
@override List<WatchlistStockPricePoint> get series {
  if (_series is EqualUnmodifiableListView) return _series;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_series);
}

@override final  bool closeFinalized;

/// Create a copy of WatchlistStockPrice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistStockPriceCopyWith<_WatchlistStockPrice> get copyWith => __$WatchlistStockPriceCopyWithImpl<_WatchlistStockPrice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistStockPrice&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.price, price) || other.price == price)&&(identical(other.previousClose, previousClose) || other.previousClose == previousClose)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate)&&const DeepCollectionEquality().equals(other._series, _series)&&(identical(other.closeFinalized, closeFinalized) || other.closeFinalized == closeFinalized));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,price,previousClose,change,changePercent,sessionDate,const DeepCollectionEquality().hash(_series),closeFinalized);

@override
String toString() {
  return 'WatchlistStockPrice(ticker: $ticker, companyName: $companyName, price: $price, previousClose: $previousClose, change: $change, changePercent: $changePercent, sessionDate: $sessionDate, series: $series, closeFinalized: $closeFinalized)';
}


}

/// @nodoc
abstract mixin class _$WatchlistStockPriceCopyWith<$Res> implements $WatchlistStockPriceCopyWith<$Res> {
  factory _$WatchlistStockPriceCopyWith(_WatchlistStockPrice value, $Res Function(_WatchlistStockPrice) _then) = __$WatchlistStockPriceCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String companyName, double price, double? previousClose, double? change, double? changePercent, String sessionDate, List<WatchlistStockPricePoint> series, bool closeFinalized
});




}
/// @nodoc
class __$WatchlistStockPriceCopyWithImpl<$Res>
    implements _$WatchlistStockPriceCopyWith<$Res> {
  __$WatchlistStockPriceCopyWithImpl(this._self, this._then);

  final _WatchlistStockPrice _self;
  final $Res Function(_WatchlistStockPrice) _then;

/// Create a copy of WatchlistStockPrice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? price = null,Object? previousClose = freezed,Object? change = freezed,Object? changePercent = freezed,Object? sessionDate = null,Object? series = null,Object? closeFinalized = null,}) {
  return _then(_WatchlistStockPrice(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,previousClose: freezed == previousClose ? _self.previousClose : previousClose // ignore: cast_nullable_to_non_nullable
as double?,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,series: null == series ? _self._series : series // ignore: cast_nullable_to_non_nullable
as List<WatchlistStockPricePoint>,closeFinalized: null == closeFinalized ? _self.closeFinalized : closeFinalized // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$WatchlistStockPricePoint {

 String get time; double get close;
/// Create a copy of WatchlistStockPricePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistStockPricePointCopyWith<WatchlistStockPricePoint> get copyWith => _$WatchlistStockPricePointCopyWithImpl<WatchlistStockPricePoint>(this as WatchlistStockPricePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistStockPricePoint&&(identical(other.time, time) || other.time == time)&&(identical(other.close, close) || other.close == close));
}


@override
int get hashCode => Object.hash(runtimeType,time,close);

@override
String toString() {
  return 'WatchlistStockPricePoint(time: $time, close: $close)';
}


}

/// @nodoc
abstract mixin class $WatchlistStockPricePointCopyWith<$Res>  {
  factory $WatchlistStockPricePointCopyWith(WatchlistStockPricePoint value, $Res Function(WatchlistStockPricePoint) _then) = _$WatchlistStockPricePointCopyWithImpl;
@useResult
$Res call({
 String time, double close
});




}
/// @nodoc
class _$WatchlistStockPricePointCopyWithImpl<$Res>
    implements $WatchlistStockPricePointCopyWith<$Res> {
  _$WatchlistStockPricePointCopyWithImpl(this._self, this._then);

  final WatchlistStockPricePoint _self;
  final $Res Function(WatchlistStockPricePoint) _then;

/// Create a copy of WatchlistStockPricePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? close = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistStockPricePoint].
extension WatchlistStockPricePointPatterns on WatchlistStockPricePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistStockPricePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistStockPricePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistStockPricePoint value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPricePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistStockPricePoint value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistStockPricePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String time,  double close)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistStockPricePoint() when $default != null:
return $default(_that.time,_that.close);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String time,  double close)  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPricePoint():
return $default(_that.time,_that.close);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String time,  double close)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistStockPricePoint() when $default != null:
return $default(_that.time,_that.close);case _:
  return null;

}
}

}

/// @nodoc


class _WatchlistStockPricePoint implements WatchlistStockPricePoint {
  const _WatchlistStockPricePoint({required this.time, required this.close});
  

@override final  String time;
@override final  double close;

/// Create a copy of WatchlistStockPricePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistStockPricePointCopyWith<_WatchlistStockPricePoint> get copyWith => __$WatchlistStockPricePointCopyWithImpl<_WatchlistStockPricePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistStockPricePoint&&(identical(other.time, time) || other.time == time)&&(identical(other.close, close) || other.close == close));
}


@override
int get hashCode => Object.hash(runtimeType,time,close);

@override
String toString() {
  return 'WatchlistStockPricePoint(time: $time, close: $close)';
}


}

/// @nodoc
abstract mixin class _$WatchlistStockPricePointCopyWith<$Res> implements $WatchlistStockPricePointCopyWith<$Res> {
  factory _$WatchlistStockPricePointCopyWith(_WatchlistStockPricePoint value, $Res Function(_WatchlistStockPricePoint) _then) = __$WatchlistStockPricePointCopyWithImpl;
@override @useResult
$Res call({
 String time, double close
});




}
/// @nodoc
class __$WatchlistStockPricePointCopyWithImpl<$Res>
    implements _$WatchlistStockPricePointCopyWith<$Res> {
  __$WatchlistStockPricePointCopyWithImpl(this._self, this._then);

  final _WatchlistStockPricePoint _self;
  final $Res Function(_WatchlistStockPricePoint) _then;

/// Create a copy of WatchlistStockPricePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? close = null,}) {
  return _then(_WatchlistStockPricePoint(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
