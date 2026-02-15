// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_api_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WatchlistEarningsDto {

 String get symbol;@TimestampConverter() DateTime get date;@TimestampConverter() DateTime? get expireAt;
/// Create a copy of WatchlistEarningsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistEarningsDtoCopyWith<WatchlistEarningsDto> get copyWith => _$WatchlistEarningsDtoCopyWithImpl<WatchlistEarningsDto>(this as WatchlistEarningsDto, _$identity);

  /// Serializes this WatchlistEarningsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistEarningsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.expireAt, expireAt) || other.expireAt == expireAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,expireAt);

@override
String toString() {
  return 'WatchlistEarningsDto(symbol: $symbol, date: $date, expireAt: $expireAt)';
}


}

/// @nodoc
abstract mixin class $WatchlistEarningsDtoCopyWith<$Res>  {
  factory $WatchlistEarningsDtoCopyWith(WatchlistEarningsDto value, $Res Function(WatchlistEarningsDto) _then) = _$WatchlistEarningsDtoCopyWithImpl;
@useResult
$Res call({
 String symbol,@TimestampConverter() DateTime date,@TimestampConverter() DateTime? expireAt
});




}
/// @nodoc
class _$WatchlistEarningsDtoCopyWithImpl<$Res>
    implements $WatchlistEarningsDtoCopyWith<$Res> {
  _$WatchlistEarningsDtoCopyWithImpl(this._self, this._then);

  final WatchlistEarningsDto _self;
  final $Res Function(WatchlistEarningsDto) _then;

/// Create a copy of WatchlistEarningsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? date = null,Object? expireAt = freezed,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,expireAt: freezed == expireAt ? _self.expireAt : expireAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistEarningsDto].
extension WatchlistEarningsDtoPatterns on WatchlistEarningsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistEarningsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistEarningsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistEarningsDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistEarningsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistEarningsDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistEarningsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol, @TimestampConverter()  DateTime date, @TimestampConverter()  DateTime? expireAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistEarningsDto() when $default != null:
return $default(_that.symbol,_that.date,_that.expireAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol, @TimestampConverter()  DateTime date, @TimestampConverter()  DateTime? expireAt)  $default,) {final _that = this;
switch (_that) {
case _WatchlistEarningsDto():
return $default(_that.symbol,_that.date,_that.expireAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol, @TimestampConverter()  DateTime date, @TimestampConverter()  DateTime? expireAt)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistEarningsDto() when $default != null:
return $default(_that.symbol,_that.date,_that.expireAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistEarningsDto implements WatchlistEarningsDto {
  const _WatchlistEarningsDto({required this.symbol, @TimestampConverter() required this.date, @TimestampConverter() this.expireAt});
  factory _WatchlistEarningsDto.fromJson(Map<String, dynamic> json) => _$WatchlistEarningsDtoFromJson(json);

@override final  String symbol;
@override@TimestampConverter() final  DateTime date;
@override@TimestampConverter() final  DateTime? expireAt;

/// Create a copy of WatchlistEarningsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistEarningsDtoCopyWith<_WatchlistEarningsDto> get copyWith => __$WatchlistEarningsDtoCopyWithImpl<_WatchlistEarningsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistEarningsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistEarningsDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.date, date) || other.date == date)&&(identical(other.expireAt, expireAt) || other.expireAt == expireAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,date,expireAt);

@override
String toString() {
  return 'WatchlistEarningsDto(symbol: $symbol, date: $date, expireAt: $expireAt)';
}


}

/// @nodoc
abstract mixin class _$WatchlistEarningsDtoCopyWith<$Res> implements $WatchlistEarningsDtoCopyWith<$Res> {
  factory _$WatchlistEarningsDtoCopyWith(_WatchlistEarningsDto value, $Res Function(_WatchlistEarningsDto) _then) = __$WatchlistEarningsDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol,@TimestampConverter() DateTime date,@TimestampConverter() DateTime? expireAt
});




}
/// @nodoc
class __$WatchlistEarningsDtoCopyWithImpl<$Res>
    implements _$WatchlistEarningsDtoCopyWith<$Res> {
  __$WatchlistEarningsDtoCopyWithImpl(this._self, this._then);

  final _WatchlistEarningsDto _self;
  final $Res Function(_WatchlistEarningsDto) _then;

/// Create a copy of WatchlistEarningsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? date = null,Object? expireAt = freezed,}) {
  return _then(_WatchlistEarningsDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,expireAt: freezed == expireAt ? _self.expireAt : expireAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WatchlistFilingDto {

 String get symbol; String get formType;@TimestampConverter() DateTime get filingDate; String? get topic; bool get isEarnings;
/// Create a copy of WatchlistFilingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchlistFilingDtoCopyWith<WatchlistFilingDto> get copyWith => _$WatchlistFilingDtoCopyWithImpl<WatchlistFilingDto>(this as WatchlistFilingDto, _$identity);

  /// Serializes this WatchlistFilingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchlistFilingDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,formType,filingDate,topic,isEarnings);

@override
String toString() {
  return 'WatchlistFilingDto(symbol: $symbol, formType: $formType, filingDate: $filingDate, topic: $topic, isEarnings: $isEarnings)';
}


}

/// @nodoc
abstract mixin class $WatchlistFilingDtoCopyWith<$Res>  {
  factory $WatchlistFilingDtoCopyWith(WatchlistFilingDto value, $Res Function(WatchlistFilingDto) _then) = _$WatchlistFilingDtoCopyWithImpl;
@useResult
$Res call({
 String symbol, String formType,@TimestampConverter() DateTime filingDate, String? topic, bool isEarnings
});




}
/// @nodoc
class _$WatchlistFilingDtoCopyWithImpl<$Res>
    implements $WatchlistFilingDtoCopyWith<$Res> {
  _$WatchlistFilingDtoCopyWithImpl(this._self, this._then);

  final WatchlistFilingDto _self;
  final $Res Function(WatchlistFilingDto) _then;

/// Create a copy of WatchlistFilingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? formType = null,Object? filingDate = null,Object? topic = freezed,Object? isEarnings = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchlistFilingDto].
extension WatchlistFilingDtoPatterns on WatchlistFilingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchlistFilingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchlistFilingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchlistFilingDto value)  $default,){
final _that = this;
switch (_that) {
case _WatchlistFilingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchlistFilingDto value)?  $default,){
final _that = this;
switch (_that) {
case _WatchlistFilingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String formType, @TimestampConverter()  DateTime filingDate,  String? topic,  bool isEarnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchlistFilingDto() when $default != null:
return $default(_that.symbol,_that.formType,_that.filingDate,_that.topic,_that.isEarnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String formType, @TimestampConverter()  DateTime filingDate,  String? topic,  bool isEarnings)  $default,) {final _that = this;
switch (_that) {
case _WatchlistFilingDto():
return $default(_that.symbol,_that.formType,_that.filingDate,_that.topic,_that.isEarnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String formType, @TimestampConverter()  DateTime filingDate,  String? topic,  bool isEarnings)?  $default,) {final _that = this;
switch (_that) {
case _WatchlistFilingDto() when $default != null:
return $default(_that.symbol,_that.formType,_that.filingDate,_that.topic,_that.isEarnings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WatchlistFilingDto implements WatchlistFilingDto {
  const _WatchlistFilingDto({required this.symbol, required this.formType, @TimestampConverter() required this.filingDate, this.topic, this.isEarnings = false});
  factory _WatchlistFilingDto.fromJson(Map<String, dynamic> json) => _$WatchlistFilingDtoFromJson(json);

@override final  String symbol;
@override final  String formType;
@override@TimestampConverter() final  DateTime filingDate;
@override final  String? topic;
@override@JsonKey() final  bool isEarnings;

/// Create a copy of WatchlistFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchlistFilingDtoCopyWith<_WatchlistFilingDto> get copyWith => __$WatchlistFilingDtoCopyWithImpl<_WatchlistFilingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WatchlistFilingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchlistFilingDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.isEarnings, isEarnings) || other.isEarnings == isEarnings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,formType,filingDate,topic,isEarnings);

@override
String toString() {
  return 'WatchlistFilingDto(symbol: $symbol, formType: $formType, filingDate: $filingDate, topic: $topic, isEarnings: $isEarnings)';
}


}

/// @nodoc
abstract mixin class _$WatchlistFilingDtoCopyWith<$Res> implements $WatchlistFilingDtoCopyWith<$Res> {
  factory _$WatchlistFilingDtoCopyWith(_WatchlistFilingDto value, $Res Function(_WatchlistFilingDto) _then) = __$WatchlistFilingDtoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String formType,@TimestampConverter() DateTime filingDate, String? topic, bool isEarnings
});




}
/// @nodoc
class __$WatchlistFilingDtoCopyWithImpl<$Res>
    implements _$WatchlistFilingDtoCopyWith<$Res> {
  __$WatchlistFilingDtoCopyWithImpl(this._self, this._then);

  final _WatchlistFilingDto _self;
  final $Res Function(_WatchlistFilingDto) _then;

/// Create a copy of WatchlistFilingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? formType = null,Object? filingDate = null,Object? topic = freezed,Object? isEarnings = null,}) {
  return _then(_WatchlistFilingDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,isEarnings: null == isEarnings ? _self.isEarnings : isEarnings // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
