// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_pfcf_ratio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyPfcfRatioState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyPfcfRatioState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyPfcfRatioState()';
}


}

/// @nodoc
class $CompanyPfcfRatioStateCopyWith<$Res>  {
$CompanyPfcfRatioStateCopyWith(CompanyPfcfRatioState _, $Res Function(CompanyPfcfRatioState) __);
}


/// Adds pattern-matching-related methods to [CompanyPfcfRatioState].
extension CompanyPfcfRatioStatePatterns on CompanyPfcfRatioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String ticker,  List<FinancialDataPoint> dataPoints,  List<ChartDataPoint> chartData,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.ticker,_that.dataPoints,_that.chartData,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel,_that.historyLimit,_that.dataOrigin,_that.lastUpdated);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String ticker,  List<FinancialDataPoint> dataPoints,  List<ChartDataPoint> chartData,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.ticker,_that.dataPoints,_that.chartData,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel,_that.historyLimit,_that.dataOrigin,_that.lastUpdated);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String ticker,  List<FinancialDataPoint> dataPoints,  List<ChartDataPoint> chartData,  double currentValue,  double growthPercentage,  double absoluteDelta,  bool isPositive,  String referenceLabel,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  DateTime? lastUpdated)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.ticker,_that.dataPoints,_that.chartData,_that.currentValue,_that.growthPercentage,_that.absoluteDelta,_that.isPositive,_that.referenceLabel,_that.historyLimit,_that.dataOrigin,_that.lastUpdated);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyPfcfRatioState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyPfcfRatioState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyPfcfRatioState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyPfcfRatioState.loading()';
}


}




/// @nodoc


class _Loaded implements CompanyPfcfRatioState {
  const _Loaded({required this.ticker, required final  List<FinancialDataPoint> dataPoints, required final  List<ChartDataPoint> chartData, required this.currentValue, required this.growthPercentage, required this.absoluteDelta, required this.isPositive, required this.referenceLabel, required this.historyLimit, required this.dataOrigin, this.lastUpdated}): _dataPoints = dataPoints,_chartData = chartData;
  

 final  String ticker;
 final  List<FinancialDataPoint> _dataPoints;
 List<FinancialDataPoint> get dataPoints {
  if (_dataPoints is EqualUnmodifiableListView) return _dataPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataPoints);
}

 final  List<ChartDataPoint> _chartData;
 List<ChartDataPoint> get chartData {
  if (_chartData is EqualUnmodifiableListView) return _chartData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chartData);
}

 final  double currentValue;
 final  double growthPercentage;
 final  double absoluteDelta;
 final  bool isPositive;
 final  String referenceLabel;
 final  int historyLimit;
 final  CompanyProfileDataOrigin dataOrigin;
 final  DateTime? lastUpdated;

/// Create a copy of CompanyPfcfRatioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.ticker, ticker) || other.ticker == ticker)&&const DeepCollectionEquality().equals(other._dataPoints, _dataPoints)&&const DeepCollectionEquality().equals(other._chartData, _chartData)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.absoluteDelta, absoluteDelta) || other.absoluteDelta == absoluteDelta)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive)&&(identical(other.referenceLabel, referenceLabel) || other.referenceLabel == referenceLabel)&&(identical(other.historyLimit, historyLimit) || other.historyLimit == historyLimit)&&(identical(other.dataOrigin, dataOrigin) || other.dataOrigin == dataOrigin)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,const DeepCollectionEquality().hash(_dataPoints),const DeepCollectionEquality().hash(_chartData),currentValue,growthPercentage,absoluteDelta,isPositive,referenceLabel,historyLimit,dataOrigin,lastUpdated);

@override
String toString() {
  return 'CompanyPfcfRatioState.loaded(ticker: $ticker, dataPoints: $dataPoints, chartData: $chartData, currentValue: $currentValue, growthPercentage: $growthPercentage, absoluteDelta: $absoluteDelta, isPositive: $isPositive, referenceLabel: $referenceLabel, historyLimit: $historyLimit, dataOrigin: $dataOrigin, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $CompanyPfcfRatioStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 String ticker, List<FinancialDataPoint> dataPoints, List<ChartDataPoint> chartData, double currentValue, double growthPercentage, double absoluteDelta, bool isPositive, String referenceLabel, int historyLimit, CompanyProfileDataOrigin dataOrigin, DateTime? lastUpdated
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of CompanyPfcfRatioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? dataPoints = null,Object? chartData = null,Object? currentValue = null,Object? growthPercentage = null,Object? absoluteDelta = null,Object? isPositive = null,Object? referenceLabel = null,Object? historyLimit = null,Object? dataOrigin = null,Object? lastUpdated = freezed,}) {
  return _then(_Loaded(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,dataPoints: null == dataPoints ? _self._dataPoints : dataPoints // ignore: cast_nullable_to_non_nullable
as List<FinancialDataPoint>,chartData: null == chartData ? _self._chartData : chartData // ignore: cast_nullable_to_non_nullable
as List<ChartDataPoint>,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as double,absoluteDelta: null == absoluteDelta ? _self.absoluteDelta : absoluteDelta // ignore: cast_nullable_to_non_nullable
as double,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,referenceLabel: null == referenceLabel ? _self.referenceLabel : referenceLabel // ignore: cast_nullable_to_non_nullable
as String,historyLimit: null == historyLimit ? _self.historyLimit : historyLimit // ignore: cast_nullable_to_non_nullable
as int,dataOrigin: null == dataOrigin ? _self.dataOrigin : dataOrigin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class _Failure implements CompanyPfcfRatioState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanyPfcfRatioState
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
  return 'CompanyPfcfRatioState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanyPfcfRatioStateCopyWith<$Res> {
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

/// Create a copy of CompanyPfcfRatioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanyPfcfRatioState
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
