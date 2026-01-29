// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarningsReportDto {

 String get symbol; String get date; double? get epsActual; double? get epsEstimated; int? get revenueActual; int? get revenueEstimated; String? get lastUpdated;
/// Create a copy of EarningsReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsReportDtoCopyWith<EarningsReportDto> get copyWith => _$EarningsReportDtoCopyWithImpl<EarningsReportDto>(this as EarningsReportDto, _$identity);

  /// Serializes this EarningsReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsReportDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.epsActual, epsActual) || other.epsActual == epsActual)&&(identical(other.epsEstimated, epsEstimated) || other.epsEstimated == epsEstimated)&&(identical(other.revenueActual, revenueActual) || other.revenueActual == revenueActual)&&(identical(other.revenueEstimated, revenueEstimated) || other.revenueEstimated == revenueEstimated)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,epsActual,epsEstimated,revenueActual,revenueEstimated,lastUpdated);

@override
String toString() {
  return 'EarningsReportDto(symbol: $symbol, date: $date, epsActual: $epsActual, epsEstimated: $epsEstimated, revenueActual: $revenueActual, revenueEstimated: $revenueEstimated, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $EarningsReportDtoCopyWith<$Res>  {
  factory $EarningsReportDtoCopyWith(EarningsReportDto value, $Res Function(EarningsReportDto) _then) = _$EarningsReportDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String date, double? epsActual, double? epsEstimated, int? revenueActual, int? revenueEstimated, String? lastUpdated
});




}
/// @nodoc
class _$EarningsReportDtoCopyWithImpl<$Res>
    implements $EarningsReportDtoCopyWith<$Res> {
  _$EarningsReportDtoCopyWithImpl(this._self, this._then);

  final EarningsReportDto _self;
  final $Res Function(EarningsReportDto) _then;

/// Create a copy of EarningsReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? epsActual = freezed,Object? epsEstimated = freezed,Object? revenueActual = freezed,Object? revenueEstimated = freezed,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,epsActual: freezed == epsActual ? _self.epsActual : epsActual // ignore: cast_nullable_to_non_nullable
as double?,epsEstimated: freezed == epsEstimated ? _self.epsEstimated : epsEstimated // ignore: cast_nullable_to_non_nullable
as double?,revenueActual: freezed == revenueActual ? _self.revenueActual : revenueActual // ignore: cast_nullable_to_non_nullable
as int?,revenueEstimated: freezed == revenueEstimated ? _self.revenueEstimated : revenueEstimated // ignore: cast_nullable_to_non_nullable
as int?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarningsReportDto].
extension EarningsReportDtoPatterns on EarningsReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningsReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningsReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningsReportDto value)  $default,){
final _that = this;
switch (_that) {
case _EarningsReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningsReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _EarningsReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String date,  double? epsActual,  double? epsEstimated,  int? revenueActual,  int? revenueEstimated,  String? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningsReportDto() when $default != null:
return $default(_that.symbol,_that.date,_that.epsActual,_that.epsEstimated,_that.revenueActual,_that.revenueEstimated,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String date,  double? epsActual,  double? epsEstimated,  int? revenueActual,  int? revenueEstimated,  String? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _EarningsReportDto():
return $default(_that.symbol,_that.date,_that.epsActual,_that.epsEstimated,_that.revenueActual,_that.revenueEstimated,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String date,  double? epsActual,  double? epsEstimated,  int? revenueActual,  int? revenueEstimated,  String? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _EarningsReportDto() when $default != null:
return $default(_that.symbol,_that.date,_that.epsActual,_that.epsEstimated,_that.revenueActual,_that.revenueEstimated,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarningsReportDto extends EarningsReportDto {
  const _EarningsReportDto({required this.symbol, required this.date, this.epsActual, this.epsEstimated, this.revenueActual, this.revenueEstimated, this.lastUpdated}): super._();
  factory _EarningsReportDto.fromJson(Map<String, dynamic> json) => _$EarningsReportDtoFromJson(json);

@override final  String symbol;
@override final  String date;
@override final  double? epsActual;
@override final  double? epsEstimated;
@override final  int? revenueActual;
@override final  int? revenueEstimated;
@override final  String? lastUpdated;

/// Create a copy of EarningsReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsReportDtoCopyWith<_EarningsReportDto> get copyWith => __$EarningsReportDtoCopyWithImpl<_EarningsReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarningsReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsReportDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.epsActual, epsActual) || other.epsActual == epsActual)&&(identical(other.epsEstimated, epsEstimated) || other.epsEstimated == epsEstimated)&&(identical(other.revenueActual, revenueActual) || other.revenueActual == revenueActual)&&(identical(other.revenueEstimated, revenueEstimated) || other.revenueEstimated == revenueEstimated)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,epsActual,epsEstimated,revenueActual,revenueEstimated,lastUpdated);

@override
String toString() {
  return 'EarningsReportDto(symbol: $symbol, date: $date, epsActual: $epsActual, epsEstimated: $epsEstimated, revenueActual: $revenueActual, revenueEstimated: $revenueEstimated, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$EarningsReportDtoCopyWith<$Res> implements $EarningsReportDtoCopyWith<$Res> {
  factory _$EarningsReportDtoCopyWith(_EarningsReportDto value, $Res Function(_EarningsReportDto) _then) = __$EarningsReportDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String date, double? epsActual, double? epsEstimated, int? revenueActual, int? revenueEstimated, String? lastUpdated
});




}
/// @nodoc
class __$EarningsReportDtoCopyWithImpl<$Res>
    implements _$EarningsReportDtoCopyWith<$Res> {
  __$EarningsReportDtoCopyWithImpl(this._self, this._then);

  final _EarningsReportDto _self;
  final $Res Function(_EarningsReportDto) _then;

/// Create a copy of EarningsReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? epsActual = freezed,Object? epsEstimated = freezed,Object? revenueActual = freezed,Object? revenueEstimated = freezed,Object? lastUpdated = freezed,}) {
  return _then(_EarningsReportDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,epsActual: freezed == epsActual ? _self.epsActual : epsActual // ignore: cast_nullable_to_non_nullable
as double?,epsEstimated: freezed == epsEstimated ? _self.epsEstimated : epsEstimated // ignore: cast_nullable_to_non_nullable
as double?,revenueActual: freezed == revenueActual ? _self.revenueActual : revenueActual // ignore: cast_nullable_to_non_nullable
as int?,revenueEstimated: freezed == revenueEstimated ? _self.revenueEstimated : revenueEstimated // ignore: cast_nullable_to_non_nullable
as int?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
