// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inc_stmt_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncStmtTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get viewedIncomeTab; bool get tappedAllIncomeYrly; bool get tappedAllIncomeQtrly; bool get switchedIncomeYear; bool get switchedIncomeQtr;
/// Create a copy of IncStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncStmtTabViewStateCopyWith<IncStmtTabViewState> get copyWith => _$IncStmtTabViewStateCopyWithImpl<IncStmtTabViewState>(this as IncStmtTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncStmtTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedIncomeTab, viewedIncomeTab) || other.viewedIncomeTab == viewedIncomeTab)&&(identical(other.tappedAllIncomeYrly, tappedAllIncomeYrly) || other.tappedAllIncomeYrly == tappedAllIncomeYrly)&&(identical(other.tappedAllIncomeQtrly, tappedAllIncomeQtrly) || other.tappedAllIncomeQtrly == tappedAllIncomeQtrly)&&(identical(other.switchedIncomeYear, switchedIncomeYear) || other.switchedIncomeYear == switchedIncomeYear)&&(identical(other.switchedIncomeQtr, switchedIncomeQtr) || other.switchedIncomeQtr == switchedIncomeQtr));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedIncomeTab,tappedAllIncomeYrly,tappedAllIncomeQtrly,switchedIncomeYear,switchedIncomeQtr);

@override
String toString() {
  return 'IncStmtTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedIncomeTab: $viewedIncomeTab, tappedAllIncomeYrly: $tappedAllIncomeYrly, tappedAllIncomeQtrly: $tappedAllIncomeQtrly, switchedIncomeYear: $switchedIncomeYear, switchedIncomeQtr: $switchedIncomeQtr)';
}


}

/// @nodoc
abstract mixin class $IncStmtTabViewStateCopyWith<$Res>  {
  factory $IncStmtTabViewStateCopyWith(IncStmtTabViewState value, $Res Function(IncStmtTabViewState) _then) = _$IncStmtTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedIncomeTab, bool tappedAllIncomeYrly, bool tappedAllIncomeQtrly, bool switchedIncomeYear, bool switchedIncomeQtr
});




}
/// @nodoc
class _$IncStmtTabViewStateCopyWithImpl<$Res>
    implements $IncStmtTabViewStateCopyWith<$Res> {
  _$IncStmtTabViewStateCopyWithImpl(this._self, this._then);

  final IncStmtTabViewState _self;
  final $Res Function(IncStmtTabViewState) _then;

/// Create a copy of IncStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedIncomeTab = null,Object? tappedAllIncomeYrly = null,Object? tappedAllIncomeQtrly = null,Object? switchedIncomeYear = null,Object? switchedIncomeQtr = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedIncomeTab: null == viewedIncomeTab ? _self.viewedIncomeTab : viewedIncomeTab // ignore: cast_nullable_to_non_nullable
as bool,tappedAllIncomeYrly: null == tappedAllIncomeYrly ? _self.tappedAllIncomeYrly : tappedAllIncomeYrly // ignore: cast_nullable_to_non_nullable
as bool,tappedAllIncomeQtrly: null == tappedAllIncomeQtrly ? _self.tappedAllIncomeQtrly : tappedAllIncomeQtrly // ignore: cast_nullable_to_non_nullable
as bool,switchedIncomeYear: null == switchedIncomeYear ? _self.switchedIncomeYear : switchedIncomeYear // ignore: cast_nullable_to_non_nullable
as bool,switchedIncomeQtr: null == switchedIncomeQtr ? _self.switchedIncomeQtr : switchedIncomeQtr // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IncStmtTabViewState].
extension IncStmtTabViewStatePatterns on IncStmtTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncStmtTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncStmtTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncStmtTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _IncStmtTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncStmtTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _IncStmtTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedIncomeTab,  bool tappedAllIncomeYrly,  bool tappedAllIncomeQtrly,  bool switchedIncomeYear,  bool switchedIncomeQtr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncStmtTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedIncomeTab,_that.tappedAllIncomeYrly,_that.tappedAllIncomeQtrly,_that.switchedIncomeYear,_that.switchedIncomeQtr);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedIncomeTab,  bool tappedAllIncomeYrly,  bool tappedAllIncomeQtrly,  bool switchedIncomeYear,  bool switchedIncomeQtr)  $default,) {final _that = this;
switch (_that) {
case _IncStmtTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedIncomeTab,_that.tappedAllIncomeYrly,_that.tappedAllIncomeQtrly,_that.switchedIncomeYear,_that.switchedIncomeQtr);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool viewedIncomeTab,  bool tappedAllIncomeYrly,  bool tappedAllIncomeQtrly,  bool switchedIncomeYear,  bool switchedIncomeQtr)?  $default,) {final _that = this;
switch (_that) {
case _IncStmtTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.viewedIncomeTab,_that.tappedAllIncomeYrly,_that.tappedAllIncomeQtrly,_that.switchedIncomeYear,_that.switchedIncomeQtr);case _:
  return null;

}
}

}

