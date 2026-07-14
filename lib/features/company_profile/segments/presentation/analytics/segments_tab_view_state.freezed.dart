// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'segments_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SegmentsTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get viewedYearlySegTab; bool get viewedQtrlySegTab; bool get changedYrDate; bool get changedQtrDate;
/// Create a copy of SegmentsTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SegmentsTabViewStateCopyWith<SegmentsTabViewState> get copyWith => _$SegmentsTabViewStateCopyWithImpl<SegmentsTabViewState>(this as SegmentsTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SegmentsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedYearlySegTab, viewedYearlySegTab) || other.viewedYearlySegTab == viewedYearlySegTab)&&(identical(other.viewedQtrlySegTab, viewedQtrlySegTab) || other.viewedQtrlySegTab == viewedQtrlySegTab)&&(identical(other.changedYrDate, changedYrDate) || other.changedYrDate == changedYrDate)&&(identical(other.changedQtrDate, changedQtrDate) || other.changedQtrDate == changedQtrDate));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedYearlySegTab,viewedQtrlySegTab,changedYrDate,changedQtrDate);

@override
String toString() {
  return 'SegmentsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedYearlySegTab: $viewedYearlySegTab, viewedQtrlySegTab: $viewedQtrlySegTab, changedYrDate: $changedYrDate, changedQtrDate: $changedQtrDate)';
}


}

/// @nodoc
abstract mixin class $SegmentsTabViewStateCopyWith<$Res>  {
  factory $SegmentsTabViewStateCopyWith(SegmentsTabViewState value, $Res Function(SegmentsTabViewState) _then) = _$SegmentsTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedYearlySegTab, bool viewedQtrlySegTab, bool changedYrDate, bool changedQtrDate
});




}
/// @nodoc
class _$SegmentsTabViewStateCopyWithImpl<$Res>
    implements $SegmentsTabViewStateCopyWith<$Res> {
  _$SegmentsTabViewStateCopyWithImpl(this._self, this._then);

  final SegmentsTabViewState _self;
  final $Res Function(SegmentsTabViewState) _then;

/// Create a copy of SegmentsTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedYearlySegTab = null,Object? viewedQtrlySegTab = null,Object? changedYrDate = null,Object? changedQtrDate = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedYearlySegTab: null == viewedYearlySegTab ? _self.viewedYearlySegTab : viewedYearlySegTab // ignore: cast_nullable_to_non_nullable
as bool,viewedQtrlySegTab: null == viewedQtrlySegTab ? _self.viewedQtrlySegTab : viewedQtrlySegTab // ignore: cast_nullable_to_non_nullable
as bool,changedYrDate: null == changedYrDate ? _self.changedYrDate : changedYrDate // ignore: cast_nullable_to_non_nullable
as bool,changedQtrDate: null == changedQtrDate ? _self.changedQtrDate : changedQtrDate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SegmentsTabViewState].
extension SegmentsTabViewStatePatterns on SegmentsTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SegmentsTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SegmentsTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SegmentsTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _SegmentsTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SegmentsTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _SegmentsTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySegTab,  bool viewedQtrlySegTab,  bool changedYrDate,  bool changedQtrDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SegmentsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySegTab,_that.viewedQtrlySegTab,_that.changedYrDate,_that.changedQtrDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySegTab,  bool viewedQtrlySegTab,  bool changedYrDate,  bool changedQtrDate)  $default,) {final _that = this;
switch (_that) {
case _SegmentsTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySegTab,_that.viewedQtrlySegTab,_that.changedYrDate,_that.changedQtrDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedYearlySegTab,  bool viewedQtrlySegTab,  bool changedYrDate,  bool changedQtrDate)?  $default,) {final _that = this;
switch (_that) {
case _SegmentsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedYearlySegTab,_that.viewedQtrlySegTab,_that.changedYrDate,_that.changedQtrDate);case _:
  return null;

}
}

}

/// @nodoc


class _SegmentsTabViewState extends SegmentsTabViewState {
  const _SegmentsTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.viewedYearlySegTab = false, this.viewedQtrlySegTab = false, this.changedYrDate = false, this.changedQtrDate = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool viewedYearlySegTab;
@override@JsonKey() final  bool viewedQtrlySegTab;
@override@JsonKey() final  bool changedYrDate;
@override@JsonKey() final  bool changedQtrDate;

/// Create a copy of SegmentsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentsTabViewStateCopyWith<_SegmentsTabViewState> get copyWith => __$SegmentsTabViewStateCopyWithImpl<_SegmentsTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedYearlySegTab, viewedYearlySegTab) || other.viewedYearlySegTab == viewedYearlySegTab)&&(identical(other.viewedQtrlySegTab, viewedQtrlySegTab) || other.viewedQtrlySegTab == viewedQtrlySegTab)&&(identical(other.changedYrDate, changedYrDate) || other.changedYrDate == changedYrDate)&&(identical(other.changedQtrDate, changedQtrDate) || other.changedQtrDate == changedQtrDate));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedYearlySegTab,viewedQtrlySegTab,changedYrDate,changedQtrDate);

@override
String toString() {
  return 'SegmentsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedYearlySegTab: $viewedYearlySegTab, viewedQtrlySegTab: $viewedQtrlySegTab, changedYrDate: $changedYrDate, changedQtrDate: $changedQtrDate)';
}


}

/// @nodoc
abstract mixin class _$SegmentsTabViewStateCopyWith<$Res> implements $SegmentsTabViewStateCopyWith<$Res> {
  factory _$SegmentsTabViewStateCopyWith(_SegmentsTabViewState value, $Res Function(_SegmentsTabViewState) _then) = __$SegmentsTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedYearlySegTab, bool viewedQtrlySegTab, bool changedYrDate, bool changedQtrDate
});




}
/// @nodoc
class __$SegmentsTabViewStateCopyWithImpl<$Res>
    implements _$SegmentsTabViewStateCopyWith<$Res> {
  __$SegmentsTabViewStateCopyWithImpl(this._self, this._then);

  final _SegmentsTabViewState _self;
  final $Res Function(_SegmentsTabViewState) _then;

/// Create a copy of SegmentsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedYearlySegTab = null,Object? viewedQtrlySegTab = null,Object? changedYrDate = null,Object? changedQtrDate = null,}) {
  return _then(_SegmentsTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedYearlySegTab: null == viewedYearlySegTab ? _self.viewedYearlySegTab : viewedYearlySegTab // ignore: cast_nullable_to_non_nullable
as bool,viewedQtrlySegTab: null == viewedQtrlySegTab ? _self.viewedQtrlySegTab : viewedQtrlySegTab // ignore: cast_nullable_to_non_nullable
as bool,changedYrDate: null == changedYrDate ? _self.changedYrDate : changedYrDate // ignore: cast_nullable_to_non_nullable
as bool,changedQtrDate: null == changedQtrDate ? _self.changedQtrDate : changedQtrDate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
