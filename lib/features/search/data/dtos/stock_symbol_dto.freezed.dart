// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_symbol_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockSymbolDto {

@JsonKey(name: 's', readValue: _readSymbol) String get symbol;@JsonKey(name: 'n', readValue: _readName) String get name;@JsonKey(name: 'isPrivate', readValue: _readIsPrivate) bool get isPrivate;
/// Create a copy of StockSymbolDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockSymbolDtoCopyWith<StockSymbolDto> get copyWith => _$StockSymbolDtoCopyWithImpl<StockSymbolDto>(this as StockSymbolDto, _$identity);

  /// Serializes this StockSymbolDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockSymbolDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,isPrivate);

@override
String toString() {
  return 'StockSymbolDto(symbol: $symbol, name: $name, isPrivate: $isPrivate)';
}


}

/// @nodoc
abstract mixin class $StockSymbolDtoCopyWith<$Res>  {
  factory $StockSymbolDtoCopyWith(StockSymbolDto value, $Res Function(StockSymbolDto) _then) = _$StockSymbolDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 's', readValue: _readSymbol) String symbol,@JsonKey(name: 'n', readValue: _readName) String name,@JsonKey(name: 'isPrivate', readValue: _readIsPrivate) bool isPrivate
});




}
/// @nodoc
class _$StockSymbolDtoCopyWithImpl<$Res>
    implements $StockSymbolDtoCopyWith<$Res> {
  _$StockSymbolDtoCopyWithImpl(this._self, this._then);

  final StockSymbolDto _self;
  final $Res Function(StockSymbolDto) _then;

/// Create a copy of StockSymbolDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? name = null,Object? isPrivate = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StockSymbolDto].
extension StockSymbolDtoPatterns on StockSymbolDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockSymbolDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockSymbolDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockSymbolDto value)  $default,){
final _that = this;
switch (_that) {
case _StockSymbolDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockSymbolDto value)?  $default,){
final _that = this;
switch (_that) {
case _StockSymbolDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 's', readValue: _readSymbol)  String symbol, @JsonKey(name: 'n', readValue: _readName)  String name, @JsonKey(name: 'isPrivate', readValue: _readIsPrivate)  bool isPrivate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockSymbolDto() when $default != null:
return $default(_that.symbol,_that.name,_that.isPrivate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 's', readValue: _readSymbol)  String symbol, @JsonKey(name: 'n', readValue: _readName)  String name, @JsonKey(name: 'isPrivate', readValue: _readIsPrivate)  bool isPrivate)  $default,) {final _that = this;
switch (_that) {
case _StockSymbolDto():
return $default(_that.symbol,_that.name,_that.isPrivate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 's', readValue: _readSymbol)  String symbol, @JsonKey(name: 'n', readValue: _readName)  String name, @JsonKey(name: 'isPrivate', readValue: _readIsPrivate)  bool isPrivate)?  $default,) {final _that = this;
switch (_that) {
case _StockSymbolDto() when $default != null:
return $default(_that.symbol,_that.name,_that.isPrivate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockSymbolDto extends StockSymbolDto {
  const _StockSymbolDto({@JsonKey(name: 's', readValue: _readSymbol) required this.symbol, @JsonKey(name: 'n', readValue: _readName) required this.name, @JsonKey(name: 'isPrivate', readValue: _readIsPrivate) this.isPrivate = false}): super._();
  factory _StockSymbolDto.fromJson(Map<String, dynamic> json) => _$StockSymbolDtoFromJson(json);

@override@JsonKey(name: 's', readValue: _readSymbol) final  String symbol;
@override@JsonKey(name: 'n', readValue: _readName) final  String name;
@override@JsonKey(name: 'isPrivate', readValue: _readIsPrivate) final  bool isPrivate;

/// Create a copy of StockSymbolDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockSymbolDtoCopyWith<_StockSymbolDto> get copyWith => __$StockSymbolDtoCopyWithImpl<_StockSymbolDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockSymbolDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockSymbolDto&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,name,isPrivate);

@override
String toString() {
  return 'StockSymbolDto(symbol: $symbol, name: $name, isPrivate: $isPrivate)';
}


}

/// @nodoc
abstract mixin class _$StockSymbolDtoCopyWith<$Res> implements $StockSymbolDtoCopyWith<$Res> {
  factory _$StockSymbolDtoCopyWith(_StockSymbolDto value, $Res Function(_StockSymbolDto) _then) = __$StockSymbolDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 's', readValue: _readSymbol) String symbol,@JsonKey(name: 'n', readValue: _readName) String name,@JsonKey(name: 'isPrivate', readValue: _readIsPrivate) bool isPrivate
});




}
/// @nodoc
class __$StockSymbolDtoCopyWithImpl<$Res>
    implements _$StockSymbolDtoCopyWith<$Res> {
  __$StockSymbolDtoCopyWithImpl(this._self, this._then);

  final _StockSymbolDto _self;
  final $Res Function(_StockSymbolDto) _then;

/// Create a copy of StockSymbolDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? name = null,Object? isPrivate = null,}) {
  return _then(_StockSymbolDto(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
