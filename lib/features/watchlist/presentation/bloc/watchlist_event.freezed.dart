// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchlistEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent()';
}


}

/// @nodoc
class $WatchlistEventCopyWith<$Res>  {
$WatchlistEventCopyWith(WatchlistEvent _, $Res Function(WatchlistEvent) __);
}


/// Adds pattern-matching-related methods to [WatchlistEvent].
extension WatchlistEventPatterns on WatchlistEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyncRequested value)?  syncRequested,TResult Function( AddRequested value)?  addRequested,TResult Function( RemoveRequested value)?  removeRequested,TResult Function( LoadRequested value)?  loadRequested,TResult Function( Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyncRequested() when syncRequested != null:
return syncRequested(_that);case AddRequested() when addRequested != null:
return addRequested(_that);case RemoveRequested() when removeRequested != null:
return removeRequested(_that);case LoadRequested() when loadRequested != null:
return loadRequested(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyncRequested value)  syncRequested,required TResult Function( AddRequested value)  addRequested,required TResult Function( RemoveRequested value)  removeRequested,required TResult Function( LoadRequested value)  loadRequested,required TResult Function( Reset value)  reset,}){
final _that = this;
switch (_that) {
case SyncRequested():
return syncRequested(_that);case AddRequested():
return addRequested(_that);case RemoveRequested():
return removeRequested(_that);case LoadRequested():
return loadRequested(_that);case Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyncRequested value)?  syncRequested,TResult? Function( AddRequested value)?  addRequested,TResult? Function( RemoveRequested value)?  removeRequested,TResult? Function( LoadRequested value)?  loadRequested,TResult? Function( Reset value)?  reset,}){
final _that = this;
switch (_that) {
case SyncRequested() when syncRequested != null:
return syncRequested(_that);case AddRequested() when addRequested != null:
return addRequested(_that);case RemoveRequested() when removeRequested != null:
return removeRequested(_that);case LoadRequested() when loadRequested != null:
return loadRequested(_that);case Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  syncRequested,TResult Function( String ticker,  String? name)?  addRequested,TResult Function( String ticker)?  removeRequested,TResult Function()?  loadRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyncRequested() when syncRequested != null:
return syncRequested();case AddRequested() when addRequested != null:
return addRequested(_that.ticker,_that.name);case RemoveRequested() when removeRequested != null:
return removeRequested(_that.ticker);case LoadRequested() when loadRequested != null:
return loadRequested();case Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  syncRequested,required TResult Function( String ticker,  String? name)  addRequested,required TResult Function( String ticker)  removeRequested,required TResult Function()  loadRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case SyncRequested():
return syncRequested();case AddRequested():
return addRequested(_that.ticker,_that.name);case RemoveRequested():
return removeRequested(_that.ticker);case LoadRequested():
return loadRequested();case Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  syncRequested,TResult? Function( String ticker,  String? name)?  addRequested,TResult? Function( String ticker)?  removeRequested,TResult? Function()?  loadRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case SyncRequested() when syncRequested != null:
return syncRequested();case AddRequested() when addRequested != null:
return addRequested(_that.ticker,_that.name);case RemoveRequested() when removeRequested != null:
return removeRequested(_that.ticker);case LoadRequested() when loadRequested != null:
return loadRequested();case Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class SyncRequested implements WatchlistEvent {
  const SyncRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent.syncRequested()';
}


}




/// @nodoc


class AddRequested implements WatchlistEvent {
  const AddRequested({required this.ticker, this.name});
  

 final  String ticker;
 final  String? name;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddRequestedCopyWith<AddRequested> get copyWith => _$AddRequestedCopyWithImpl<AddRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddRequested&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,name);

@override
String toString() {
  return 'WatchlistEvent.addRequested(ticker: $ticker, name: $name)';
}


}

/// @nodoc
abstract mixin class $AddRequestedCopyWith<$Res> implements $WatchlistEventCopyWith<$Res> {
  factory $AddRequestedCopyWith(AddRequested value, $Res Function(AddRequested) _then) = _$AddRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker, String? name
});




}
/// @nodoc
class _$AddRequestedCopyWithImpl<$Res>
    implements $AddRequestedCopyWith<$Res> {
  _$AddRequestedCopyWithImpl(this._self, this._then);

  final AddRequested _self;
  final $Res Function(AddRequested) _then;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? name = freezed,}) {
  return _then(AddRequested(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class RemoveRequested implements WatchlistEvent {
  const RemoveRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveRequestedCopyWith<RemoveRequested> get copyWith => _$RemoveRequestedCopyWithImpl<RemoveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveRequested&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'WatchlistEvent.removeRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $RemoveRequestedCopyWith<$Res> implements $WatchlistEventCopyWith<$Res> {
  factory $RemoveRequestedCopyWith(RemoveRequested value, $Res Function(RemoveRequested) _then) = _$RemoveRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class _$RemoveRequestedCopyWithImpl<$Res>
    implements $RemoveRequestedCopyWith<$Res> {
  _$RemoveRequestedCopyWithImpl(this._self, this._then);

  final RemoveRequested _self;
  final $Res Function(RemoveRequested) _then;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(RemoveRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadRequested implements WatchlistEvent {
  const LoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent.loadRequested()';
}


}




/// @nodoc


class Reset implements WatchlistEvent {
  const Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent.reset()';
}


}




// dart format on
