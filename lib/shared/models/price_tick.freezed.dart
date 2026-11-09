// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceTick {

 String get unchangedText; String get changedText; Color? get flashColor; double get intensity;
/// Create a copy of PriceTick
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceTickCopyWith<PriceTick> get copyWith => _$PriceTickCopyWithImpl<PriceTick>(this as PriceTick, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceTick&&(identical(other.unchangedText, unchangedText) || other.unchangedText == unchangedText)&&(identical(other.changedText, changedText) || other.changedText == changedText)&&(identical(other.flashColor, flashColor) || other.flashColor == flashColor)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,unchangedText,changedText,flashColor,intensity);

@override
String toString() {
  return 'PriceTick(unchangedText: $unchangedText, changedText: $changedText, flashColor: $flashColor, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class $PriceTickCopyWith<$Res>  {
  factory $PriceTickCopyWith(PriceTick value, $Res Function(PriceTick) _then) = _$PriceTickCopyWithImpl;
@useResult
$Res call({
 String unchangedText, String changedText, Color? flashColor, double intensity
});




}
/// @nodoc
class _$PriceTickCopyWithImpl<$Res>
    implements $PriceTickCopyWith<$Res> {
  _$PriceTickCopyWithImpl(this._self, this._then);

  final PriceTick _self;
  final $Res Function(PriceTick) _then;

/// Create a copy of PriceTick
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unchangedText = null,Object? changedText = null,Object? flashColor = freezed,Object? intensity = null,}) {
  return _then(_self.copyWith(
unchangedText: null == unchangedText ? _self.unchangedText : unchangedText // ignore: cast_nullable_to_non_nullable
as String,changedText: null == changedText ? _self.changedText : changedText // ignore: cast_nullable_to_non_nullable
as String,flashColor: freezed == flashColor ? _self.flashColor : flashColor // ignore: cast_nullable_to_non_nullable
as Color?,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceTick].
extension PriceTickPatterns on PriceTick {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceTick value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceTick() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceTick value)  $default,){
final _that = this;
switch (_that) {
case _PriceTick():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceTick value)?  $default,){
final _that = this;
switch (_that) {
case _PriceTick() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String unchangedText,  String changedText,  Color? flashColor,  double intensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceTick() when $default != null:
return $default(_that.unchangedText,_that.changedText,_that.flashColor,_that.intensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String unchangedText,  String changedText,  Color? flashColor,  double intensity)  $default,) {final _that = this;
switch (_that) {
case _PriceTick():
return $default(_that.unchangedText,_that.changedText,_that.flashColor,_that.intensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String unchangedText,  String changedText,  Color? flashColor,  double intensity)?  $default,) {final _that = this;
switch (_that) {
case _PriceTick() when $default != null:
return $default(_that.unchangedText,_that.changedText,_that.flashColor,_that.intensity);case _:
  return null;

}
}

}

/// @nodoc


class _PriceTick extends PriceTick {
  const _PriceTick({required this.unchangedText, required this.changedText, required this.flashColor, required this.intensity}): super._();
  

@override final  String unchangedText;
@override final  String changedText;
@override final  Color? flashColor;
@override final  double intensity;

/// Create a copy of PriceTick
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceTickCopyWith<_PriceTick> get copyWith => __$PriceTickCopyWithImpl<_PriceTick>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceTick&&(identical(other.unchangedText, unchangedText) || other.unchangedText == unchangedText)&&(identical(other.changedText, changedText) || other.changedText == changedText)&&(identical(other.flashColor, flashColor) || other.flashColor == flashColor)&&(identical(other.intensity, intensity) || other.intensity == intensity));
}


@override
int get hashCode => Object.hash(runtimeType,unchangedText,changedText,flashColor,intensity);

@override
String toString() {
  return 'PriceTick(unchangedText: $unchangedText, changedText: $changedText, flashColor: $flashColor, intensity: $intensity)';
}


}

/// @nodoc
abstract mixin class _$PriceTickCopyWith<$Res> implements $PriceTickCopyWith<$Res> {
  factory _$PriceTickCopyWith(_PriceTick value, $Res Function(_PriceTick) _then) = __$PriceTickCopyWithImpl;
@override @useResult
$Res call({
 String unchangedText, String changedText, Color? flashColor, double intensity
});




}
/// @nodoc
class __$PriceTickCopyWithImpl<$Res>
    implements _$PriceTickCopyWith<$Res> {
  __$PriceTickCopyWithImpl(this._self, this._then);

  final _PriceTick _self;
  final $Res Function(_PriceTick) _then;

/// Create a copy of PriceTick
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unchangedText = null,Object? changedText = null,Object? flashColor = freezed,Object? intensity = null,}) {
  return _then(_PriceTick(
unchangedText: null == unchangedText ? _self.unchangedText : unchangedText // ignore: cast_nullable_to_non_nullable
as String,changedText: null == changedText ? _self.changedText : changedText // ignore: cast_nullable_to_non_nullable
as String,flashColor: freezed == flashColor ? _self.flashColor : flashColor // ignore: cast_nullable_to_non_nullable
as Color?,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
