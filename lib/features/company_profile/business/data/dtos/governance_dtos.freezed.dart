// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'governance_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GovernanceDto {

 String get symbol; String get nameAndPosition; double? get total;
/// Create a copy of GovernanceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GovernanceDtoCopyWith<GovernanceDto> get copyWith => _$GovernanceDtoCopyWithImpl<GovernanceDto>(this as GovernanceDto, _$identity);

  /// Serializes this GovernanceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GovernanceDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.nameAndPosition, nameAndPosition) || other.nameAndPosition == nameAndPosition)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,nameAndPosition,total);

@override
String toString() {
  return 'GovernanceDto(symbol: $symbol, nameAndPosition: $nameAndPosition, total: $total)';
}


}

/// @nodoc
abstract mixin class $GovernanceDtoCopyWith<$Res>  {
  factory $GovernanceDtoCopyWith(GovernanceDto value, $Res Function(GovernanceDto) _then) = _$GovernanceDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String nameAndPosition, double? total
});




}
/// @nodoc
class _$GovernanceDtoCopyWithImpl<$Res>
    implements $GovernanceDtoCopyWith<$Res> {
  _$GovernanceDtoCopyWithImpl(this._self, this._then);

  final GovernanceDto _self;
  final $Res Function(GovernanceDto) _then;

/// Create a copy of GovernanceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? nameAndPosition = null,Object? total = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,nameAndPosition: null == nameAndPosition ? _self.nameAndPosition : nameAndPosition // ignore: cast_nullable_to_non_nullable
as String,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GovernanceDto].
extension GovernanceDtoPatterns on GovernanceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GovernanceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GovernanceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GovernanceDto value)  $default,){
final _that = this;
switch (_that) {
case _GovernanceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GovernanceDto value)?  $default,){
final _that = this;
switch (_that) {
case _GovernanceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String nameAndPosition,  double? total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GovernanceDto() when $default != null:
return $default(_that.symbol,_that.nameAndPosition,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String nameAndPosition,  double? total)  $default,) {final _that = this;
switch (_that) {
case _GovernanceDto():
return $default(_that.symbol,_that.nameAndPosition,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String nameAndPosition,  double? total)?  $default,) {final _that = this;
switch (_that) {
case _GovernanceDto() when $default != null:
return $default(_that.symbol,_that.nameAndPosition,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GovernanceDto implements GovernanceDto {
  const _GovernanceDto({required this.symbol, required this.nameAndPosition, this.total});
  factory _GovernanceDto.fromJson(Map<String, dynamic> json) => _$GovernanceDtoFromJson(json);

@override final  String symbol;
@override final  String nameAndPosition;
@override final  double? total;

/// Create a copy of GovernanceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GovernanceDtoCopyWith<_GovernanceDto> get copyWith => __$GovernanceDtoCopyWithImpl<_GovernanceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GovernanceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GovernanceDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.nameAndPosition, nameAndPosition) || other.nameAndPosition == nameAndPosition)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,nameAndPosition,total);

@override
String toString() {
  return 'GovernanceDto(symbol: $symbol, nameAndPosition: $nameAndPosition, total: $total)';
}


}

/// @nodoc
abstract mixin class _$GovernanceDtoCopyWith<$Res> implements $GovernanceDtoCopyWith<$Res> {
  factory _$GovernanceDtoCopyWith(_GovernanceDto value, $Res Function(_GovernanceDto) _then) = __$GovernanceDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String nameAndPosition, double? total
});




}
/// @nodoc
class __$GovernanceDtoCopyWithImpl<$Res>
    implements _$GovernanceDtoCopyWith<$Res> {
  __$GovernanceDtoCopyWithImpl(this._self, this._then);

  final _GovernanceDto _self;
  final $Res Function(_GovernanceDto) _then;

/// Create a copy of GovernanceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? nameAndPosition = null,Object? total = freezed,}) {
  return _then(_GovernanceDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,nameAndPosition: null == nameAndPosition ? _self.nameAndPosition : nameAndPosition // ignore: cast_nullable_to_non_nullable
as String,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ExecutiveDto {

 String get name; String get title; double? get pay; String? get currencyPay; String? get gender; int? get yearBorn;
/// Create a copy of ExecutiveDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutiveDtoCopyWith<ExecutiveDto> get copyWith => _$ExecutiveDtoCopyWithImpl<ExecutiveDto>(this as ExecutiveDto, _$identity);

  /// Serializes this ExecutiveDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutiveDto&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.pay, pay) || other.pay == pay)&&(identical(other.currencyPay, currencyPay) || other.currencyPay == currencyPay)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.yearBorn, yearBorn) || other.yearBorn == yearBorn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,title,pay,currencyPay,gender,yearBorn);

@override
String toString() {
  return 'ExecutiveDto(name: $name, title: $title, pay: $pay, currencyPay: $currencyPay, gender: $gender, yearBorn: $yearBorn)';
}


}

/// @nodoc
abstract mixin class $ExecutiveDtoCopyWith<$Res>  {
  factory $ExecutiveDtoCopyWith(ExecutiveDto value, $Res Function(ExecutiveDto) _then) = _$ExecutiveDtoCopyWithImpl;
@useResult
$Res call({
 String name, String title, double? pay, String? currencyPay, String? gender, int? yearBorn
});




}
/// @nodoc
class _$ExecutiveDtoCopyWithImpl<$Res>
    implements $ExecutiveDtoCopyWith<$Res> {
  _$ExecutiveDtoCopyWithImpl(this._self, this._then);

  final ExecutiveDto _self;
  final $Res Function(ExecutiveDto) _then;

/// Create a copy of ExecutiveDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? title = null,Object? pay = freezed,Object? currencyPay = freezed,Object? gender = freezed,Object? yearBorn = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pay: freezed == pay ? _self.pay : pay // ignore: cast_nullable_to_non_nullable
as double?,currencyPay: freezed == currencyPay ? _self.currencyPay : currencyPay // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,yearBorn: freezed == yearBorn ? _self.yearBorn : yearBorn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExecutiveDto].
extension ExecutiveDtoPatterns on ExecutiveDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutiveDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutiveDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutiveDto value)  $default,){
final _that = this;
switch (_that) {
case _ExecutiveDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutiveDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutiveDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String title,  double? pay,  String? currencyPay,  String? gender,  int? yearBorn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutiveDto() when $default != null:
return $default(_that.name,_that.title,_that.pay,_that.currencyPay,_that.gender,_that.yearBorn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String title,  double? pay,  String? currencyPay,  String? gender,  int? yearBorn)  $default,) {final _that = this;
switch (_that) {
case _ExecutiveDto():
return $default(_that.name,_that.title,_that.pay,_that.currencyPay,_that.gender,_that.yearBorn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String title,  double? pay,  String? currencyPay,  String? gender,  int? yearBorn)?  $default,) {final _that = this;
switch (_that) {
case _ExecutiveDto() when $default != null:
return $default(_that.name,_that.title,_that.pay,_that.currencyPay,_that.gender,_that.yearBorn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecutiveDto implements ExecutiveDto {
  const _ExecutiveDto({required this.name, required this.title, this.pay, this.currencyPay, this.gender, this.yearBorn});
  factory _ExecutiveDto.fromJson(Map<String, dynamic> json) => _$ExecutiveDtoFromJson(json);

@override final  String name;
@override final  String title;
@override final  double? pay;
@override final  String? currencyPay;
@override final  String? gender;
@override final  int? yearBorn;

/// Create a copy of ExecutiveDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutiveDtoCopyWith<_ExecutiveDto> get copyWith => __$ExecutiveDtoCopyWithImpl<_ExecutiveDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecutiveDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutiveDto&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.pay, pay) || other.pay == pay)&&(identical(other.currencyPay, currencyPay) || other.currencyPay == currencyPay)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.yearBorn, yearBorn) || other.yearBorn == yearBorn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,title,pay,currencyPay,gender,yearBorn);

@override
String toString() {
  return 'ExecutiveDto(name: $name, title: $title, pay: $pay, currencyPay: $currencyPay, gender: $gender, yearBorn: $yearBorn)';
}


}

/// @nodoc
abstract mixin class _$ExecutiveDtoCopyWith<$Res> implements $ExecutiveDtoCopyWith<$Res> {
  factory _$ExecutiveDtoCopyWith(_ExecutiveDto value, $Res Function(_ExecutiveDto) _then) = __$ExecutiveDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String title, double? pay, String? currencyPay, String? gender, int? yearBorn
});




}
/// @nodoc
class __$ExecutiveDtoCopyWithImpl<$Res>
    implements _$ExecutiveDtoCopyWith<$Res> {
  __$ExecutiveDtoCopyWithImpl(this._self, this._then);

  final _ExecutiveDto _self;
  final $Res Function(_ExecutiveDto) _then;

/// Create a copy of ExecutiveDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? title = null,Object? pay = freezed,Object? currencyPay = freezed,Object? gender = freezed,Object? yearBorn = freezed,}) {
  return _then(_ExecutiveDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pay: freezed == pay ? _self.pay : pay // ignore: cast_nullable_to_non_nullable
as double?,currencyPay: freezed == currencyPay ? _self.currencyPay : currencyPay // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,yearBorn: freezed == yearBorn ? _self.yearBorn : yearBorn // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
