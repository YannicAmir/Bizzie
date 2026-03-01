// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shares_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SharesTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get viewedYearlySharesTab; bool get viewedQtrlySharesTab; bool get tappedQtrchartViewAll; bool get tappedYrchartViewAll; bool get tappedQtrtableViewAll; bool get tappedYrtableViewAll;
/// Create a copy of SharesTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharesTabViewStateCopyWith<SharesTabViewState> get copyWith => _$SharesTabViewStateCopyWithImpl<SharesTabViewState>(this as SharesTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharesTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedYearlySharesTab, viewedYearlySharesTab) || other.viewedYearlySharesTab == viewedYearlySharesTab)&&(identical(other.viewedQtrlySharesTab, viewedQtrlySharesTab) || other.viewedQtrlySharesTab == viewedQtrlySharesTab)&&(identical(other.tappedQtrchartViewAll, tappedQtrchartViewAll) || other.tappedQtrchartViewAll == tappedQtrchartViewAll)&&(identical(other.tappedYrchartViewAll, tappedYrchartViewAll) || other.tappedYrchartViewAll == tappedYrchartViewAll)&&(identical(other.tappedQtrtableViewAll, tappedQtrtableViewAll) || other.tappedQtrtableViewAll == tappedQtrtableViewAll)&&(identical(other.tappedYrtableViewAll, tappedYrtableViewAll) || other.tappedYrtableViewAll == tappedYrtableViewAll));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedYearlySharesTab,viewedQtrlySharesTab,tappedQtrchartViewAll,tappedYrchartViewAll,tappedQtrtableViewAll,tappedYrtableViewAll);

@override
String toString() {
  return 'SharesTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedYearlySharesTab: $viewedYearlySharesTab, viewedQtrlySharesTab: $viewedQtrlySharesTab, tappedQtrchartViewAll: $tappedQtrchartViewAll, tappedYrchartViewAll: $tappedYrchartViewAll, tappedQtrtableViewAll: $tappedQtrtableViewAll, tappedYrtableViewAll: $tappedYrtableViewAll)';
}


}

/// @nodoc
abstract mixin class $SharesTabViewStateCopyWith<$Res>  {
  factory $SharesTabViewStateCopyWith(SharesTabViewState value, $Res Function(SharesTabViewState) _then) = _$SharesTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedYearlySharesTab, bool viewedQtrlySharesTab, bool tappedQtrchartViewAll, bool tappedYrchartViewAll, bool tappedQtrtableViewAll, bool tappedYrtableViewAll
});




}
/// @nodoc
class _$SharesTabViewStateCopyWithImpl<$Res>
    implements $SharesTabViewStateCopyWith<$Res> {
  _$SharesTabViewStateCopyWithImpl(this._self, this._then);

  final SharesTabViewState _self;
  final $Res Function(SharesTabViewState) _then;

/// Create a copy of SharesTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedYearlySharesTab = null,Object? viewedQtrlySharesTab = null,Object? tappedQtrchartViewAll = null,Object? tappedYrchartViewAll = null,Object? tappedQtrtableViewAll = null,Object? tappedYrtableViewAll = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedYearlySharesTab: null == viewedYearlySharesTab ? _self.viewedYearlySharesTab : viewedYearlySharesTab // ignore: cast_nullable_to_non_nullable
as bool,viewedQtrlySharesTab: null == viewedQtrlySharesTab ? _self.viewedQtrlySharesTab : viewedQtrlySharesTab // ignore: cast_nullable_to_non_nullable
as bool,tappedQtrchartViewAll: null == tappedQtrchartViewAll ? _self.tappedQtrchartViewAll : tappedQtrchartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedYrchartViewAll: null == tappedYrchartViewAll ? _self.tappedYrchartViewAll : tappedYrchartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedQtrtableViewAll: null == tappedQtrtableViewAll ? _self.tappedQtrtableViewAll : tappedQtrtableViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedYrtableViewAll: null == tappedYrtableViewAll ? _self.tappedYrtableViewAll : tappedYrtableViewAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SharesTabViewState].
extension SharesTabViewStatePatterns on SharesTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharesTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharesTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharesTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _SharesTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharesTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _SharesTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySharesTab,  bool viewedQtrlySharesTab,  bool tappedQtrchartViewAll,  bool tappedYrchartViewAll,  bool tappedQtrtableViewAll,  bool tappedYrtableViewAll)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharesTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySharesTab,_that.viewedQtrlySharesTab,_that.tappedQtrchartViewAll,_that.tappedYrchartViewAll,_that.tappedQtrtableViewAll,_that.tappedYrtableViewAll);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySharesTab,  bool viewedQtrlySharesTab,  bool tappedQtrchartViewAll,  bool tappedYrchartViewAll,  bool tappedQtrtableViewAll,  bool tappedYrtableViewAll)  $default,) {final _that = this;
switch (_that) {
case _SharesTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySharesTab,_that.viewedQtrlySharesTab,_that.tappedQtrchartViewAll,_that.tappedYrchartViewAll,_that.tappedQtrtableViewAll,_that.tappedYrtableViewAll);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySharesTab,  bool viewedQtrlySharesTab,  bool tappedQtrchartViewAll,  bool tappedYrchartViewAll,  bool tappedQtrtableViewAll,  bool tappedYrtableViewAll)?  $default,) {final _that = this;
switch (_that) {
case _SharesTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySharesTab,_that.viewedQtrlySharesTab,_that.tappedQtrchartViewAll,_that.tappedYrchartViewAll,_that.tappedQtrtableViewAll,_that.tappedYrtableViewAll);case _:
  return null;

}
}

}

