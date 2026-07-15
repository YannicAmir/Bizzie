// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_activation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TabActivation {

 CompanyProfileTab get tab; String get ticker;
/// Create a copy of TabActivation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabActivationCopyWith<TabActivation> get copyWith => _$TabActivationCopyWithImpl<TabActivation>(this as TabActivation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabActivation&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,tab,ticker);

@override
String toString() {
  return 'TabActivation(tab: $tab, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $TabActivationCopyWith<$Res>  {
  factory $TabActivationCopyWith(TabActivation value, $Res Function(TabActivation) _then) = _$TabActivationCopyWithImpl;
@useResult
$Res call({
 CompanyProfileTab tab, String ticker
});




}
/// @nodoc
class _$TabActivationCopyWithImpl<$Res>
    implements $TabActivationCopyWith<$Res> {
  _$TabActivationCopyWithImpl(this._self, this._then);

  final TabActivation _self;
  final $Res Function(TabActivation) _then;

/// Create a copy of TabActivation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tab = null,Object? ticker = null,}) {
  return _then(_self.copyWith(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as CompanyProfileTab,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TabActivation].
extension TabActivationPatterns on TabActivation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabActivation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabActivation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabActivation value)  $default,){
final _that = this;
switch (_that) {
case _TabActivation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabActivation value)?  $default,){
final _that = this;
switch (_that) {
case _TabActivation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CompanyProfileTab tab,  String ticker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabActivation() when $default != null:
return $default(_that.tab,_that.ticker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CompanyProfileTab tab,  String ticker)  $default,) {final _that = this;
switch (_that) {
case _TabActivation():
return $default(_that.tab,_that.ticker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CompanyProfileTab tab,  String ticker)?  $default,) {final _that = this;
switch (_that) {
case _TabActivation() when $default != null:
return $default(_that.tab,_that.ticker);case _:
  return null;

}
}

}

/// @nodoc


class _TabActivation implements TabActivation {
  const _TabActivation({required this.tab, required this.ticker});
  

@override final  CompanyProfileTab tab;
@override final  String ticker;

/// Create a copy of TabActivation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabActivationCopyWith<_TabActivation> get copyWith => __$TabActivationCopyWithImpl<_TabActivation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabActivation&&(identical(other.tab, tab) || other.tab == tab)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}


@override
int get hashCode => Object.hash(runtimeType,tab,ticker);

@override
String toString() {
  return 'TabActivation(tab: $tab, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$TabActivationCopyWith<$Res> implements $TabActivationCopyWith<$Res> {
  factory _$TabActivationCopyWith(_TabActivation value, $Res Function(_TabActivation) _then) = __$TabActivationCopyWithImpl;
@override @useResult
$Res call({
 CompanyProfileTab tab, String ticker
});




}
/// @nodoc
class __$TabActivationCopyWithImpl<$Res>
    implements _$TabActivationCopyWith<$Res> {
  __$TabActivationCopyWithImpl(this._self, this._then);

  final _TabActivation _self;
  final $Res Function(_TabActivation) _then;

/// Create a copy of TabActivation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tab = null,Object? ticker = null,}) {
  return _then(_TabActivation(
tab: null == tab ? _self.tab : tab // ignore: cast_nullable_to_non_nullable
as CompanyProfileTab,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
