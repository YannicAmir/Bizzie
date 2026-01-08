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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SyncRequested value)?  syncRequested,TResult Function( _AddRequested value)?  addRequested,TResult Function( _RemoveRequested value)?  removeRequested,TResult Function( _LoadRequested value)?  loadRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncRequested() when syncRequested != null:
return syncRequested(_that);case _AddRequested() when addRequested != null:
return addRequested(_that);case _RemoveRequested() when removeRequested != null:
return removeRequested(_that);case _LoadRequested() when loadRequested != null:
return loadRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SyncRequested value)  syncRequested,required TResult Function( _AddRequested value)  addRequested,required TResult Function( _RemoveRequested value)  removeRequested,required TResult Function( _LoadRequested value)  loadRequested,}){
final _that = this;
switch (_that) {
case _SyncRequested():
return syncRequested(_that);case _AddRequested():
return addRequested(_that);case _RemoveRequested():
return removeRequested(_that);case _LoadRequested():
return loadRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SyncRequested value)?  syncRequested,TResult? Function( _AddRequested value)?  addRequested,TResult? Function( _RemoveRequested value)?  removeRequested,TResult? Function( _LoadRequested value)?  loadRequested,}){
final _that = this;
switch (_that) {
case _SyncRequested() when syncRequested != null:
return syncRequested(_that);case _AddRequested() when addRequested != null:
return addRequested(_that);case _RemoveRequested() when removeRequested != null:
return removeRequested(_that);case _LoadRequested() when loadRequested != null:
return loadRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  syncRequested,TResult Function( Company company)?  addRequested,TResult Function( String ticker)?  removeRequested,TResult Function()?  loadRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncRequested() when syncRequested != null:
return syncRequested();case _AddRequested() when addRequested != null:
return addRequested(_that.company);case _RemoveRequested() when removeRequested != null:
return removeRequested(_that.ticker);case _LoadRequested() when loadRequested != null:
return loadRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  syncRequested,required TResult Function( Company company)  addRequested,required TResult Function( String ticker)  removeRequested,required TResult Function()  loadRequested,}) {final _that = this;
switch (_that) {
case _SyncRequested():
return syncRequested();case _AddRequested():
return addRequested(_that.company);case _RemoveRequested():
return removeRequested(_that.ticker);case _LoadRequested():
return loadRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  syncRequested,TResult? Function( Company company)?  addRequested,TResult? Function( String ticker)?  removeRequested,TResult? Function()?  loadRequested,}) {final _that = this;
switch (_that) {
case _SyncRequested() when syncRequested != null:
return syncRequested();case _AddRequested() when addRequested != null:
return addRequested(_that.company);case _RemoveRequested() when removeRequested != null:
return removeRequested(_that.ticker);case _LoadRequested() when loadRequested != null:
return loadRequested();case _:
  return null;

}
}

}

/// @nodoc


class _SyncRequested implements WatchlistEvent {
  const _SyncRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent.syncRequested()';
}


}




/// @nodoc


class _AddRequested implements WatchlistEvent {
  const _AddRequested(this.company);
  

 final  Company company;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddRequestedCopyWith<_AddRequested> get copyWith => __$AddRequestedCopyWithImpl<_AddRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddRequested&&(identical(other.company, company) || other.company == company));
}


@override
int get hashCode => Object.hash(runtimeType,company);

@override
String toString() {
  return 'WatchlistEvent.addRequested(company: $company)';
}


}

/// @nodoc
abstract mixin class _$AddRequestedCopyWith<$Res> implements $WatchlistEventCopyWith<$Res> {
  factory _$AddRequestedCopyWith(_AddRequested value, $Res Function(_AddRequested) _then) = __$AddRequestedCopyWithImpl;
@useResult
$Res call({
 Company company
});


$CompanyCopyWith<$Res> get company;

}
/// @nodoc
class __$AddRequestedCopyWithImpl<$Res>
    implements _$AddRequestedCopyWith<$Res> {
  __$AddRequestedCopyWithImpl(this._self, this._then);

  final _AddRequested _self;
  final $Res Function(_AddRequested) _then;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? company = null,}) {
  return _then(_AddRequested(
null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as Company,
  ));
}

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyCopyWith<$Res> get company {
  
  return $CompanyCopyWith<$Res>(_self.company, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}

/// @nodoc


class _RemoveRequested implements WatchlistEvent {
  const _RemoveRequested(this.ticker);
  

 final  String ticker;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveRequestedCopyWith<_RemoveRequested> get copyWith => __$RemoveRequestedCopyWithImpl<_RemoveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveRequested&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,ticker);

@override
String toString() {
  return 'WatchlistEvent.removeRequested(ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$RemoveRequestedCopyWith<$Res> implements $WatchlistEventCopyWith<$Res> {
  factory _$RemoveRequestedCopyWith(_RemoveRequested value, $Res Function(_RemoveRequested) _then) = __$RemoveRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker
});




}
/// @nodoc
class __$RemoveRequestedCopyWithImpl<$Res>
    implements _$RemoveRequestedCopyWith<$Res> {
  __$RemoveRequestedCopyWithImpl(this._self, this._then);

  final _RemoveRequested _self;
  final $Res Function(_RemoveRequested) _then;

/// Create a copy of WatchlistEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,}) {
  return _then(_RemoveRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadRequested implements WatchlistEvent {
  const _LoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WatchlistEvent.loadRequested()';
}


}




// dart format on
