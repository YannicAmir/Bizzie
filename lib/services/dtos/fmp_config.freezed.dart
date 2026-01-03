// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fmp_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FmpConfig {

 String get baseUrl; String get v3Url; String get v4Url;
/// Create a copy of FmpConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FmpConfigCopyWith<FmpConfig> get copyWith => _$FmpConfigCopyWithImpl<FmpConfig>(this as FmpConfig, _$identity);

  /// Serializes this FmpConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FmpConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.v3Url, v3Url) || other.v3Url == v3Url)&&(identical(other.v4Url, v4Url) || other.v4Url == v4Url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,v3Url,v4Url);

@override
String toString() {
  return 'FmpConfig(baseUrl: $baseUrl, v3Url: $v3Url, v4Url: $v4Url)';
}


}

/// @nodoc
abstract mixin class $FmpConfigCopyWith<$Res>  {
  factory $FmpConfigCopyWith(FmpConfig value, $Res Function(FmpConfig) _then) = _$FmpConfigCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String v3Url, String v4Url
});




}
/// @nodoc
class _$FmpConfigCopyWithImpl<$Res>
    implements $FmpConfigCopyWith<$Res> {
  _$FmpConfigCopyWithImpl(this._self, this._then);

  final FmpConfig _self;
  final $Res Function(FmpConfig) _then;

/// Create a copy of FmpConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? v3Url = null,Object? v4Url = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,v3Url: null == v3Url ? _self.v3Url : v3Url // ignore: cast_nullable_to_non_nullable
as String,v4Url: null == v4Url ? _self.v4Url : v4Url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FmpConfig].
extension FmpConfigPatterns on FmpConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FmpConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FmpConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FmpConfig value)  $default,){
final _that = this;
switch (_that) {
case _FmpConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FmpConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FmpConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String v3Url,  String v4Url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FmpConfig() when $default != null:
return $default(_that.baseUrl,_that.v3Url,_that.v4Url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String v3Url,  String v4Url)  $default,) {final _that = this;
switch (_that) {
case _FmpConfig():
return $default(_that.baseUrl,_that.v3Url,_that.v4Url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String v3Url,  String v4Url)?  $default,) {final _that = this;
switch (_that) {
case _FmpConfig() when $default != null:
return $default(_that.baseUrl,_that.v3Url,_that.v4Url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FmpConfig implements FmpConfig {
  const _FmpConfig({required this.baseUrl, required this.v3Url, required this.v4Url});
  factory _FmpConfig.fromJson(Map<String, dynamic> json) => _$FmpConfigFromJson(json);

@override final  String baseUrl;
@override final  String v3Url;
@override final  String v4Url;

/// Create a copy of FmpConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FmpConfigCopyWith<_FmpConfig> get copyWith => __$FmpConfigCopyWithImpl<_FmpConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FmpConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FmpConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.v3Url, v3Url) || other.v3Url == v3Url)&&(identical(other.v4Url, v4Url) || other.v4Url == v4Url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,v3Url,v4Url);

@override
String toString() {
  return 'FmpConfig(baseUrl: $baseUrl, v3Url: $v3Url, v4Url: $v4Url)';
}


}

/// @nodoc
abstract mixin class _$FmpConfigCopyWith<$Res> implements $FmpConfigCopyWith<$Res> {
  factory _$FmpConfigCopyWith(_FmpConfig value, $Res Function(_FmpConfig) _then) = __$FmpConfigCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String v3Url, String v4Url
});




}
/// @nodoc
class __$FmpConfigCopyWithImpl<$Res>
    implements _$FmpConfigCopyWith<$Res> {
  __$FmpConfigCopyWithImpl(this._self, this._then);

  final _FmpConfig _self;
  final $Res Function(_FmpConfig) _then;

/// Create a copy of FmpConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? v3Url = null,Object? v4Url = null,}) {
  return _then(_FmpConfig(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,v3Url: null == v3Url ? _self.v3Url : v3Url // ignore: cast_nullable_to_non_nullable
as String,v4Url: null == v4Url ? _self.v4Url : v4Url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
