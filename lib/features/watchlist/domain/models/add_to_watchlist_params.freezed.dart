// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_watchlist_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddToWatchlistParams {

 Company get company; String get uid;
/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToWatchlistParamsCopyWith<AddToWatchlistParams> get copyWith => _$AddToWatchlistParamsCopyWithImpl<AddToWatchlistParams>(this as AddToWatchlistParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToWatchlistParams&&(identical(other.company, company) || other.company == company)&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,company,uid);

@override
String toString() {
  return 'AddToWatchlistParams(company: $company, uid: $uid)';
}


}

/// @nodoc
abstract mixin class $AddToWatchlistParamsCopyWith<$Res>  {
  factory $AddToWatchlistParamsCopyWith(AddToWatchlistParams value, $Res Function(AddToWatchlistParams) _then) = _$AddToWatchlistParamsCopyWithImpl;
@useResult
$Res call({
 Company company, String uid
});


$CompanyCopyWith<$Res> get company;

}
/// @nodoc
class _$AddToWatchlistParamsCopyWithImpl<$Res>
    implements $AddToWatchlistParamsCopyWith<$Res> {
  _$AddToWatchlistParamsCopyWithImpl(this._self, this._then);

  final AddToWatchlistParams _self;
  final $Res Function(AddToWatchlistParams) _then;

/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? company = null,Object? uid = null,}) {
  return _then(_self.copyWith(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as Company,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyCopyWith<$Res> get company {
  
  return $CompanyCopyWith<$Res>(_self.company, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddToWatchlistParams].
extension AddToWatchlistParamsPatterns on AddToWatchlistParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddToWatchlistParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddToWatchlistParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddToWatchlistParams value)  $default,){
final _that = this;
switch (_that) {
case _AddToWatchlistParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddToWatchlistParams value)?  $default,){
final _that = this;
switch (_that) {
case _AddToWatchlistParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Company company,  String uid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddToWatchlistParams() when $default != null:
return $default(_that.company,_that.uid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Company company,  String uid)  $default,) {final _that = this;
switch (_that) {
case _AddToWatchlistParams():
return $default(_that.company,_that.uid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Company company,  String uid)?  $default,) {final _that = this;
switch (_that) {
case _AddToWatchlistParams() when $default != null:
return $default(_that.company,_that.uid);case _:
  return null;

}
}

}

/// @nodoc


class _AddToWatchlistParams implements AddToWatchlistParams {
  const _AddToWatchlistParams({required this.company, required this.uid});
  

@override final  Company company;
@override final  String uid;

/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToWatchlistParamsCopyWith<_AddToWatchlistParams> get copyWith => __$AddToWatchlistParamsCopyWithImpl<_AddToWatchlistParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToWatchlistParams&&(identical(other.company, company) || other.company == company)&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,company,uid);

@override
String toString() {
  return 'AddToWatchlistParams(company: $company, uid: $uid)';
}


}

/// @nodoc
abstract mixin class _$AddToWatchlistParamsCopyWith<$Res> implements $AddToWatchlistParamsCopyWith<$Res> {
  factory _$AddToWatchlistParamsCopyWith(_AddToWatchlistParams value, $Res Function(_AddToWatchlistParams) _then) = __$AddToWatchlistParamsCopyWithImpl;
@override @useResult
$Res call({
 Company company, String uid
});


@override $CompanyCopyWith<$Res> get company;

}
/// @nodoc
class __$AddToWatchlistParamsCopyWithImpl<$Res>
    implements _$AddToWatchlistParamsCopyWith<$Res> {
  __$AddToWatchlistParamsCopyWithImpl(this._self, this._then);

  final _AddToWatchlistParams _self;
  final $Res Function(_AddToWatchlistParams) _then;

/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? company = null,Object? uid = null,}) {
  return _then(_AddToWatchlistParams(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as Company,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AddToWatchlistParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyCopyWith<$Res> get company {
  
  return $CompanyCopyWith<$Res>(_self.company, (value) {
    return _then(_self.copyWith(company: value));
  });
}
}

// dart format on
