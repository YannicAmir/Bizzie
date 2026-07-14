// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_free_cash_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyFreeCashFlowState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyFreeCashFlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyFreeCashFlowState()';
}


}

/// @nodoc
class $CompanyFreeCashFlowStateCopyWith<$Res>  {
$CompanyFreeCashFlowStateCopyWith(CompanyFreeCashFlowState _, $Res Function(CompanyFreeCashFlowState) __);
}


/// Adds pattern-matching-related methods to [CompanyFreeCashFlowState].
extension CompanyFreeCashFlowStatePatterns on CompanyFreeCashFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( CompanyFreeCashFlowLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyFreeCashFlowLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( CompanyFreeCashFlowLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case CompanyFreeCashFlowLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( CompanyFreeCashFlowLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyFreeCashFlowLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String ticker,  FreeCashFlowStats fcfStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  FreeCashFlowTabViewState? analyticsState)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyFreeCashFlowLoaded() when loaded != null:
return loaded(_that.ticker,_that.fcfStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String ticker,  FreeCashFlowStats fcfStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  FreeCashFlowTabViewState? analyticsState)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case CompanyFreeCashFlowLoaded():
return loaded(_that.ticker,_that.fcfStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String ticker,  FreeCashFlowStats fcfStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  FreeCashFlowTabViewState? analyticsState)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyFreeCashFlowLoaded() when loaded != null:
return loaded(_that.ticker,_that.fcfStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyFreeCashFlowState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyFreeCashFlowState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyFreeCashFlowState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyFreeCashFlowState.loading()';
}


}




/// @nodoc


class CompanyFreeCashFlowLoaded implements CompanyFreeCashFlowState {
  const CompanyFreeCashFlowLoaded({required this.ticker, required this.fcfStats, required final  List<ChartDataPoint> annualChartData, required final  List<ChartDataPoint> quarterlyChartData, required this.historyLimit, required this.dataOrigin, this.isAnnualView = true, this.lastUpdated, this.analyticsState}): _annualChartData = annualChartData,_quarterlyChartData = quarterlyChartData;
  

 final  String ticker;
 final  FreeCashFlowStats fcfStats;
 final  List<ChartDataPoint> _annualChartData;
 List<ChartDataPoint> get annualChartData {
  if (_annualChartData is EqualUnmodifiableListView) return _annualChartData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualChartData);
}

 final  List<ChartDataPoint> _quarterlyChartData;
 List<ChartDataPoint> get quarterlyChartData {
  if (_quarterlyChartData is EqualUnmodifiableListView) return _quarterlyChartData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyChartData);
}

 final  int historyLimit;
 final  CompanyProfileDataOrigin dataOrigin;
@JsonKey() final  bool isAnnualView;
 final  DateTime? lastUpdated;
 final  FreeCashFlowTabViewState? analyticsState;

/// Create a copy of CompanyFreeCashFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyFreeCashFlowLoadedCopyWith<CompanyFreeCashFlowLoaded> get copyWith => _$CompanyFreeCashFlowLoadedCopyWithImpl<CompanyFreeCashFlowLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyFreeCashFlowLoaded&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.fcfStats, fcfStats) || other.fcfStats == fcfStats)&&const DeepCollectionEquality().equals(other._annualChartData, _annualChartData)&&const DeepCollectionEquality().equals(other._quarterlyChartData, _quarterlyChartData)&&(identical(other.historyLimit, historyLimit) || other.historyLimit == historyLimit)&&(identical(other.dataOrigin, dataOrigin) || other.dataOrigin == dataOrigin)&&(identical(other.isAnnualView, isAnnualView) || other.isAnnualView == isAnnualView)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,fcfStats,const DeepCollectionEquality().hash(_annualChartData),const DeepCollectionEquality().hash(_quarterlyChartData),historyLimit,dataOrigin,isAnnualView,lastUpdated,analyticsState);

@override
String toString() {
  return 'CompanyFreeCashFlowState.loaded(ticker: $ticker, fcfStats: $fcfStats, annualChartData: $annualChartData, quarterlyChartData: $quarterlyChartData, historyLimit: $historyLimit, dataOrigin: $dataOrigin, isAnnualView: $isAnnualView, lastUpdated: $lastUpdated, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $CompanyFreeCashFlowLoadedCopyWith<$Res> implements $CompanyFreeCashFlowStateCopyWith<$Res> {
  factory $CompanyFreeCashFlowLoadedCopyWith(CompanyFreeCashFlowLoaded value, $Res Function(CompanyFreeCashFlowLoaded) _then) = _$CompanyFreeCashFlowLoadedCopyWithImpl;
@useResult
$Res call({
 String ticker, FreeCashFlowStats fcfStats, List<ChartDataPoint> annualChartData, List<ChartDataPoint> quarterlyChartData, int historyLimit, CompanyProfileDataOrigin dataOrigin, bool isAnnualView, DateTime? lastUpdated, FreeCashFlowTabViewState? analyticsState
});


$FreeCashFlowStatsCopyWith<$Res> get fcfStats;$FreeCashFlowTabViewStateCopyWith<$Res>? get analyticsState;

}
/// @nodoc
class _$CompanyFreeCashFlowLoadedCopyWithImpl<$Res>
    implements $CompanyFreeCashFlowLoadedCopyWith<$Res> {
  _$CompanyFreeCashFlowLoadedCopyWithImpl(this._self, this._then);

  final CompanyFreeCashFlowLoaded _self;
  final $Res Function(CompanyFreeCashFlowLoaded) _then;

/// Create a copy of CompanyFreeCashFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? fcfStats = null,Object? annualChartData = null,Object? quarterlyChartData = null,Object? historyLimit = null,Object? dataOrigin = null,Object? isAnnualView = null,Object? lastUpdated = freezed,Object? analyticsState = freezed,}) {
  return _then(CompanyFreeCashFlowLoaded(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,fcfStats: null == fcfStats ? _self.fcfStats : fcfStats // ignore: cast_nullable_to_non_nullable
as FreeCashFlowStats,annualChartData: null == annualChartData ? _self._annualChartData : annualChartData // ignore: cast_nullable_to_non_nullable
as List<ChartDataPoint>,quarterlyChartData: null == quarterlyChartData ? _self._quarterlyChartData : quarterlyChartData // ignore: cast_nullable_to_non_nullable
as List<ChartDataPoint>,historyLimit: null == historyLimit ? _self.historyLimit : historyLimit // ignore: cast_nullable_to_non_nullable
as int,dataOrigin: null == dataOrigin ? _self.dataOrigin : dataOrigin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,isAnnualView: null == isAnnualView ? _self.isAnnualView : isAnnualView // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,analyticsState: freezed == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as FreeCashFlowTabViewState?,
  ));
}

/// Create a copy of CompanyFreeCashFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FreeCashFlowStatsCopyWith<$Res> get fcfStats {
  
  return $FreeCashFlowStatsCopyWith<$Res>(_self.fcfStats, (value) {
    return _then(_self.copyWith(fcfStats: value));
  });
}/// Create a copy of CompanyFreeCashFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FreeCashFlowTabViewStateCopyWith<$Res>? get analyticsState {
    if (_self.analyticsState == null) {
    return null;
  }

  return $FreeCashFlowTabViewStateCopyWith<$Res>(_self.analyticsState!, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanyFreeCashFlowState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanyFreeCashFlowState
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
  return 'CompanyFreeCashFlowState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanyFreeCashFlowStateCopyWith<$Res> {
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

/// Create a copy of CompanyFreeCashFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanyFreeCashFlowState
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
