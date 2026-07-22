// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ytd_price_change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$YtdPriceChange {

 String get ticker; String get companyName; int get year; String get baselineDate; double get baselineClose; String get latestDate; double get latestClose; double get ytdChange; double get ytdChangePercent;
/// Create a copy of YtdPriceChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YtdPriceChangeCopyWith<YtdPriceChange> get copyWith => _$YtdPriceChangeCopyWithImpl<YtdPriceChange>(this as YtdPriceChange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YtdPriceChange&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.year, year) || other.year == year)&&(identical(other.baselineDate, baselineDate) || other.baselineDate == baselineDate)&&(identical(other.baselineClose, baselineClose) || other.baselineClose == baselineClose)&&(identical(other.latestDate, latestDate) || other.latestDate == latestDate)&&(identical(other.latestClose, latestClose) || other.latestClose == latestClose)&&(identical(other.ytdChange, ytdChange) || other.ytdChange == ytdChange)&&(identical(other.ytdChangePercent, ytdChangePercent) || other.ytdChangePercent == ytdChangePercent));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,year,baselineDate,baselineClose,latestDate,latestClose,ytdChange,ytdChangePercent);

@override
String toString() {
  return 'YtdPriceChange(ticker: $ticker, companyName: $companyName, year: $year, baselineDate: $baselineDate, baselineClose: $baselineClose, latestDate: $latestDate, latestClose: $latestClose, ytdChange: $ytdChange, ytdChangePercent: $ytdChangePercent)';
}


}

