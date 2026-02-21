// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_tab_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityTabViewState {

 String get ticker; String get securityType; int? get loadTimeMs; int? get priceLoadMs; bool get isSuccess; bool get isPriceSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get hasUpcomingEarnings; String? get earningsDaysAway; int get priceChartChangeCount; String get finalPriceTimeframe;
/// Create a copy of SecurityTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityTabViewStateCopyWith<SecurityTabViewState> get copyWith => _$SecurityTabViewStateCopyWithImpl<SecurityTabViewState>(this as SecurityTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.securityType, securityType) || other.securityType == securityType)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.priceLoadMs, priceLoadMs) || other.priceLoadMs == priceLoadMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isPriceSuccess, isPriceSuccess) || other.isPriceSuccess == isPriceSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.hasUpcomingEarnings, hasUpcomingEarnings) || other.hasUpcomingEarnings == hasUpcomingEarnings)&&(identical(other.earningsDaysAway, earningsDaysAway) || other.earningsDaysAway == earningsDaysAway)&&(identical(other.priceChartChangeCount, priceChartChangeCount) || other.priceChartChangeCount == priceChartChangeCount)&&(identical(other.finalPriceTimeframe, finalPriceTimeframe) || other.finalPriceTimeframe == finalPriceTimeframe));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,securityType,loadTimeMs,priceLoadMs,isSuccess,isPriceSuccess,dataSource,viewDurationSec,hasUpcomingEarnings,earningsDaysAway,priceChartChangeCount,finalPriceTimeframe);

@override
String toString() {
  return 'SecurityTabViewState(ticker: $ticker, securityType: $securityType, loadTimeMs: $loadTimeMs, priceLoadMs: $priceLoadMs, isSuccess: $isSuccess, isPriceSuccess: $isPriceSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, hasUpcomingEarnings: $hasUpcomingEarnings, earningsDaysAway: $earningsDaysAway, priceChartChangeCount: $priceChartChangeCount, finalPriceTimeframe: $finalPriceTimeframe)';
}


}

/// @nodoc
abstract mixin class $SecurityTabViewStateCopyWith<$Res>  {
  factory $SecurityTabViewStateCopyWith(SecurityTabViewState value, $Res Function(SecurityTabViewState) _then) = _$SecurityTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String securityType, int? loadTimeMs, int? priceLoadMs, bool isSuccess, bool isPriceSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool hasUpcomingEarnings, String? earningsDaysAway, int priceChartChangeCount, String finalPriceTimeframe
});




}
/// @nodoc
class _$SecurityTabViewStateCopyWithImpl<$Res>
    implements $SecurityTabViewStateCopyWith<$Res> {
  _$SecurityTabViewStateCopyWithImpl(this._self, this._then);

  final SecurityTabViewState _self;
  final $Res Function(SecurityTabViewState) _then;

/// Create a copy of SecurityTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? securityType = null,Object? loadTimeMs = freezed,Object? priceLoadMs = freezed,Object? isSuccess = null,Object? isPriceSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? hasUpcomingEarnings = null,Object? earningsDaysAway = freezed,Object? priceChartChangeCount = null,Object? finalPriceTimeframe = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,securityType: null == securityType ? _self.securityType : securityType // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,priceLoadMs: freezed == priceLoadMs ? _self.priceLoadMs : priceLoadMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isPriceSuccess: null == isPriceSuccess ? _self.isPriceSuccess : isPriceSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,hasUpcomingEarnings: null == hasUpcomingEarnings ? _self.hasUpcomingEarnings : hasUpcomingEarnings // ignore: cast_nullable_to_non_nullable
as bool,earningsDaysAway: freezed == earningsDaysAway ? _self.earningsDaysAway : earningsDaysAway // ignore: cast_nullable_to_non_nullable
as String?,priceChartChangeCount: null == priceChartChangeCount ? _self.priceChartChangeCount : priceChartChangeCount // ignore: cast_nullable_to_non_nullable
as int,finalPriceTimeframe: null == finalPriceTimeframe ? _self.finalPriceTimeframe : finalPriceTimeframe // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityTabViewState].
extension SecurityTabViewStatePatterns on SecurityTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _SecurityTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String securityType,  int? loadTimeMs,  int? priceLoadMs,  bool isSuccess,  bool isPriceSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool hasUpcomingEarnings,  String? earningsDaysAway,  int priceChartChangeCount,  String finalPriceTimeframe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityTabViewState() when $default != null:
return $default(_that.ticker,_that.securityType,_that.loadTimeMs,_that.priceLoadMs,_that.isSuccess,_that.isPriceSuccess,_that.dataSource,_that.viewDurationSec,_that.hasUpcomingEarnings,_that.earningsDaysAway,_that.priceChartChangeCount,_that.finalPriceTimeframe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String securityType,  int? loadTimeMs,  int? priceLoadMs,  bool isSuccess,  bool isPriceSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool hasUpcomingEarnings,  String? earningsDaysAway,  int priceChartChangeCount,  String finalPriceTimeframe)  $default,) {final _that = this;
switch (_that) {
case _SecurityTabViewState():
return $default(_that.ticker,_that.securityType,_that.loadTimeMs,_that.priceLoadMs,_that.isSuccess,_that.isPriceSuccess,_that.dataSource,_that.viewDurationSec,_that.hasUpcomingEarnings,_that.earningsDaysAway,_that.priceChartChangeCount,_that.finalPriceTimeframe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String securityType,  int? loadTimeMs,  int? priceLoadMs,  bool isSuccess,  bool isPriceSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool hasUpcomingEarnings,  String? earningsDaysAway,  int priceChartChangeCount,  String finalPriceTimeframe)?  $default,) {final _that = this;
switch (_that) {
case _SecurityTabViewState() when $default != null:
return $default(_that.ticker,_that.securityType,_that.loadTimeMs,_that.priceLoadMs,_that.isSuccess,_that.isPriceSuccess,_that.dataSource,_that.viewDurationSec,_that.hasUpcomingEarnings,_that.earningsDaysAway,_that.priceChartChangeCount,_that.finalPriceTimeframe);case _:
  return null;

}
}

}

