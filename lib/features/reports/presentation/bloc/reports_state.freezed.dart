// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reports_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReportsState()';
}


}

/// @nodoc
class $ReportsStateCopyWith<$Res>  {
$ReportsStateCopyWith(ReportsState _, $Res Function(ReportsState) __);
}


/// Adds pattern-matching-related methods to [ReportsState].
extension ReportsStatePatterns on ReportsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReportsInitial value)?  initial,TResult Function( ReportsLoading value)?  loading,TResult Function( ReportsLoaded value)?  loaded,TResult Function( ReportsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReportsInitial value)  initial,required TResult Function( ReportsLoading value)  loading,required TResult Function( ReportsLoaded value)  loaded,required TResult Function( ReportsFailure value)  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial():
return initial(_that);case ReportsLoading():
return loading(_that);case ReportsLoaded():
return loaded(_that);case ReportsFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReportsInitial value)?  initial,TResult? Function( ReportsLoading value)?  loading,TResult? Function( ReportsLoaded value)?  loaded,TResult? Function( ReportsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial(_that);case ReportsLoading() when loading != null:
return loading(_that);case ReportsLoaded() when loaded != null:
return loaded(_that);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ReportsFeed feed,  DateTime today,  DateTime? lastViewedReports,  Set<String> seenWeeklyReportIds,  List<FilingViewModel> recentFilings,  List<WeeklyReport> recentWeeklyReports,  List<WeeklyReport> todaysWeeklyReports)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.feed,_that.today,_that.lastViewedReports,_that.seenWeeklyReportIds,_that.recentFilings,_that.recentWeeklyReports,_that.todaysWeeklyReports);case ReportsFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ReportsFeed feed,  DateTime today,  DateTime? lastViewedReports,  Set<String> seenWeeklyReportIds,  List<FilingViewModel> recentFilings,  List<WeeklyReport> recentWeeklyReports,  List<WeeklyReport> todaysWeeklyReports)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial():
return initial();case ReportsLoading():
return loading();case ReportsLoaded():
return loaded(_that.feed,_that.today,_that.lastViewedReports,_that.seenWeeklyReportIds,_that.recentFilings,_that.recentWeeklyReports,_that.todaysWeeklyReports);case ReportsFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ReportsFeed feed,  DateTime today,  DateTime? lastViewedReports,  Set<String> seenWeeklyReportIds,  List<FilingViewModel> recentFilings,  List<WeeklyReport> recentWeeklyReports,  List<WeeklyReport> todaysWeeklyReports)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ReportsInitial() when initial != null:
return initial();case ReportsLoading() when loading != null:
return loading();case ReportsLoaded() when loaded != null:
return loaded(_that.feed,_that.today,_that.lastViewedReports,_that.seenWeeklyReportIds,_that.recentFilings,_that.recentWeeklyReports,_that.todaysWeeklyReports);case ReportsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ReportsInitial implements ReportsState {
  const ReportsInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReportsState.initial()';
}


}




/// @nodoc


class ReportsLoading implements ReportsState {
  const ReportsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ReportsState.loading()';
}


}




/// @nodoc


class ReportsLoaded implements ReportsState {
  const ReportsLoaded(this.feed, {required this.today, this.lastViewedReports,  Set<String> seenWeeklyReportIds = const <String>{},  List<FilingViewModel> recentFilings = const [],  List<WeeklyReport> recentWeeklyReports = const [],  List<WeeklyReport> todaysWeeklyReports = const []}): _seenWeeklyReportIds = seenWeeklyReportIds,_recentFilings = recentFilings,_recentWeeklyReports = recentWeeklyReports,_todaysWeeklyReports = todaysWeeklyReports;
  

 final  ReportsFeed feed;
 final  DateTime today;
 final  DateTime? lastViewedReports;
 final  Set<String> _seenWeeklyReportIds;
@JsonKey() Set<String> get seenWeeklyReportIds {
  if (_seenWeeklyReportIds is EqualUnmodifiableSetView) return _seenWeeklyReportIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_seenWeeklyReportIds);
}

 final  List<FilingViewModel> _recentFilings;
@JsonKey() List<FilingViewModel> get recentFilings {
  if (_recentFilings is EqualUnmodifiableListView) return _recentFilings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentFilings);
}

 final  List<WeeklyReport> _recentWeeklyReports;
@JsonKey() List<WeeklyReport> get recentWeeklyReports {
  if (_recentWeeklyReports is EqualUnmodifiableListView) return _recentWeeklyReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentWeeklyReports);
}

 final  List<WeeklyReport> _todaysWeeklyReports;
