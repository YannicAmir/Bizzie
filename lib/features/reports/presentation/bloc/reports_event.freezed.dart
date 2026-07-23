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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( Refresh value)?  refresh,TResult Function( WatchlistUpdated value)?  watchlistUpdated,TResult Function( ReportsUpdated value)?  reportsUpdated,TResult Function( Viewed value)?  viewed,TResult Function( LinkOpened value)?  linkOpened,TResult Function( SummaryRequested value)?  summaryRequested,TResult Function( SummarizeLockedClicked value)?  summarizeLockedClicked,TResult Function( UpcomingExpanded value)?  upcomingExpanded,TResult Function( UpcomingCompanyClicked value)?  upcomingCompanyClicked,TResult Function( YtdCompanyClicked value)?  ytdCompanyClicked,TResult Function( FilingCardCompanyClicked value)?  filingCardCompanyClicked,TResult Function( EmptyCtaClicked value)?  emptyCtaClicked,TResult Function( MarketNewsArticleOpened value)?  marketNewsArticleOpened,TResult Function( MarketNewsLoadFailed value)?  marketNewsLoadFailed,TResult Function( ActivityUpdated value)?  activityUpdated,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refresh() when refresh != null:
return refresh(_that);case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that);case Viewed() when viewed != null:
return viewed(_that);case LinkOpened() when linkOpened != null:
return linkOpened(_that);case SummaryRequested() when summaryRequested != null:
return summaryRequested(_that);case SummarizeLockedClicked() when summarizeLockedClicked != null:
return summarizeLockedClicked(_that);case UpcomingExpanded() when upcomingExpanded != null:
return upcomingExpanded(_that);case UpcomingCompanyClicked() when upcomingCompanyClicked != null:
return upcomingCompanyClicked(_that);case YtdCompanyClicked() when ytdCompanyClicked != null:
return ytdCompanyClicked(_that);case FilingCardCompanyClicked() when filingCardCompanyClicked != null:
return filingCardCompanyClicked(_that);case EmptyCtaClicked() when emptyCtaClicked != null:
return emptyCtaClicked(_that);case MarketNewsArticleOpened() when marketNewsArticleOpened != null:
return marketNewsArticleOpened(_that);case MarketNewsLoadFailed() when marketNewsLoadFailed != null:
return marketNewsLoadFailed(_that);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( Refresh value)  refresh,required TResult Function( WatchlistUpdated value)  watchlistUpdated,required TResult Function( ReportsUpdated value)  reportsUpdated,required TResult Function( Viewed value)  viewed,required TResult Function( LinkOpened value)  linkOpened,required TResult Function( SummaryRequested value)  summaryRequested,required TResult Function( SummarizeLockedClicked value)  summarizeLockedClicked,required TResult Function( UpcomingExpanded value)  upcomingExpanded,required TResult Function( UpcomingCompanyClicked value)  upcomingCompanyClicked,required TResult Function( YtdCompanyClicked value)  ytdCompanyClicked,required TResult Function( FilingCardCompanyClicked value)  filingCardCompanyClicked,required TResult Function( EmptyCtaClicked value)  emptyCtaClicked,required TResult Function( MarketNewsArticleOpened value)  marketNewsArticleOpened,required TResult Function( MarketNewsLoadFailed value)  marketNewsLoadFailed,required TResult Function( ActivityUpdated value)  activityUpdated,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case Refresh():
return refresh(_that);case WatchlistUpdated():
return watchlistUpdated(_that);case ReportsUpdated():
return reportsUpdated(_that);case Viewed():
return viewed(_that);case LinkOpened():
return linkOpened(_that);case SummaryRequested():
return summaryRequested(_that);case SummarizeLockedClicked():
return summarizeLockedClicked(_that);case UpcomingExpanded():
return upcomingExpanded(_that);case UpcomingCompanyClicked():
return upcomingCompanyClicked(_that);case YtdCompanyClicked():
return ytdCompanyClicked(_that);case FilingCardCompanyClicked():
return filingCardCompanyClicked(_that);case EmptyCtaClicked():
return emptyCtaClicked(_that);case MarketNewsArticleOpened():
return marketNewsArticleOpened(_that);case MarketNewsLoadFailed():
return marketNewsLoadFailed(_that);case ActivityUpdated():
return activityUpdated(_that);case Reset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( Refresh value)?  refresh,TResult? Function( WatchlistUpdated value)?  watchlistUpdated,TResult? Function( ReportsUpdated value)?  reportsUpdated,TResult? Function( Viewed value)?  viewed,TResult? Function( LinkOpened value)?  linkOpened,TResult? Function( SummaryRequested value)?  summaryRequested,TResult? Function( SummarizeLockedClicked value)?  summarizeLockedClicked,TResult? Function( UpcomingExpanded value)?  upcomingExpanded,TResult? Function( UpcomingCompanyClicked value)?  upcomingCompanyClicked,TResult? Function( YtdCompanyClicked value)?  ytdCompanyClicked,TResult? Function( FilingCardCompanyClicked value)?  filingCardCompanyClicked,TResult? Function( EmptyCtaClicked value)?  emptyCtaClicked,TResult? Function( MarketNewsArticleOpened value)?  marketNewsArticleOpened,TResult? Function( MarketNewsLoadFailed value)?  marketNewsLoadFailed,TResult? Function( ActivityUpdated value)?  activityUpdated,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case Refresh() when refresh != null:
return refresh(_that);case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that);case Viewed() when viewed != null:
return viewed(_that);case LinkOpened() when linkOpened != null:
return linkOpened(_that);case SummaryRequested() when summaryRequested != null:
return summaryRequested(_that);case SummarizeLockedClicked() when summarizeLockedClicked != null:
return summarizeLockedClicked(_that);case UpcomingExpanded() when upcomingExpanded != null:
return upcomingExpanded(_that);case UpcomingCompanyClicked() when upcomingCompanyClicked != null:
return upcomingCompanyClicked(_that);case YtdCompanyClicked() when ytdCompanyClicked != null:
return ytdCompanyClicked(_that);case FilingCardCompanyClicked() when filingCardCompanyClicked != null:
return filingCardCompanyClicked(_that);case EmptyCtaClicked() when emptyCtaClicked != null:
return emptyCtaClicked(_that);case MarketNewsArticleOpened() when marketNewsArticleOpened != null:
return marketNewsArticleOpened(_that);case MarketNewsLoadFailed() when marketNewsLoadFailed != null:
return marketNewsLoadFailed(_that);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that);case Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? uid)?  started,TResult Function()?  refresh,TResult Function( List<String> tickers)?  watchlistUpdated,TResult Function( Either<Failure, ReportsFeed> result)?  reportsUpdated,TResult Function( int unreadCount,  ReportsEntrySource entrySource,  ReportsNotificationType? notificationType)?  viewed,TResult Function( String ticker,  String filingType)?  linkOpened,TResult Function( String ticker,  String filingType,  bool isReady)?  summaryRequested,TResult Function( String ticker,  String filingType)?  summarizeLockedClicked,TResult Function()?  upcomingExpanded,TResult Function( String ticker)?  upcomingCompanyClicked,TResult Function( String ticker)?  ytdCompanyClicked,TResult Function( String ticker)?  filingCardCompanyClicked,TResult Function()?  emptyCtaClicked,TResult Function( String publisher,  String site)?  marketNewsArticleOpened,TResult Function( String error)?  marketNewsLoadFailed,TResult Function( DateTime? lastViewedReports)?  activityUpdated,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.uid);case Refresh() when refresh != null:
return refresh();case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that.tickers);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that.result);case Viewed() when viewed != null:
return viewed(_that.unreadCount,_that.entrySource,_that.notificationType);case LinkOpened() when linkOpened != null:
return linkOpened(_that.ticker,_that.filingType);case SummaryRequested() when summaryRequested != null:
return summaryRequested(_that.ticker,_that.filingType,_that.isReady);case SummarizeLockedClicked() when summarizeLockedClicked != null:
return summarizeLockedClicked(_that.ticker,_that.filingType);case UpcomingExpanded() when upcomingExpanded != null:
return upcomingExpanded();case UpcomingCompanyClicked() when upcomingCompanyClicked != null:
return upcomingCompanyClicked(_that.ticker);case YtdCompanyClicked() when ytdCompanyClicked != null:
return ytdCompanyClicked(_that.ticker);case FilingCardCompanyClicked() when filingCardCompanyClicked != null:
return filingCardCompanyClicked(_that.ticker);case EmptyCtaClicked() when emptyCtaClicked != null:
return emptyCtaClicked();case MarketNewsArticleOpened() when marketNewsArticleOpened != null:
return marketNewsArticleOpened(_that.publisher,_that.site);case MarketNewsLoadFailed() when marketNewsLoadFailed != null:
return marketNewsLoadFailed(_that.error);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that.lastViewedReports);case Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? uid)  started,required TResult Function()  refresh,required TResult Function( List<String> tickers)  watchlistUpdated,required TResult Function( Either<Failure, ReportsFeed> result)  reportsUpdated,required TResult Function( int unreadCount,  ReportsEntrySource entrySource,  ReportsNotificationType? notificationType)  viewed,required TResult Function( String ticker,  String filingType)  linkOpened,required TResult Function( String ticker,  String filingType,  bool isReady)  summaryRequested,required TResult Function( String ticker,  String filingType)  summarizeLockedClicked,required TResult Function()  upcomingExpanded,required TResult Function( String ticker)  upcomingCompanyClicked,required TResult Function( String ticker)  ytdCompanyClicked,required TResult Function( String ticker)  filingCardCompanyClicked,required TResult Function()  emptyCtaClicked,required TResult Function( String publisher,  String site)  marketNewsArticleOpened,required TResult Function( String error)  marketNewsLoadFailed,required TResult Function( DateTime? lastViewedReports)  activityUpdated,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case Started():
return started(_that.uid);case Refresh():
return refresh();case WatchlistUpdated():
return watchlistUpdated(_that.tickers);case ReportsUpdated():
return reportsUpdated(_that.result);case Viewed():
return viewed(_that.unreadCount,_that.entrySource,_that.notificationType);case LinkOpened():
return linkOpened(_that.ticker,_that.filingType);case SummaryRequested():
return summaryRequested(_that.ticker,_that.filingType,_that.isReady);case SummarizeLockedClicked():
return summarizeLockedClicked(_that.ticker,_that.filingType);case UpcomingExpanded():
return upcomingExpanded();case UpcomingCompanyClicked():
return upcomingCompanyClicked(_that.ticker);case YtdCompanyClicked():
return ytdCompanyClicked(_that.ticker);case FilingCardCompanyClicked():
return filingCardCompanyClicked(_that.ticker);case EmptyCtaClicked():
return emptyCtaClicked();case MarketNewsArticleOpened():
return marketNewsArticleOpened(_that.publisher,_that.site);case MarketNewsLoadFailed():
return marketNewsLoadFailed(_that.error);case ActivityUpdated():
return activityUpdated(_that.lastViewedReports);case Reset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? uid)?  started,TResult? Function()?  refresh,TResult? Function( List<String> tickers)?  watchlistUpdated,TResult? Function( Either<Failure, ReportsFeed> result)?  reportsUpdated,TResult? Function( int unreadCount,  ReportsEntrySource entrySource,  ReportsNotificationType? notificationType)?  viewed,TResult? Function( String ticker,  String filingType)?  linkOpened,TResult? Function( String ticker,  String filingType,  bool isReady)?  summaryRequested,TResult? Function( String ticker,  String filingType)?  summarizeLockedClicked,TResult? Function()?  upcomingExpanded,TResult? Function( String ticker)?  upcomingCompanyClicked,TResult? Function( String ticker)?  ytdCompanyClicked,TResult? Function( String ticker)?  filingCardCompanyClicked,TResult? Function()?  emptyCtaClicked,TResult? Function( String publisher,  String site)?  marketNewsArticleOpened,TResult? Function( String error)?  marketNewsLoadFailed,TResult? Function( DateTime? lastViewedReports)?  activityUpdated,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that.uid);case Refresh() when refresh != null:
return refresh();case WatchlistUpdated() when watchlistUpdated != null:
return watchlistUpdated(_that.tickers);case ReportsUpdated() when reportsUpdated != null:
return reportsUpdated(_that.result);case Viewed() when viewed != null:
return viewed(_that.unreadCount,_that.entrySource,_that.notificationType);case LinkOpened() when linkOpened != null:
return linkOpened(_that.ticker,_that.filingType);case SummaryRequested() when summaryRequested != null:
return summaryRequested(_that.ticker,_that.filingType,_that.isReady);case SummarizeLockedClicked() when summarizeLockedClicked != null:
return summarizeLockedClicked(_that.ticker,_that.filingType);case UpcomingExpanded() when upcomingExpanded != null:
return upcomingExpanded();case UpcomingCompanyClicked() when upcomingCompanyClicked != null:
return upcomingCompanyClicked(_that.ticker);case YtdCompanyClicked() when ytdCompanyClicked != null:
return ytdCompanyClicked(_that.ticker);case FilingCardCompanyClicked() when filingCardCompanyClicked != null:
return filingCardCompanyClicked(_that.ticker);case EmptyCtaClicked() when emptyCtaClicked != null:
return emptyCtaClicked();case MarketNewsArticleOpened() when marketNewsArticleOpened != null:
return marketNewsArticleOpened(_that.publisher,_that.site);case MarketNewsLoadFailed() when marketNewsLoadFailed != null:
return marketNewsLoadFailed(_that.error);case ActivityUpdated() when activityUpdated != null:
return activityUpdated(_that.lastViewedReports);case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class Started implements ReportsEvent {
  const Started({this.uid});
  

 final  String? uid;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartedCopyWith<Started> get copyWith => _$StartedCopyWithImpl<Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,uid);

