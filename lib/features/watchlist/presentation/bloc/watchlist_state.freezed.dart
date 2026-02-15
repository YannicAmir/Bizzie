// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistState()';
}


}

/// @nodoc
class $WatchlistStateCopyWith<$Res>  {
$WatchlistStateCopyWith(WatchlistState _, $Res Function(WatchlistState) __);
}


/// Adds pattern-matching-related methods to [WatchlistState].
extension WatchlistStatePatterns on WatchlistState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( WatchlistLoaded value)?  loaded,TResult Function( _Failure value)?  failure,TResult Function( _Success value)?  success,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case WatchlistLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( WatchlistLoaded value)  loaded,required TResult Function( _Failure value)  failure,required TResult Function( _Success value)  success,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case WatchlistLoaded():
return loaded(_that);case _Failure():
return failure(_that);case _Success():
return success(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( WatchlistLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,TResult? Function( _Success value)?  success,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case WatchlistLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
return failure(_that);case _Success() when success != null:
return success(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Company> companies,  Map<String, WatchlistEventStatus> events)?  loaded,TResult Function( Failure failure)?  failure,TResult Function( String message)?  success,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case WatchlistLoaded() when loaded != null:
return loaded(_that.companies,_that.events);case _Failure() when failure != null:
return failure(_that.failure);case _Success() when success != null:
return success(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Company> companies,  Map<String, WatchlistEventStatus> events)  loaded,required TResult Function( Failure failure)  failure,required TResult Function( String message)  success,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case WatchlistLoaded():
return loaded(_that.companies,_that.events);case _Failure():
return failure(_that.failure);case _Success():
return success(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Company> companies,  Map<String, WatchlistEventStatus> events)?  loaded,TResult? Function( Failure failure)?  failure,TResult? Function( String message)?  success,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case WatchlistLoaded() when loaded != null:
return loaded(_that.companies,_that.events);case _Failure() when failure != null:
return failure(_that.failure);case _Success() when success != null:
return success(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements WatchlistState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistState.initial()';
}


}




/// @nodoc


class _Loading implements WatchlistState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistState.loading()';
}


}




/// @nodoc


class WatchlistLoaded implements WatchlistState {
  const WatchlistLoaded(final  List<Company> companies, {final  Map<String, WatchlistEventStatus> events = const {}}): _companies = companies,_events = events;
  

 final  List<Company> _companies;
 List<Company> get companies {
  if (_companies is EqualUnmodifiableListView) return _companies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companies);
}

 final  Map<String, WatchlistEventStatus> _events;
@JsonKey() Map<String, WatchlistEventStatus> get events {
  if (_events is EqualUnmodifiableMapView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_events);
}


/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistLoadedCopyWith<WatchlistLoaded> get copyWith => _$WatchlistLoadedCopyWithImpl<WatchlistLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistLoaded&&const DeepCollectionEquality().equals(other._companies, _companies)&&const DeepCollectionEquality().equals(other._events, _events));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_companies),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'WatchlistState.loaded(companies: $companies, events: $events)';
}


}

/// @nodoc
abstract mixin class $WatchlistLoadedCopyWith<$Res> implements $WatchlistStateCopyWith<$Res> {
  factory $WatchlistLoadedCopyWith(WatchlistLoaded value, $Res Function(WatchlistLoaded) _then) = _$WatchlistLoadedCopyWithImpl;
@useResult
$Res call({
 List<Company> companies, Map<String, WatchlistEventStatus> events
});




}
/// @nodoc
class _$WatchlistLoadedCopyWithImpl<$Res>
    implements $WatchlistLoadedCopyWith<$Res> {
  _$WatchlistLoadedCopyWithImpl(this._self, this._then);

  final WatchlistLoaded _self;
  final $Res Function(WatchlistLoaded) _then;

/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? companies = null,Object? events = null,}) {
  return _then(WatchlistLoaded(
null == companies ? _self._companies : companies // ignore: cast_nullable_to_non_nullable
as List<Company>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as Map<String, WatchlistEventStatus>,
  ));
}


}

/// @nodoc


class _Failure implements WatchlistState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of WatchlistState
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
  return 'WatchlistState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $WatchlistStateCopyWith<$Res> {
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

/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class _Success implements WatchlistState {
  const _Success(this.message);
  

 final  String message;

/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WatchlistState.success(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $WatchlistStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of WatchlistState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Success(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
