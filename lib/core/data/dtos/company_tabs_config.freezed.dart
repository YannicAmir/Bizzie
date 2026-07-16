// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_tabs_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyTabsConfig {

 List<String> get mainTabs; List<String> get moreTabs; List<String> get bizziePlusTabs;
/// Create a copy of CompanyTabsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyTabsConfigCopyWith<CompanyTabsConfig> get copyWith => _$CompanyTabsConfigCopyWithImpl<CompanyTabsConfig>(this as CompanyTabsConfig, _$identity);

  /// Serializes this CompanyTabsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyTabsConfig&&const DeepCollectionEquality().equals(other.mainTabs, mainTabs)&&const DeepCollectionEquality().equals(other.moreTabs, moreTabs)&&const DeepCollectionEquality().equals(other.bizziePlusTabs, bizziePlusTabs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(mainTabs),const DeepCollectionEquality().hash(moreTabs),const DeepCollectionEquality().hash(bizziePlusTabs));

@override
String toString() {
  return 'CompanyTabsConfig(mainTabs: $mainTabs, moreTabs: $moreTabs, bizziePlusTabs: $bizziePlusTabs)';
}


}

/// @nodoc
abstract mixin class $CompanyTabsConfigCopyWith<$Res>  {
  factory $CompanyTabsConfigCopyWith(CompanyTabsConfig value, $Res Function(CompanyTabsConfig) _then) = _$CompanyTabsConfigCopyWithImpl;
@useResult
$Res call({
 List<String> mainTabs, List<String> moreTabs, List<String> bizziePlusTabs
});




}
/// @nodoc
class _$CompanyTabsConfigCopyWithImpl<$Res>
    implements $CompanyTabsConfigCopyWith<$Res> {
  _$CompanyTabsConfigCopyWithImpl(this._self, this._then);

  final CompanyTabsConfig _self;
  final $Res Function(CompanyTabsConfig) _then;

/// Create a copy of CompanyTabsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? bizziePlusTabs = null,}) {
  return _then(_self.copyWith(
mainTabs: null == mainTabs ? _self.mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<String>,moreTabs: null == moreTabs ? _self.moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<String>,bizziePlusTabs: null == bizziePlusTabs ? _self.bizziePlusTabs : bizziePlusTabs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyTabsConfig].
extension CompanyTabsConfigPatterns on CompanyTabsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyTabsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyTabsConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyTabsConfig value)  $default,){
final _that = this;
switch (_that) {
case _CompanyTabsConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyTabsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyTabsConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> mainTabs,  List<String> moreTabs,  List<String> bizziePlusTabs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyTabsConfig() when $default != null:
return $default(_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> mainTabs,  List<String> moreTabs,  List<String> bizziePlusTabs)  $default,) {final _that = this;
switch (_that) {
case _CompanyTabsConfig():
return $default(_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> mainTabs,  List<String> moreTabs,  List<String> bizziePlusTabs)?  $default,) {final _that = this;
switch (_that) {
case _CompanyTabsConfig() when $default != null:
return $default(_that.mainTabs,_that.moreTabs,_that.bizziePlusTabs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyTabsConfig implements CompanyTabsConfig {
  const _CompanyTabsConfig({final  List<String> mainTabs = const [], final  List<String> moreTabs = const [], final  List<String> bizziePlusTabs = const []}): _mainTabs = mainTabs,_moreTabs = moreTabs,_bizziePlusTabs = bizziePlusTabs;
  factory _CompanyTabsConfig.fromJson(Map<String, dynamic> json) => _$CompanyTabsConfigFromJson(json);

 final  List<String> _mainTabs;
@override@JsonKey() List<String> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<String> _moreTabs;
@override@JsonKey() List<String> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}

 final  List<String> _bizziePlusTabs;
@override@JsonKey() List<String> get bizziePlusTabs {
  if (_bizziePlusTabs is EqualUnmodifiableListView) return _bizziePlusTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bizziePlusTabs);
}


/// Create a copy of CompanyTabsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyTabsConfigCopyWith<_CompanyTabsConfig> get copyWith => __$CompanyTabsConfigCopyWithImpl<_CompanyTabsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyTabsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyTabsConfig&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs)&&const DeepCollectionEquality().equals(other._bizziePlusTabs, _bizziePlusTabs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs),const DeepCollectionEquality().hash(_bizziePlusTabs));

@override
String toString() {
  return 'CompanyTabsConfig(mainTabs: $mainTabs, moreTabs: $moreTabs, bizziePlusTabs: $bizziePlusTabs)';
}


}

/// @nodoc
abstract mixin class _$CompanyTabsConfigCopyWith<$Res> implements $CompanyTabsConfigCopyWith<$Res> {
  factory _$CompanyTabsConfigCopyWith(_CompanyTabsConfig value, $Res Function(_CompanyTabsConfig) _then) = __$CompanyTabsConfigCopyWithImpl;
@override @useResult
$Res call({
 List<String> mainTabs, List<String> moreTabs, List<String> bizziePlusTabs
});




}
/// @nodoc
class __$CompanyTabsConfigCopyWithImpl<$Res>
    implements _$CompanyTabsConfigCopyWith<$Res> {
  __$CompanyTabsConfigCopyWithImpl(this._self, this._then);

  final _CompanyTabsConfig _self;
  final $Res Function(_CompanyTabsConfig) _then;

/// Create a copy of CompanyTabsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainTabs = null,Object? moreTabs = null,Object? bizziePlusTabs = null,}) {
  return _then(_CompanyTabsConfig(
mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<String>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<String>,bizziePlusTabs: null == bizziePlusTabs ? _self._bizziePlusTabs : bizziePlusTabs // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
