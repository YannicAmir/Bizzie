// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_chart_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceChartEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceChartEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PriceChartEvent()';
}


}

/// @nodoc
class $PriceChartEventCopyWith<$Res>  {
$PriceChartEventCopyWith(PriceChartEvent _, $Res Function(PriceChartEvent) __);
}


/// Adds pattern-matching-related methods to [PriceChartEvent].
extension PriceChartEventPatterns on PriceChartEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryUpdated value)?  historyUpdated,TResult Function( TimeFrameChanged value)?  timeFrameChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryUpdated() when historyUpdated != null:
return historyUpdated(_that);case TimeFrameChanged() when timeFrameChanged != null:
return timeFrameChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryUpdated value)  historyUpdated,required TResult Function( TimeFrameChanged value)  timeFrameChanged,}){
final _that = this;
switch (_that) {
case HistoryUpdated():
return historyUpdated(_that);case TimeFrameChanged():
return timeFrameChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryUpdated value)?  historyUpdated,TResult? Function( TimeFrameChanged value)?  timeFrameChanged,}){
final _that = this;
switch (_that) {
case HistoryUpdated() when historyUpdated != null:
return historyUpdated(_that);case TimeFrameChanged() when timeFrameChanged != null:
return timeFrameChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<HistoricalPriceEod> history)?  historyUpdated,TResult Function( ChartTimeFrame timeFrame)?  timeFrameChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryUpdated() when historyUpdated != null:
return historyUpdated(_that.history);case TimeFrameChanged() when timeFrameChanged != null:
return timeFrameChanged(_that.timeFrame);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<HistoricalPriceEod> history)  historyUpdated,required TResult Function( ChartTimeFrame timeFrame)  timeFrameChanged,}) {final _that = this;
switch (_that) {
case HistoryUpdated():
return historyUpdated(_that.history);case TimeFrameChanged():
return timeFrameChanged(_that.timeFrame);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<HistoricalPriceEod> history)?  historyUpdated,TResult? Function( ChartTimeFrame timeFrame)?  timeFrameChanged,}) {final _that = this;
switch (_that) {
case HistoryUpdated() when historyUpdated != null:
return historyUpdated(_that.history);case TimeFrameChanged() when timeFrameChanged != null:
return timeFrameChanged(_that.timeFrame);case _:
  return null;

}
}

}

/// @nodoc


class HistoryUpdated implements PriceChartEvent {
  const HistoryUpdated(final  List<HistoricalPriceEod> history): _history = history;
  

 final  List<HistoricalPriceEod> _history;
 List<HistoricalPriceEod> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of PriceChartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryUpdatedCopyWith<HistoryUpdated> get copyWith => _$HistoryUpdatedCopyWithImpl<HistoryUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryUpdated&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'PriceChartEvent.historyUpdated(history: $history)';
}


}

/// @nodoc
abstract mixin class $HistoryUpdatedCopyWith<$Res> implements $PriceChartEventCopyWith<$Res> {
  factory $HistoryUpdatedCopyWith(HistoryUpdated value, $Res Function(HistoryUpdated) _then) = _$HistoryUpdatedCopyWithImpl;
@useResult
$Res call({
 List<HistoricalPriceEod> history
});




}
/// @nodoc
class _$HistoryUpdatedCopyWithImpl<$Res>
    implements $HistoryUpdatedCopyWith<$Res> {
  _$HistoryUpdatedCopyWithImpl(this._self, this._then);

  final HistoryUpdated _self;
  final $Res Function(HistoryUpdated) _then;

/// Create a copy of PriceChartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(HistoryUpdated(
null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<HistoricalPriceEod>,
  ));
}


}

/// @nodoc


class TimeFrameChanged implements PriceChartEvent {
  const TimeFrameChanged(this.timeFrame);
  

 final  ChartTimeFrame timeFrame;

/// Create a copy of PriceChartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeFrameChangedCopyWith<TimeFrameChanged> get copyWith => _$TimeFrameChangedCopyWithImpl<TimeFrameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeFrameChanged&&(identical(other.timeFrame, timeFrame) || other.timeFrame == timeFrame));
}


@override
int get hashCode => Object.hash(runtimeType,timeFrame);

@override
String toString() {
  return 'PriceChartEvent.timeFrameChanged(timeFrame: $timeFrame)';
}


}

/// @nodoc
abstract mixin class $TimeFrameChangedCopyWith<$Res> implements $PriceChartEventCopyWith<$Res> {
  factory $TimeFrameChangedCopyWith(TimeFrameChanged value, $Res Function(TimeFrameChanged) _then) = _$TimeFrameChangedCopyWithImpl;
@useResult
$Res call({
 ChartTimeFrame timeFrame
});




}
/// @nodoc
class _$TimeFrameChangedCopyWithImpl<$Res>
    implements $TimeFrameChangedCopyWith<$Res> {
  _$TimeFrameChangedCopyWithImpl(this._self, this._then);

  final TimeFrameChanged _self;
  final $Res Function(TimeFrameChanged) _then;

/// Create a copy of PriceChartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeFrame = null,}) {
  return _then(TimeFrameChanged(
null == timeFrame ? _self.timeFrame : timeFrame // ignore: cast_nullable_to_non_nullable
as ChartTimeFrame,
  ));
}


}

// dart format on
