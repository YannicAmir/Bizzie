// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_tab_layout_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetTabLayoutParams {

 bool get isSubscribed;
/// Create a copy of GetTabLayoutParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTabLayoutParamsCopyWith<GetTabLayoutParams> get copyWith => _$GetTabLayoutParamsCopyWithImpl<GetTabLayoutParams>(this as GetTabLayoutParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTabLayoutParams&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed);

@override
String toString() {
  return 'GetTabLayoutParams(isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class $GetTabLayoutParamsCopyWith<$Res>  {
  factory $GetTabLayoutParamsCopyWith(GetTabLayoutParams value, $Res Function(GetTabLayoutParams) _then) = _$GetTabLayoutParamsCopyWithImpl;
@useResult
$Res call({
 bool isSubscribed
});




}
/// @nodoc
class _$GetTabLayoutParamsCopyWithImpl<$Res>
    implements $GetTabLayoutParamsCopyWith<$Res> {
  _$GetTabLayoutParamsCopyWithImpl(this._self, this._then);

  final GetTabLayoutParams _self;
  final $Res Function(GetTabLayoutParams) _then;

/// Create a copy of GetTabLayoutParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSubscribed = null,}) {
  return _then(_self.copyWith(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GetTabLayoutParams].
extension GetTabLayoutParamsPatterns on GetTabLayoutParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetTabLayoutParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetTabLayoutParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetTabLayoutParams value)  $default,){
final _that = this;
switch (_that) {
case _GetTabLayoutParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetTabLayoutParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetTabLayoutParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSubscribed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetTabLayoutParams() when $default != null:
return $default(_that.isSubscribed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSubscribed)  $default,) {final _that = this;
switch (_that) {
case _GetTabLayoutParams():
return $default(_that.isSubscribed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSubscribed)?  $default,) {final _that = this;
switch (_that) {
case _GetTabLayoutParams() when $default != null:
return $default(_that.isSubscribed);case _:
  return null;

}
}

}

/// @nodoc


class _GetTabLayoutParams implements GetTabLayoutParams {
  const _GetTabLayoutParams({required this.isSubscribed});
  

@override final  bool isSubscribed;

/// Create a copy of GetTabLayoutParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTabLayoutParamsCopyWith<_GetTabLayoutParams> get copyWith => __$GetTabLayoutParamsCopyWithImpl<_GetTabLayoutParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTabLayoutParams&&(identical(other.isSubscribed, isSubscribed) || other.isSubscribed == isSubscribed));
}


@override
int get hashCode => Object.hash(runtimeType,isSubscribed);

@override
String toString() {
  return 'GetTabLayoutParams(isSubscribed: $isSubscribed)';
}


}

/// @nodoc
abstract mixin class _$GetTabLayoutParamsCopyWith<$Res> implements $GetTabLayoutParamsCopyWith<$Res> {
  factory _$GetTabLayoutParamsCopyWith(_GetTabLayoutParams value, $Res Function(_GetTabLayoutParams) _then) = __$GetTabLayoutParamsCopyWithImpl;
@override @useResult
$Res call({
 bool isSubscribed
});




}
/// @nodoc
class __$GetTabLayoutParamsCopyWithImpl<$Res>
    implements _$GetTabLayoutParamsCopyWith<$Res> {
  __$GetTabLayoutParamsCopyWithImpl(this._self, this._then);

  final _GetTabLayoutParams _self;
  final $Res Function(_GetTabLayoutParams) _then;

/// Create a copy of GetTabLayoutParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSubscribed = null,}) {
  return _then(_GetTabLayoutParams(
isSubscribed: null == isSubscribed ? _self.isSubscribed : isSubscribed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
