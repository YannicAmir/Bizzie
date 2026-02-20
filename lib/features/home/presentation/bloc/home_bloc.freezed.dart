// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _WatchlistTapped value)?  watchlistTapped,TResult Function( _EmptyStateViewed value)?  emptyStateViewed,TResult Function( _WatchlistLoadFailed value)?  watchlistLoadFailed,TResult Function( _WatchlistLoaded value)?  watchlistLoaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _WatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that);case _EmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed(_that);case _WatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that);case _WatchlistLoaded() when watchlistLoaded != null:
return watchlistLoaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _WatchlistTapped value)  watchlistTapped,required TResult Function( _EmptyStateViewed value)  emptyStateViewed,required TResult Function( _WatchlistLoadFailed value)  watchlistLoadFailed,required TResult Function( _WatchlistLoaded value)  watchlistLoaded,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _WatchlistTapped():
return watchlistTapped(_that);case _EmptyStateViewed():
return emptyStateViewed(_that);case _WatchlistLoadFailed():
return watchlistLoadFailed(_that);case _WatchlistLoaded():
return watchlistLoaded(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _WatchlistTapped value)?  watchlistTapped,TResult? Function( _EmptyStateViewed value)?  emptyStateViewed,TResult? Function( _WatchlistLoadFailed value)?  watchlistLoadFailed,TResult? Function( _WatchlistLoaded value)?  watchlistLoaded,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _WatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that);case _EmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed(_that);case _WatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that);case _WatchlistLoaded() when watchlistLoaded != null:
return watchlistLoaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String ticker,  String? eventText,  bool? isUpcoming)?  watchlistTapped,TResult Function()?  emptyStateViewed,TResult Function( String error)?  watchlistLoadFailed,TResult Function( int itemCount)?  watchlistLoaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _WatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case _EmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed();case _WatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that.error);case _WatchlistLoaded() when watchlistLoaded != null:
return watchlistLoaded(_that.itemCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String ticker,  String? eventText,  bool? isUpcoming)  watchlistTapped,required TResult Function()  emptyStateViewed,required TResult Function( String error)  watchlistLoadFailed,required TResult Function( int itemCount)  watchlistLoaded,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _WatchlistTapped():
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case _EmptyStateViewed():
return emptyStateViewed();case _WatchlistLoadFailed():
return watchlistLoadFailed(_that.error);case _WatchlistLoaded():
return watchlistLoaded(_that.itemCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String ticker,  String? eventText,  bool? isUpcoming)?  watchlistTapped,TResult? Function()?  emptyStateViewed,TResult? Function( String error)?  watchlistLoadFailed,TResult? Function( int itemCount)?  watchlistLoaded,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _WatchlistTapped() when watchlistTapped != null:
return watchlistTapped(_that.ticker,_that.eventText,_that.isUpcoming);case _EmptyStateViewed() when emptyStateViewed != null:
return emptyStateViewed();case _WatchlistLoadFailed() when watchlistLoadFailed != null:
return watchlistLoadFailed(_that.error);case _WatchlistLoaded() when watchlistLoaded != null:
return watchlistLoaded(_that.itemCount);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements HomeEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.started()';
}


}




/// @nodoc


class _WatchlistTapped implements HomeEvent {
  const _WatchlistTapped({required this.ticker, this.eventText, this.isUpcoming});
  

 final  String ticker;
 final  String? eventText;
 final  bool? isUpcoming;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistTappedCopyWith<_WatchlistTapped> get copyWith => __$WatchlistTappedCopyWithImpl<_WatchlistTapped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistTapped&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.eventText, eventText) || other.eventText == eventText)&&(identical(other.isUpcoming, isUpcoming) || other.isUpcoming == isUpcoming));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,eventText,isUpcoming);

@override
String toString() {
  return 'HomeEvent.watchlistTapped(ticker: $ticker, eventText: $eventText, isUpcoming: $isUpcoming)';
}


}

/// @nodoc
abstract mixin class _$WatchlistTappedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$WatchlistTappedCopyWith(_WatchlistTapped value, $Res Function(_WatchlistTapped) _then) = __$WatchlistTappedCopyWithImpl;
@useResult
$Res call({
 String ticker, String? eventText, bool? isUpcoming
});




}
/// @nodoc
class __$WatchlistTappedCopyWithImpl<$Res>
    implements _$WatchlistTappedCopyWith<$Res> {
  __$WatchlistTappedCopyWithImpl(this._self, this._then);

  final _WatchlistTapped _self;
  final $Res Function(_WatchlistTapped) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? eventText = freezed,Object? isUpcoming = freezed,}) {
  return _then(_WatchlistTapped(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,eventText: freezed == eventText ? _self.eventText : eventText // ignore: cast_nullable_to_non_nullable
as String?,isUpcoming: freezed == isUpcoming ? _self.isUpcoming : isUpcoming // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class _EmptyStateViewed implements HomeEvent {
  const _EmptyStateViewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmptyStateViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.emptyStateViewed()';
}


}




/// @nodoc


class _WatchlistLoadFailed implements HomeEvent {
  const _WatchlistLoadFailed({required this.error});
  

 final  String error;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistLoadFailedCopyWith<_WatchlistLoadFailed> get copyWith => __$WatchlistLoadFailedCopyWithImpl<_WatchlistLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistLoadFailed&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'HomeEvent.watchlistLoadFailed(error: $error)';
}


}

/// @nodoc
abstract mixin class _$WatchlistLoadFailedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$WatchlistLoadFailedCopyWith(_WatchlistLoadFailed value, $Res Function(_WatchlistLoadFailed) _then) = __$WatchlistLoadFailedCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class __$WatchlistLoadFailedCopyWithImpl<$Res>
    implements _$WatchlistLoadFailedCopyWith<$Res> {
  __$WatchlistLoadFailedCopyWithImpl(this._self, this._then);

  final _WatchlistLoadFailed _self;
  final $Res Function(_WatchlistLoadFailed) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(_WatchlistLoadFailed(
error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _WatchlistLoaded implements HomeEvent {
  const _WatchlistLoaded({required this.itemCount});
  

 final  int itemCount;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistLoadedCopyWith<_WatchlistLoaded> get copyWith => __$WatchlistLoadedCopyWithImpl<_WatchlistLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistLoaded&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount));
}


@override
int get hashCode => Object.hash(runtimeType,itemCount);

@override
String toString() {
  return 'HomeEvent.watchlistLoaded(itemCount: $itemCount)';
}


}

/// @nodoc
abstract mixin class _$WatchlistLoadedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory _$WatchlistLoadedCopyWith(_WatchlistLoaded value, $Res Function(_WatchlistLoaded) _then) = __$WatchlistLoadedCopyWithImpl;
@useResult
$Res call({
 int itemCount
});




}
/// @nodoc
class __$WatchlistLoadedCopyWithImpl<$Res>
    implements _$WatchlistLoadedCopyWith<$Res> {
  __$WatchlistLoadedCopyWithImpl(this._self, this._then);

  final _WatchlistLoaded _self;
  final $Res Function(_WatchlistLoaded) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? itemCount = null,}) {
  return _then(_WatchlistLoaded(
itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




// dart format on
