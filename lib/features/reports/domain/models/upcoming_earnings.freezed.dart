// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_earnings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpcomingEarnings {

 String get symbol; String get companyName; DateTime? get date;
/// Create a copy of UpcomingEarnings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEarningsCopyWith<UpcomingEarnings> get copyWith => _$UpcomingEarningsCopyWithImpl<UpcomingEarnings>(this as UpcomingEarnings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEarnings&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,companyName,date);

@override
String toString() {
  return 'UpcomingEarnings(symbol: $symbol, companyName: $companyName, date: $date)';
}


}

/// @nodoc
abstract mixin class $UpcomingEarningsCopyWith<$Res>  {
  factory $UpcomingEarningsCopyWith(UpcomingEarnings value, $Res Function(UpcomingEarnings) _then) = _$UpcomingEarningsCopyWithImpl;
@useResult
$Res call({
 String symbol, String companyName, DateTime? date
});




}
/// @nodoc
class _$UpcomingEarningsCopyWithImpl<$Res>
    implements $UpcomingEarningsCopyWith<$Res> {
  _$UpcomingEarningsCopyWithImpl(this._self, this._then);

  final UpcomingEarnings _self;
  final $Res Function(UpcomingEarnings) _then;

/// Create a copy of UpcomingEarnings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? companyName = null,Object? date = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingEarnings].
extension UpcomingEarningsPatterns on UpcomingEarnings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingEarnings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingEarnings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingEarnings value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingEarnings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingEarnings value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingEarnings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String companyName,  DateTime? date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingEarnings() when $default != null:
return $default(_that.symbol,_that.companyName,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String companyName,  DateTime? date)  $default,) {final _that = this;
switch (_that) {
case _UpcomingEarnings():
return $default(_that.symbol,_that.companyName,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String companyName,  DateTime? date)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingEarnings() when $default != null:
return $default(_that.symbol,_that.companyName,_that.date);case _:
  return null;

}
}

}

/// @nodoc


class _UpcomingEarnings implements UpcomingEarnings {
  const _UpcomingEarnings({required this.symbol, required this.companyName, required this.date});
  

@override final  String symbol;
@override final  String companyName;
@override final  DateTime? date;

/// Create a copy of UpcomingEarnings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEarningsCopyWith<_UpcomingEarnings> get copyWith => __$UpcomingEarningsCopyWithImpl<_UpcomingEarnings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEarnings&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,companyName,date);

@override
String toString() {
  return 'UpcomingEarnings(symbol: $symbol, companyName: $companyName, date: $date)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEarningsCopyWith<$Res> implements $UpcomingEarningsCopyWith<$Res> {
  factory _$UpcomingEarningsCopyWith(_UpcomingEarnings value, $Res Function(_UpcomingEarnings) _then) = __$UpcomingEarningsCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String companyName, DateTime? date
});




}
/// @nodoc
class __$UpcomingEarningsCopyWithImpl<$Res>
    implements _$UpcomingEarningsCopyWith<$Res> {
  __$UpcomingEarningsCopyWithImpl(this._self, this._then);

  final _UpcomingEarnings _self;
  final $Res Function(_UpcomingEarnings) _then;

/// Create a copy of UpcomingEarnings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? companyName = null,Object? date = freezed,}) {
  return _then(_UpcomingEarnings(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
