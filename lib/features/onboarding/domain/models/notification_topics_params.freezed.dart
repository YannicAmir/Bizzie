// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_topics_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationTopicsParams {

 String? get sectorName; List<String> get tickers;
/// Create a copy of NotificationTopicsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTopicsParamsCopyWith<NotificationTopicsParams> get copyWith => _$NotificationTopicsParamsCopyWithImpl<NotificationTopicsParams>(this as NotificationTopicsParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationTopicsParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTopicsParams&&(identical(other.sectorName, _this.sectorName) || other.sectorName == _this.sectorName)&&const DeepCollectionEquality().equals(other.tickers, _this.tickers));
}


@override
int get hashCode {
  final _this = this as NotificationTopicsParams;
  return Object.hash(runtimeType,_this.sectorName,const DeepCollectionEquality().hash(_this.tickers));
}

@override
String toString() {
  final _this = this as NotificationTopicsParams;
  return 'NotificationTopicsParams(sectorName: ${_this.sectorName}, tickers: ${_this.tickers})';
}


}

/// @nodoc
abstract mixin class $NotificationTopicsParamsCopyWith<$Res>  {
  factory $NotificationTopicsParamsCopyWith(NotificationTopicsParams value, $Res Function(NotificationTopicsParams) _then) = _$NotificationTopicsParamsCopyWithImpl;
@useResult
$Res call({
 String? sectorName, List<String> tickers
});




}
/// @nodoc
class _$NotificationTopicsParamsCopyWithImpl<$Res>
    implements $NotificationTopicsParamsCopyWith<$Res> {
  _$NotificationTopicsParamsCopyWithImpl(this._self, this._then);

  final NotificationTopicsParams _self;
  final $Res Function(NotificationTopicsParams) _then;

/// Create a copy of NotificationTopicsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sectorName = freezed,Object? tickers = null,}) {
  return _then(NotificationTopicsParams(
sectorName: freezed == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String?,tickers: null == tickers ? _self.tickers : tickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTopicsParams].
extension NotificationTopicsParamsPatterns on NotificationTopicsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTopicsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTopicsParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTopicsParams value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTopicsParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTopicsParams value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTopicsParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sectorName,  List<String> tickers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTopicsParams() when $default != null:
return $default(_that.sectorName,_that.tickers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sectorName,  List<String> tickers)  $default,) {final _that = this;
switch (_that) {
case _NotificationTopicsParams():
return $default(_that.sectorName,_that.tickers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sectorName,  List<String> tickers)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTopicsParams() when $default != null:
return $default(_that.sectorName,_that.tickers);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationTopicsParams implements NotificationTopicsParams {
  const _NotificationTopicsParams({this.sectorName,  List<String> tickers = const []}): _tickers = tickers;
  

@override final  String? sectorName;
 final  List<String> _tickers;
@override@JsonKey() List<String> get tickers {
  if (_tickers is EqualUnmodifiableListView) return _tickers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickers);
}


/// Create a copy of NotificationTopicsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTopicsParamsCopyWith<_NotificationTopicsParams> get copyWith => __$NotificationTopicsParamsCopyWithImpl<_NotificationTopicsParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTopicsParams&&(identical(other.sectorName, sectorName) || other.sectorName == sectorName)&&const DeepCollectionEquality().equals(other.tickers, _tickers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sectorName,const DeepCollectionEquality().hash(_tickers));
}

@override
String toString() {
    return 'NotificationTopicsParams(sectorName: $sectorName, tickers: $tickers)';
}


}

/// @nodoc
abstract mixin class _$NotificationTopicsParamsCopyWith<$Res> implements $NotificationTopicsParamsCopyWith<$Res> {
  factory _$NotificationTopicsParamsCopyWith(_NotificationTopicsParams value, $Res Function(_NotificationTopicsParams) _then) = __$NotificationTopicsParamsCopyWithImpl;
@override @useResult
$Res call({
 String? sectorName, List<String> tickers
});




}
/// @nodoc
class __$NotificationTopicsParamsCopyWithImpl<$Res>
    implements _$NotificationTopicsParamsCopyWith<$Res> {
  __$NotificationTopicsParamsCopyWithImpl(this._self, this._then);

  final _NotificationTopicsParams _self;
  final $Res Function(_NotificationTopicsParams) _then;

/// Create a copy of NotificationTopicsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sectorName = freezed,Object? tickers = null,}) {
  return _then(_NotificationTopicsParams(
sectorName: freezed == sectorName ? _self.sectorName : sectorName // ignore: cast_nullable_to_non_nullable
as String?,tickers: null == tickers ? _self._tickers : tickers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