/// @nodoc
abstract mixin class $YtdPriceChangeCopyWith<$Res>  {
  factory $YtdPriceChangeCopyWith(YtdPriceChange value, $Res Function(YtdPriceChange) _then) = _$YtdPriceChangeCopyWithImpl;
@useResult
$Res call({
 String ticker, String companyName, int year, String baselineDate, double baselineClose, String latestDate, double latestClose, double ytdChange, double ytdChangePercent
});




}
/// @nodoc
class _$YtdPriceChangeCopyWithImpl<$Res>
    implements $YtdPriceChangeCopyWith<$Res> {
  _$YtdPriceChangeCopyWithImpl(this._self, this._then);

  final YtdPriceChange _self;
  final $Res Function(YtdPriceChange) _then;

/// Create a copy of YtdPriceChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? companyName = null,Object? year = null,Object? baselineDate = null,Object? baselineClose = null,Object? latestDate = null,Object? latestClose = null,Object? ytdChange = null,Object? ytdChangePercent = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,baselineDate: null == baselineDate ? _self.baselineDate : baselineDate // ignore: cast_nullable_to_non_nullable
as String,baselineClose: null == baselineClose ? _self.baselineClose : baselineClose // ignore: cast_nullable_to_non_nullable
as double,latestDate: null == latestDate ? _self.latestDate : latestDate // ignore: cast_nullable_to_non_nullable
as String,latestClose: null == latestClose ? _self.latestClose : latestClose // ignore: cast_nullable_to_non_nullable
as double,ytdChange: null == ytdChange ? _self.ytdChange : ytdChange // ignore: cast_nullable_to_non_nullable
as double,ytdChangePercent: null == ytdChangePercent ? _self.ytdChangePercent : ytdChangePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [YtdPriceChange].
extension YtdPriceChangePatterns on YtdPriceChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _YtdPriceChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _YtdPriceChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _YtdPriceChange value)  $default,){
final _that = this;
switch (_that) {
case _YtdPriceChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _YtdPriceChange value)?  $default,){
final _that = this;
switch (_that) {
case _YtdPriceChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String companyName,  int year,  String baselineDate,  double baselineClose,  String latestDate,  double latestClose,  double ytdChange,  double ytdChangePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _YtdPriceChange() when $default != null:
return $default(_that.ticker,_that.companyName,_that.year,_that.baselineDate,_that.baselineClose,_that.latestDate,_that.latestClose,_that.ytdChange,_that.ytdChangePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String companyName,  int year,  String baselineDate,  double baselineClose,  String latestDate,  double latestClose,  double ytdChange,  double ytdChangePercent)  $default,) {final _that = this;
switch (_that) {
case _YtdPriceChange():
return $default(_that.ticker,_that.companyName,_that.year,_that.baselineDate,_that.baselineClose,_that.latestDate,_that.latestClose,_that.ytdChange,_that.ytdChangePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String companyName,  int year,  String baselineDate,  double baselineClose,  String latestDate,  double latestClose,  double ytdChange,  double ytdChangePercent)?  $default,) {final _that = this;
switch (_that) {
case _YtdPriceChange() when $default != null:
return $default(_that.ticker,_that.companyName,_that.year,_that.baselineDate,_that.baselineClose,_that.latestDate,_that.latestClose,_that.ytdChange,_that.ytdChangePercent);case _:
  return null;

}
}

}

/// @nodoc


class _YtdPriceChange implements YtdPriceChange {
  const _YtdPriceChange({required this.ticker, required this.companyName, required this.year, required this.baselineDate, required this.baselineClose, required this.latestDate, required this.latestClose, required this.ytdChange, required this.ytdChangePercent});
  

@override final  String ticker;
@override final  String companyName;
@override final  int year;
@override final  String baselineDate;
@override final  double baselineClose;
@override final  String latestDate;
@override final  double latestClose;
@override final  double ytdChange;
@override final  double ytdChangePercent;

/// Create a copy of YtdPriceChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$YtdPriceChangeCopyWith<_YtdPriceChange> get copyWith => __$YtdPriceChangeCopyWithImpl<_YtdPriceChange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _YtdPriceChange&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.year, year) || other.year == year)&&(identical(other.baselineDate, baselineDate) || other.baselineDate == baselineDate)&&(identical(other.baselineClose, baselineClose) || other.baselineClose == baselineClose)&&(identical(other.latestDate, latestDate) || other.latestDate == latestDate)&&(identical(other.latestClose, latestClose) || other.latestClose == latestClose)&&(identical(other.ytdChange, ytdChange) || other.ytdChange == ytdChange)&&(identical(other.ytdChangePercent, ytdChangePercent) || other.ytdChangePercent == ytdChangePercent));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,companyName,year,baselineDate,baselineClose,latestDate,latestClose,ytdChange,ytdChangePercent);

@override
String toString() {
  return 'YtdPriceChange(ticker: $ticker, companyName: $companyName, year: $year, baselineDate: $baselineDate, baselineClose: $baselineClose, latestDate: $latestDate, latestClose: $latestClose, ytdChange: $ytdChange, ytdChangePercent: $ytdChangePercent)';
}


}

/// @nodoc
abstract mixin class _$YtdPriceChangeCopyWith<$Res> implements $YtdPriceChangeCopyWith<$Res> {
  factory _$YtdPriceChangeCopyWith(_YtdPriceChange value, $Res Function(_YtdPriceChange) _then) = __$YtdPriceChangeCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String companyName, int year, String baselineDate, double baselineClose, String latestDate, double latestClose, double ytdChange, double ytdChangePercent
});




}
/// @nodoc
class __$YtdPriceChangeCopyWithImpl<$Res>
    implements _$YtdPriceChangeCopyWith<$Res> {
  __$YtdPriceChangeCopyWithImpl(this._self, this._then);

  final _YtdPriceChange _self;
  final $Res Function(_YtdPriceChange) _then;

/// Create a copy of YtdPriceChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? companyName = null,Object? year = null,Object? baselineDate = null,Object? baselineClose = null,Object? latestDate = null,Object? latestClose = null,Object? ytdChange = null,Object? ytdChangePercent = null,}) {
  return _then(_YtdPriceChange(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,baselineDate: null == baselineDate ? _self.baselineDate : baselineDate // ignore: cast_nullable_to_non_nullable
as String,baselineClose: null == baselineClose ? _self.baselineClose : baselineClose // ignore: cast_nullable_to_non_nullable
as double,latestDate: null == latestDate ? _self.latestDate : latestDate // ignore: cast_nullable_to_non_nullable
as String,latestClose: null == latestClose ? _self.latestClose : latestClose // ignore: cast_nullable_to_non_nullable
as double,ytdChange: null == ytdChange ? _self.ytdChange : ytdChange // ignore: cast_nullable_to_non_nullable
as double,ytdChangePercent: null == ytdChangePercent ? _self.ytdChangePercent : ytdChangePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