@JsonKey() List<WeeklyReport> get todaysWeeklyReports {
  if (_todaysWeeklyReports is EqualUnmodifiableListView) return _todaysWeeklyReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todaysWeeklyReports);
}


/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsLoadedCopyWith<ReportsLoaded> get copyWith => _$ReportsLoadedCopyWithImpl<ReportsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsLoaded&&(identical(other.feed, feed) || other.feed == feed)&&(identical(other.today, today) || other.today == today)&&(identical(other.lastViewedReports, lastViewedReports) || other.lastViewedReports == lastViewedReports)&&const DeepCollectionEquality().equals(other.seenWeeklyReportIds, _seenWeeklyReportIds)&&const DeepCollectionEquality().equals(other.recentFilings, _recentFilings)&&const DeepCollectionEquality().equals(other.recentWeeklyReports, _recentWeeklyReports)&&const DeepCollectionEquality().equals(other.todaysWeeklyReports, _todaysWeeklyReports));
}


@override
int get hashCode {
    return Object.hash(runtimeType,feed,today,lastViewedReports,const DeepCollectionEquality().hash(_seenWeeklyReportIds),const DeepCollectionEquality().hash(_recentFilings),const DeepCollectionEquality().hash(_recentWeeklyReports),const DeepCollectionEquality().hash(_todaysWeeklyReports));
}

@override
String toString() {
    return 'ReportsState.loaded(feed: $feed, today: $today, lastViewedReports: $lastViewedReports, seenWeeklyReportIds: $seenWeeklyReportIds, recentFilings: $recentFilings, recentWeeklyReports: $recentWeeklyReports, todaysWeeklyReports: $todaysWeeklyReports)';
}


}

/// @nodoc
abstract mixin class $ReportsLoadedCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsLoadedCopyWith(ReportsLoaded value, $Res Function(ReportsLoaded) _then) = _$ReportsLoadedCopyWithImpl;
@useResult
$Res call({
 ReportsFeed feed, DateTime today, DateTime? lastViewedReports, Set<String> seenWeeklyReportIds, List<FilingViewModel> recentFilings, List<WeeklyReport> recentWeeklyReports, List<WeeklyReport> todaysWeeklyReports
});


$ReportsFeedCopyWith<$Res> get feed;

}
/// @nodoc
class _$ReportsLoadedCopyWithImpl<$Res>
    implements $ReportsLoadedCopyWith<$Res> {
  _$ReportsLoadedCopyWithImpl(this._self, this._then);

  final ReportsLoaded _self;
  final $Res Function(ReportsLoaded) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? feed = null,Object? today = null,Object? lastViewedReports = freezed,Object? seenWeeklyReportIds = null,Object? recentFilings = null,Object? recentWeeklyReports = null,Object? todaysWeeklyReports = null,}) {
  return _then(ReportsLoaded(
null == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as ReportsFeed,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as DateTime,lastViewedReports: freezed == lastViewedReports ? _self.lastViewedReports : lastViewedReports // ignore: cast_nullable_to_non_nullable
as DateTime?,seenWeeklyReportIds: null == seenWeeklyReportIds ? _self._seenWeeklyReportIds : seenWeeklyReportIds // ignore: cast_nullable_to_non_nullable
as Set<String>,recentFilings: null == recentFilings ? _self._recentFilings : recentFilings // ignore: cast_nullable_to_non_nullable
as List<FilingViewModel>,recentWeeklyReports: null == recentWeeklyReports ? _self._recentWeeklyReports : recentWeeklyReports // ignore: cast_nullable_to_non_nullable
as List<WeeklyReport>,todaysWeeklyReports: null == todaysWeeklyReports ? _self._todaysWeeklyReports : todaysWeeklyReports // ignore: cast_nullable_to_non_nullable
as List<WeeklyReport>,
  ));
}

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportsFeedCopyWith<$Res> get feed {
  
  return $ReportsFeedCopyWith<$Res>(_self.feed, (value) {
    return _then(_self.copyWith(feed: value));
  });
}
}

/// @nodoc


class ReportsFailure implements ReportsState {
  const ReportsFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportsFailureCopyWith<ReportsFailure> get copyWith => _$ReportsFailureCopyWithImpl<ReportsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'ReportsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ReportsFailureCopyWith<$Res> implements $ReportsStateCopyWith<$Res> {
  factory $ReportsFailureCopyWith(ReportsFailure value, $Res Function(ReportsFailure) _then) = _$ReportsFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ReportsFailureCopyWithImpl<$Res>
    implements $ReportsFailureCopyWith<$Res> {
  _$ReportsFailureCopyWithImpl(this._self, this._then);

  final ReportsFailure _self;
  final $Res Function(ReportsFailure) _then;

/// Create a copy of ReportsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ReportsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of ReportsState
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
