// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sector_performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectorPerformance {

 String get date; String get sector; String get exchange; double get averageChange;
/// Create a copy of SectorPerformance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorPerformanceCopyWith<SectorPerformance> get copyWith => _$SectorPerformanceCopyWithImpl<SectorPerformance>(this as SectorPerformance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorPerformance&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange));
}


@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,averageChange);

@override
String toString() {
  return 'SectorPerformance(date: $date, sector: $sector, exchange: $exchange, averageChange: $averageChange)';
}


}

/// @nodoc
abstract mixin class $SectorPerformanceCopyWith<$Res>  {
  factory $SectorPerformanceCopyWith(SectorPerformance value, $Res Function(SectorPerformance) _then) = _$SectorPerformanceCopyWithImpl;
@useResult
$Res call({
 String date, String sector, String exchange, double averageChange
});




}
/// @nodoc
class _$SectorPerformanceCopyWithImpl<$Res>
    implements $SectorPerformanceCopyWith<$Res> {
  _$SectorPerformanceCopyWithImpl(this._self, this._then);

  final SectorPerformance _self;
  final $Res Function(SectorPerformance) _then;

/// Create a copy of SectorPerformance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? averageChange = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorPerformance].
extension SectorPerformancePatterns on SectorPerformance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorPerformance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorPerformance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorPerformance value)  $default,){
final _that = this;
switch (_that) {
case _SectorPerformance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorPerformance value)?  $default,){
final _that = this;
switch (_that) {
case _SectorPerformance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double averageChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorPerformance() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double averageChange)  $default,) {final _that = this;
switch (_that) {
case _SectorPerformance():
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String sector,  String exchange,  double averageChange)?  $default,) {final _that = this;
switch (_that) {
case _SectorPerformance() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.averageChange);case _:
  return null;

}
}

}

/// @nodoc


class _SectorPerformance implements SectorPerformance {
  const _SectorPerformance({required this.date, required this.sector, required this.exchange, required this.averageChange});
  

@override final  String date;
@override final  String sector;
@override final  String exchange;
@override final  double averageChange;

/// Create a copy of SectorPerformance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorPerformanceCopyWith<_SectorPerformance> get copyWith => __$SectorPerformanceCopyWithImpl<_SectorPerformance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorPerformance&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.averageChange, averageChange) || other.averageChange == averageChange));
}


@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,averageChange);

@override
String toString() {
  return 'SectorPerformance(date: $date, sector: $sector, exchange: $exchange, averageChange: $averageChange)';
}


}

/// @nodoc
abstract mixin class _$SectorPerformanceCopyWith<$Res> implements $SectorPerformanceCopyWith<$Res> {
  factory _$SectorPerformanceCopyWith(_SectorPerformance value, $Res Function(_SectorPerformance) _then) = __$SectorPerformanceCopyWithImpl;
@override @useResult
$Res call({
 String date, String sector, String exchange, double averageChange
});




}
/// @nodoc
class __$SectorPerformanceCopyWithImpl<$Res>
    implements _$SectorPerformanceCopyWith<$Res> {
  __$SectorPerformanceCopyWithImpl(this._self, this._then);

  final _SectorPerformance _self;
  final $Res Function(_SectorPerformance) _then;

/// Create a copy of SectorPerformance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? averageChange = null,}) {
  return _then(_SectorPerformance(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,averageChange: null == averageChange ? _self.averageChange : averageChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
