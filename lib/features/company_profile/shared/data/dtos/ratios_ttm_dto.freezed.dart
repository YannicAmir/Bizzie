// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ratios_ttm_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatiosTtmDto {

 String? get symbol; double? get priceToEarningsRatioTTM; double? get priceToFreeCashFlowRatioTTM;
/// Create a copy of RatiosTtmDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatiosTtmDtoCopyWith<RatiosTtmDto> get copyWith => _$RatiosTtmDtoCopyWithImpl<RatiosTtmDto>(this as RatiosTtmDto, _$identity);

  /// Serializes this RatiosTtmDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatiosTtmDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.priceToEarningsRatioTTM, priceToEarningsRatioTTM) || other.priceToEarningsRatioTTM == priceToEarningsRatioTTM)&&(identical(other.priceToFreeCashFlowRatioTTM, priceToFreeCashFlowRatioTTM) || other.priceToFreeCashFlowRatioTTM == priceToFreeCashFlowRatioTTM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,priceToEarningsRatioTTM,priceToFreeCashFlowRatioTTM);

@override
String toString() {
  return 'RatiosTtmDto(symbol: $symbol, priceToEarningsRatioTTM: $priceToEarningsRatioTTM, priceToFreeCashFlowRatioTTM: $priceToFreeCashFlowRatioTTM)';
}


}

/// @nodoc
abstract mixin class $RatiosTtmDtoCopyWith<$Res>  {
  factory $RatiosTtmDtoCopyWith(RatiosTtmDto value, $Res Function(RatiosTtmDto) _then) = _$RatiosTtmDtoCopyWithImpl;
@useResult
$Res call({
 String? symbol, double? priceToEarningsRatioTTM, double? priceToFreeCashFlowRatioTTM
});




}
/// @nodoc
class _$RatiosTtmDtoCopyWithImpl<$Res>
    implements $RatiosTtmDtoCopyWith<$Res> {
  _$RatiosTtmDtoCopyWithImpl(this._self, this._then);

  final RatiosTtmDto _self;
  final $Res Function(RatiosTtmDto) _then;

/// Create a copy of RatiosTtmDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = freezed,Object? priceToEarningsRatioTTM = freezed,Object? priceToFreeCashFlowRatioTTM = freezed,}) {
  return _then(_self.copyWith(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,priceToEarningsRatioTTM: freezed == priceToEarningsRatioTTM ? _self.priceToEarningsRatioTTM : priceToEarningsRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowRatioTTM: freezed == priceToFreeCashFlowRatioTTM ? _self.priceToFreeCashFlowRatioTTM : priceToFreeCashFlowRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [RatiosTtmDto].
extension RatiosTtmDtoPatterns on RatiosTtmDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatiosTtmDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatiosTtmDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatiosTtmDto value)  $default,){
final _that = this;
switch (_that) {
case _RatiosTtmDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatiosTtmDto value)?  $default,){
final _that = this;
switch (_that) {
case _RatiosTtmDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? symbol,  double? priceToEarningsRatioTTM,  double? priceToFreeCashFlowRatioTTM)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatiosTtmDto() when $default != null:
return $default(_that.symbol,_that.priceToEarningsRatioTTM,_that.priceToFreeCashFlowRatioTTM);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? symbol,  double? priceToEarningsRatioTTM,  double? priceToFreeCashFlowRatioTTM)  $default,) {final _that = this;
switch (_that) {
case _RatiosTtmDto():
return $default(_that.symbol,_that.priceToEarningsRatioTTM,_that.priceToFreeCashFlowRatioTTM);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? symbol,  double? priceToEarningsRatioTTM,  double? priceToFreeCashFlowRatioTTM)?  $default,) {final _that = this;
switch (_that) {
case _RatiosTtmDto() when $default != null:
return $default(_that.symbol,_that.priceToEarningsRatioTTM,_that.priceToFreeCashFlowRatioTTM);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatiosTtmDto extends RatiosTtmDto {
  const _RatiosTtmDto({this.symbol, this.priceToEarningsRatioTTM, this.priceToFreeCashFlowRatioTTM}): super._();
  factory _RatiosTtmDto.fromJson(Map<String, dynamic> json) => _$RatiosTtmDtoFromJson(json);

@override final  String? symbol;
@override final  double? priceToEarningsRatioTTM;
@override final  double? priceToFreeCashFlowRatioTTM;

/// Create a copy of RatiosTtmDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatiosTtmDtoCopyWith<_RatiosTtmDto> get copyWith => __$RatiosTtmDtoCopyWithImpl<_RatiosTtmDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatiosTtmDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatiosTtmDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.priceToEarningsRatioTTM, priceToEarningsRatioTTM) || other.priceToEarningsRatioTTM == priceToEarningsRatioTTM)&&(identical(other.priceToFreeCashFlowRatioTTM, priceToFreeCashFlowRatioTTM) || other.priceToFreeCashFlowRatioTTM == priceToFreeCashFlowRatioTTM));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,priceToEarningsRatioTTM,priceToFreeCashFlowRatioTTM);

@override
String toString() {
  return 'RatiosTtmDto(symbol: $symbol, priceToEarningsRatioTTM: $priceToEarningsRatioTTM, priceToFreeCashFlowRatioTTM: $priceToFreeCashFlowRatioTTM)';
}


}

/// @nodoc
abstract mixin class _$RatiosTtmDtoCopyWith<$Res> implements $RatiosTtmDtoCopyWith<$Res> {
  factory _$RatiosTtmDtoCopyWith(_RatiosTtmDto value, $Res Function(_RatiosTtmDto) _then) = __$RatiosTtmDtoCopyWithImpl;
@override @useResult
$Res call({
 String? symbol, double? priceToEarningsRatioTTM, double? priceToFreeCashFlowRatioTTM
});




}
/// @nodoc
class __$RatiosTtmDtoCopyWithImpl<$Res>
    implements _$RatiosTtmDtoCopyWith<$Res> {
  __$RatiosTtmDtoCopyWithImpl(this._self, this._then);

  final _RatiosTtmDto _self;
  final $Res Function(_RatiosTtmDto) _then;

/// Create a copy of RatiosTtmDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = freezed,Object? priceToEarningsRatioTTM = freezed,Object? priceToFreeCashFlowRatioTTM = freezed,}) {
  return _then(_RatiosTtmDto(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,priceToEarningsRatioTTM: freezed == priceToEarningsRatioTTM ? _self.priceToEarningsRatioTTM : priceToEarningsRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowRatioTTM: freezed == priceToFreeCashFlowRatioTTM ? _self.priceToFreeCashFlowRatioTTM : priceToFreeCashFlowRatioTTM // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
