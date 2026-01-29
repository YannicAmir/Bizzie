// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ratios_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatiosDto {

 String? get symbol; String? get date; String? get period; double? get priceToEarningsRatio; double? get priceToFreeCashFlowRatio;
/// Create a copy of RatiosDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatiosDtoCopyWith<RatiosDto> get copyWith => _$RatiosDtoCopyWithImpl<RatiosDto>(this as RatiosDto, _$identity);

  /// Serializes this RatiosDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatiosDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToEarningsRatio, priceToEarningsRatio) || other.priceToEarningsRatio == priceToEarningsRatio)&&(identical(other.priceToFreeCashFlowRatio, priceToFreeCashFlowRatio) || other.priceToFreeCashFlowRatio == priceToFreeCashFlowRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToEarningsRatio,priceToFreeCashFlowRatio);

@override
String toString() {
  return 'RatiosDto(symbol: $symbol, date: $date, period: $period, priceToEarningsRatio: $priceToEarningsRatio, priceToFreeCashFlowRatio: $priceToFreeCashFlowRatio)';
}


}

/// @nodoc
abstract mixin class $RatiosDtoCopyWith<$Res>  {
  factory $RatiosDtoCopyWith(RatiosDto value, $Res Function(RatiosDto) _then) = _$RatiosDtoCopyWithImpl;
@useResult
$Res call({
 String? symbol, String? date, String? period, double? priceToEarningsRatio, double? priceToFreeCashFlowRatio
});




}
/// @nodoc
class _$RatiosDtoCopyWithImpl<$Res>
    implements $RatiosDtoCopyWith<$Res> {
  _$RatiosDtoCopyWithImpl(this._self, this._then);

  final RatiosDto _self;
  final $Res Function(RatiosDto) _then;

/// Create a copy of RatiosDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = freezed,Object? date = freezed,Object? period = freezed,Object? priceToEarningsRatio = freezed,Object? priceToFreeCashFlowRatio = freezed,}) {
  return _then(_self.copyWith(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,priceToEarningsRatio: freezed == priceToEarningsRatio ? _self.priceToEarningsRatio : priceToEarningsRatio // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowRatio: freezed == priceToFreeCashFlowRatio ? _self.priceToFreeCashFlowRatio : priceToFreeCashFlowRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [RatiosDto].
extension RatiosDtoPatterns on RatiosDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatiosDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatiosDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatiosDto value)  $default,){
final _that = this;
switch (_that) {
case _RatiosDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatiosDto value)?  $default,){
final _that = this;
switch (_that) {
case _RatiosDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? symbol,  String? date,  String? period,  double? priceToEarningsRatio,  double? priceToFreeCashFlowRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatiosDto() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio,_that.priceToFreeCashFlowRatio);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? symbol,  String? date,  String? period,  double? priceToEarningsRatio,  double? priceToFreeCashFlowRatio)  $default,) {final _that = this;
switch (_that) {
case _RatiosDto():
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio,_that.priceToFreeCashFlowRatio);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? symbol,  String? date,  String? period,  double? priceToEarningsRatio,  double? priceToFreeCashFlowRatio)?  $default,) {final _that = this;
switch (_that) {
case _RatiosDto() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.priceToEarningsRatio,_that.priceToFreeCashFlowRatio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatiosDto extends RatiosDto {
  const _RatiosDto({this.symbol, this.date, this.period, this.priceToEarningsRatio, this.priceToFreeCashFlowRatio}): super._();
  factory _RatiosDto.fromJson(Map<String, dynamic> json) => _$RatiosDtoFromJson(json);

@override final  String? symbol;
@override final  String? date;
@override final  String? period;
@override final  double? priceToEarningsRatio;
@override final  double? priceToFreeCashFlowRatio;

/// Create a copy of RatiosDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatiosDtoCopyWith<_RatiosDto> get copyWith => __$RatiosDtoCopyWithImpl<_RatiosDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatiosDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatiosDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.priceToEarningsRatio, priceToEarningsRatio) || other.priceToEarningsRatio == priceToEarningsRatio)&&(identical(other.priceToFreeCashFlowRatio, priceToFreeCashFlowRatio) || other.priceToFreeCashFlowRatio == priceToFreeCashFlowRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,priceToEarningsRatio,priceToFreeCashFlowRatio);

@override
String toString() {
  return 'RatiosDto(symbol: $symbol, date: $date, period: $period, priceToEarningsRatio: $priceToEarningsRatio, priceToFreeCashFlowRatio: $priceToFreeCashFlowRatio)';
}


}

/// @nodoc
abstract mixin class _$RatiosDtoCopyWith<$Res> implements $RatiosDtoCopyWith<$Res> {
  factory _$RatiosDtoCopyWith(_RatiosDto value, $Res Function(_RatiosDto) _then) = __$RatiosDtoCopyWithImpl;
@override @useResult
$Res call({
 String? symbol, String? date, String? period, double? priceToEarningsRatio, double? priceToFreeCashFlowRatio
});




}
/// @nodoc
class __$RatiosDtoCopyWithImpl<$Res>
    implements _$RatiosDtoCopyWith<$Res> {
  __$RatiosDtoCopyWithImpl(this._self, this._then);

  final _RatiosDto _self;
  final $Res Function(_RatiosDto) _then;

/// Create a copy of RatiosDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = freezed,Object? date = freezed,Object? period = freezed,Object? priceToEarningsRatio = freezed,Object? priceToFreeCashFlowRatio = freezed,}) {
  return _then(_RatiosDto(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,priceToEarningsRatio: freezed == priceToEarningsRatio ? _self.priceToEarningsRatio : priceToEarningsRatio // ignore: cast_nullable_to_non_nullable
as double?,priceToFreeCashFlowRatio: freezed == priceToFreeCashFlowRatio ? _self.priceToFreeCashFlowRatio : priceToFreeCashFlowRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