/// @nodoc


class _IncStmtTabViewState extends IncStmtTabViewState {
  const _IncStmtTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.viewedIncomeTab = false, this.tappedAllIncomeYrly = false, this.tappedAllIncomeQtrly = false, this.switchedIncomeYear = false, this.switchedIncomeQtr = false}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool viewedIncomeTab;
@override@JsonKey() final  bool tappedAllIncomeYrly;
@override@JsonKey() final  bool tappedAllIncomeQtrly;
@override@JsonKey() final  bool switchedIncomeYear;
@override@JsonKey() final  bool switchedIncomeQtr;

/// Create a copy of IncStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncStmtTabViewStateCopyWith<_IncStmtTabViewState> get copyWith => __$IncStmtTabViewStateCopyWithImpl<_IncStmtTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncStmtTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.viewedIncomeTab, viewedIncomeTab) || other.viewedIncomeTab == viewedIncomeTab)&&(identical(other.tappedAllIncomeYrly, tappedAllIncomeYrly) || other.tappedAllIncomeYrly == tappedAllIncomeYrly)&&(identical(other.tappedAllIncomeQtrly, tappedAllIncomeQtrly) || other.tappedAllIncomeQtrly == tappedAllIncomeQtrly)&&(identical(other.switchedIncomeYear, switchedIncomeYear) || other.switchedIncomeYear == switchedIncomeYear)&&(identical(other.switchedIncomeQtr, switchedIncomeQtr) || other.switchedIncomeQtr == switchedIncomeQtr));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,viewedIncomeTab,tappedAllIncomeYrly,tappedAllIncomeQtrly,switchedIncomeYear,switchedIncomeQtr);

@override
String toString() {
  return 'IncStmtTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, viewedIncomeTab: $viewedIncomeTab, tappedAllIncomeYrly: $tappedAllIncomeYrly, tappedAllIncomeQtrly: $tappedAllIncomeQtrly, switchedIncomeYear: $switchedIncomeYear, switchedIncomeQtr: $switchedIncomeQtr)';
}


}

/// @nodoc
abstract mixin class _$IncStmtTabViewStateCopyWith<$Res> implements $IncStmtTabViewStateCopyWith<$Res> {
  factory _$IncStmtTabViewStateCopyWith(_IncStmtTabViewState value, $Res Function(_IncStmtTabViewState) _then) = __$IncStmtTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool viewedIncomeTab, bool tappedAllIncomeYrly, bool tappedAllIncomeQtrly, bool switchedIncomeYear, bool switchedIncomeQtr
});




}
/// @nodoc
class __$IncStmtTabViewStateCopyWithImpl<$Res>
    implements _$IncStmtTabViewStateCopyWith<$Res> {
  __$IncStmtTabViewStateCopyWithImpl(this._self, this._then);

  final _IncStmtTabViewState _self;
  final $Res Function(_IncStmtTabViewState) _then;

/// Create a copy of IncStmtTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? viewedIncomeTab = null,Object? tappedAllIncomeYrly = null,Object? tappedAllIncomeQtrly = null,Object? switchedIncomeYear = null,Object? switchedIncomeQtr = null,}) {
  return _then(_IncStmtTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,viewedIncomeTab: null == viewedIncomeTab ? _self.viewedIncomeTab : viewedIncomeTab // ignore: cast_nullable_to_non_nullable
as bool,tappedAllIncomeYrly: null == tappedAllIncomeYrly ? _self.tappedAllIncomeYrly : tappedAllIncomeYrly // ignore: cast_nullable_to_non_nullable
as bool,tappedAllIncomeQtrly: null == tappedAllIncomeQtrly ? _self.tappedAllIncomeQtrly : tappedAllIncomeQtrly // ignore: cast_nullable_to_non_nullable
as bool,switchedIncomeYear: null == switchedIncomeYear ? _self.switchedIncomeYear : switchedIncomeYear // ignore: cast_nullable_to_non_nullable
as bool,switchedIncomeQtr: null == switchedIncomeQtr ? _self.switchedIncomeQtr : switchedIncomeQtr // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