@override
String toString() {
  return 'ReportsEvent.started(uid: $uid)';
}


}

/// @nodoc
abstract mixin class $StartedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $StartedCopyWith(Started value, $Res Function(Started) _then) = _$StartedCopyWithImpl;
@useResult
$Res call({
 String? uid
});




}
/// @nodoc
class _$StartedCopyWithImpl<$Res>
    implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = freezed,}) {
  return _then(Started(
uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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
  const Viewed({required this.unreadCount, required this.entrySource, this.notificationType});
  

 final  int unreadCount;
 final  ReportsEntrySource entrySource;
 final  ReportsNotificationType? notificationType;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewedCopyWith<Viewed> get copyWith => _$ViewedCopyWithImpl<Viewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Viewed&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.entrySource, entrySource) || other.entrySource == entrySource)&&(identical(other.notificationType, notificationType) || other.notificationType == notificationType));
}


@override
int get hashCode => Object.hash(runtimeType,unreadCount,entrySource,notificationType);

@override
String toString() {
  return 'ReportsEvent.viewed(unreadCount: $unreadCount, entrySource: $entrySource, notificationType: $notificationType)';
}


}

/// @nodoc
abstract mixin class $ViewedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $ViewedCopyWith(Viewed value, $Res Function(Viewed) _then) = _$ViewedCopyWithImpl;
@useResult
$Res call({
 int unreadCount, ReportsEntrySource entrySource, ReportsNotificationType? notificationType
});




}
/// @nodoc
class _$ViewedCopyWithImpl<$Res>
    implements $ViewedCopyWith<$Res> {
  _$ViewedCopyWithImpl(this._self, this._then);

  final Viewed _self;
  final $Res Function(Viewed) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? unreadCount = null,Object? entrySource = null,Object? notificationType = freezed,}) {
  return _then(Viewed(
unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,entrySource: null == entrySource ? _self.entrySource : entrySource // ignore: cast_nullable_to_non_nullable
as ReportsEntrySource,notificationType: freezed == notificationType ? _self.notificationType : notificationType // ignore: cast_nullable_to_non_nullable
as ReportsNotificationType?,
  ));
}


}

