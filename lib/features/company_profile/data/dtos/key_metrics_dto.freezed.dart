// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_metrics_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyMetricsDto {

 String? get symbol; String? get date; String? get period; double? get returnOnEquity;
/// Create a copy of KeyMetricsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyMetricsDtoCopyWith<KeyMetricsDto> get copyWith => _$KeyMetricsDtoCopyWithImpl<KeyMetricsDto>(this as KeyMetricsDto, _$identity);

  /// Serializes this KeyMetricsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyMetricsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.returnOnEquity, returnOnEquity) || other.returnOnEquity == returnOnEquity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,returnOnEquity);

@override
String toString() {
  return 'KeyMetricsDto(symbol: $symbol, date: $date, period: $period, returnOnEquity: $returnOnEquity)';
}


}

/// @nodoc
abstract mixin class $KeyMetricsDtoCopyWith<$Res>  {
  factory $KeyMetricsDtoCopyWith(KeyMetricsDto value, $Res Function(KeyMetricsDto) _then) = _$KeyMetricsDtoCopyWithImpl;
@useResult
$Res call({
 String? symbol, String? date, String? period, double? returnOnEquity
});




}
/// @nodoc
class _$KeyMetricsDtoCopyWithImpl<$Res>
    implements $KeyMetricsDtoCopyWith<$Res> {
  _$KeyMetricsDtoCopyWithImpl(this._self, this._then);

  final KeyMetricsDto _self;
  final $Res Function(KeyMetricsDto) _then;

/// Create a copy of KeyMetricsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = freezed,Object? date = freezed,Object? period = freezed,Object? returnOnEquity = freezed,}) {
  return _then(_self.copyWith(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,returnOnEquity: freezed == returnOnEquity ? _self.returnOnEquity : returnOnEquity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyMetricsDto].
extension KeyMetricsDtoPatterns on KeyMetricsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyMetricsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyMetricsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyMetricsDto value)  $default,){
final _that = this;
switch (_that) {
case _KeyMetricsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyMetricsDto value)?  $default,){
final _that = this;
switch (_that) {
case _KeyMetricsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? symbol,  String? date,  String? period,  double? returnOnEquity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyMetricsDto() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? symbol,  String? date,  String? period,  double? returnOnEquity)  $default,) {final _that = this;
switch (_that) {
case _KeyMetricsDto():
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? symbol,  String? date,  String? period,  double? returnOnEquity)?  $default,) {final _that = this;
switch (_that) {
case _KeyMetricsDto() when $default != null:
return $default(_that.symbol,_that.date,_that.period,_that.returnOnEquity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeyMetricsDto implements KeyMetricsDto {
  const _KeyMetricsDto({this.symbol, this.date, this.period, this.returnOnEquity});
  factory _KeyMetricsDto.fromJson(Map<String, dynamic> json) => _$KeyMetricsDtoFromJson(json);

@override final  String? symbol;
@override final  String? date;
@override final  String? period;
@override final  double? returnOnEquity;

/// Create a copy of KeyMetricsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyMetricsDtoCopyWith<_KeyMetricsDto> get copyWith => __$KeyMetricsDtoCopyWithImpl<_KeyMetricsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeyMetricsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyMetricsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.period, period) || other.period == period)&&(identical(other.returnOnEquity, returnOnEquity) || other.returnOnEquity == returnOnEquity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,period,returnOnEquity);

@override
String toString() {
  return 'KeyMetricsDto(symbol: $symbol, date: $date, period: $period, returnOnEquity: $returnOnEquity)';
}


}

/// @nodoc
abstract mixin class _$KeyMetricsDtoCopyWith<$Res> implements $KeyMetricsDtoCopyWith<$Res> {
  factory _$KeyMetricsDtoCopyWith(_KeyMetricsDto value, $Res Function(_KeyMetricsDto) _then) = __$KeyMetricsDtoCopyWithImpl;
@override @useResult
$Res call({
 String? symbol, String? date, String? period, double? returnOnEquity
});




}
/// @nodoc
class __$KeyMetricsDtoCopyWithImpl<$Res>
    implements _$KeyMetricsDtoCopyWith<$Res> {
  __$KeyMetricsDtoCopyWithImpl(this._self, this._then);

  final _KeyMetricsDto _self;
  final $Res Function(_KeyMetricsDto) _then;

/// Create a copy of KeyMetricsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = freezed,Object? date = freezed,Object? period = freezed,Object? returnOnEquity = freezed,}) {
  return _then(_KeyMetricsDto(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,returnOnEquity: freezed == returnOnEquity ? _self.returnOnEquity : returnOnEquity // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
