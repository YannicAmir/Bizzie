// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_skip_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingSkipConfig {

 List<OnboardingSkipWatchlistItem> get defaultWatchlist; String get defaultSector; String get initialCompanyTicker;
/// Create a copy of OnboardingSkipConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSkipConfigCopyWith<OnboardingSkipConfig> get copyWith => _$OnboardingSkipConfigCopyWithImpl<OnboardingSkipConfig>(this as OnboardingSkipConfig, _$identity);

  /// Serializes this OnboardingSkipConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSkipConfig&&const DeepCollectionEquality().equals(other.defaultWatchlist, defaultWatchlist)&&(identical(other.defaultSector, defaultSector) || other.defaultSector == defaultSector)&&(identical(other.initialCompanyTicker, initialCompanyTicker) || other.initialCompanyTicker == initialCompanyTicker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(defaultWatchlist),defaultSector,initialCompanyTicker);

@override
String toString() {
  return 'OnboardingSkipConfig(defaultWatchlist: $defaultWatchlist, defaultSector: $defaultSector, initialCompanyTicker: $initialCompanyTicker)';
}


}

/// @nodoc
abstract mixin class $OnboardingSkipConfigCopyWith<$Res>  {
  factory $OnboardingSkipConfigCopyWith(OnboardingSkipConfig value, $Res Function(OnboardingSkipConfig) _then) = _$OnboardingSkipConfigCopyWithImpl;
@useResult
$Res call({
 List<OnboardingSkipWatchlistItem> defaultWatchlist, String defaultSector, String initialCompanyTicker
});




}
/// @nodoc
class _$OnboardingSkipConfigCopyWithImpl<$Res>
    implements $OnboardingSkipConfigCopyWith<$Res> {
  _$OnboardingSkipConfigCopyWithImpl(this._self, this._then);

  final OnboardingSkipConfig _self;
  final $Res Function(OnboardingSkipConfig) _then;

/// Create a copy of OnboardingSkipConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? defaultWatchlist = null,Object? defaultSector = null,Object? initialCompanyTicker = null,}) {
  return _then(_self.copyWith(
defaultWatchlist: null == defaultWatchlist ? _self.defaultWatchlist : defaultWatchlist // ignore: cast_nullable_to_non_nullable
as List<OnboardingSkipWatchlistItem>,defaultSector: null == defaultSector ? _self.defaultSector : defaultSector // ignore: cast_nullable_to_non_nullable
as String,initialCompanyTicker: null == initialCompanyTicker ? _self.initialCompanyTicker : initialCompanyTicker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingSkipConfig].
extension OnboardingSkipConfigPatterns on OnboardingSkipConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingSkipConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingSkipConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingSkipConfig value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingSkipConfig value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OnboardingSkipWatchlistItem> defaultWatchlist,  String defaultSector,  String initialCompanyTicker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingSkipConfig() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OnboardingSkipWatchlistItem> defaultWatchlist,  String defaultSector,  String initialCompanyTicker)  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipConfig():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OnboardingSkipWatchlistItem> defaultWatchlist,  String defaultSector,  String initialCompanyTicker)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipConfig() when $default != null:
return $default(_that.defaultWatchlist,_that.defaultSector,_that.initialCompanyTicker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingSkipConfig implements OnboardingSkipConfig {
  const _OnboardingSkipConfig({final  List<OnboardingSkipWatchlistItem> defaultWatchlist = const [], required this.defaultSector, required this.initialCompanyTicker}): _defaultWatchlist = defaultWatchlist;
  factory _OnboardingSkipConfig.fromJson(Map<String, dynamic> json) => _$OnboardingSkipConfigFromJson(json);

 final  List<OnboardingSkipWatchlistItem> _defaultWatchlist;
@override@JsonKey() List<OnboardingSkipWatchlistItem> get defaultWatchlist {
  if (_defaultWatchlist is EqualUnmodifiableListView) return _defaultWatchlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defaultWatchlist);
}

@override final  String defaultSector;
@override final  String initialCompanyTicker;

/// Create a copy of OnboardingSkipConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingSkipConfigCopyWith<_OnboardingSkipConfig> get copyWith => __$OnboardingSkipConfigCopyWithImpl<_OnboardingSkipConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingSkipConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingSkipConfig&&const DeepCollectionEquality().equals(other._defaultWatchlist, _defaultWatchlist)&&(identical(other.defaultSector, defaultSector) || other.defaultSector == defaultSector)&&(identical(other.initialCompanyTicker, initialCompanyTicker) || other.initialCompanyTicker == initialCompanyTicker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_defaultWatchlist),defaultSector,initialCompanyTicker);

@override
String toString() {
  return 'OnboardingSkipConfig(defaultWatchlist: $defaultWatchlist, defaultSector: $defaultSector, initialCompanyTicker: $initialCompanyTicker)';
}


}

