// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_reports_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiReportsTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get viewedTenKTab; bool get viewedTenQTab; bool get viewedEightKTab; bool get viewedRecapsTab; bool get openedReport; bool get openedFilingLink;
/// Create a copy of AiReportsTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiReportsTabViewStateCopyWith<AiReportsTabViewState> get copyWith => _$AiReportsTabViewStateCopyWithImpl<AiReportsTabViewState>(this as AiReportsTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiReportsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedTenKTab, viewedTenKTab) || other.viewedTenKTab == viewedTenKTab)&&(identical(other.viewedTenQTab, viewedTenQTab) || other.viewedTenQTab == viewedTenQTab)&&(identical(other.viewedEightKTab, viewedEightKTab) || other.viewedEightKTab == viewedEightKTab)&&(identical(other.viewedRecapsTab, viewedRecapsTab) || other.viewedRecapsTab == viewedRecapsTab)&&(identical(other.openedReport, openedReport) || other.openedReport == openedReport)&&(identical(other.openedFilingLink, openedFilingLink) || other.openedFilingLink == openedFilingLink));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedTenKTab,viewedTenQTab,viewedEightKTab,viewedRecapsTab,openedReport,openedFilingLink);

@override
String toString() {
  return 'AiReportsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedTenKTab: $viewedTenKTab, viewedTenQTab: $viewedTenQTab, viewedEightKTab: $viewedEightKTab, viewedRecapsTab: $viewedRecapsTab, openedReport: $openedReport, openedFilingLink: $openedFilingLink)';
}


}

/// @nodoc
abstract mixin class $AiReportsTabViewStateCopyWith<$Res>  {
  factory $AiReportsTabViewStateCopyWith(AiReportsTabViewState value, $Res Function(AiReportsTabViewState) _then) = _$AiReportsTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedTenKTab, bool viewedTenQTab, bool viewedEightKTab, bool viewedRecapsTab, bool openedReport, bool openedFilingLink
});




}
/// @nodoc
class _$AiReportsTabViewStateCopyWithImpl<$Res>
    implements $AiReportsTabViewStateCopyWith<$Res> {
  _$AiReportsTabViewStateCopyWithImpl(this._self, this._then);

  final AiReportsTabViewState _self;
  final $Res Function(AiReportsTabViewState) _then;

/// Create a copy of AiReportsTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedTenKTab = null,Object? viewedTenQTab = null,Object? viewedEightKTab = null,Object? viewedRecapsTab = null,Object? openedReport = null,Object? openedFilingLink = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedTenKTab: null == viewedTenKTab ? _self.viewedTenKTab : viewedTenKTab // ignore: cast_nullable_to_non_nullable
as bool,viewedTenQTab: null == viewedTenQTab ? _self.viewedTenQTab : viewedTenQTab // ignore: cast_nullable_to_non_nullable
as bool,viewedEightKTab: null == viewedEightKTab ? _self.viewedEightKTab : viewedEightKTab // ignore: cast_nullable_to_non_nullable
as bool,viewedRecapsTab: null == viewedRecapsTab ? _self.viewedRecapsTab : viewedRecapsTab // ignore: cast_nullable_to_non_nullable
as bool,openedReport: null == openedReport ? _self.openedReport : openedReport // ignore: cast_nullable_to_non_nullable
as bool,openedFilingLink: null == openedFilingLink ? _self.openedFilingLink : openedFilingLink // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AiReportsTabViewState].
extension AiReportsTabViewStatePatterns on AiReportsTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiReportsTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiReportsTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiReportsTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _AiReportsTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiReportsTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _AiReportsTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedTenKTab,  bool viewedTenQTab,  bool viewedEightKTab,  bool viewedRecapsTab,  bool openedReport,  bool openedFilingLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiReportsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedTenKTab,_that.viewedTenQTab,_that.viewedEightKTab,_that.viewedRecapsTab,_that.openedReport,_that.openedFilingLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedTenKTab,  bool viewedTenQTab,  bool viewedEightKTab,  bool viewedRecapsTab,  bool openedReport,  bool openedFilingLink)  $default,) {final _that = this;
switch (_that) {
case _AiReportsTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedTenKTab,_that.viewedTenQTab,_that.viewedEightKTab,_that.viewedRecapsTab,_that.openedReport,_that.openedFilingLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedTenKTab,  bool viewedTenQTab,  bool viewedEightKTab,  bool viewedRecapsTab,  bool openedReport,  bool openedFilingLink)?  $default,) {final _that = this;
switch (_that) {
case _AiReportsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedTenKTab,_that.viewedTenQTab,_that.viewedEightKTab,_that.viewedRecapsTab,_that.openedReport,_that.openedFilingLink);case _:
  return null;

}
}

}

