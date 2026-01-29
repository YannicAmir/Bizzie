// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PricePoint {

 String get date; double get close; double? get volume;
/// Create a copy of PricePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PricePointCopyWith<PricePoint> get copyWith => _$PricePointCopyWithImpl<PricePoint>(this as PricePoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PricePoint&&(identical(other.date, date) || other.date == date)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,date,close,volume);

@override
String toString() {
  return 'PricePoint(date: $date, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $PricePointCopyWith<$Res>  {
  factory $PricePointCopyWith(PricePoint value, $Res Function(PricePoint) _then) = _$PricePointCopyWithImpl;
@useResult
$Res call({
 String date, double close, double? volume
});




}
/// @nodoc
class _$PricePointCopyWithImpl<$Res>
    implements $PricePointCopyWith<$Res> {
  _$PricePointCopyWithImpl(this._self, this._then);

  final PricePoint _self;
  final $Res Function(PricePoint) _then;

/// Create a copy of PricePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? close = null,Object? volume = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PricePoint].
extension PricePointPatterns on PricePoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PricePoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PricePoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PricePoint value)  $default,){
final _that = this;
switch (_that) {
case _PricePoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PricePoint value)?  $default,){
final _that = this;
switch (_that) {
case _PricePoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double close,  double? volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PricePoint() when $default != null:
return $default(_that.date,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double close,  double? volume)  $default,) {final _that = this;
switch (_that) {
case _PricePoint():
return $default(_that.date,_that.close,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double close,  double? volume)?  $default,) {final _that = this;
switch (_that) {
case _PricePoint() when $default != null:
return $default(_that.date,_that.close,_that.volume);case _:
  return null;

}
}

}

/// @nodoc


class _PricePoint implements PricePoint {
  const _PricePoint({required this.date, required this.close, this.volume});
  

@override final  String date;
@override final  double close;
@override final  double? volume;

/// Create a copy of PricePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PricePointCopyWith<_PricePoint> get copyWith => __$PricePointCopyWithImpl<_PricePoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PricePoint&&(identical(other.date, date) || other.date == date)&&(identical(other.close, close) || other.close == close)&&(identical(other.volume, volume) || other.volume == volume));
}


@override
int get hashCode => Object.hash(runtimeType,date,close,volume);

@override
String toString() {
  return 'PricePoint(date: $date, close: $close, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$PricePointCopyWith<$Res> implements $PricePointCopyWith<$Res> {
  factory _$PricePointCopyWith(_PricePoint value, $Res Function(_PricePoint) _then) = __$PricePointCopyWithImpl;
@override @useResult
$Res call({
 String date, double close, double? volume
});




}
/// @nodoc
class __$PricePointCopyWithImpl<$Res>
    implements _$PricePointCopyWith<$Res> {
  __$PricePointCopyWithImpl(this._self, this._then);

  final _PricePoint _self;
  final $Res Function(_PricePoint) _then;

/// Create a copy of PricePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? close = null,Object? volume = freezed,}) {
  return _then(_PricePoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,close: null == close ? _self.close : close // ignore: cast_nullable_to_non_nullable
as double,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
