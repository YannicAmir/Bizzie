// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_stmt_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CashStmtTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get viewedCashFlowTab; bool get tappedAllCashflYrly; bool get tappedAllCashflQtrly; bool get switchedCashflYear; bool get switchedCashflQtr;
/// Create a copy of CashStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashStmtTabViewStateCopyWith<CashStmtTabViewState> get copyWith => _$CashStmtTabViewStateCopyWithImpl<CashStmtTabViewState>(this as CashStmtTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashStmtTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedCashFlowTab, viewedCashFlowTab) || other.viewedCashFlowTab == viewedCashFlowTab)&&(identical(other.tappedAllCashflYrly, tappedAllCashflYrly) || other.tappedAllCashflYrly == tappedAllCashflYrly)&&(identical(other.tappedAllCashflQtrly, tappedAllCashflQtrly) || other.tappedAllCashflQtrly == tappedAllCashflQtrly)&&(identical(other.switchedCashflYear, switchedCashflYear) || other.switchedCashflYear == switchedCashflYear)&&(identical(other.switchedCashflQtr, switchedCashflQtr) || other.switchedCashflQtr == switchedCashflQtr));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedCashFlowTab,tappedAllCashflYrly,tappedAllCashflQtrly,switchedCashflYear,switchedCashflQtr);

@override
String toString() {
  return 'CashStmtTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedCashFlowTab: $viewedCashFlowTab, tappedAllCashflYrly: $tappedAllCashflYrly, tappedAllCashflQtrly: $tappedAllCashflQtrly, switchedCashflYear: $switchedCashflYear, switchedCashflQtr: $switchedCashflQtr)';
}


}

/// @nodoc
abstract mixin class $CashStmtTabViewStateCopyWith<$Res>  {
  factory $CashStmtTabViewStateCopyWith(CashStmtTabViewState value, $Res Function(CashStmtTabViewState) _then) = _$CashStmtTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedCashFlowTab, bool tappedAllCashflYrly, bool tappedAllCashflQtrly, bool switchedCashflYear, bool switchedCashflQtr
});




}
/// @nodoc
class _$CashStmtTabViewStateCopyWithImpl<$Res>
    implements $CashStmtTabViewStateCopyWith<$Res> {
  _$CashStmtTabViewStateCopyWithImpl(this._self, this._then);

  final CashStmtTabViewState _self;
  final $Res Function(CashStmtTabViewState) _then;

/// Create a copy of CashStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedCashFlowTab = null,Object? tappedAllCashflYrly = null,Object? tappedAllCashflQtrly = null,Object? switchedCashflYear = null,Object? switchedCashflQtr = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedCashFlowTab: null == viewedCashFlowTab ? _self.viewedCashFlowTab : viewedCashFlowTab // ignore: cast_nullable_to_non_nullable
as bool,tappedAllCashflYrly: null == tappedAllCashflYrly ? _self.tappedAllCashflYrly : tappedAllCashflYrly // ignore: cast_nullable_to_non_nullable
as bool,tappedAllCashflQtrly: null == tappedAllCashflQtrly ? _self.tappedAllCashflQtrly : tappedAllCashflQtrly // ignore: cast_nullable_to_non_nullable
as bool,switchedCashflYear: null == switchedCashflYear ? _self.switchedCashflYear : switchedCashflYear // ignore: cast_nullable_to_non_nullable
as bool,switchedCashflQtr: null == switchedCashflQtr ? _self.switchedCashflQtr : switchedCashflQtr // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CashStmtTabViewState].
extension CashStmtTabViewStatePatterns on CashStmtTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashStmtTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashStmtTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashStmtTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _CashStmtTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashStmtTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _CashStmtTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedCashFlowTab,  bool tappedAllCashflYrly,  bool tappedAllCashflQtrly,  bool switchedCashflYear,  bool switchedCashflQtr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashStmtTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedCashFlowTab,_that.tappedAllCashflYrly,_that.tappedAllCashflQtrly,_that.switchedCashflYear,_that.switchedCashflQtr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedCashFlowTab,  bool tappedAllCashflYrly,  bool tappedAllCashflQtrly,  bool switchedCashflYear,  bool switchedCashflQtr)  $default,) {final _that = this;
switch (_that) {
case _CashStmtTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedCashFlowTab,_that.tappedAllCashflYrly,_that.tappedAllCashflQtrly,_that.switchedCashflYear,_that.switchedCashflQtr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedCashFlowTab,  bool tappedAllCashflYrly,  bool tappedAllCashflQtrly,  bool switchedCashflYear,  bool switchedCashflQtr)?  $default,) {final _that = this;
switch (_that) {
case _CashStmtTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedCashFlowTab,_that.tappedAllCashflYrly,_that.tappedAllCashflQtrly,_that.switchedCashflYear,_that.switchedCashflQtr);case _:
  return null;

}
}

}

