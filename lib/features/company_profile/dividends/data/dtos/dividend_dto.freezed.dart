// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dividend_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DividendDto {

 String get date; double? get dividend; double? get adjDividend; String? get recordDate; String? get paymentDate; String? get declarationDate; double? get yield; String? get frequency;
/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DividendDtoCopyWith<DividendDto> get copyWith => _$DividendDtoCopyWithImpl<DividendDto>(this as DividendDto, _$identity);

  /// Serializes this DividendDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DividendDto&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,recordDate,paymentDate,declarationDate,yield,frequency);

@override
String toString() {
  return 'DividendDto(date: $date, dividend: $dividend, adjDividend: $adjDividend, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, yield: $yield, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class $DividendDtoCopyWith<$Res>  {
  factory $DividendDtoCopyWith(DividendDto value, $Res Function(DividendDto) _then) = _$DividendDtoCopyWithImpl;
@useResult
$Res call({
 String date, double? dividend, double? adjDividend, String? recordDate, String? paymentDate, String? declarationDate, double? yield, String? frequency
});




}
/// @nodoc
class _$DividendDtoCopyWithImpl<$Res>
    implements $DividendDtoCopyWith<$Res> {
  _$DividendDtoCopyWithImpl(this._self, this._then);

  final DividendDto _self;
  final $Res Function(DividendDto) _then;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dividend = freezed,Object? adjDividend = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? yield = freezed,Object? frequency = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: freezed == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double?,adjDividend: freezed == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DividendDto].
extension DividendDtoPatterns on DividendDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DividendDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DividendDto value)  $default,){
final _that = this;
switch (_that) {
case _DividendDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DividendDto value)?  $default,){
final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)  $default,) {final _that = this;
switch (_that) {
case _DividendDto():
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double? dividend,  double? adjDividend,  String? recordDate,  String? paymentDate,  String? declarationDate,  double? yield,  String? frequency)?  $default,) {final _that = this;
switch (_that) {
case _DividendDto() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.yield,_that.frequency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DividendDto extends DividendDto {
  const _DividendDto({required this.date, this.dividend, this.adjDividend, this.recordDate, this.paymentDate, this.declarationDate, this.yield, this.frequency}): super._();
  factory _DividendDto.fromJson(Map<String, dynamic> json) => _$DividendDtoFromJson(json);

@override final  String date;
@override final  double? dividend;
@override final  double? adjDividend;
@override final  String? recordDate;
@override final  String? paymentDate;
@override final  String? declarationDate;
@override final  double? yield;
@override final  String? frequency;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DividendDtoCopyWith<_DividendDto> get copyWith => __$DividendDtoCopyWithImpl<_DividendDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DividendDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DividendDto&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,recordDate,paymentDate,declarationDate,yield,frequency);

@override
String toString() {
  return 'DividendDto(date: $date, dividend: $dividend, adjDividend: $adjDividend, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, yield: $yield, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class _$DividendDtoCopyWith<$Res> implements $DividendDtoCopyWith<$Res> {
  factory _$DividendDtoCopyWith(_DividendDto value, $Res Function(_DividendDto) _then) = __$DividendDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, double? dividend, double? adjDividend, String? recordDate, String? paymentDate, String? declarationDate, double? yield, String? frequency
});




}
/// @nodoc
class __$DividendDtoCopyWithImpl<$Res>
    implements _$DividendDtoCopyWith<$Res> {
  __$DividendDtoCopyWithImpl(this._self, this._then);

  final _DividendDto _self;
  final $Res Function(_DividendDto) _then;

/// Create a copy of DividendDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dividend = freezed,Object? adjDividend = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? yield = freezed,Object? frequency = freezed,}) {
  return _then(_DividendDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: freezed == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double?,adjDividend: freezed == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
