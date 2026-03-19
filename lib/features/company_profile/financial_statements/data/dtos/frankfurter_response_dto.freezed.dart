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

 double get amount; String get base; String get date; Map<String, double> get rates;
/// Create a copy of FrankfurterResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FrankfurterResponseDtoCopyWith<FrankfurterResponseDto> get copyWith => _$FrankfurterResponseDtoCopyWithImpl<FrankfurterResponseDto>(this as FrankfurterResponseDto, _$identity);

  /// Serializes this FrankfurterResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FrankfurterResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.rates, rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,date,const DeepCollectionEquality().hash(rates));

@override
String toString() {
  return 'FrankfurterResponseDto(amount: $amount, base: $base, date: $date, rates: $rates)';
}


}

/// @nodoc
abstract mixin class $FrankfurterResponseDtoCopyWith<$Res>  {
  factory $FrankfurterResponseDtoCopyWith(FrankfurterResponseDto value, $Res Function(FrankfurterResponseDto) _then) = _$FrankfurterResponseDtoCopyWithImpl;
@useResult
$Res call({
 double amount, String base, String date, Map<String, double> rates
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
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? base = null,Object? date = null,Object? rates = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String base,  String date,  Map<String, double> rates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String base,  String date,  Map<String, double> rates)  $default,) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto():
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String base,  String date,  Map<String, double> rates)?  $default,) {final _that = this;
switch (_that) {
case _FrankfurterResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FrankfurterResponseDto extends FrankfurterResponseDto {
  const _FrankfurterResponseDto({required this.amount, required this.base, required this.date, required final  Map<String, double> rates}): _rates = rates,super._();
  factory _FrankfurterResponseDto.fromJson(Map<String, dynamic> json) => _$FrankfurterResponseDtoFromJson(json);

@override final  double amount;
@override final  String base;
@override final  String date;
 final  Map<String, double> _rates;
@override Map<String, double> get rates {
  if (_rates is EqualUnmodifiableMapView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rates);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FrankfurterResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._rates, _rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,date,const DeepCollectionEquality().hash(_rates));

@override
String toString() {
  return 'FrankfurterResponseDto(amount: $amount, base: $base, date: $date, rates: $rates)';
}


}

/// @nodoc
abstract mixin class _$FrankfurterResponseDtoCopyWith<$Res> implements $FrankfurterResponseDtoCopyWith<$Res> {
  factory _$FrankfurterResponseDtoCopyWith(_FrankfurterResponseDto value, $Res Function(_FrankfurterResponseDto) _then) = __$FrankfurterResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 double amount, String base, String date, Map<String, double> rates
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
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? base = null,Object? date = null,Object? rates = null,}) {
  return _then(_FrankfurterResponseDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
