// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_dividends_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyDividendsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyDividendsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyDividendsState()';
}


}

/// @nodoc
class $CompanyDividendsStateCopyWith<$Res>  {
$CompanyDividendsStateCopyWith(CompanyDividendsState _, $Res Function(CompanyDividendsState) __);
}


/// Adds pattern-matching-related methods to [CompanyDividendsState].
extension CompanyDividendsStatePatterns on CompanyDividendsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( CompanyDividendsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyDividendsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( CompanyDividendsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case CompanyDividendsLoaded():
return loaded(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( CompanyDividendsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyDividendsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DividendInfo dividendInfo,  String ticker,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated,  DividendTabViewState? analyticsState)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyDividendsLoaded() when loaded != null:
return loaded(_that.dividendInfo,_that.ticker,_that.historyLimit,_that.dataOrigin,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DividendInfo dividendInfo,  String ticker,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated,  DividendTabViewState? analyticsState)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case CompanyDividendsLoaded():
return loaded(_that.dividendInfo,_that.ticker,_that.historyLimit,_that.dataOrigin,_that.lastUpdated,_that.analyticsState);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DividendInfo dividendInfo,  String ticker,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated,  DividendTabViewState? analyticsState)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyDividendsLoaded() when loaded != null:
return loaded(_that.dividendInfo,_that.ticker,_that.historyLimit,_that.dataOrigin,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyDividendsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyDividendsState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyDividendsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyDividendsState.loading()';
}


}




/// @nodoc


class CompanyDividendsLoaded implements CompanyDividendsState {
  const CompanyDividendsLoaded({required this.dividendInfo, required this.ticker, required this.historyLimit, required this.dataOrigin, this.lastUpdated, this.analyticsState});
  

 final  DividendInfo dividendInfo;
 final  String ticker;
 final  int historyLimit;
 final  CompanyProfileDataOrigin dataOrigin;
 final  DateTime? lastUpdated;
 final  DividendTabViewState? analyticsState;

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyDividendsLoadedCopyWith<CompanyDividendsLoaded> get copyWith => _$CompanyDividendsLoadedCopyWithImpl<CompanyDividendsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyDividendsLoaded&&(identical(other.dividendInfo, dividendInfo) || other.dividendInfo == dividendInfo)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.historyLimit, historyLimit) || other.historyLimit == historyLimit)&&(identical(other.dataOrigin, dataOrigin) || other.dataOrigin == dataOrigin)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,dividendInfo,ticker,historyLimit,dataOrigin,lastUpdated,analyticsState);

@override
String toString() {
  return 'CompanyDividendsState.loaded(dividendInfo: $dividendInfo, ticker: $ticker, historyLimit: $historyLimit, dataOrigin: $dataOrigin, lastUpdated: $lastUpdated, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $CompanyDividendsLoadedCopyWith<$Res> implements $CompanyDividendsStateCopyWith<$Res> {
  factory $CompanyDividendsLoadedCopyWith(CompanyDividendsLoaded value, $Res Function(CompanyDividendsLoaded) _then) = _$CompanyDividendsLoadedCopyWithImpl;
@useResult
$Res call({
 DividendInfo dividendInfo, String ticker, int historyLimit, CompanyProfileDataOrigin dataOrigin, DateTime? lastUpdated, DividendTabViewState? analyticsState
});


$DividendInfoCopyWith<$Res> get dividendInfo;$DividendTabViewStateCopyWith<$Res>? get analyticsState;

}
/// @nodoc
class _$CompanyDividendsLoadedCopyWithImpl<$Res>
    implements $CompanyDividendsLoadedCopyWith<$Res> {
  _$CompanyDividendsLoadedCopyWithImpl(this._self, this._then);

  final CompanyDividendsLoaded _self;
  final $Res Function(CompanyDividendsLoaded) _then;

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dividendInfo = null,Object? ticker = null,Object? historyLimit = null,Object? dataOrigin = null,Object? lastUpdated = freezed,Object? analyticsState = freezed,}) {
  return _then(CompanyDividendsLoaded(
dividendInfo: null == dividendInfo ? _self.dividendInfo : dividendInfo // ignore: cast_nullable_to_non_nullable
as DividendInfo,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,historyLimit: null == historyLimit ? _self.historyLimit : historyLimit // ignore: cast_nullable_to_non_nullable
as int,dataOrigin: null == dataOrigin ? _self.dataOrigin : dataOrigin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,analyticsState: freezed == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as DividendTabViewState?,
  ));
}

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DividendInfoCopyWith<$Res> get dividendInfo {
  
  return $DividendInfoCopyWith<$Res>(_self.dividendInfo, (value) {
    return _then(_self.copyWith(dividendInfo: value));
  });
}/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DividendTabViewStateCopyWith<$Res>? get analyticsState {
    if (_self.analyticsState == null) {
    return null;
  }

  return $DividendTabViewStateCopyWith<$Res>(_self.analyticsState!, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanyDividendsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CompanyDividendsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanyDividendsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanyDividendsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
