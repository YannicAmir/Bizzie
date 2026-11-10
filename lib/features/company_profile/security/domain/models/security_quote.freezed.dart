// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityQuote {

 String get ticker; double get price; double? get change; double? get changePercent; String get sessionDate;
/// Create a copy of SecurityQuote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityQuoteCopyWith<SecurityQuote> get copyWith => _$SecurityQuoteCopyWithImpl<SecurityQuote>(this as SecurityQuote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityQuote&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,price,change,changePercent,sessionDate);

@override
String toString() {
  return 'SecurityQuote(ticker: $ticker, price: $price, change: $change, changePercent: $changePercent, sessionDate: $sessionDate)';
}


}

/// @nodoc
abstract mixin class $SecurityQuoteCopyWith<$Res>  {
  factory $SecurityQuoteCopyWith(SecurityQuote value, $Res Function(SecurityQuote) _then) = _$SecurityQuoteCopyWithImpl;
@useResult
$Res call({
 String ticker, double price, double? change, double? changePercent, String sessionDate
});




}
/// @nodoc
class _$SecurityQuoteCopyWithImpl<$Res>
    implements $SecurityQuoteCopyWith<$Res> {
  _$SecurityQuoteCopyWithImpl(this._self, this._then);

  final SecurityQuote _self;
  final $Res Function(SecurityQuote) _then;

/// Create a copy of SecurityQuote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? price = null,Object? change = freezed,Object? changePercent = freezed,Object? sessionDate = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityQuote].
extension SecurityQuotePatterns on SecurityQuote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityQuote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityQuote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityQuote value)  $default,){
final _that = this;
switch (_that) {
case _SecurityQuote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityQuote value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityQuote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  double price,  double? change,  double? changePercent,  String sessionDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityQuote() when $default != null:
return $default(_that.ticker,_that.price,_that.change,_that.changePercent,_that.sessionDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  double price,  double? change,  double? changePercent,  String sessionDate)  $default,) {final _that = this;
switch (_that) {
case _SecurityQuote():
return $default(_that.ticker,_that.price,_that.change,_that.changePercent,_that.sessionDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  double price,  double? change,  double? changePercent,  String sessionDate)?  $default,) {final _that = this;
switch (_that) {
case _SecurityQuote() when $default != null:
return $default(_that.ticker,_that.price,_that.change,_that.changePercent,_that.sessionDate);case _:
  return null;

}
}

}

/// @nodoc


class _SecurityQuote implements SecurityQuote {
  const _SecurityQuote({required this.ticker, required this.price, required this.change, required this.changePercent, required this.sessionDate});
  

@override final  String ticker;
@override final  double price;
@override final  double? change;
@override final  double? changePercent;
@override final  String sessionDate;

/// Create a copy of SecurityQuote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityQuoteCopyWith<_SecurityQuote> get copyWith => __$SecurityQuoteCopyWithImpl<_SecurityQuote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityQuote&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.price, price) || other.price == price)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.sessionDate, sessionDate) || other.sessionDate == sessionDate));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,price,change,changePercent,sessionDate);

@override
String toString() {
  return 'SecurityQuote(ticker: $ticker, price: $price, change: $change, changePercent: $changePercent, sessionDate: $sessionDate)';
}


}

/// @nodoc
abstract mixin class _$SecurityQuoteCopyWith<$Res> implements $SecurityQuoteCopyWith<$Res> {
  factory _$SecurityQuoteCopyWith(_SecurityQuote value, $Res Function(_SecurityQuote) _then) = __$SecurityQuoteCopyWithImpl;
@override @useResult
$Res call({
 String ticker, double price, double? change, double? changePercent, String sessionDate
});




}
/// @nodoc
class __$SecurityQuoteCopyWithImpl<$Res>
    implements _$SecurityQuoteCopyWith<$Res> {
  __$SecurityQuoteCopyWithImpl(this._self, this._then);

  final _SecurityQuote _self;
  final $Res Function(_SecurityQuote) _then;

/// Create a copy of SecurityQuote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? price = null,Object? change = freezed,Object? changePercent = freezed,Object? sessionDate = null,}) {
  return _then(_SecurityQuote(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,change: freezed == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double?,changePercent: freezed == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double?,sessionDate: null == sessionDate ? _self.sessionDate : sessionDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