/// @nodoc


class _SecurityTabViewState implements SecurityTabViewState {
  const _SecurityTabViewState({required this.ticker, required this.securityType, this.loadTimeMs, this.priceLoadMs, this.isSuccess = false, this.isPriceSuccess = false, this.dataSource, this.viewDurationSec = 0, this.hasUpcomingEarnings = false, this.earningsDaysAway, this.priceChartChangeCount = 0, this.finalPriceTimeframe = '1D'});
  

@override final  String ticker;
@override final  String securityType;
@override final  int? loadTimeMs;
@override final  int? priceLoadMs;
@override@JsonKey() final  bool isSuccess;
@override@JsonKey() final  bool isPriceSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool hasUpcomingEarnings;
@override final  String? earningsDaysAway;
@override@JsonKey() final  int priceChartChangeCount;
@override@JsonKey() final  String finalPriceTimeframe;

/// Create a copy of SecurityTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityTabViewStateCopyWith<_SecurityTabViewState> get copyWith => __$SecurityTabViewStateCopyWithImpl<_SecurityTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.securityType, securityType) || other.securityType == securityType)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.priceLoadMs, priceLoadMs) || other.priceLoadMs == priceLoadMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.isPriceSuccess, isPriceSuccess) || other.isPriceSuccess == isPriceSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.hasUpcomingEarnings, hasUpcomingEarnings) || other.hasUpcomingEarnings == hasUpcomingEarnings)&&(identical(other.earningsDaysAway, earningsDaysAway) || other.earningsDaysAway == earningsDaysAway)&&(identical(other.priceChartChangeCount, priceChartChangeCount) || other.priceChartChangeCount == priceChartChangeCount)&&(identical(other.finalPriceTimeframe, finalPriceTimeframe) || other.finalPriceTimeframe == finalPriceTimeframe));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,securityType,loadTimeMs,priceLoadMs,isSuccess,isPriceSuccess,dataSource,viewDurationSec,hasUpcomingEarnings,earningsDaysAway,priceChartChangeCount,finalPriceTimeframe);

@override
String toString() {
  return 'SecurityTabViewState(ticker: $ticker, securityType: $securityType, loadTimeMs: $loadTimeMs, priceLoadMs: $priceLoadMs, isSuccess: $isSuccess, isPriceSuccess: $isPriceSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, hasUpcomingEarnings: $hasUpcomingEarnings, earningsDaysAway: $earningsDaysAway, priceChartChangeCount: $priceChartChangeCount, finalPriceTimeframe: $finalPriceTimeframe)';
}


}

/// @nodoc
abstract mixin class _$SecurityTabViewStateCopyWith<$Res> implements $SecurityTabViewStateCopyWith<$Res> {
  factory _$SecurityTabViewStateCopyWith(_SecurityTabViewState value, $Res Function(_SecurityTabViewState) _then) = __$SecurityTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String securityType, int? loadTimeMs, int? priceLoadMs, bool isSuccess, bool isPriceSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool hasUpcomingEarnings, String? earningsDaysAway, int priceChartChangeCount, String finalPriceTimeframe
});




}
/// @nodoc
class __$SecurityTabViewStateCopyWithImpl<$Res>
    implements _$SecurityTabViewStateCopyWith<$Res> {
  __$SecurityTabViewStateCopyWithImpl(this._self, this._then);

  final _SecurityTabViewState _self;
  final $Res Function(_SecurityTabViewState) _then;

/// Create a copy of SecurityTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? securityType = null,Object? loadTimeMs = freezed,Object? priceLoadMs = freezed,Object? isSuccess = null,Object? isPriceSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? hasUpcomingEarnings = null,Object? earningsDaysAway = freezed,Object? priceChartChangeCount = null,Object? finalPriceTimeframe = null,}) {
  return _then(_SecurityTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,securityType: null == securityType ? _self.securityType : securityType // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,priceLoadMs: freezed == priceLoadMs ? _self.priceLoadMs : priceLoadMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,isPriceSuccess: null == isPriceSuccess ? _self.isPriceSuccess : isPriceSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,hasUpcomingEarnings: null == hasUpcomingEarnings ? _self.hasUpcomingEarnings : hasUpcomingEarnings // ignore: cast_nullable_to_non_nullable
as bool,earningsDaysAway: freezed == earningsDaysAway ? _self.earningsDaysAway : earningsDaysAway // ignore: cast_nullable_to_non_nullable
as String?,priceChartChangeCount: null == priceChartChangeCount ? _self.priceChartChangeCount : priceChartChangeCount // ignore: cast_nullable_to_non_nullable
as int,finalPriceTimeframe: null == finalPriceTimeframe ? _self.finalPriceTimeframe : finalPriceTimeframe // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
