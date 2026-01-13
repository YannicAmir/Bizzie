// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_earnings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpcomingEarningsDto {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String get symbol; String get date; String? get expireAt;
/// Create a copy of UpcomingEarningsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpcomingEarningsDtoCopyWith<UpcomingEarningsDto> get copyWith => _$UpcomingEarningsDtoCopyWithImpl<UpcomingEarningsDto>(this as UpcomingEarningsDto, _$identity);

  /// Serializes this UpcomingEarningsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpcomingEarningsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.expireAt, expireAt) || other.expireAt == expireAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,date,expireAt);

@override
String toString() {
  return 'UpcomingEarningsDto(id: $id, symbol: $symbol, date: $date, expireAt: $expireAt)';
}


}

/// @nodoc
abstract mixin class $UpcomingEarningsDtoCopyWith<$Res>  {
  factory $UpcomingEarningsDtoCopyWith(UpcomingEarningsDto value, $Res Function(UpcomingEarningsDto) _then) = _$UpcomingEarningsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String symbol, String date, String? expireAt
});




}
/// @nodoc
class _$UpcomingEarningsDtoCopyWithImpl<$Res>
    implements $UpcomingEarningsDtoCopyWith<$Res> {
  _$UpcomingEarningsDtoCopyWithImpl(this._self, this._then);

  final UpcomingEarningsDto _self;
  final $Res Function(UpcomingEarningsDto) _then;

/// Create a copy of UpcomingEarningsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? symbol = null,Object? date = null,Object? expireAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,expireAt: freezed == expireAt ? _self.expireAt : expireAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpcomingEarningsDto].
extension UpcomingEarningsDtoPatterns on UpcomingEarningsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpcomingEarningsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpcomingEarningsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpcomingEarningsDto value)  $default,){
final _that = this;
switch (_that) {
case _UpcomingEarningsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpcomingEarningsDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpcomingEarningsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String date,  String? expireAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpcomingEarningsDto() when $default != null:
return $default(_that.id,_that.symbol,_that.date,_that.expireAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String date,  String? expireAt)  $default,) {final _that = this;
switch (_that) {
case _UpcomingEarningsDto():
return $default(_that.id,_that.symbol,_that.date,_that.expireAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String symbol,  String date,  String? expireAt)?  $default,) {final _that = this;
switch (_that) {
case _UpcomingEarningsDto() when $default != null:
return $default(_that.id,_that.symbol,_that.date,_that.expireAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpcomingEarningsDto extends UpcomingEarningsDto {
  const _UpcomingEarningsDto({@JsonKey(includeFromJson: false, includeToJson: false) this.id, required this.symbol, required this.date, this.expireAt}): super._();
  factory _UpcomingEarningsDto.fromJson(Map<String, dynamic> json) => _$UpcomingEarningsDtoFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String symbol;
@override final  String date;
@override final  String? expireAt;

/// Create a copy of UpcomingEarningsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpcomingEarningsDtoCopyWith<_UpcomingEarningsDto> get copyWith => __$UpcomingEarningsDtoCopyWithImpl<_UpcomingEarningsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpcomingEarningsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpcomingEarningsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.expireAt, expireAt) || other.expireAt == expireAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,date,expireAt);

@override
String toString() {
  return 'UpcomingEarningsDto(id: $id, symbol: $symbol, date: $date, expireAt: $expireAt)';
}


}

/// @nodoc
abstract mixin class _$UpcomingEarningsDtoCopyWith<$Res> implements $UpcomingEarningsDtoCopyWith<$Res> {
  factory _$UpcomingEarningsDtoCopyWith(_UpcomingEarningsDto value, $Res Function(_UpcomingEarningsDto) _then) = __$UpcomingEarningsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String symbol, String date, String? expireAt
});




}
/// @nodoc
class __$UpcomingEarningsDtoCopyWithImpl<$Res>
    implements _$UpcomingEarningsDtoCopyWith<$Res> {
  __$UpcomingEarningsDtoCopyWithImpl(this._self, this._then);

  final _UpcomingEarningsDto _self;
  final $Res Function(_UpcomingEarningsDto) _then;

/// Create a copy of UpcomingEarningsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? symbol = null,Object? date = null,Object? expireAt = freezed,}) {
  return _then(_UpcomingEarningsDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,expireAt: freezed == expireAt ? _self.expireAt : expireAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
