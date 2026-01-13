// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent()';
}


}

/// @nodoc
class $ReportsEventCopyWith<$Res>  {
$ReportsEventCopyWith(ReportsEvent _, $Res Function(ReportsEvent) __);
}


/// Adds pattern-matching-related methods to [ReportsEvent].
extension ReportsEventPatterns on ReportsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Refresh value)?  refresh,TResult Function( WatchlistUpdated value)?  watchlistUpdated,TResult Function( ReportsUpdated value)?  reportsUpdated,TResult Function( Viewed value)?  viewed,TResult Function( ActivityUpdated value)?  activityUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refresh() when refresh != null:
return refresh(_that);case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that);case Viewed() when viewed != null:
return viewed(_that);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Refresh value)  refresh,required TResult Function( WatchlistUpdated value)  watchlistUpdated,required TResult Function( ReportsUpdated value)  reportsUpdated,required TResult Function( Viewed value)  viewed,required TResult Function( ActivityUpdated value)  activityUpdated,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Refresh():
return refresh(_that);case WatchlistUpdated():
return watchlistUpdated(_that);case ReportsUpdated():
return reportsUpdated(_that);case Viewed():
return viewed(_that);case ActivityUpdated():
return activityUpdated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Refresh value)?  refresh,TResult? Function( WatchlistUpdated value)?  watchlistUpdated,TResult? Function( ReportsUpdated value)?  reportsUpdated,TResult? Function( Viewed value)?  viewed,TResult? Function( ActivityUpdated value)?  activityUpdated,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refresh() when refresh != null:
return refresh(_that);case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that);case Viewed() when viewed != null:
return viewed(_that);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refresh,TResult Function( List<String> tickers)?  watchlistUpdated,TResult Function( Either<Failure, ReportsFeed> result)?  reportsUpdated,TResult Function()?  viewed,TResult Function( DateTime? lastViewedReports)?  activityUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refresh() when refresh != null:
return refresh();case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that.tickers);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that.result);case Viewed() when viewed != null:
return viewed();case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that.lastViewedReports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refresh,required TResult Function( List<String> tickers)  watchlistUpdated,required TResult Function( Either<Failure, ReportsFeed> result)  reportsUpdated,required TResult Function()  viewed,required TResult Function( DateTime? lastViewedReports)  activityUpdated,}) {final _that = this;
switch (_that) {
case Started():
return started();case Refresh():
return refresh();case WatchlistUpdated():
return watchlistUpdated(_that.tickers);case ReportsUpdated():
return reportsUpdated(_that.result);case Viewed():
return viewed();case ActivityUpdated():
return activityUpdated(_that.lastViewedReports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refresh,TResult? Function( List<String> tickers)?  watchlistUpdated,TResult? Function( Either<Failure, ReportsFeed> result)?  reportsUpdated,TResult? Function()?  viewed,TResult? Function( DateTime? lastViewedReports)?  activityUpdated,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case Refresh() when refresh != null:
return refresh();case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that.tickers);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that.result);case Viewed() when viewed != null:
return viewed();case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that.lastViewedReports);case _:
  return null;

}
}

}

/// @nodoc


class Started implements ReportsEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.started()';
}


}




/// @nodoc


class Refresh implements ReportsEvent {
  const Refresh();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.refresh()';
}


}




/// @nodoc


class WatchlistUpdated implements ReportsEvent {
  const WatchlistUpdated(final  List<String> tickers): _tickers = tickers;
  

 final  List<String> _tickers;
 List<String> get tickers {
  if (_tickers is EqualUnmodifiableListView) return _tickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickers);
}


/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistUpdatedCopyWith<WatchlistUpdated> get copyWith => _$WatchlistUpdatedCopyWithImpl<WatchlistUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistUpdated&&const DeepCollectionEquality().equals(other._tickers, _tickers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickers));

@override
String toString() {
  return 'ReportsEvent.watchlistUpdated(tickers: $tickers)';
}


}

/// @nodoc
abstract mixin class $WatchlistUpdatedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $WatchlistUpdatedCopyWith(WatchlistUpdated value, $Res Function(WatchlistUpdated) _then) = _$WatchlistUpdatedCopyWithImpl;
@useResult
$Res call({
 List<String> tickers
});




}
/// @nodoc
class _$WatchlistUpdatedCopyWithImpl<$Res>
    implements $WatchlistUpdatedCopyWith<$Res> {
  _$WatchlistUpdatedCopyWithImpl(this._self, this._then);

  final WatchlistUpdated _self;
  final $Res Function(WatchlistUpdated) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tickers = null,}) {
  return _then(WatchlistUpdated(
null == tickers ? _self._tickers : tickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class ReportsUpdated implements ReportsEvent {
  const ReportsUpdated(this.result);
  

 final  Either<Failure, ReportsFeed> result;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsUpdatedCopyWith<ReportsUpdated> get copyWith => _$ReportsUpdatedCopyWithImpl<ReportsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsUpdated&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ReportsEvent.reportsUpdated(result: $result)';
}


}

/// @nodoc
abstract mixin class $ReportsUpdatedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ReportsUpdatedCopyWith(ReportsUpdated value, $Res Function(ReportsUpdated) _then) = _$ReportsUpdatedCopyWithImpl;
@useResult
$Res call({
 Either<Failure, ReportsFeed> result
});




}
/// @nodoc
class _$ReportsUpdatedCopyWithImpl<$Res>
    implements $ReportsUpdatedCopyWith<$Res> {
  _$ReportsUpdatedCopyWithImpl(this._self, this._then);

  final ReportsUpdated _self;
  final $Res Function(ReportsUpdated) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ReportsUpdated(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Either<Failure, ReportsFeed>,
  ));
}


}

/// @nodoc


class Viewed implements ReportsEvent {
  const Viewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Viewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.viewed()';
}


}




/// @nodoc


class ActivityUpdated implements ReportsEvent {
  const ActivityUpdated(this.lastViewedReports);
  

 final  DateTime? lastViewedReports;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityUpdatedCopyWith<ActivityUpdated> get copyWith => _$ActivityUpdatedCopyWithImpl<ActivityUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityUpdated&&(identical(other.lastViewedReports, lastViewedReports) || other.lastViewedReports == lastViewedReports));
}


@override
int get hashCode => Object.hash(runtimeType,lastViewedReports);

@override
String toString() {
  return 'ReportsEvent.activityUpdated(lastViewedReports: $lastViewedReports)';
}


}

/// @nodoc
abstract mixin class $ActivityUpdatedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ActivityUpdatedCopyWith(ActivityUpdated value, $Res Function(ActivityUpdated) _then) = _$ActivityUpdatedCopyWithImpl;
@useResult
$Res call({
 DateTime? lastViewedReports
});




}
/// @nodoc
class _$ActivityUpdatedCopyWithImpl<$Res>
    implements $ActivityUpdatedCopyWith<$Res> {
  _$ActivityUpdatedCopyWithImpl(this._self, this._then);

  final ActivityUpdated _self;
  final $Res Function(ActivityUpdated) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastViewedReports = freezed,}) {
  return _then(ActivityUpdated(
freezed == lastViewedReports ? _self.lastViewedReports : lastViewedReports // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
