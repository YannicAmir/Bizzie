// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_tab_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessTabViewState {

 String get ticker; int? get loadTimeMs; bool get isSuccess; CompanyProfileDataOrigin? get dataSource; int get viewDurationSec; bool get tappedWebsite; bool get tappedProxy; bool get didExpandDescription; bool get viewed10Ks; bool get viewed10Qs; bool get viewAll10KsTapped; bool get viewAll10QsTapped;
/// Create a copy of BusinessTabViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessTabViewStateCopyWith<BusinessTabViewState> get copyWith => _$BusinessTabViewStateCopyWithImpl<BusinessTabViewState>(this as BusinessTabViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.tappedWebsite, tappedWebsite) || other.tappedWebsite == tappedWebsite)&&(identical(other.tappedProxy, tappedProxy) || other.tappedProxy == tappedProxy)&&(identical(other.didExpandDescription, didExpandDescription) || other.didExpandDescription == didExpandDescription)&&(identical(other.viewed10Ks, viewed10Ks) || other.viewed10Ks == viewed10Ks)&&(identical(other.viewed10Qs, viewed10Qs) || other.viewed10Qs == viewed10Qs)&&(identical(other.viewAll10KsTapped, viewAll10KsTapped) || other.viewAll10KsTapped == viewAll10KsTapped)&&(identical(other.viewAll10QsTapped, viewAll10QsTapped) || other.viewAll10QsTapped == viewAll10QsTapped));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,loadTimeMs,isSuccess,dataSource,viewDurationSec,tappedWebsite,tappedProxy,didExpandDescription,viewed10Ks,viewed10Qs,viewAll10KsTapped,viewAll10QsTapped);

@override
String toString() {
  return 'BusinessTabViewState(ticker: $ticker, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, tappedWebsite: $tappedWebsite, tappedProxy: $tappedProxy, didExpandDescription: $didExpandDescription, viewed10Ks: $viewed10Ks, viewed10Qs: $viewed10Qs, viewAll10KsTapped: $viewAll10KsTapped, viewAll10QsTapped: $viewAll10QsTapped)';
}


}