/// @nodoc


class LinkOpened implements ReportsEvent {
  const LinkOpened({required this.ticker, required this.filingType});
  

 final  String ticker;
 final  String filingType;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkOpenedCopyWith<LinkOpened> get copyWith => _$LinkOpenedCopyWithImpl<LinkOpened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkOpened&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.filingType, filingType) || other.filingType == filingType));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,filingType);

@override
String toString() {
  return 'ReportsEvent.linkOpened(ticker: $ticker, filingType: $filingType)';
}


}

/// @nodoc
abstract mixin class $LinkOpenedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $LinkOpenedCopyWith(LinkOpened value, $Res Function(LinkOpened) _then) = _$LinkOpenedCopyWithImpl;
@useResult
$Res call({
 String ticker, String filingType
});




}
/// @nodoc
class _$LinkOpenedCopyWithImpl<$Res>
    implements $LinkOpenedCopyWith<$Res> {
  _$LinkOpenedCopyWithImpl(this._self, this._then);

  final LinkOpened _self;
  final $Res Function(LinkOpened) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? filingType = null,}) {
  return _then(LinkOpened(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,filingType: null == filingType ? _self.filingType : filingType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SummaryRequested implements ReportsEvent {
  const SummaryRequested({required this.ticker, required this.filingType, required this.isReady});
  

 final  String ticker;
 final  String filingType;
 final  bool isReady;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryRequestedCopyWith<SummaryRequested> get copyWith => _$SummaryRequestedCopyWithImpl<SummaryRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryRequested&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.filingType, filingType) || other.filingType == filingType)&&(identical(other.isReady, isReady) || other.isReady == isReady));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,filingType,isReady);

