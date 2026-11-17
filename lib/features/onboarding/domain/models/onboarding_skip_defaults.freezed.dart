// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_skip_defaults.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingSkipDefaults {

 List<Company> get defaultWatchlist; Sector? get defaultSector; String get initialCompanyTicker;
/// Create a copy of OnboardingSkipDefaults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSkipDefaultsCopyWith<OnboardingSkipDefaults> get copyWith => _$OnboardingSkipDefaultsCopyWithImpl<OnboardingSkipDefaults>(this as OnboardingSkipDefaults, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSkipDefaults&&const DeepCollectionEquality().equals(other.defaultWatchlist, defaultWatchlist)&&(identical(other.defaultSector, defaultSector) || other.defaultSector == defaultSector)&&(identical(other.initialCompanyTicker, initialCompanyTicker) || other.initialCompanyTicker == initialCompanyTicker));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(defaultWatchlist),defaultSector,initialCompanyTicker);

@override
String toString() {
  return 'OnboardingSkipDefaults(defaultWatchlist: $defaultWatchlist, defaultSector: $defaultSector, initialCompanyTicker: $initialCompanyTicker)';
}


}

/// @nodoc
abstract mixin class $OnboardingSkipDefaultsCopyWith<$Res>  {
  factory $OnboardingSkipDefaultsCopyWith(OnboardingSkipDefaults value, $Res Function(OnboardingSkipDefaults) _then) = _$OnboardingSkipDefaultsCopyWithImpl;
@useResult
$Res call({
 List<Company> defaultWatchlist, Sector? defaultSector, String initialCompanyTicker
});




}
/// @nodoc
class _$OnboardingSkipDefaultsCopyWithImpl<$Res>
    implements $OnboardingSkipDefaultsCopyWith<$Res> {
  _$OnboardingSkipDefaultsCopyWithImpl(this._self, this._then);

  final OnboardingSkipDefaults _self;
  final $Res Function(OnboardingSkipDefaults) _then;

/// Create a copy of OnboardingSkipDefaults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultWatchlist = null,Object? defaultSector = freezed,Object? initialCompanyTicker = null,}) {
  return _then(_self.copyWith(
defaultWatchlist: null == defaultWatchlist ? _self.defaultWatchlist : defaultWatchlist // ignore: cast_nullable_to_non_nullable
as List<Company>,defaultSector: freezed == defaultSector ? _self.defaultSector : defaultSector // ignore: cast_nullable_to_non_nullable
as Sector?,initialCompanyTicker: null == initialCompanyTicker ? _self.initialCompanyTicker : initialCompanyTicker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingSkipDefaults].
extension OnboardingSkipDefaultsPatterns on OnboardingSkipDefaults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingSkipDefaults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingSkipDefaults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingSkipDefaults value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipDefaults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingSkipDefaults value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipDefaults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Company> defaultWatchlist,  Sector? defaultSector,  String initialCompanyTicker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingSkipDefaults() when $default != null:
return $default(_that.defaultWatchlist,_that.defaultSector,_that.initialCompanyTicker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Company> defaultWatchlist,  Sector? defaultSector,  String initialCompanyTicker)  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipDefaults():
return $default(_that.defaultWatchlist,_that.defaultSector,_that.initialCompanyTicker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Company> defaultWatchlist,  Sector? defaultSector,  String initialCompanyTicker)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipDefaults() when $default != null:
return $default(_that.defaultWatchlist,_that.defaultSector,_that.initialCompanyTicker);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingSkipDefaults implements OnboardingSkipDefaults {
  const _OnboardingSkipDefaults({required final  List<Company> defaultWatchlist, this.defaultSector, required this.initialCompanyTicker}): _defaultWatchlist = defaultWatchlist;
  

 final  List<Company> _defaultWatchlist;
@override List<Company> get defaultWatchlist {
  if (_defaultWatchlist is EqualUnmodifiableListView) return _defaultWatchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defaultWatchlist);
}

@override final  Sector? defaultSector;
@override final  String initialCompanyTicker;

/// Create a copy of OnboardingSkipDefaults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingSkipDefaultsCopyWith<_OnboardingSkipDefaults> get copyWith => __$OnboardingSkipDefaultsCopyWithImpl<_OnboardingSkipDefaults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingSkipDefaults&&const DeepCollectionEquality().equals(other._defaultWatchlist, _defaultWatchlist)&&(identical(other.defaultSector, defaultSector) || other.defaultSector == defaultSector)&&(identical(other.initialCompanyTicker, initialCompanyTicker) || other.initialCompanyTicker == initialCompanyTicker));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_defaultWatchlist),defaultSector,initialCompanyTicker);

@override
String toString() {
  return 'OnboardingSkipDefaults(defaultWatchlist: $defaultWatchlist, defaultSector: $defaultSector, initialCompanyTicker: $initialCompanyTicker)';
}


}

/// @nodoc
abstract mixin class _$OnboardingSkipDefaultsCopyWith<$Res> implements $OnboardingSkipDefaultsCopyWith<$Res> {
  factory _$OnboardingSkipDefaultsCopyWith(_OnboardingSkipDefaults value, $Res Function(_OnboardingSkipDefaults) _then) = __$OnboardingSkipDefaultsCopyWithImpl;
@override @useResult
$Res call({
 List<Company> defaultWatchlist, Sector? defaultSector, String initialCompanyTicker
});




}
/// @nodoc
class __$OnboardingSkipDefaultsCopyWithImpl<$Res>
    implements _$OnboardingSkipDefaultsCopyWith<$Res> {
  __$OnboardingSkipDefaultsCopyWithImpl(this._self, this._then);

  final _OnboardingSkipDefaults _self;
  final $Res Function(_OnboardingSkipDefaults) _then;

/// Create a copy of OnboardingSkipDefaults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultWatchlist = null,Object? defaultSector = freezed,Object? initialCompanyTicker = null,}) {
  return _then(_OnboardingSkipDefaults(
defaultWatchlist: null == defaultWatchlist ? _self._defaultWatchlist : defaultWatchlist // ignore: cast_nullable_to_non_nullable
as List<Company>,defaultSector: freezed == defaultSector ? _self.defaultSector : defaultSector // ignore: cast_nullable_to_non_nullable
as Sector?,initialCompanyTicker: null == initialCompanyTicker ? _self.initialCompanyTicker : initialCompanyTicker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
