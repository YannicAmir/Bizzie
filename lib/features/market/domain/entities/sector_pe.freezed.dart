// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sector_pe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectorPe {

 String get date; String get sector; String get exchange; double get pe;
/// Create a copy of SectorPe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectorPeCopyWith<SectorPe> get copyWith => _$SectorPeCopyWithImpl<SectorPe>(this as SectorPe, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectorPe&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.pe, pe) || other.pe == pe));
}


@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,pe);

@override
String toString() {
  return 'SectorPe(date: $date, sector: $sector, exchange: $exchange, pe: $pe)';
}


}

/// @nodoc
abstract mixin class $SectorPeCopyWith<$Res>  {
  factory $SectorPeCopyWith(SectorPe value, $Res Function(SectorPe) _then) = _$SectorPeCopyWithImpl;
@useResult
$Res call({
 String date, String sector, String exchange, double pe
});




}
/// @nodoc
class _$SectorPeCopyWithImpl<$Res>
    implements $SectorPeCopyWith<$Res> {
  _$SectorPeCopyWithImpl(this._self, this._then);

  final SectorPe _self;
  final $Res Function(SectorPe) _then;

/// Create a copy of SectorPe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? pe = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,pe: null == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SectorPe].
extension SectorPePatterns on SectorPe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectorPe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectorPe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectorPe value)  $default,){
final _that = this;
switch (_that) {
case _SectorPe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectorPe value)?  $default,){
final _that = this;
switch (_that) {
case _SectorPe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double pe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectorPe() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String sector,  String exchange,  double pe)  $default,) {final _that = this;
switch (_that) {
case _SectorPe():
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String sector,  String exchange,  double pe)?  $default,) {final _that = this;
switch (_that) {
case _SectorPe() when $default != null:
return $default(_that.date,_that.sector,_that.exchange,_that.pe);case _:
  return null;

}
}

}

/// @nodoc


class _SectorPe implements SectorPe {
  const _SectorPe({required this.date, required this.sector, required this.exchange, required this.pe});
  

@override final  String date;
@override final  String sector;
@override final  String exchange;
@override final  double pe;

/// Create a copy of SectorPe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorPeCopyWith<_SectorPe> get copyWith => __$SectorPeCopyWithImpl<_SectorPe>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorPe&&(identical(other.date, date) || other.date == date)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.exchange, exchange) || other.exchange == exchange)&&(identical(other.pe, pe) || other.pe == pe));
}


@override
int get hashCode => Object.hash(runtimeType,date,sector,exchange,pe);

@override
String toString() {
  return 'SectorPe(date: $date, sector: $sector, exchange: $exchange, pe: $pe)';
}


}

/// @nodoc
abstract mixin class _$SectorPeCopyWith<$Res> implements $SectorPeCopyWith<$Res> {
  factory _$SectorPeCopyWith(_SectorPe value, $Res Function(_SectorPe) _then) = __$SectorPeCopyWithImpl;
@override @useResult
$Res call({
 String date, String sector, String exchange, double pe
});




}
/// @nodoc
class __$SectorPeCopyWithImpl<$Res>
    implements _$SectorPeCopyWith<$Res> {
  __$SectorPeCopyWithImpl(this._self, this._then);

  final _SectorPe _self;
  final $Res Function(_SectorPe) _then;

/// Create a copy of SectorPe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? sector = null,Object? exchange = null,Object? pe = null,}) {
  return _then(_SectorPe(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,sector: null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,exchange: null == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as String,pe: null == pe ? _self.pe : pe // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
