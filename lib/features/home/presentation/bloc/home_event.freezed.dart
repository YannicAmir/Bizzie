// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeStarted value)?  started,TResult Function( HomeWatchlistTapped value)?  watchlistTapped,TResult Function( HomeEmptyStateViewed value)?  emptyStateViewed,TResult Function( HomeWatchlistLoadFailed value)?  watchlistLoadFailed,TResult Function( HomeNewsArticleTapped value)?  newsArticleTapped,TResult Function( HomeNewsLoadFailed value)?  newsLoadFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeWatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that);case HomeEmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed(_that);case HomeWatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that);case HomeNewsArticleTapped() when newsArticleTapped != null:
return newsArticleTapped(_that);case HomeNewsLoadFailed() when newsLoadFailed != null:
return newsLoadFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeStarted value)  started,required TResult Function( HomeWatchlistTapped value)  watchlistTapped,required TResult Function( HomeEmptyStateViewed value)  emptyStateViewed,required TResult Function( HomeWatchlistLoadFailed value)  watchlistLoadFailed,required TResult Function( HomeNewsArticleTapped value)  newsArticleTapped,required TResult Function( HomeNewsLoadFailed value)  newsLoadFailed,}){
final _that = this;
switch (_that) {
case HomeStarted():
return started(_that);case HomeWatchlistTapped():
return watchlistTapped(_that);case HomeEmptyStateViewed():
return emptyStateViewed(_that);case HomeWatchlistLoadFailed():
return watchlistLoadFailed(_that);case HomeNewsArticleTapped():
return newsArticleTapped(_that);case HomeNewsLoadFailed():
return newsLoadFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeStarted value)?  started,TResult? Function( HomeWatchlistTapped value)?  watchlistTapped,TResult? Function( HomeEmptyStateViewed value)?  emptyStateViewed,TResult? Function( HomeWatchlistLoadFailed value)?  watchlistLoadFailed,TResult? Function( HomeNewsArticleTapped value)?  newsArticleTapped,TResult? Function( HomeNewsLoadFailed value)?  newsLoadFailed,}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeWatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that);case HomeEmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed(_that);case HomeWatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that);case HomeNewsArticleTapped() when newsArticleTapped != null:
return newsArticleTapped(_that);case HomeNewsLoadFailed() when newsLoadFailed != null:
return newsLoadFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String ticker,  String? eventText,  bool? isUpcoming)?  watchlistTapped,TResult Function()?  emptyStateViewed,TResult Function( String error)?  watchlistLoadFailed,TResult Function( String ticker,  String site)?  newsArticleTapped,TResult Function( String error)?  newsLoadFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeWatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case HomeEmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed();case HomeWatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that.error);case HomeNewsArticleTapped() when newsArticleTapped != null:
return newsArticleTapped(_that.ticker,_that.site);case HomeNewsLoadFailed() when newsLoadFailed != null:
return newsLoadFailed(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String ticker,  String? eventText,  bool? isUpcoming)  watchlistTapped,required TResult Function()  emptyStateViewed,required TResult Function( String error)  watchlistLoadFailed,required TResult Function( String ticker,  String site)  newsArticleTapped,required TResult Function( String error)  newsLoadFailed,}) {final _that = this;
switch (_that) {
case HomeStarted():
return started();case HomeWatchlistTapped():
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case HomeEmptyStateViewed():
return emptyStateViewed();case HomeWatchlistLoadFailed():
return watchlistLoadFailed(_that.error);case HomeNewsArticleTapped():
return newsArticleTapped(_that.ticker,_that.site);case HomeNewsLoadFailed():
return newsLoadFailed(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String ticker,  String? eventText,  bool? isUpcoming)?  watchlistTapped,TResult? Function()?  emptyStateViewed,TResult? Function( String error)?  watchlistLoadFailed,TResult? Function( String ticker,  String site)?  newsArticleTapped,TResult? Function( String error)?  newsLoadFailed,}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeWatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case HomeEmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed();case HomeWatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that.error);case HomeNewsArticleTapped() when newsArticleTapped != null:
return newsArticleTapped(_that.ticker,_that.site);case HomeNewsLoadFailed() when newsLoadFailed != null:
return newsLoadFailed(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class HomeStarted implements HomeEvent {
  const HomeStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.started()';
}


}




/// @nodoc


class HomeWatchlistTapped implements HomeEvent {
  const HomeWatchlistTapped({required this.ticker, this.eventText, this.isUpcoming});
  

 final  String ticker;
 final  String? eventText;
 final  bool? isUpcoming;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWatchlistTappedCopyWith<HomeWatchlistTapped> get copyWith => _$HomeWatchlistTappedCopyWithImpl<HomeWatchlistTapped>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWatchlistTapped&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.eventText, eventText) || other.eventText == eventText)&&(identical(other.isUpcoming, isUpcoming) || other.isUpcoming == isUpcoming));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,eventText,isUpcoming);
}