/// @nodoc
abstract mixin class $BusinessTabViewStateCopyWith<$Res>  {
  factory $BusinessTabViewStateCopyWith(BusinessTabViewState value, $Res Function(BusinessTabViewState) _then) = _$BusinessTabViewStateCopyWithImpl;
@useResult
$Res call({
 String ticker, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool tappedWebsite, bool tappedProxy, bool didExpandDescription, bool viewed10Ks, bool viewed10Qs, bool viewAll10KsTapped, bool viewAll10QsTapped
});




}
/// @nodoc
class _$BusinessTabViewStateCopyWithImpl<$Res>
    implements $BusinessTabViewStateCopyWith<$Res> {
  _$BusinessTabViewStateCopyWithImpl(this._self, this._then);

  final BusinessTabViewState _self;
  final $Res Function(BusinessTabViewState) _then;

/// Create a copy of BusinessTabViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? tappedWebsite = null,Object? tappedProxy = null,Object? didExpandDescription = null,Object? viewed10Ks = null,Object? viewed10Qs = null,Object? viewAll10KsTapped = null,Object? viewAll10QsTapped = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,tappedWebsite: null == tappedWebsite ? _self.tappedWebsite : tappedWebsite // ignore: cast_nullable_to_non_nullable
as bool,tappedProxy: null == tappedProxy ? _self.tappedProxy : tappedProxy // ignore: cast_nullable_to_non_nullable
as bool,didExpandDescription: null == didExpandDescription ? _self.didExpandDescription : didExpandDescription // ignore: cast_nullable_to_non_nullable
as bool,viewed10Ks: null == viewed10Ks ? _self.viewed10Ks : viewed10Ks // ignore: cast_nullable_to_non_nullable
as bool,viewed10Qs: null == viewed10Qs ? _self.viewed10Qs : viewed10Qs // ignore: cast_nullable_to_non_nullable
as bool,viewAll10KsTapped: null == viewAll10KsTapped ? _self.viewAll10KsTapped : viewAll10KsTapped // ignore: cast_nullable_to_non_nullable
as bool,viewAll10QsTapped: null == viewAll10QsTapped ? _self.viewAll10QsTapped : viewAll10QsTapped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessTabViewState].
extension BusinessTabViewStatePatterns on BusinessTabViewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessTabViewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessTabViewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessTabViewState value)  $default,){
final _that = this;
switch (_that) {
case _BusinessTabViewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessTabViewState value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessTabViewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedWebsite,  bool tappedProxy,  bool didExpandDescription,  bool viewed10Ks,  bool viewed10Qs,  bool viewAll10KsTapped,  bool viewAll10QsTapped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessTabViewState() when $default != null:
return $default(_that.ticker,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedWebsite,  bool tappedProxy,  bool didExpandDescription,  bool viewed10Ks,  bool viewed10Qs,  bool viewAll10KsTapped,  bool viewAll10QsTapped)  $default,) {final _that = this;
switch (_that) {
case _BusinessTabViewState():
return $default(_that.ticker,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  int? loadTimeMs,  bool isSuccess,  CompanyProfileDataOrigin? dataSource,  int viewDurationSec,  bool tappedWebsite,  bool tappedProxy,  bool didExpandDescription,  bool viewed10Ks,  bool viewed10Qs,  bool viewAll10KsTapped,  bool viewAll10QsTapped)?  $default,) {final _that = this;
switch (_that) {
case _BusinessTabViewState() when $default != null:
return $default(_that.ticker,_that.loadTimeMs,_that.isSuccess,_that.dataSource,_that.viewDurationSec,_that.tappedWebsite,_that.tappedProxy,_that.didExpandDescription,_that.viewed10Ks,_that.viewed10Qs,_that.viewAll10KsTapped,_that.viewAll10QsTapped);case _:
  return null;

}
}

}

/// @nodoc


class _BusinessTabViewState implements BusinessTabViewState {
  const _BusinessTabViewState({required this.ticker, this.loadTimeMs, this.isSuccess = false, this.dataSource, this.viewDurationSec = 0, this.tappedWebsite = false, this.tappedProxy = false, this.didExpandDescription = false, this.viewed10Ks = false, this.viewed10Qs = false, this.viewAll10KsTapped = false, this.viewAll10QsTapped = false});
  

@override final  String ticker;
@override final  int? loadTimeMs;
@override@JsonKey() final  bool isSuccess;
@override final  CompanyProfileDataOrigin? dataSource;
@override@JsonKey() final  int viewDurationSec;
@override@JsonKey() final  bool tappedWebsite;
@override@JsonKey() final  bool tappedProxy;
@override@JsonKey() final  bool didExpandDescription;
@override@JsonKey() final  bool viewed10Ks;
@override@JsonKey() final  bool viewed10Qs;
@override@JsonKey() final  bool viewAll10KsTapped;
@override@JsonKey() final  bool viewAll10QsTapped;

/// Create a copy of BusinessTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessTabViewStateCopyWith<_BusinessTabViewState> get copyWith => __$BusinessTabViewStateCopyWithImpl<_BusinessTabViewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessTabViewState&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.dataSource, dataSource) || other.dataSource == dataSource)&&(identical(other.viewDurationSec, viewDurationSec) || other.viewDurationSec == viewDurationSec)&&(identical(other.tappedWebsite, tappedWebsite) || other.tappedWebsite == tappedWebsite)&&(identical(other.tappedProxy, tappedProxy) || other.tappedProxy == tappedProxy)&&(identical(other.didExpandDescription, didExpandDescription) || other.didExpandDescription == didExpandDescription)&&(identical(other.viewed10Ks, viewed10Ks) || other.viewed10Ks == viewed10Ks)&&(identical(other.viewed10Qs, viewed10Qs) || other.viewed10Qs == viewed10Qs)&&(identical(other.viewAll10KsTapped, viewAll10KsTapped) || other.viewAll10KsTapped == viewAll10KsTapped)&&(identical(other.viewAll10QsTapped, viewAll10QsTapped) || other.viewAll10QsTapped == viewAll10QsTapped));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,loadTimeMs,isSuccess,dataSource,viewDurationSec,tappedWebsite,tappedProxy,didExpandDescription,viewed10Ks,viewed10Qs,viewAll10KsTapped,viewAll10QsTapped);

@override
String toString() {
  return 'BusinessTabViewState(ticker: $ticker, loadTimeMs: $loadTimeMs, isSuccess: $isSuccess, dataSource: $dataSource, viewDurationSec: $viewDurationSec, tappedWebsite: $tappedWebsite, tappedProxy: $tappedProxy, didExpandDescription: $didExpandDescription, viewed10Ks: $viewed10Ks, viewed10Qs: $viewed10Qs, viewAll10KsTapped: $viewAll10KsTapped, viewAll10QsTapped: $viewAll10QsTapped)';
}


}

/// @nodoc
abstract mixin class _$BusinessTabViewStateCopyWith<$Res> implements $BusinessTabViewStateCopyWith<$Res> {
  factory _$BusinessTabViewStateCopyWith(_BusinessTabViewState value, $Res Function(_BusinessTabViewState) _then) = __$BusinessTabViewStateCopyWithImpl;
@override @useResult
$Res call({
 String ticker, int? loadTimeMs, bool isSuccess, CompanyProfileDataOrigin? dataSource, int viewDurationSec, bool tappedWebsite, bool tappedProxy, bool didExpandDescription, bool viewed10Ks, bool viewed10Qs, bool viewAll10KsTapped, bool viewAll10QsTapped
});




}
/// @nodoc
class __$BusinessTabViewStateCopyWithImpl<$Res>
    implements _$BusinessTabViewStateCopyWith<$Res> {
  __$BusinessTabViewStateCopyWithImpl(this._self, this._then);

  final _BusinessTabViewState _self;
  final $Res Function(_BusinessTabViewState) _then;

/// Create a copy of BusinessTabViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? loadTimeMs = freezed,Object? isSuccess = null,Object? dataSource = freezed,Object? viewDurationSec = null,Object? tappedWebsite = null,Object? tappedProxy = null,Object? didExpandDescription = null,Object? viewed10Ks = null,Object? viewed10Qs = null,Object? viewAll10KsTapped = null,Object? viewAll10QsTapped = null,}) {
  return _then(_BusinessTabViewState(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,dataSource: freezed == dataSource ? _self.dataSource : dataSource // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin?,viewDurationSec: null == viewDurationSec ? _self.viewDurationSec : viewDurationSec // ignore: cast_nullable_to_non_nullable
as int,tappedWebsite: null == tappedWebsite ? _self.tappedWebsite : tappedWebsite // ignore: cast_nullable_to_non_nullable
as bool,tappedProxy: null == tappedProxy ? _self.tappedProxy : tappedProxy // ignore: cast_nullable_to_non_nullable
as bool,didExpandDescription: null == didExpandDescription ? _self.didExpandDescription : didExpandDescription // ignore: cast_nullable_to_non_nullable
as bool,viewed10Ks: null == viewed10Ks ? _self.viewed10Ks : viewed10Ks // ignore: cast_nullable_to_non_nullable
as bool,viewed10Qs: null == viewed10Qs ? _self.viewed10Qs : viewed10Qs // ignore: cast_nullable_to_non_nullable
as bool,viewAll10KsTapped: null == viewAll10KsTapped ? _self.viewAll10KsTapped : viewAll10KsTapped // ignore: cast_nullable_to_non_nullable
as bool,viewAll10QsTapped: null == viewAll10QsTapped ? _self.viewAll10QsTapped : viewAll10QsTapped // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