/// @nodoc


class _SharesTabViewState extends SharesTabViewState {
  const _SharesTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.viewedYearlySharesTab = false, this.viewedQtrlySharesTab = false, this.tappedQtrchartViewAll = false, this.tappedYrchartViewAll = false, this.tappedQtrtableViewAll = false, this.tappedYrtableViewAll = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool viewedYearlySharesTab;
@override@JsonKey() final  bool viewedQtrlySharesTab;
@override@JsonKey() final  bool tappedQtrchartViewAll;
@override@JsonKey() final  bool tappedYrchartViewAll;
@override@JsonKey() final  bool tappedQtrtableViewAll;
@override@JsonKey() final  bool tappedYrtableViewAll;

/// Create a copy of SharesTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharesTabViewStateCopyWith<_SharesTabViewState> get copyWith => __$SharesTabViewStateCopyWithImpl<_SharesTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharesTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedYearlySharesTab, viewedYearlySharesTab) || other.viewedYearlySharesTab == viewedYearlySharesTab)&&(identical(other.viewedQtrlySharesTab, viewedQtrlySharesTab) || other.viewedQtrlySharesTab == viewedQtrlySharesTab)&&(identical(other.tappedQtrchartViewAll, tappedQtrchartViewAll) || other.tappedQtrchartViewAll == tappedQtrchartViewAll)&&(identical(other.tappedYrchartViewAll, tappedYrchartViewAll) || other.tappedYrchartViewAll == tappedYrchartViewAll)&&(identical(other.tappedQtrtableViewAll, tappedQtrtableViewAll) || other.tappedQtrtableViewAll == tappedQtrtableViewAll)&&(identical(other.tappedYrtableViewAll, tappedYrtableViewAll) || other.tappedYrtableViewAll == tappedYrtableViewAll));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedYearlySharesTab,viewedQtrlySharesTab,tappedQtrchartViewAll,tappedYrchartViewAll,tappedQtrtableViewAll,tappedYrtableViewAll);

@override
String toString() {
  return 'SharesTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedYearlySharesTab: $viewedYearlySharesTab, viewedQtrlySharesTab: $viewedQtrlySharesTab, tappedQtrchartViewAll: $tappedQtrchartViewAll, tappedYrchartViewAll: $tappedYrchartViewAll, tappedQtrtableViewAll: $tappedQtrtableViewAll, tappedYrtableViewAll: $tappedYrtableViewAll)';
}


}

/// @nodoc
abstract mixin class _$SharesTabViewStateCopyWith<$Res> implements $SharesTabViewStateCopyWith<$Res> {
  factory _$SharesTabViewStateCopyWith(_SharesTabViewState value, $Res Function(_SharesTabViewState) _then) = __$SharesTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedYearlySharesTab, bool viewedQtrlySharesTab, bool tappedQtrchartViewAll, bool tappedYrchartViewAll, bool tappedQtrtableViewAll, bool tappedYrtableViewAll
});




}
/// @nodoc
class __$SharesTabViewStateCopyWithImpl<$Res>
    implements _$SharesTabViewStateCopyWith<$Res> {
  __$SharesTabViewStateCopyWithImpl(this._self, this._then);

  final _SharesTabViewState _self;
  final $Res Function(_SharesTabViewState) _then;

/// Create a copy of SharesTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedYearlySharesTab = null,Object? viewedQtrlySharesTab = null,Object? tappedQtrchartViewAll = null,Object? tappedYrchartViewAll = null,Object? tappedQtrtableViewAll = null,Object? tappedYrtableViewAll = null,}) {
  return _then(_SharesTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedYearlySharesTab: null == viewedYearlySharesTab ? _self.viewedYearlySharesTab : viewedYearlySharesTab // ignore: cast_nullable_to_non_nullable
as bool,viewedQtrlySharesTab: null == viewedQtrlySharesTab ? _self.viewedQtrlySharesTab : viewedQtrlySharesTab // ignore: cast_nullable_to_non_nullable
as bool,tappedQtrchartViewAll: null == tappedQtrchartViewAll ? _self.tappedQtrchartViewAll : tappedQtrchartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedYrchartViewAll: null == tappedYrchartViewAll ? _self.tappedYrchartViewAll : tappedYrchartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedQtrtableViewAll: null == tappedQtrtableViewAll ? _self.tappedQtrtableViewAll : tappedQtrtableViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedYrtableViewAll: null == tappedYrtableViewAll ? _self.tappedYrtableViewAll : tappedYrtableViewAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