@override
String toString() {
  return 'ReportsEvent.summaryRequested(ticker: $ticker, filingType: $filingType, isReady: $isReady)';
}


}

/// @nodoc
abstract mixin class $SummaryRequestedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $SummaryRequestedCopyWith(SummaryRequested value, $Res Function(SummaryRequested) _then) = _$SummaryRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker, String filingType, bool isReady
});




}
/// @nodoc
class _$SummaryRequestedCopyWithImpl<$Res>
    implements $SummaryRequestedCopyWith<$Res> {
  _$SummaryRequestedCopyWithImpl(this._self, this._then);

  final SummaryRequested _self;
  final $Res Function(SummaryRequested) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? filingType = null,Object? isReady = null,}) {
  return _then(SummaryRequested(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,filingType: null == filingType ? _self.filingType : filingType // ignore: cast_nullable_to_non_nullable
as String,isReady: null == isReady ? _self.isReady : isReady // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SummarizeLockedClicked implements ReportsEvent {
  const SummarizeLockedClicked({required this.ticker, required this.filingType});
  

 final  String ticker;
 final  String filingType;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummarizeLockedClickedCopyWith<SummarizeLockedClicked> get copyWith => _$SummarizeLockedClickedCopyWithImpl<SummarizeLockedClicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummarizeLockedClicked&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.filingType, filingType) || other.filingType == filingType));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,filingType);

