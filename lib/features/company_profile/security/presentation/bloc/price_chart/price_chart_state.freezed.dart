// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceChartState {

 List<HistoricalPriceEod> get fullHistory; List<HistoricalPriceEod> get viewData; ChartTimeFrame get selectedTimeFrame; int get chartChangeCount;
/// Create a copy of PriceChartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceChartStateCopyWith<PriceChartState> get copyWith => _$PriceChartStateCopyWithImpl<PriceChartState>(this as PriceChartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceChartState&&const DeepCollectionEquality().equals(other.fullHistory, fullHistory)&&const DeepCollectionEquality().equals(other.viewData, viewData)&&(identical(other.selectedTimeFrame, selectedTimeFrame) || other.selectedTimeFrame == selectedTimeFrame)&&(identical(other.chartChangeCount, chartChangeCount) || other.chartChangeCount == chartChangeCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fullHistory),const DeepCollectionEquality().hash(viewData),selectedTimeFrame,chartChangeCount);

@override
String toString() {
  return 'PriceChartState(fullHistory: $fullHistory, viewData: $viewData, selectedTimeFrame: $selectedTimeFrame, chartChangeCount: $chartChangeCount)';
}


}

/// @nodoc
abstract mixin class $PriceChartStateCopyWith<$Res>  {
  factory $PriceChartStateCopyWith(PriceChartState value, $Res Function(PriceChartState) _then) = _$PriceChartStateCopyWithImpl;
@useResult
$Res call({
 List<HistoricalPriceEod> fullHistory, List<HistoricalPriceEod> viewData, ChartTimeFrame selectedTimeFrame, int chartChangeCount
});




}
/// @nodoc
class _$PriceChartStateCopyWithImpl<$Res>
    implements $PriceChartStateCopyWith<$Res> {
  _$PriceChartStateCopyWithImpl(this._self, this._then);

  final PriceChartState _self;
  final $Res Function(PriceChartState) _then;

/// Create a copy of PriceChartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullHistory = null,Object? viewData = null,Object? selectedTimeFrame = null,Object? chartChangeCount = null,}) {
  return _then(_self.copyWith(
fullHistory: null == fullHistory ? _self.fullHistory : fullHistory // ignore: cast_nullable_to_non_nullable
as List<HistoricalPriceEod>,viewData: null == viewData ? _self.viewData : viewData // ignore: cast_nullable_to_non_nullable
as List<HistoricalPriceEod>,selectedTimeFrame: null == selectedTimeFrame ? _self.selectedTimeFrame : selectedTimeFrame // ignore: cast_nullable_to_non_nullable
as ChartTimeFrame,chartChangeCount: null == chartChangeCount ? _self.chartChangeCount : chartChangeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceChartState].
extension PriceChartStatePatterns on PriceChartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceChartState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceChartState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceChartState value)  $default,){
final _that = this;
switch (_that) {
case _PriceChartState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceChartState value)?  $default,){
final _that = this;
switch (_that) {
case _PriceChartState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HistoricalPriceEod> fullHistory,  List<HistoricalPriceEod> viewData,  ChartTimeFrame selectedTimeFrame,  int chartChangeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceChartState() when $default != null:
return $default(_that.fullHistory,_that.viewData,_that.selectedTimeFrame,_that.chartChangeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HistoricalPriceEod> fullHistory,  List<HistoricalPriceEod> viewData,  ChartTimeFrame selectedTimeFrame,  int chartChangeCount)  $default,) {final _that = this;
switch (_that) {
case _PriceChartState():
return $default(_that.fullHistory,_that.viewData,_that.selectedTimeFrame,_that.chartChangeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HistoricalPriceEod> fullHistory,  List<HistoricalPriceEod> viewData,  ChartTimeFrame selectedTimeFrame,  int chartChangeCount)?  $default,) {final _that = this;
switch (_that) {
case _PriceChartState() when $default != null:
return $default(_that.fullHistory,_that.viewData,_that.selectedTimeFrame,_that.chartChangeCount);case _:
  return null;

}
}

}

/// @nodoc


class _PriceChartState extends PriceChartState {
  const _PriceChartState({required final  List<HistoricalPriceEod> fullHistory, required final  List<HistoricalPriceEod> viewData, required this.selectedTimeFrame, this.chartChangeCount = 0}): _fullHistory = fullHistory,_viewData = viewData,super._();
  

 final  List<HistoricalPriceEod> _fullHistory;
@override List<HistoricalPriceEod> get fullHistory {
  if (_fullHistory is EqualUnmodifiableListView) return _fullHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fullHistory);
}

 final  List<HistoricalPriceEod> _viewData;
@override List<HistoricalPriceEod> get viewData {
  if (_viewData is EqualUnmodifiableListView) return _viewData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_viewData);
}

@override final  ChartTimeFrame selectedTimeFrame;
@override@JsonKey() final  int chartChangeCount;

/// Create a copy of PriceChartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceChartStateCopyWith<_PriceChartState> get copyWith => __$PriceChartStateCopyWithImpl<_PriceChartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceChartState&&const DeepCollectionEquality().equals(other._fullHistory, _fullHistory)&&const DeepCollectionEquality().equals(other._viewData, _viewData)&&(identical(other.selectedTimeFrame, selectedTimeFrame) || other.selectedTimeFrame == selectedTimeFrame)&&(identical(other.chartChangeCount, chartChangeCount) || other.chartChangeCount == chartChangeCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fullHistory),const DeepCollectionEquality().hash(_viewData),selectedTimeFrame,chartChangeCount);

@override
String toString() {
  return 'PriceChartState(fullHistory: $fullHistory, viewData: $viewData, selectedTimeFrame: $selectedTimeFrame, chartChangeCount: $chartChangeCount)';
}


}

/// @nodoc
abstract mixin class _$PriceChartStateCopyWith<$Res> implements $PriceChartStateCopyWith<$Res> {
  factory _$PriceChartStateCopyWith(_PriceChartState value, $Res Function(_PriceChartState) _then) = __$PriceChartStateCopyWithImpl;
@override @useResult
$Res call({
 List<HistoricalPriceEod> fullHistory, List<HistoricalPriceEod> viewData, ChartTimeFrame selectedTimeFrame, int chartChangeCount
});




}
/// @nodoc
class __$PriceChartStateCopyWithImpl<$Res>
    implements _$PriceChartStateCopyWith<$Res> {
  __$PriceChartStateCopyWithImpl(this._self, this._then);

  final _PriceChartState _self;
  final $Res Function(_PriceChartState) _then;

/// Create a copy of PriceChartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullHistory = null,Object? viewData = null,Object? selectedTimeFrame = null,Object? chartChangeCount = null,}) {
  return _then(_PriceChartState(
fullHistory: null == fullHistory ? _self._fullHistory : fullHistory // ignore: cast_nullable_to_non_nullable
as List<HistoricalPriceEod>,viewData: null == viewData ? _self._viewData : viewData // ignore: cast_nullable_to_non_nullable
as List<HistoricalPriceEod>,selectedTimeFrame: null == selectedTimeFrame ? _self.selectedTimeFrame : selectedTimeFrame // ignore: cast_nullable_to_non_nullable
as ChartTimeFrame,chartChangeCount: null == chartChangeCount ? _self.chartChangeCount : chartChangeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
