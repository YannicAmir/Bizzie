// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_watchlist_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncWatchlistParams {

 List<String> get activeTickers;
/// Create a copy of SyncWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncWatchlistParamsCopyWith<SyncWatchlistParams> get copyWith => _$SyncWatchlistParamsCopyWithImpl<SyncWatchlistParams>(this as SyncWatchlistParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncWatchlistParams&&const DeepCollectionEquality().equals(other.activeTickers, activeTickers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activeTickers));

@override
String toString() {
  return 'SyncWatchlistParams(activeTickers: $activeTickers)';
}


}

/// @nodoc
abstract mixin class $SyncWatchlistParamsCopyWith<$Res>  {
  factory $SyncWatchlistParamsCopyWith(SyncWatchlistParams value, $Res Function(SyncWatchlistParams) _then) = _$SyncWatchlistParamsCopyWithImpl;
@useResult
$Res call({
 List<String> activeTickers
});




}
/// @nodoc
class _$SyncWatchlistParamsCopyWithImpl<$Res>
    implements $SyncWatchlistParamsCopyWith<$Res> {
  _$SyncWatchlistParamsCopyWithImpl(this._self, this._then);

  final SyncWatchlistParams _self;
  final $Res Function(SyncWatchlistParams) _then;

/// Create a copy of SyncWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeTickers = null,}) {
  return _then(_self.copyWith(
activeTickers: null == activeTickers ? _self.activeTickers : activeTickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncWatchlistParams].
extension SyncWatchlistParamsPatterns on SyncWatchlistParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncWatchlistParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncWatchlistParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncWatchlistParams value)  $default,){
final _that = this;
switch (_that) {
case _SyncWatchlistParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncWatchlistParams value)?  $default,){
final _that = this;
switch (_that) {
case _SyncWatchlistParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> activeTickers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncWatchlistParams() when $default != null:
return $default(_that.activeTickers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> activeTickers)  $default,) {final _that = this;
switch (_that) {
case _SyncWatchlistParams():
return $default(_that.activeTickers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> activeTickers)?  $default,) {final _that = this;
switch (_that) {
case _SyncWatchlistParams() when $default != null:
return $default(_that.activeTickers);case _:
  return null;

}
}

}

/// @nodoc


class _SyncWatchlistParams implements SyncWatchlistParams {
  const _SyncWatchlistParams({required final  List<String> activeTickers}): _activeTickers = activeTickers;
  

 final  List<String> _activeTickers;
@override List<String> get activeTickers {
  if (_activeTickers is EqualUnmodifiableListView) return _activeTickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeTickers);
}


/// Create a copy of SyncWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncWatchlistParamsCopyWith<_SyncWatchlistParams> get copyWith => __$SyncWatchlistParamsCopyWithImpl<_SyncWatchlistParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncWatchlistParams&&const DeepCollectionEquality().equals(other._activeTickers, _activeTickers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activeTickers));

@override
String toString() {
  return 'SyncWatchlistParams(activeTickers: $activeTickers)';
}


}

/// @nodoc
abstract mixin class _$SyncWatchlistParamsCopyWith<$Res> implements $SyncWatchlistParamsCopyWith<$Res> {
  factory _$SyncWatchlistParamsCopyWith(_SyncWatchlistParams value, $Res Function(_SyncWatchlistParams) _then) = __$SyncWatchlistParamsCopyWithImpl;
@override @useResult
$Res call({
 List<String> activeTickers
});




}
/// @nodoc
class __$SyncWatchlistParamsCopyWithImpl<$Res>
    implements _$SyncWatchlistParamsCopyWith<$Res> {
  __$SyncWatchlistParamsCopyWithImpl(this._self, this._then);

  final _SyncWatchlistParams _self;
  final $Res Function(_SyncWatchlistParams) _then;

/// Create a copy of SyncWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeTickers = null,}) {
  return _then(_SyncWatchlistParams(
activeTickers: null == activeTickers ? _self._activeTickers : activeTickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