/// @nodoc


class _AiReportsTabViewState extends AiReportsTabViewState {
  const _AiReportsTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.viewedTenKTab = false, this.viewedTenQTab = false, this.viewedEightKTab = false, this.viewedRecapsTab = false, this.openedReport = false, this.openedFilingLink = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool viewedTenKTab;
@override@JsonKey() final  bool viewedTenQTab;
@override@JsonKey() final  bool viewedEightKTab;
@override@JsonKey() final  bool viewedRecapsTab;
@override@JsonKey() final  bool openedReport;
@override@JsonKey() final  bool openedFilingLink;

/// Create a copy of AiReportsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiReportsTabViewStateCopyWith<_AiReportsTabViewState> get copyWith => __$AiReportsTabViewStateCopyWithImpl<_AiReportsTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiReportsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedTenKTab, viewedTenKTab) || other.viewedTenKTab == viewedTenKTab)&&(identical(other.viewedTenQTab, viewedTenQTab) || other.viewedTenQTab == viewedTenQTab)&&(identical(other.viewedEightKTab, viewedEightKTab) || other.viewedEightKTab == viewedEightKTab)&&(identical(other.viewedRecapsTab, viewedRecapsTab) || other.viewedRecapsTab == viewedRecapsTab)&&(identical(other.openedReport, openedReport) || other.openedReport == openedReport)&&(identical(other.openedFilingLink, openedFilingLink) || other.openedFilingLink == openedFilingLink));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedTenKTab,viewedTenQTab,viewedEightKTab,viewedRecapsTab,openedReport,openedFilingLink);

@override
String toString() {
  return 'AiReportsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedTenKTab: $viewedTenKTab, viewedTenQTab: $viewedTenQTab, viewedEightKTab: $viewedEightKTab, viewedRecapsTab: $viewedRecapsTab, openedReport: $openedReport, openedFilingLink: $openedFilingLink)';
}


}

/// @nodoc
abstract mixin class _$AiReportsTabViewStateCopyWith<$Res> implements $AiReportsTabViewStateCopyWith<$Res> {
  factory _$AiReportsTabViewStateCopyWith(_AiReportsTabViewState value, $Res Function(_AiReportsTabViewState) _then) = __$AiReportsTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedTenKTab, bool viewedTenQTab, bool viewedEightKTab, bool viewedRecapsTab, bool openedReport, bool openedFilingLink
});




}
/// @nodoc
class __$AiReportsTabViewStateCopyWithImpl<$Res>
    implements _$AiReportsTabViewStateCopyWith<$Res> {
  __$AiReportsTabViewStateCopyWithImpl(this._self, this._then);

  final _AiReportsTabViewState _self;
  final $Res Function(_AiReportsTabViewState) _then;

/// Create a copy of AiReportsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedTenKTab = null,Object? viewedTenQTab = null,Object? viewedEightKTab = null,Object? viewedRecapsTab = null,Object? openedReport = null,Object? openedFilingLink = null,}) {
  return _then(_AiReportsTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedTenKTab: null == viewedTenKTab ? _self.viewedTenKTab : viewedTenKTab // ignore: cast_nullable_to_non_nullable
as bool,viewedTenQTab: null == viewedTenQTab ? _self.viewedTenQTab : viewedTenQTab // ignore: cast_nullable_to_non_nullable
as bool,viewedEightKTab: null == viewedEightKTab ? _self.viewedEightKTab : viewedEightKTab // ignore: cast_nullable_to_non_nullable
as bool,viewedRecapsTab: null == viewedRecapsTab ? _self.viewedRecapsTab : viewedRecapsTab // ignore: cast_nullable_to_non_nullable
as bool,openedReport: null == openedReport ? _self.openedReport : openedReport // ignore: cast_nullable_to_non_nullable
as bool,openedFilingLink: null == openedFilingLink ? _self.openedFilingLink : openedFilingLink // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
