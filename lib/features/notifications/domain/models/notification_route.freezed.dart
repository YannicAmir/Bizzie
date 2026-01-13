// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationRoute {

 String get path; Object? get extra;
/// Create a copy of NotificationRoute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationRouteCopyWith<NotificationRoute> get copyWith => _$NotificationRouteCopyWithImpl<NotificationRoute>(this as NotificationRoute, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationRoute&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.extra, extra));
}


@override
int get hashCode => Object.hash(runtimeType,path,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'NotificationRoute(path: $path, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $NotificationRouteCopyWith<$Res>  {
  factory $NotificationRouteCopyWith(NotificationRoute value, $Res Function(NotificationRoute) _then) = _$NotificationRouteCopyWithImpl;
@useResult
$Res call({
 String path, Object? extra
});




}
/// @nodoc
class _$NotificationRouteCopyWithImpl<$Res>
    implements $NotificationRouteCopyWith<$Res> {
  _$NotificationRouteCopyWithImpl(this._self, this._then);

  final NotificationRoute _self;
  final $Res Function(NotificationRoute) _then;

/// Create a copy of NotificationRoute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? extra = freezed,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,extra: freezed == extra ? _self.extra : extra ,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationRoute].
extension NotificationRoutePatterns on NotificationRoute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationRoute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationRoute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationRoute value)  $default,){
final _that = this;
switch (_that) {
case _NotificationRoute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationRoute value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationRoute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  Object? extra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationRoute() when $default != null:
return $default(_that.path,_that.extra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  Object? extra)  $default,) {final _that = this;
switch (_that) {
case _NotificationRoute():
return $default(_that.path,_that.extra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  Object? extra)?  $default,) {final _that = this;
switch (_that) {
case _NotificationRoute() when $default != null:
return $default(_that.path,_that.extra);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationRoute implements NotificationRoute {
  const _NotificationRoute(this.path, {this.extra});
  

@override final  String path;
@override final  Object? extra;

/// Create a copy of NotificationRoute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationRouteCopyWith<_NotificationRoute> get copyWith => __$NotificationRouteCopyWithImpl<_NotificationRoute>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationRoute&&(identical(other.path, path) || other.path == path)&&const DeepCollectionEquality().equals(other.extra, extra));
}


@override
int get hashCode => Object.hash(runtimeType,path,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'NotificationRoute(path: $path, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$NotificationRouteCopyWith<$Res> implements $NotificationRouteCopyWith<$Res> {
  factory _$NotificationRouteCopyWith(_NotificationRoute value, $Res Function(_NotificationRoute) _then) = __$NotificationRouteCopyWithImpl;
@override @useResult
$Res call({
 String path, Object? extra
});




}
/// @nodoc
class __$NotificationRouteCopyWithImpl<$Res>
    implements _$NotificationRouteCopyWith<$Res> {
  __$NotificationRouteCopyWithImpl(this._self, this._then);

  final _NotificationRoute _self;
  final $Res Function(_NotificationRoute) _then;

/// Create a copy of NotificationRoute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? extra = freezed,}) {
  return _then(_NotificationRoute(
null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,extra: freezed == extra ? _self.extra : extra ,
  ));
}


}

// dart format on
