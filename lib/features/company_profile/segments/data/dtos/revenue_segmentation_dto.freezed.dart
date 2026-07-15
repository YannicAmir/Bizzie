// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_segmentation_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RevenueSegmentationDto {

 String? get symbol; int? get fiscalYear; String? get period; String? get reportedCurrency; String? get date; Map<String, double>? get data;
/// Create a copy of RevenueSegmentationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevenueSegmentationDtoCopyWith<RevenueSegmentationDto> get copyWith => _$RevenueSegmentationDtoCopyWithImpl<RevenueSegmentationDto>(this as RevenueSegmentationDto, _$identity);

  /// Serializes this RevenueSegmentationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevenueSegmentationDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,fiscalYear,period,reportedCurrency,date,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'RevenueSegmentationDto(symbol: $symbol, fiscalYear: $fiscalYear, period: $period, reportedCurrency: $reportedCurrency, date: $date, data: $data)';
}


}

/// @nodoc
abstract mixin class $RevenueSegmentationDtoCopyWith<$Res>  {
  factory $RevenueSegmentationDtoCopyWith(RevenueSegmentationDto value, $Res Function(RevenueSegmentationDto) _then) = _$RevenueSegmentationDtoCopyWithImpl;
@useResult
$Res call({
 String? symbol, int? fiscalYear, String? period, String? reportedCurrency, String? date, Map<String, double>? data
});




}
/// @nodoc
class _$RevenueSegmentationDtoCopyWithImpl<$Res>
    implements $RevenueSegmentationDtoCopyWith<$Res> {
  _$RevenueSegmentationDtoCopyWithImpl(this._self, this._then);

  final RevenueSegmentationDto _self;
  final $Res Function(RevenueSegmentationDto) _then;

/// Create a copy of RevenueSegmentationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = freezed,Object? fiscalYear = freezed,Object? period = freezed,Object? reportedCurrency = freezed,Object? date = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,fiscalYear: freezed == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as int?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,reportedCurrency: freezed == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,
  ));
}

}


/// Adds pattern-matching-related methods to [RevenueSegmentationDto].
extension RevenueSegmentationDtoPatterns on RevenueSegmentationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevenueSegmentationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevenueSegmentationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevenueSegmentationDto value)  $default,){
final _that = this;
switch (_that) {
case _RevenueSegmentationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevenueSegmentationDto value)?  $default,){
final _that = this;
switch (_that) {
case _RevenueSegmentationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? symbol,  int? fiscalYear,  String? period,  String? reportedCurrency,  String? date,  Map<String, double>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevenueSegmentationDto() when $default != null:
return $default(_that.symbol,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.date,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? symbol,  int? fiscalYear,  String? period,  String? reportedCurrency,  String? date,  Map<String, double>? data)  $default,) {final _that = this;
switch (_that) {
case _RevenueSegmentationDto():
return $default(_that.symbol,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.date,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? symbol,  int? fiscalYear,  String? period,  String? reportedCurrency,  String? date,  Map<String, double>? data)?  $default,) {final _that = this;
switch (_that) {
case _RevenueSegmentationDto() when $default != null:
return $default(_that.symbol,_that.fiscalYear,_that.period,_that.reportedCurrency,_that.date,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _RevenueSegmentationDto extends RevenueSegmentationDto {
  const _RevenueSegmentationDto({this.symbol, this.fiscalYear, this.period, this.reportedCurrency, this.date, final  Map<String, double>? data}): _data = data,super._();
  factory _RevenueSegmentationDto.fromJson(Map<String, dynamic> json) => _$RevenueSegmentationDtoFromJson(json);

@override final  String? symbol;
@override final  int? fiscalYear;
@override final  String? period;
@override final  String? reportedCurrency;
@override final  String? date;
 final  Map<String, double>? _data;
@override Map<String, double>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RevenueSegmentationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevenueSegmentationDtoCopyWith<_RevenueSegmentationDto> get copyWith => __$RevenueSegmentationDtoCopyWithImpl<_RevenueSegmentationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevenueSegmentationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevenueSegmentationDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,fiscalYear,period,reportedCurrency,date,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'RevenueSegmentationDto(symbol: $symbol, fiscalYear: $fiscalYear, period: $period, reportedCurrency: $reportedCurrency, date: $date, data: $data)';
}


}

/// @nodoc
abstract mixin class _$RevenueSegmentationDtoCopyWith<$Res> implements $RevenueSegmentationDtoCopyWith<$Res> {
  factory _$RevenueSegmentationDtoCopyWith(_RevenueSegmentationDto value, $Res Function(_RevenueSegmentationDto) _then) = __$RevenueSegmentationDtoCopyWithImpl;
@override @useResult
$Res call({
 String? symbol, int? fiscalYear, String? period, String? reportedCurrency, String? date, Map<String, double>? data
});




}
/// @nodoc
class __$RevenueSegmentationDtoCopyWithImpl<$Res>
    implements _$RevenueSegmentationDtoCopyWith<$Res> {
  __$RevenueSegmentationDtoCopyWithImpl(this._self, this._then);

  final _RevenueSegmentationDto _self;
  final $Res Function(_RevenueSegmentationDto) _then;

/// Create a copy of RevenueSegmentationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = freezed,Object? fiscalYear = freezed,Object? period = freezed,Object? reportedCurrency = freezed,Object? date = freezed,Object? data = freezed,}) {
  return _then(_RevenueSegmentationDto(
symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,fiscalYear: freezed == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as int?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,reportedCurrency: freezed == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,
  ));
}


}

// dart format on