@override
String toString() {
  return 'ReportsEvent.summarizeLockedClicked(ticker: $ticker, filingType: $filingType)';
}


}

/// @nodoc
abstract mixin class $SummarizeLockedClickedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $SummarizeLockedClickedCopyWith(SummarizeLockedClicked value, $Res Function(SummarizeLockedClicked) _then) = _$SummarizeLockedClickedCopyWithImpl;
@useResult
$Res call({
 String ticker, String filingType
});




}
/// @nodoc
class _$SummarizeLockedClickedCopyWithImpl<$Res>
    implements $SummarizeLockedClickedCopyWith<$Res> {
  _$SummarizeLockedClickedCopyWithImpl(this._self, this._then);

  final SummarizeLockedClicked _self;
  final $Res Function(SummarizeLockedClicked) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? filingType = null,}) {
  return _then(SummarizeLockedClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,filingType: null == filingType ? _self.filingType : filingType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpcomingExpanded implements ReportsEvent {
  const UpcomingExpanded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingExpanded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.upcomingExpanded()';
}


}




/// @nodoc


class UpcomingCompanyClicked implements ReportsEvent {
  const UpcomingCompanyClicked({required this.ticker});
  

 final  String ticker;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingCompanyClickedCopyWith<UpcomingCompanyClicked> get copyWith => _$UpcomingCompanyClickedCopyWithImpl<UpcomingCompanyClicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingCompanyClicked&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'ReportsEvent.upcomingCompanyClicked(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $UpcomingCompanyClickedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $UpcomingCompanyClickedCopyWith(UpcomingCompanyClicked value, $Res Function(UpcomingCompanyClicked) _then) = _$UpcomingCompanyClickedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$UpcomingCompanyClickedCopyWithImpl<$Res>
    implements $UpcomingCompanyClickedCopyWith<$Res> {
  _$UpcomingCompanyClickedCopyWithImpl(this._self, this._then);

  final UpcomingCompanyClicked _self;
  final $Res Function(UpcomingCompanyClicked) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(UpcomingCompanyClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class YtdCompanyClicked implements ReportsEvent {
  const YtdCompanyClicked({required this.ticker});
  

 final  String ticker;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$YtdCompanyClickedCopyWith<YtdCompanyClicked> get copyWith => _$YtdCompanyClickedCopyWithImpl<YtdCompanyClicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is YtdCompanyClicked&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'ReportsEvent.ytdCompanyClicked(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $YtdCompanyClickedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $YtdCompanyClickedCopyWith(YtdCompanyClicked value, $Res Function(YtdCompanyClicked) _then) = _$YtdCompanyClickedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$YtdCompanyClickedCopyWithImpl<$Res>
    implements $YtdCompanyClickedCopyWith<$Res> {
  _$YtdCompanyClickedCopyWithImpl(this._self, this._then);

  final YtdCompanyClicked _self;
  final $Res Function(YtdCompanyClicked) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(YtdCompanyClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FilingCardCompanyClicked implements ReportsEvent {
  const FilingCardCompanyClicked({required this.ticker});
  

 final  String ticker;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilingCardCompanyClickedCopyWith<FilingCardCompanyClicked> get copyWith => _$FilingCardCompanyClickedCopyWithImpl<FilingCardCompanyClicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilingCardCompanyClicked&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'ReportsEvent.filingCardCompanyClicked(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $FilingCardCompanyClickedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $FilingCardCompanyClickedCopyWith(FilingCardCompanyClicked value, $Res Function(FilingCardCompanyClicked) _then) = _$FilingCardCompanyClickedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$FilingCardCompanyClickedCopyWithImpl<$Res>
    implements $FilingCardCompanyClickedCopyWith<$Res> {
  _$FilingCardCompanyClickedCopyWithImpl(this._self, this._then);

  final FilingCardCompanyClicked _self;
  final $Res Function(FilingCardCompanyClicked) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(FilingCardCompanyClicked(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmptyCtaClicked implements ReportsEvent {
  const EmptyCtaClicked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmptyCtaClicked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.emptyCtaClicked()';
}


}




/// @nodoc


class MarketNewsArticleOpened implements ReportsEvent {
  const MarketNewsArticleOpened({required this.publisher, required this.site});
  

 final  String publisher;
 final  String site;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketNewsArticleOpenedCopyWith<MarketNewsArticleOpened> get copyWith => _$MarketNewsArticleOpenedCopyWithImpl<MarketNewsArticleOpened>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketNewsArticleOpened&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.site, site) || other.site == site));
}


@override
int get hashCode => Object.hash(runtimeType,publisher,site);

@override
String toString() {
  return 'ReportsEvent.marketNewsArticleOpened(publisher: $publisher, site: $site)';
}


}

/// @nodoc
abstract mixin class $MarketNewsArticleOpenedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $MarketNewsArticleOpenedCopyWith(MarketNewsArticleOpened value, $Res Function(MarketNewsArticleOpened) _then) = _$MarketNewsArticleOpenedCopyWithImpl;
@useResult
$Res call({
 String publisher, String site
});




}
/// @nodoc
class _$MarketNewsArticleOpenedCopyWithImpl<$Res>
    implements $MarketNewsArticleOpenedCopyWith<$Res> {
  _$MarketNewsArticleOpenedCopyWithImpl(this._self, this._then);

  final MarketNewsArticleOpened _self;
  final $Res Function(MarketNewsArticleOpened) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? publisher = null,Object? site = null,}) {
  return _then(MarketNewsArticleOpened(
publisher: null == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MarketNewsLoadFailed implements ReportsEvent {
  const MarketNewsLoadFailed({required this.error});
  

 final  String error;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarketNewsLoadFailedCopyWith<MarketNewsLoadFailed> get copyWith => _$MarketNewsLoadFailedCopyWithImpl<MarketNewsLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarketNewsLoadFailed&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ReportsEvent.marketNewsLoadFailed(error: $error)';
}


}

/// @nodoc
abstract mixin class $MarketNewsLoadFailedCopyWith<$Res> implements $ReportsEventCopyWith<$Res> {
  factory $MarketNewsLoadFailedCopyWith(MarketNewsLoadFailed value, $Res Function(MarketNewsLoadFailed) _then) = _$MarketNewsLoadFailedCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$MarketNewsLoadFailedCopyWithImpl<$Res>
    implements $MarketNewsLoadFailedCopyWith<$Res> {
  _$MarketNewsLoadFailedCopyWithImpl(this._self, this._then);

  final MarketNewsLoadFailed _self;
  final $Res Function(MarketNewsLoadFailed) _then;

/// Create a copy of ReportsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(MarketNewsLoadFailed(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
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

/// @nodoc


class Reset implements ReportsEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReportsEvent.reset()';
}


}




// dart format on
