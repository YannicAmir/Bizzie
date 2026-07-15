// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_layout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TabLayout {

 List<CompanyProfileTab> get mainTabs; List<CompanyProfileTab> get moreTabs;
/// Create a copy of TabLayout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabLayoutCopyWith<TabLayout> get copyWith => _$TabLayoutCopyWithImpl<TabLayout>(this as TabLayout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabLayout&&const DeepCollectionEquality().equals(other.mainTabs, mainTabs)&&const DeepCollectionEquality().equals(other.moreTabs, moreTabs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(mainTabs),const DeepCollectionEquality().hash(moreTabs));

@override
String toString() {
  return 'TabLayout(mainTabs: $mainTabs, moreTabs: $moreTabs)';
}


}

/// @nodoc
abstract mixin class $TabLayoutCopyWith<$Res>  {
  factory $TabLayoutCopyWith(TabLayout value, $Res Function(TabLayout) _then) = _$TabLayoutCopyWithImpl;
@useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs
});




}
/// @nodoc
class _$TabLayoutCopyWithImpl<$Res>
    implements $TabLayoutCopyWith<$Res> {
  _$TabLayoutCopyWithImpl(this._self, this._then);

  final TabLayout _self;
  final $Res Function(TabLayout) _then;

/// Create a copy of TabLayout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainTabs = null,Object? moreTabs = null,}) {
  return _then(_self.copyWith(
mainTabs: null == mainTabs ? _self.mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self.moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,
  ));
}

}


/// Adds pattern-matching-related methods to [TabLayout].
extension TabLayoutPatterns on TabLayout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabLayout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabLayout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabLayout value)  $default,){
final _that = this;
switch (_that) {
case _TabLayout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabLayout value)?  $default,){
final _that = this;
switch (_that) {
case _TabLayout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabLayout() when $default != null:
return $default(_that.mainTabs,_that.moreTabs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs)  $default,) {final _that = this;
switch (_that) {
case _TabLayout():
return $default(_that.mainTabs,_that.moreTabs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CompanyProfileTab> mainTabs,  List<CompanyProfileTab> moreTabs)?  $default,) {final _that = this;
switch (_that) {
case _TabLayout() when $default != null:
return $default(_that.mainTabs,_that.moreTabs);case _:
  return null;

}
}

}

/// @nodoc


class _TabLayout extends TabLayout {
  const _TabLayout({required final  List<CompanyProfileTab> mainTabs, required final  List<CompanyProfileTab> moreTabs}): _mainTabs = mainTabs,_moreTabs = moreTabs,super._();
  

 final  List<CompanyProfileTab> _mainTabs;
@override List<CompanyProfileTab> get mainTabs {
  if (_mainTabs is EqualUnmodifiableListView) return _mainTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mainTabs);
}

 final  List<CompanyProfileTab> _moreTabs;
@override List<CompanyProfileTab> get moreTabs {
  if (_moreTabs is EqualUnmodifiableListView) return _moreTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreTabs);
}


/// Create a copy of TabLayout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabLayoutCopyWith<_TabLayout> get copyWith => __$TabLayoutCopyWithImpl<_TabLayout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabLayout&&const DeepCollectionEquality().equals(other._mainTabs, _mainTabs)&&const DeepCollectionEquality().equals(other._moreTabs, _moreTabs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mainTabs),const DeepCollectionEquality().hash(_moreTabs));

@override
String toString() {
  return 'TabLayout(mainTabs: $mainTabs, moreTabs: $moreTabs)';
}


}

/// @nodoc
abstract mixin class _$TabLayoutCopyWith<$Res> implements $TabLayoutCopyWith<$Res> {
  factory _$TabLayoutCopyWith(_TabLayout value, $Res Function(_TabLayout) _then) = __$TabLayoutCopyWithImpl;
@override @useResult
$Res call({
 List<CompanyProfileTab> mainTabs, List<CompanyProfileTab> moreTabs
});




}
/// @nodoc
class __$TabLayoutCopyWithImpl<$Res>
    implements _$TabLayoutCopyWith<$Res> {
  __$TabLayoutCopyWithImpl(this._self, this._then);

  final _TabLayout _self;
  final $Res Function(_TabLayout) _then;

/// Create a copy of TabLayout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainTabs = null,Object? moreTabs = null,}) {
  return _then(_TabLayout(
mainTabs: null == mainTabs ? _self._mainTabs : mainTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,moreTabs: null == moreTabs ? _self._moreTabs : moreTabs // ignore: cast_nullable_to_non_nullable
as List<CompanyProfileTab>,
  ));
}


}

// dart format on