/// @nodoc
abstract mixin class _$OnboardingSkipConfigCopyWith<$Res> implements $OnboardingSkipConfigCopyWith<$Res> {
  factory _$OnboardingSkipConfigCopyWith(_OnboardingSkipConfig value, $Res Function(_OnboardingSkipConfig) _then) = __$OnboardingSkipConfigCopyWithImpl;
@override @useResult
$Res call({
 List<OnboardingSkipWatchlistItem> defaultWatchlist, String defaultSector, String initialCompanyTicker
});




}
/// @nodoc
class __$OnboardingSkipConfigCopyWithImpl<$Res>
    implements _$OnboardingSkipConfigCopyWith<$Res> {
  __$OnboardingSkipConfigCopyWithImpl(this._self, this._then);

  final _OnboardingSkipConfig _self;
  final $Res Function(_OnboardingSkipConfig) _then;

/// Create a copy of OnboardingSkipConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? defaultWatchlist = null,Object? defaultSector = null,Object? initialCompanyTicker = null,}) {
  return _then(_OnboardingSkipConfig(
defaultWatchlist: null == defaultWatchlist ? _self._defaultWatchlist : defaultWatchlist // ignore: cast_nullable_to_non_nullable
as List<OnboardingSkipWatchlistItem>,defaultSector: null == defaultSector ? _self.defaultSector : defaultSector // ignore: cast_nullable_to_non_nullable
as String,initialCompanyTicker: null == initialCompanyTicker ? _self.initialCompanyTicker : initialCompanyTicker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OnboardingSkipWatchlistItem {

 String get ticker; String get name;
/// Create a copy of OnboardingSkipWatchlistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSkipWatchlistItemCopyWith<OnboardingSkipWatchlistItem> get copyWith => _$OnboardingSkipWatchlistItemCopyWithImpl<OnboardingSkipWatchlistItem>(this as OnboardingSkipWatchlistItem, _$identity);

  /// Serializes this OnboardingSkipWatchlistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSkipWatchlistItem&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name);

@override
String toString() {
  return 'OnboardingSkipWatchlistItem(ticker: $ticker, name: $name)';
}


}

/// @nodoc
abstract mixin class $OnboardingSkipWatchlistItemCopyWith<$Res>  {
  factory $OnboardingSkipWatchlistItemCopyWith(OnboardingSkipWatchlistItem value, $Res Function(OnboardingSkipWatchlistItem) _then) = _$OnboardingSkipWatchlistItemCopyWithImpl;
@useResult
$Res call({
 String ticker, String name
});




}
/// @nodoc
class _$OnboardingSkipWatchlistItemCopyWithImpl<$Res>
    implements $OnboardingSkipWatchlistItemCopyWith<$Res> {
  _$OnboardingSkipWatchlistItemCopyWithImpl(this._self, this._then);

  final OnboardingSkipWatchlistItem _self;
  final $Res Function(OnboardingSkipWatchlistItem) _then;

/// Create a copy of OnboardingSkipWatchlistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? name = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingSkipWatchlistItem].
extension OnboardingSkipWatchlistItemPatterns on OnboardingSkipWatchlistItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingSkipWatchlistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingSkipWatchlistItem value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingSkipWatchlistItem value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem() when $default != null:
return $default(_that.ticker,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String name)  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem():
return $default(_that.ticker,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String name)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingSkipWatchlistItem() when $default != null:
return $default(_that.ticker,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingSkipWatchlistItem extends OnboardingSkipWatchlistItem {
  const _OnboardingSkipWatchlistItem({required this.ticker, required this.name}): super._();
  factory _OnboardingSkipWatchlistItem.fromJson(Map<String, dynamic> json) => _$OnboardingSkipWatchlistItemFromJson(json);

@override final  String ticker;
@override final  String name;

/// Create a copy of OnboardingSkipWatchlistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingSkipWatchlistItemCopyWith<_OnboardingSkipWatchlistItem> get copyWith => __$OnboardingSkipWatchlistItemCopyWithImpl<_OnboardingSkipWatchlistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingSkipWatchlistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingSkipWatchlistItem&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,name);

@override
String toString() {
  return 'OnboardingSkipWatchlistItem(ticker: $ticker, name: $name)';
}


}

/// @nodoc
abstract mixin class _$OnboardingSkipWatchlistItemCopyWith<$Res> implements $OnboardingSkipWatchlistItemCopyWith<$Res> {
  factory _$OnboardingSkipWatchlistItemCopyWith(_OnboardingSkipWatchlistItem value, $Res Function(_OnboardingSkipWatchlistItem) _then) = __$OnboardingSkipWatchlistItemCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String name
});




}
/// @nodoc
class __$OnboardingSkipWatchlistItemCopyWithImpl<$Res>
    implements _$OnboardingSkipWatchlistItemCopyWith<$Res> {
  __$OnboardingSkipWatchlistItemCopyWithImpl(this._self, this._then);

  final _OnboardingSkipWatchlistItem _self;
  final $Res Function(_OnboardingSkipWatchlistItem) _then;

/// Create a copy of OnboardingSkipWatchlistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? name = null,}) {
  return _then(_OnboardingSkipWatchlistItem(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