/// @nodoc


class _CashStmtTabViewState extends CashStmtTabViewState {
  const _CashStmtTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.viewedCashFlowTab = false, this.tappedAllCashflYrly = false, this.tappedAllCashflQtrly = false, this.switchedCashflYear = false, this.switchedCashflQtr = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool viewedCashFlowTab;
@override@JsonKey() final  bool tappedAllCashflYrly;
@override@JsonKey() final  bool tappedAllCashflQtrly;
@override@JsonKey() final  bool switchedCashflYear;
@override@JsonKey() final  bool switchedCashflQtr;

/// Create a copy of CashStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashStmtTabViewStateCopyWith<_CashStmtTabViewState> get copyWith => __$CashStmtTabViewStateCopyWithImpl<_CashStmtTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashStmtTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedCashFlowTab, viewedCashFlowTab) || other.viewedCashFlowTab == viewedCashFlowTab)&&(identical(other.tappedAllCashflYrly, tappedAllCashflYrly) || other.tappedAllCashflYrly == tappedAllCashflYrly)&&(identical(other.tappedAllCashflQtrly, tappedAllCashflQtrly) || other.tappedAllCashflQtrly == tappedAllCashflQtrly)&&(identical(other.switchedCashflYear, switchedCashflYear) || other.switchedCashflYear == switchedCashflYear)&&(identical(other.switchedCashflQtr, switchedCashflQtr) || other.switchedCashflQtr == switchedCashflQtr));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedCashFlowTab,tappedAllCashflYrly,tappedAllCashflQtrly,switchedCashflYear,switchedCashflQtr);

@override
String toString() {
  return 'CashStmtTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedCashFlowTab: $viewedCashFlowTab, tappedAllCashflYrly: $tappedAllCashflYrly, tappedAllCashflQtrly: $tappedAllCashflQtrly, switchedCashflYear: $switchedCashflYear, switchedCashflQtr: $switchedCashflQtr)';
}


}

/// @nodoc
abstract mixin class _$CashStmtTabViewStateCopyWith<$Res> implements $CashStmtTabViewStateCopyWith<$Res> {
  factory _$CashStmtTabViewStateCopyWith(_CashStmtTabViewState value, $Res Function(_CashStmtTabViewState) _then) = __$CashStmtTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedCashFlowTab, bool tappedAllCashflYrly, bool tappedAllCashflQtrly, bool switchedCashflYear, bool switchedCashflQtr
});




}
/// @nodoc
class __$CashStmtTabViewStateCopyWithImpl<$Res>
    implements _$CashStmtTabViewStateCopyWith<$Res> {
  __$CashStmtTabViewStateCopyWithImpl(this._self, this._then);

  final _CashStmtTabViewState _self;
  final $Res Function(_CashStmtTabViewState) _then;

/// Create a copy of CashStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedCashFlowTab = null,Object? tappedAllCashflYrly = null,Object? tappedAllCashflQtrly = null,Object? switchedCashflYear = null,Object? switchedCashflQtr = null,}) {
  return _then(_CashStmtTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedCashFlowTab: null == viewedCashFlowTab ? _self.viewedCashFlowTab : viewedCashFlowTab // ignore: cast_nullable_to_non_nullable
as bool,tappedAllCashflYrly: null == tappedAllCashflYrly ? _self.tappedAllCashflYrly : tappedAllCashflYrly // ignore: cast_nullable_to_non_nullable
as bool,tappedAllCashflQtrly: null == tappedAllCashflQtrly ? _self.tappedAllCashflQtrly : tappedAllCashflQtrly // ignore: cast_nullable_to_non_nullable
as bool,switchedCashflYear: null == switchedCashflYear ? _self.switchedCashflYear : switchedCashflYear // ignore: cast_nullable_to_non_nullable
as bool,switchedCashflQtr: null == switchedCashflQtr ? _self.switchedCashflQtr : switchedCashflQtr // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
