// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_daily_brands_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetDailyBrandsParams {

 Sector? get sector;
/// Create a copy of GetDailyBrandsParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetDailyBrandsParamsCopyWith<GetDailyBrandsParams> get copyWith => _$GetDailyBrandsParamsCopyWithImpl<GetDailyBrandsParams>(this as GetDailyBrandsParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetDailyBrandsParams&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'GetDailyBrandsParams(sector: $sector)';
}


}

/// @nodoc
abstract mixin class $GetDailyBrandsParamsCopyWith<$Res>  {
  factory $GetDailyBrandsParamsCopyWith(GetDailyBrandsParams value, $Res Function(GetDailyBrandsParams) _then) = _$GetDailyBrandsParamsCopyWithImpl;
@useResult
$Res call({
 Sector? sector
});




}
/// @nodoc
class _$GetDailyBrandsParamsCopyWithImpl<$Res>
    implements $GetDailyBrandsParamsCopyWith<$Res> {
  _$GetDailyBrandsParamsCopyWithImpl(this._self, this._then);

  final GetDailyBrandsParams _self;
  final $Res Function(GetDailyBrandsParams) _then;

/// Create a copy of GetDailyBrandsParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sector = freezed,}) {
  return _then(_self.copyWith(
sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetDailyBrandsParams].
extension GetDailyBrandsParamsPatterns on GetDailyBrandsParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetDailyBrandsParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetDailyBrandsParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetDailyBrandsParams value)  $default,){
final _that = this;
switch (_that) {
case _GetDailyBrandsParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetDailyBrandsParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetDailyBrandsParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Sector? sector)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetDailyBrandsParams() when $default != null:
return $default(_that.sector);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Sector? sector)  $default,) {final _that = this;
switch (_that) {
case _GetDailyBrandsParams():
return $default(_that.sector);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Sector? sector)?  $default,) {final _that = this;
switch (_that) {
case _GetDailyBrandsParams() when $default != null:
return $default(_that.sector);case _:
  return null;

}
}

}

/// @nodoc


class _GetDailyBrandsParams implements GetDailyBrandsParams {
  const _GetDailyBrandsParams({this.sector});
  

@override final  Sector? sector;

/// Create a copy of GetDailyBrandsParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDailyBrandsParamsCopyWith<_GetDailyBrandsParams> get copyWith => __$GetDailyBrandsParamsCopyWithImpl<_GetDailyBrandsParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDailyBrandsParams&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'GetDailyBrandsParams(sector: $sector)';
}


}

/// @nodoc
abstract mixin class _$GetDailyBrandsParamsCopyWith<$Res> implements $GetDailyBrandsParamsCopyWith<$Res> {
  factory _$GetDailyBrandsParamsCopyWith(_GetDailyBrandsParams value, $Res Function(_GetDailyBrandsParams) _then) = __$GetDailyBrandsParamsCopyWithImpl;
@override @useResult
$Res call({
 Sector? sector
});




}
/// @nodoc
class __$GetDailyBrandsParamsCopyWithImpl<$Res>
    implements _$GetDailyBrandsParamsCopyWith<$Res> {
  __$GetDailyBrandsParamsCopyWithImpl(this._self, this._then);

  final _GetDailyBrandsParams _self;
  final $Res Function(_GetDailyBrandsParams) _then;

/// Create a copy of GetDailyBrandsParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sector = freezed,}) {
  return _then(_GetDailyBrandsParams(
sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector?,
  ));
}


}

// dart format on
