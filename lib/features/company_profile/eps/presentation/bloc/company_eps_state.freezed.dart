// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_eps_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyEpsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyEpsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsState()';
}


}

/// @nodoc
class $CompanyEpsStateCopyWith<$Res>  {
$CompanyEpsStateCopyWith(CompanyEpsState _, $Res Function(CompanyEpsState) __);
}


/// Adds pattern-matching-related methods to [CompanyEpsState].
extension CompanyEpsStatePatterns on CompanyEpsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( CompanyEpsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyEpsLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( CompanyEpsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case CompanyEpsLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( CompanyEpsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanyEpsLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String ticker,  EpsStats epsStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  EpsTabViewState? analyticsState)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyEpsLoaded() when loaded != null:
return loaded(_that.ticker,_that.epsStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String ticker,  EpsStats epsStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  EpsTabViewState? analyticsState)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case CompanyEpsLoaded():
return loaded(_that.ticker,_that.epsStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String ticker,  EpsStats epsStats,  List<ChartDataPoint> annualChartData,  List<ChartDataPoint> quarterlyChartData,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  DateTime? lastUpdated,  EpsTabViewState? analyticsState)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanyEpsLoaded() when loaded != null:
return loaded(_that.ticker,_that.epsStats,_that.annualChartData,_that.quarterlyChartData,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyEpsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyEpsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyEpsState.loading()';
}


}




/// @nodoc


class CompanyEpsLoaded implements CompanyEpsState {
  const CompanyEpsLoaded({required this.ticker, required this.epsStats, required final  List<ChartDataPoint> annualChartData, required final  List<ChartDataPoint> quarterlyChartData, required this.historyLimit, required this.dataOrigin, this.isAnnualView = true, this.lastUpdated, this.analyticsState}): _annualChartData = annualChartData,_quarterlyChartData = quarterlyChartData;
  

 final  String ticker;
 final  EpsStats epsStats;
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
 final  EpsTabViewState? analyticsState;

/// Create a copy of CompanyEpsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyEpsLoadedCopyWith<CompanyEpsLoaded> get copyWith => _$CompanyEpsLoadedCopyWithImpl<CompanyEpsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyEpsLoaded&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.epsStats, epsStats) || other.epsStats == epsStats)&&const DeepCollectionEquality().equals(other._annualChartData, _annualChartData)&&const DeepCollectionEquality().equals(other._quarterlyChartData, _quarterlyChartData)&&(identical(other.historyLimit, historyLimit) || other.historyLimit == historyLimit)&&(identical(other.dataOrigin, dataOrigin) || other.dataOrigin == dataOrigin)&&(identical(other.isAnnualView, isAnnualView) || other.isAnnualView == isAnnualView)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,epsStats,const DeepCollectionEquality().hash(_annualChartData),const DeepCollectionEquality().hash(_quarterlyChartData),historyLimit,dataOrigin,isAnnualView,lastUpdated,analyticsState);

@override
String toString() {
  return 'CompanyEpsState.loaded(ticker: $ticker, epsStats: $epsStats, annualChartData: $annualChartData, quarterlyChartData: $quarterlyChartData, historyLimit: $historyLimit, dataOrigin: $dataOrigin, isAnnualView: $isAnnualView, lastUpdated: $lastUpdated, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $CompanyEpsLoadedCopyWith<$Res> implements $CompanyEpsStateCopyWith<$Res> {
  factory $CompanyEpsLoadedCopyWith(CompanyEpsLoaded value, $Res Function(CompanyEpsLoaded) _then) = _$CompanyEpsLoadedCopyWithImpl;
@useResult
$Res call({
 String ticker, EpsStats epsStats, List<ChartDataPoint> annualChartData, List<ChartDataPoint> quarterlyChartData, int historyLimit, CompanyProfileDataOrigin dataOrigin, bool isAnnualView, DateTime? lastUpdated, EpsTabViewState? analyticsState
});


$EpsStatsCopyWith<$Res> get epsStats;$EpsTabViewStateCopyWith<$Res>? get analyticsState;

}
/// @nodoc
class _$CompanyEpsLoadedCopyWithImpl<$Res>
    implements $CompanyEpsLoadedCopyWith<$Res> {
  _$CompanyEpsLoadedCopyWithImpl(this._self, this._then);

  final CompanyEpsLoaded _self;
  final $Res Function(CompanyEpsLoaded) _then;

/// Create a copy of CompanyEpsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? epsStats = null,Object? annualChartData = null,Object? quarterlyChartData = null,Object? historyLimit = null,Object? dataOrigin = null,Object? isAnnualView = null,Object? lastUpdated = freezed,Object? analyticsState = freezed,}) {
  return _then(CompanyEpsLoaded(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,epsStats: null == epsStats ? _self.epsStats : epsStats // ignore: cast_nullable_to_non_nullable
as EpsStats,annualChartData: null == annualChartData ? _self._annualChartData : annualChartData // ignore: cast_nullable_to_non_nullable
as List<ChartDataPoint>,quarterlyChartData: null == quarterlyChartData ? _self._quarterlyChartData : quarterlyChartData // ignore: cast_nullable_to_non_nullable
as List<ChartDataPoint>,historyLimit: null == historyLimit ? _self.historyLimit : historyLimit // ignore: cast_nullable_to_non_nullable
as int,dataOrigin: null == dataOrigin ? _self.dataOrigin : dataOrigin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,isAnnualView: null == isAnnualView ? _self.isAnnualView : isAnnualView // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,analyticsState: freezed == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as EpsTabViewState?,
  ));
}

/// Create a copy of CompanyEpsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpsStatsCopyWith<$Res> get epsStats {
  
  return $EpsStatsCopyWith<$Res>(_self.epsStats, (value) {
    return _then(_self.copyWith(epsStats: value));
  });
}/// Create a copy of CompanyEpsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpsTabViewStateCopyWith<$Res>? get analyticsState {
    if (_self.analyticsState == null) {
    return null;
  }

  return $EpsTabViewStateCopyWith<$Res>(_self.analyticsState!, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanyEpsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanyEpsState
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
  return 'CompanyEpsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanyEpsStateCopyWith<$Res> {
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

/// Create a copy of CompanyEpsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanyEpsState
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
