// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frankfurter_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FrankfurterResponseDto {

 String get date; String get base; String get quote; double get rate;
/// Create a copy of FrankfurterResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrankfurterResponseDtoCopyWith<FrankfurterResponseDto> get copyWith => _$FrankfurterResponseDtoCopyWithImpl<FrankfurterResponseDto>(this as FrankfurterResponseDto, _$identity);

  /// Serializes this FrankfurterResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrankfurterResponseDto&&(identical(other.date, date) || other.date == date)&&(identical(other.base, base) || other.base == base)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,base,quote,rate);

@override
String toString() {
  return 'FrankfurterResponseDto(date: $date, base: $base, quote: $quote, rate: $rate)';
}


}

/// @nodoc
abstract mixin class $FrankfurterResponseDtoCopyWith<$Res>  {
  factory $FrankfurterResponseDtoCopyWith(FrankfurterResponseDto value, $Res Function(FrankfurterResponseDto) _then) = _$FrankfurterResponseDtoCopyWithImpl;
@useResult
$Res call({
 String date, String base, String quote, double rate
});




}
/// @nodoc
class _$FrankfurterResponseDtoCopyWithImpl<$Res>
    implements $FrankfurterResponseDtoCopyWith<$Res> {
  _$FrankfurterResponseDtoCopyWithImpl(this._self, this._then);

  final FrankfurterResponseDto _self;
  final $Res Function(FrankfurterResponseDto) _then;

/// Create a copy of FrankfurterResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? base = null,Object? quote = null,Object? rate = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [FrankfurterResponseDto].
extension FrankfurterResponseDtoPatterns on FrankfurterResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FrankfurterResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FrankfurterResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _FrankfurterResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FrankfurterResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String base,  String quote,  double rate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String base,  String quote,  double rate)  $default,) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto():
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String base,  String quote,  double rate)?  $default,) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FrankfurterResponseDto extends FrankfurterResponseDto {
  const _FrankfurterResponseDto({required this.date, required this.base, required this.quote, required this.rate}): super._();
  factory _FrankfurterResponseDto.fromJson(Map<String, dynamic> json) => _$FrankfurterResponseDtoFromJson(json);

@override final  String date;
@override final  String base;
@override final  String quote;
@override final  double rate;

/// Create a copy of FrankfurterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FrankfurterResponseDtoCopyWith<_FrankfurterResponseDto> get copyWith => __$FrankfurterResponseDtoCopyWithImpl<_FrankfurterResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FrankfurterResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrankfurterResponseDto&&(identical(other.date, date) || other.date == date)&&(identical(other.base, base) || other.base == base)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,base,quote,rate);

@override
String toString() {
  return 'FrankfurterResponseDto(date: $date, base: $base, quote: $quote, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$FrankfurterResponseDtoCopyWith<$Res> implements $FrankfurterResponseDtoCopyWith<$Res> {
  factory _$FrankfurterResponseDtoCopyWith(_FrankfurterResponseDto value, $Res Function(_FrankfurterResponseDto) _then) = __$FrankfurterResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String base, String quote, double rate
});




}
/// @nodoc
class __$FrankfurterResponseDtoCopyWithImpl<$Res>
    implements _$FrankfurterResponseDtoCopyWith<$Res> {
  __$FrankfurterResponseDtoCopyWithImpl(this._self, this._then);

  final _FrankfurterResponseDto _self;
  final $Res Function(_FrankfurterResponseDto) _then;

/// Create a copy of FrankfurterResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? base = null,Object? quote = null,Object? rate = null,}) {
  return _then(_FrankfurterResponseDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
