// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dividend_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DividendEvent {

 String get date; double get dividend; double get adjDividend; double? get yield; String? get recordDate; String? get paymentDate; String? get declarationDate; String? get frequency;
/// Create a copy of DividendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DividendEventCopyWith<DividendEvent> get copyWith => _$DividendEventCopyWithImpl<DividendEvent>(this as DividendEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DividendEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}


@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,yield,recordDate,paymentDate,declarationDate,frequency);

@override
String toString() {
  return 'DividendEvent(date: $date, dividend: $dividend, adjDividend: $adjDividend, yield: $yield, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class $DividendEventCopyWith<$Res>  {
  factory $DividendEventCopyWith(DividendEvent value, $Res Function(DividendEvent) _then) = _$DividendEventCopyWithImpl;
@useResult
$Res call({
 String date, double dividend, double adjDividend, double? yield, String? recordDate, String? paymentDate, String? declarationDate, String? frequency
});




}
/// @nodoc
class _$DividendEventCopyWithImpl<$Res>
    implements $DividendEventCopyWith<$Res> {
  _$DividendEventCopyWithImpl(this._self, this._then);

  final DividendEvent _self;
  final $Res Function(DividendEvent) _then;

/// Create a copy of DividendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? dividend = null,Object? adjDividend = null,Object? yield = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? frequency = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: null == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double,adjDividend: null == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DividendEvent].
extension DividendEventPatterns on DividendEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DividendEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DividendEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DividendEvent value)  $default,){
final _that = this;
switch (_that) {
case _DividendEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DividendEvent value)?  $default,){
final _that = this;
switch (_that) {
case _DividendEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  double dividend,  double adjDividend,  double? yield,  String? recordDate,  String? paymentDate,  String? declarationDate,  String? frequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DividendEvent() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.yield,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.frequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  double dividend,  double adjDividend,  double? yield,  String? recordDate,  String? paymentDate,  String? declarationDate,  String? frequency)  $default,) {final _that = this;
switch (_that) {
case _DividendEvent():
return $default(_that.date,_that.dividend,_that.adjDividend,_that.yield,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.frequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  double dividend,  double adjDividend,  double? yield,  String? recordDate,  String? paymentDate,  String? declarationDate,  String? frequency)?  $default,) {final _that = this;
switch (_that) {
case _DividendEvent() when $default != null:
return $default(_that.date,_that.dividend,_that.adjDividend,_that.yield,_that.recordDate,_that.paymentDate,_that.declarationDate,_that.frequency);case _:
  return null;

}
}

}

/// @nodoc


class _DividendEvent extends DividendEvent {
  const _DividendEvent({required this.date, required this.dividend, required this.adjDividend, this.yield, this.recordDate, this.paymentDate, this.declarationDate, this.frequency}): super._();
  

@override final  String date;
@override final  double dividend;
@override final  double adjDividend;
@override final  double? yield;
@override final  String? recordDate;
@override final  String? paymentDate;
@override final  String? declarationDate;
@override final  String? frequency;

/// Create a copy of DividendEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DividendEventCopyWith<_DividendEvent> get copyWith => __$DividendEventCopyWithImpl<_DividendEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DividendEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.dividend, dividend) || other.dividend == dividend)&&(identical(other.adjDividend, adjDividend) || other.adjDividend == adjDividend)&&(identical(other.yield, yield) || other.yield == yield)&&(identical(other.recordDate, recordDate) || other.recordDate == recordDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.declarationDate, declarationDate) || other.declarationDate == declarationDate)&&(identical(other.frequency, frequency) || other.frequency == frequency));
}


@override
int get hashCode => Object.hash(runtimeType,date,dividend,adjDividend,yield,recordDate,paymentDate,declarationDate,frequency);

@override
String toString() {
  return 'DividendEvent(date: $date, dividend: $dividend, adjDividend: $adjDividend, yield: $yield, recordDate: $recordDate, paymentDate: $paymentDate, declarationDate: $declarationDate, frequency: $frequency)';
}


}

/// @nodoc
abstract mixin class _$DividendEventCopyWith<$Res> implements $DividendEventCopyWith<$Res> {
  factory _$DividendEventCopyWith(_DividendEvent value, $Res Function(_DividendEvent) _then) = __$DividendEventCopyWithImpl;
@override @useResult
$Res call({
 String date, double dividend, double adjDividend, double? yield, String? recordDate, String? paymentDate, String? declarationDate, String? frequency
});




}
/// @nodoc
class __$DividendEventCopyWithImpl<$Res>
    implements _$DividendEventCopyWith<$Res> {
  __$DividendEventCopyWithImpl(this._self, this._then);

  final _DividendEvent _self;
  final $Res Function(_DividendEvent) _then;

/// Create a copy of DividendEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? dividend = null,Object? adjDividend = null,Object? yield = freezed,Object? recordDate = freezed,Object? paymentDate = freezed,Object? declarationDate = freezed,Object? frequency = freezed,}) {
  return _then(_DividendEvent(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dividend: null == dividend ? _self.dividend : dividend // ignore: cast_nullable_to_non_nullable
as double,adjDividend: null == adjDividend ? _self.adjDividend : adjDividend // ignore: cast_nullable_to_non_nullable
as double,yield: freezed == yield ? _self.yield : yield // ignore: cast_nullable_to_non_nullable
as double?,recordDate: freezed == recordDate ? _self.recordDate : recordDate // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,declarationDate: freezed == declarationDate ? _self.declarationDate : declarationDate // ignore: cast_nullable_to_non_nullable
as String?,frequency: freezed == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