@override
String toString() {
    return 'HomeEvent.watchlistTapped(ticker: $ticker, eventText: $eventText, isUpcoming: $isUpcoming)';
}


}

/// @nodoc
abstract mixin class $HomeWatchlistTappedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeWatchlistTappedCopyWith(HomeWatchlistTapped value, $Res Function(HomeWatchlistTapped) _then) = _$HomeWatchlistTappedCopyWithImpl;
@useResult
$Res call({
 String ticker, String? eventText, bool? isUpcoming
});




}
/// @nodoc
class _$HomeWatchlistTappedCopyWithImpl<$Res>
    implements $HomeWatchlistTappedCopyWith<$Res> {
  _$HomeWatchlistTappedCopyWithImpl(this._self, this._then);

  final HomeWatchlistTapped _self;
  final $Res Function(HomeWatchlistTapped) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? eventText = freezed,Object? isUpcoming = freezed,}) {
  return _then(HomeWatchlistTapped(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,eventText: freezed == eventText ? _self.eventText : eventText // ignore: cast_nullable_to_non_nullable
as String?,isUpcoming: freezed == isUpcoming ? _self.isUpcoming : isUpcoming // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class HomeEmptyStateViewed implements HomeEvent {
  const HomeEmptyStateViewed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEmptyStateViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.emptyStateViewed()';
}


}




/// @nodoc


class HomeWatchlistLoadFailed implements HomeEvent {
  const HomeWatchlistLoadFailed({required this.error});
  

 final  String error;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeWatchlistLoadFailedCopyWith<HomeWatchlistLoadFailed> get copyWith => _$HomeWatchlistLoadFailedCopyWithImpl<HomeWatchlistLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeWatchlistLoadFailed&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,error);
}

@override
String toString() {
    return 'HomeEvent.watchlistLoadFailed(error: $error)';
}


}

/// @nodoc
abstract mixin class $HomeWatchlistLoadFailedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeWatchlistLoadFailedCopyWith(HomeWatchlistLoadFailed value, $Res Function(HomeWatchlistLoadFailed) _then) = _$HomeWatchlistLoadFailedCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$HomeWatchlistLoadFailedCopyWithImpl<$Res>
    implements $HomeWatchlistLoadFailedCopyWith<$Res> {
  _$HomeWatchlistLoadFailedCopyWithImpl(this._self, this._then);

  final HomeWatchlistLoadFailed _self;
  final $Res Function(HomeWatchlistLoadFailed) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(HomeWatchlistLoadFailed(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeNewsArticleTapped implements HomeEvent {
  const HomeNewsArticleTapped({required this.ticker, required this.site});
  

 final  String ticker;
 final  String site;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeNewsArticleTappedCopyWith<HomeNewsArticleTapped> get copyWith => _$HomeNewsArticleTappedCopyWithImpl<HomeNewsArticleTapped>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeNewsArticleTapped&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.site, site) || other.site == site));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticker,site);
}

@override
String toString() {
    return 'HomeEvent.newsArticleTapped(ticker: $ticker, site: $site)';
}


}

/// @nodoc
abstract mixin class $HomeNewsArticleTappedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeNewsArticleTappedCopyWith(HomeNewsArticleTapped value, $Res Function(HomeNewsArticleTapped) _then) = _$HomeNewsArticleTappedCopyWithImpl;
@useResult
$Res call({
 String ticker, String site
});




}
/// @nodoc
class _$HomeNewsArticleTappedCopyWithImpl<$Res>
    implements $HomeNewsArticleTappedCopyWith<$Res> {
  _$HomeNewsArticleTappedCopyWithImpl(this._self, this._then);

  final HomeNewsArticleTapped _self;
  final $Res Function(HomeNewsArticleTapped) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? site = null,}) {
  return _then(HomeNewsArticleTapped(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeNewsLoadFailed implements HomeEvent {
  const HomeNewsLoadFailed({required this.error});
  

 final  String error;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeNewsLoadFailedCopyWith<HomeNewsLoadFailed> get copyWith => _$HomeNewsLoadFailedCopyWithImpl<HomeNewsLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeNewsLoadFailed&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,error);
}

@override
String toString() {
    return 'HomeEvent.newsLoadFailed(error: $error)';
}


}

/// @nodoc
abstract mixin class $HomeNewsLoadFailedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeNewsLoadFailedCopyWith(HomeNewsLoadFailed value, $Res Function(HomeNewsLoadFailed) _then) = _$HomeNewsLoadFailedCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$HomeNewsLoadFailedCopyWithImpl<$Res>
    implements $HomeNewsLoadFailedCopyWith<$Res> {
  _$HomeNewsLoadFailedCopyWithImpl(this._self, this._then);

  final HomeNewsLoadFailed _self;
  final $Res Function(HomeNewsLoadFailed) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(HomeNewsLoadFailed(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
