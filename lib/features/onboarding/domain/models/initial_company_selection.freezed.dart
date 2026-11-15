// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initial_company_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InitialCompanySelection {

 String get ticker; OnboardingValueSource get source;
/// Create a copy of InitialCompanySelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialCompanySelectionCopyWith<InitialCompanySelection> get copyWith => _$InitialCompanySelectionCopyWithImpl<InitialCompanySelection>(this as InitialCompanySelection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialCompanySelection&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,source);

@override
String toString() {
  return 'InitialCompanySelection(ticker: $ticker, source: $source)';
}


}

/// @nodoc
abstract mixin class $InitialCompanySelectionCopyWith<$Res>  {
  factory $InitialCompanySelectionCopyWith(InitialCompanySelection value, $Res Function(InitialCompanySelection) _then) = _$InitialCompanySelectionCopyWithImpl;
@useResult
$Res call({
 String ticker, OnboardingValueSource source
});




}
/// @nodoc
class _$InitialCompanySelectionCopyWithImpl<$Res>
    implements $InitialCompanySelectionCopyWith<$Res> {
  _$InitialCompanySelectionCopyWithImpl(this._self, this._then);

  final InitialCompanySelection _self;
  final $Res Function(InitialCompanySelection) _then;

/// Create a copy of InitialCompanySelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? source = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialCompanySelection].
extension InitialCompanySelectionPatterns on InitialCompanySelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialCompanySelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialCompanySelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialCompanySelection value)  $default,){
final _that = this;
switch (_that) {
case _InitialCompanySelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialCompanySelection value)?  $default,){
final _that = this;
switch (_that) {
case _InitialCompanySelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  OnboardingValueSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialCompanySelection() when $default != null:
return $default(_that.ticker,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  OnboardingValueSource source)  $default,) {final _that = this;
switch (_that) {
case _InitialCompanySelection():
return $default(_that.ticker,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  OnboardingValueSource source)?  $default,) {final _that = this;
switch (_that) {
case _InitialCompanySelection() when $default != null:
return $default(_that.ticker,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _InitialCompanySelection implements InitialCompanySelection {
  const _InitialCompanySelection({required this.ticker, required this.source});
  

@override final  String ticker;
@override final  OnboardingValueSource source;

/// Create a copy of InitialCompanySelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCompanySelectionCopyWith<_InitialCompanySelection> get copyWith => __$InitialCompanySelectionCopyWithImpl<_InitialCompanySelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialCompanySelection&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,source);

@override
String toString() {
  return 'InitialCompanySelection(ticker: $ticker, source: $source)';
}


}

/// @nodoc
abstract mixin class _$InitialCompanySelectionCopyWith<$Res> implements $InitialCompanySelectionCopyWith<$Res> {
  factory _$InitialCompanySelectionCopyWith(_InitialCompanySelection value, $Res Function(_InitialCompanySelection) _then) = __$InitialCompanySelectionCopyWithImpl;
@override @useResult
$Res call({
 String ticker, OnboardingValueSource source
});




}
/// @nodoc
class __$InitialCompanySelectionCopyWithImpl<$Res>
    implements _$InitialCompanySelectionCopyWith<$Res> {
  __$InitialCompanySelectionCopyWithImpl(this._self, this._then);

  final _InitialCompanySelection _self;
  final $Res Function(_InitialCompanySelection) _then;

/// Create a copy of InitialCompanySelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? source = null,}) {
  return _then(_InitialCompanySelection(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as OnboardingValueSource,
  ));
}


}

// dart format on
