// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dividend_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DividendTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get tappedChartViewAll; bool get tappedTableViewAll;
/// Create a copy of DividendTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DividendTabViewStateCopyWith<DividendTabViewState> get copyWith => _$DividendTabViewStateCopyWithImpl<DividendTabViewState>(this as DividendTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DividendTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.tappedChartViewAll, tappedChartViewAll) || other.tappedChartViewAll == tappedChartViewAll)&&(identical(other.tappedTableViewAll, tappedTableViewAll) || other.tappedTableViewAll == tappedTableViewAll));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,tappedChartViewAll,tappedTableViewAll);

@override
String toString() {
  return 'DividendTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, tappedChartViewAll: $tappedChartViewAll, tappedTableViewAll: $tappedTableViewAll)';
}


}

/// @nodoc
abstract mixin class $DividendTabViewStateCopyWith<$Res>  {
  factory $DividendTabViewStateCopyWith(DividendTabViewState value, $Res Function(DividendTabViewState) _then) = _$DividendTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool tappedChartViewAll, bool tappedTableViewAll
});




}
/// @nodoc
class _$DividendTabViewStateCopyWithImpl<$Res>
    implements $DividendTabViewStateCopyWith<$Res> {
  _$DividendTabViewStateCopyWithImpl(this._self, this._then);

  final DividendTabViewState _self;
  final $Res Function(DividendTabViewState) _then;

/// Create a copy of DividendTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? tappedChartViewAll = null,Object? tappedTableViewAll = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,tappedChartViewAll: null == tappedChartViewAll ? _self.tappedChartViewAll : tappedChartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedTableViewAll: null == tappedTableViewAll ? _self.tappedTableViewAll : tappedTableViewAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DividendTabViewState].
extension DividendTabViewStatePatterns on DividendTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DividendTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DividendTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DividendTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _DividendTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DividendTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _DividendTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedChartViewAll,  bool tappedTableViewAll)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DividendTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedChartViewAll,_that.tappedTableViewAll);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedChartViewAll,  bool tappedTableViewAll)  $default,) {final _that = this;
switch (_that) {
case _DividendTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedChartViewAll,_that.tappedTableViewAll);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedChartViewAll,  bool tappedTableViewAll)?  $default,) {final _that = this;
switch (_that) {
case _DividendTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedChartViewAll,_that.tappedTableViewAll);case _:
  return null;

}
}

}

/// @nodoc


class _DividendTabViewState extends DividendTabViewState {
  const _DividendTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.tappedChartViewAll = false, this.tappedTableViewAll = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool tappedChartViewAll;
@override@JsonKey() final  bool tappedTableViewAll;

/// Create a copy of DividendTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DividendTabViewStateCopyWith<_DividendTabViewState> get copyWith => __$DividendTabViewStateCopyWithImpl<_DividendTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DividendTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.tappedChartViewAll, tappedChartViewAll) || other.tappedChartViewAll == tappedChartViewAll)&&(identical(other.tappedTableViewAll, tappedTableViewAll) || other.tappedTableViewAll == tappedTableViewAll));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,tappedChartViewAll,tappedTableViewAll);

@override
String toString() {
  return 'DividendTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, tappedChartViewAll: $tappedChartViewAll, tappedTableViewAll: $tappedTableViewAll)';
}


}

/// @nodoc
abstract mixin class _$DividendTabViewStateCopyWith<$Res> implements $DividendTabViewStateCopyWith<$Res> {
  factory _$DividendTabViewStateCopyWith(_DividendTabViewState value, $Res Function(_DividendTabViewState) _then) = __$DividendTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool tappedChartViewAll, bool tappedTableViewAll
});




}
/// @nodoc
class __$DividendTabViewStateCopyWithImpl<$Res>
    implements _$DividendTabViewStateCopyWith<$Res> {
  __$DividendTabViewStateCopyWithImpl(this._self, this._then);

  final _DividendTabViewState _self;
  final $Res Function(_DividendTabViewState) _then;

/// Create a copy of DividendTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? tappedChartViewAll = null,Object? tappedTableViewAll = null,}) {
  return _then(_DividendTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,tappedChartViewAll: null == tappedChartViewAll ? _self.tappedChartViewAll : tappedChartViewAll // ignore: cast_nullable_to_non_nullable
as bool,tappedTableViewAll: null == tappedTableViewAll ? _self.tappedTableViewAll : tappedTableViewAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
