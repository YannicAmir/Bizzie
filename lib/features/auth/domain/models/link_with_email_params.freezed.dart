// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_with_email_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LinkWithEmailParams {

 String get email; String get password;
/// Create a copy of LinkWithEmailParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkWithEmailParamsCopyWith<LinkWithEmailParams> get copyWith => _$LinkWithEmailParamsCopyWithImpl<LinkWithEmailParams>(this as LinkWithEmailParams, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LinkWithEmailParams;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkWithEmailParams&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password));
}


@override
int get hashCode {
  final _this = this as LinkWithEmailParams;
  return Object.hash(runtimeType,_this.email,_this.password);
}

@override
String toString() {
  final _this = this as LinkWithEmailParams;
  return 'LinkWithEmailParams(email: ${_this.email}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $LinkWithEmailParamsCopyWith<$Res>  {
  factory $LinkWithEmailParamsCopyWith(LinkWithEmailParams value, $Res Function(LinkWithEmailParams) _then) = _$LinkWithEmailParamsCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LinkWithEmailParamsCopyWithImpl<$Res>
    implements $LinkWithEmailParamsCopyWith<$Res> {
  _$LinkWithEmailParamsCopyWithImpl(this._self, this._then);

  final LinkWithEmailParams _self;
  final $Res Function(LinkWithEmailParams) _then;

/// Create a copy of LinkWithEmailParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(LinkWithEmailParams(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkWithEmailParams].
extension LinkWithEmailParamsPatterns on LinkWithEmailParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkWithEmailParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkWithEmailParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkWithEmailParams value)  $default,){
final _that = this;
switch (_that) {
case _LinkWithEmailParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkWithEmailParams value)?  $default,){
final _that = this;
switch (_that) {
case _LinkWithEmailParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkWithEmailParams() when $default != null:
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _LinkWithEmailParams():
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _LinkWithEmailParams() when $default != null:
return $default(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _LinkWithEmailParams implements LinkWithEmailParams {
  const _LinkWithEmailParams({required this.email, required this.password});
  

@override final  String email;
@override final  String password;

/// Create a copy of LinkWithEmailParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkWithEmailParamsCopyWith<_LinkWithEmailParams> get copyWith => __$LinkWithEmailParamsCopyWithImpl<_LinkWithEmailParams>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkWithEmailParams&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,password);
}

@override
String toString() {
    return 'LinkWithEmailParams(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LinkWithEmailParamsCopyWith<$Res> implements $LinkWithEmailParamsCopyWith<$Res> {
  factory _$LinkWithEmailParamsCopyWith(_LinkWithEmailParams value, $Res Function(_LinkWithEmailParams) _then) = __$LinkWithEmailParamsCopyWithImpl;
@override @useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$LinkWithEmailParamsCopyWithImpl<$Res>
    implements _$LinkWithEmailParamsCopyWith<$Res> {
  __$LinkWithEmailParamsCopyWithImpl(this._self, this._then);

  final _LinkWithEmailParams _self;
  final $Res Function(_LinkWithEmailParams) _then;

/// Create a copy of LinkWithEmailParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LinkWithEmailParams(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
