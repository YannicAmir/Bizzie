// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_tab_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsTabViewState {

 String get ticker; String get timestamp; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get featuredArticleTapped; bool get normalArticleTapped; int get refreshTriggeredCount;
/// Create a copy of NewsTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsTabViewStateCopyWith<NewsTabViewState> get copyWith => _$NewsTabViewStateCopyWithImpl<NewsTabViewState>(this as NewsTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.featuredArticleTapped, featuredArticleTapped) || other.featuredArticleTapped == featuredArticleTapped)&&(identical(other.normalArticleTapped, normalArticleTapped) || other.normalArticleTapped == normalArticleTapped)&&(identical(other.refreshTriggeredCount, refreshTriggeredCount) || other.refreshTriggeredCount == refreshTriggeredCount));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,featuredArticleTapped,normalArticleTapped,refreshTriggeredCount);

@override
String toString() {
  return 'NewsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, featuredArticleTapped: $featuredArticleTapped, normalArticleTapped: $normalArticleTapped, refreshTriggeredCount: $refreshTriggeredCount)';
}


}

/// @nodoc
abstract mixin class $NewsTabViewStateCopyWith<$Res>  {
  factory $NewsTabViewStateCopyWith(NewsTabViewState value, $Res Function(NewsTabViewState) _then) = _$NewsTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool featuredArticleTapped, bool normalArticleTapped, int refreshTriggeredCount
});




}
/// @nodoc
class _$NewsTabViewStateCopyWithImpl<$Res>
    implements $NewsTabViewStateCopyWith<$Res> {
  _$NewsTabViewStateCopyWithImpl(this._self, this._then);

  final NewsTabViewState _self;
  final $Res Function(NewsTabViewState) _then;

/// Create a copy of NewsTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? featuredArticleTapped = null,Object? normalArticleTapped = null,Object? refreshTriggeredCount = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,featuredArticleTapped: null == featuredArticleTapped ? _self.featuredArticleTapped : featuredArticleTapped // ignore: cast_nullable_to_non_nullable
as bool,normalArticleTapped: null == normalArticleTapped ? _self.normalArticleTapped : normalArticleTapped // ignore: cast_nullable_to_non_nullable
as bool,refreshTriggeredCount: null == refreshTriggeredCount ? _self.refreshTriggeredCount : refreshTriggeredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsTabViewState].
extension NewsTabViewStatePatterns on NewsTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _NewsTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _NewsTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool featuredArticleTapped,  bool normalArticleTapped,  int refreshTriggeredCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.featuredArticleTapped,_that.normalArticleTapped,_that.refreshTriggeredCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool featuredArticleTapped,  bool normalArticleTapped,  int refreshTriggeredCount)  $default,) {final _that = this;
switch (_that) {
case _NewsTabViewState():
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.featuredArticleTapped,_that.normalArticleTapped,_that.refreshTriggeredCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String timestamp,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool featuredArticleTapped,  bool normalArticleTapped,  int refreshTriggeredCount)?  $default,) {final _that = this;
switch (_that) {
case _NewsTabViewState() when $default != null:
return $default(_that.ticker,_that.timestamp,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.featuredArticleTapped,_that.normalArticleTapped,_that.refreshTriggeredCount);case _:
  return null;

}
}

}

/// @nodoc


class _NewsTabViewState extends NewsTabViewState {
  const _NewsTabViewState({required this.ticker, required this.timestamp, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.featuredArticleTapped = false, this.normalArticleTapped = false, this.refreshTriggeredCount = 0}): super._();
  

@override final  String ticker;
@override final  String timestamp;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool featuredArticleTapped;
@override@JsonKey() final  bool normalArticleTapped;
@override@JsonKey() final  int refreshTriggeredCount;

/// Create a copy of NewsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsTabViewStateCopyWith<_NewsTabViewState> get copyWith => __$NewsTabViewStateCopyWithImpl<_NewsTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.featuredArticleTapped, featuredArticleTapped) || other.featuredArticleTapped == featuredArticleTapped)&&(identical(other.normalArticleTapped, normalArticleTapped) || other.normalArticleTapped == normalArticleTapped)&&(identical(other.refreshTriggeredCount, refreshTriggeredCount) || other.refreshTriggeredCount == refreshTriggeredCount));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,timestamp,loadTimeMs,isSuccess,dataSource,viewDurationSec,featuredArticleTapped,normalArticleTapped,refreshTriggeredCount);

@override
String toString() {
  return 'NewsTabViewState(ticker: $ticker, timestamp: $timestamp, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, featuredArticleTapped: $featuredArticleTapped, normalArticleTapped: $normalArticleTapped, refreshTriggeredCount: $refreshTriggeredCount)';
}


}

/// @nodoc
abstract mixin class _$NewsTabViewStateCopyWith<$Res> implements $NewsTabViewStateCopyWith<$Res> {
  factory _$NewsTabViewStateCopyWith(_NewsTabViewState value, $Res Function(_NewsTabViewState) _then) = __$NewsTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String timestamp, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool featuredArticleTapped, bool normalArticleTapped, int refreshTriggeredCount
});




}
/// @nodoc
class __$NewsTabViewStateCopyWithImpl<$Res>
    implements _$NewsTabViewStateCopyWith<$Res> {
  __$NewsTabViewStateCopyWithImpl(this._self, this._then);

  final _NewsTabViewState _self;
  final $Res Function(_NewsTabViewState) _then;

/// Create a copy of NewsTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? timestamp = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? featuredArticleTapped = null,Object? normalArticleTapped = null,Object? refreshTriggeredCount = null,}) {
  return _then(_NewsTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,featuredArticleTapped: null == featuredArticleTapped ? _self.featuredArticleTapped : featuredArticleTapped // ignore: cast_nullable_to_non_nullable
as bool,normalArticleTapped: null == normalArticleTapped ? _self.normalArticleTapped : normalArticleTapped // ignore: cast_nullable_to_non_nullable
as bool,refreshTriggeredCount: null == refreshTriggeredCount ? _self.refreshTriggeredCount : refreshTriggeredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
