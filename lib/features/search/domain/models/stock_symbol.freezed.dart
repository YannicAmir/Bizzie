// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_symbol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockSymbol {

 String get symbol; String get name; bool get isPrivate;
/// Create a copy of StockSymbol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockSymbolCopyWith<StockSymbol> get copyWith => _$StockSymbolCopyWithImpl<StockSymbol>(this as StockSymbol, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockSymbol&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,name,isPrivate);

@override
String toString() {
  return 'StockSymbol(symbol: $symbol, name: $name, isPrivate: $isPrivate)';
}


}

/// @nodoc
abstract mixin class $StockSymbolCopyWith<$Res>  {
  factory $StockSymbolCopyWith(StockSymbol value, $Res Function(StockSymbol) _then) = _$StockSymbolCopyWithImpl;
@useResult
$Res call({
 String symbol, String name, bool isPrivate
});




}
/// @nodoc
class _$StockSymbolCopyWithImpl<$Res>
    implements $StockSymbolCopyWith<$Res> {
  _$StockSymbolCopyWithImpl(this._self, this._then);

  final StockSymbol _self;
  final $Res Function(StockSymbol) _then;

/// Create a copy of StockSymbol
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


/// Adds pattern-matching-related methods to [StockSymbol].
extension StockSymbolPatterns on StockSymbol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockSymbol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockSymbol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockSymbol value)  $default,){
final _that = this;
switch (_that) {
case _StockSymbol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockSymbol value)?  $default,){
final _that = this;
switch (_that) {
case _StockSymbol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String name,  bool isPrivate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockSymbol() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String name,  bool isPrivate)  $default,) {final _that = this;
switch (_that) {
case _StockSymbol():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String name,  bool isPrivate)?  $default,) {final _that = this;
switch (_that) {
case _StockSymbol() when $default != null:
return $default(_that.symbol,_that.name,_that.isPrivate);case _:
  return null;

}
}

}

/// @nodoc


class _StockSymbol implements StockSymbol {
  const _StockSymbol({required this.symbol, required this.name, this.isPrivate = false});
  

@override final  String symbol;
@override final  String name;
@override@JsonKey() final  bool isPrivate;

/// Create a copy of StockSymbol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockSymbolCopyWith<_StockSymbol> get copyWith => __$StockSymbolCopyWithImpl<_StockSymbol>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockSymbol&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,name,isPrivate);

@override
String toString() {
  return 'StockSymbol(symbol: $symbol, name: $name, isPrivate: $isPrivate)';
}


}

/// @nodoc
abstract mixin class _$StockSymbolCopyWith<$Res> implements $StockSymbolCopyWith<$Res> {
  factory _$StockSymbolCopyWith(_StockSymbol value, $Res Function(_StockSymbol) _then) = __$StockSymbolCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String name, bool isPrivate
});




}
/// @nodoc
class __$StockSymbolCopyWithImpl<$Res>
    implements _$StockSymbolCopyWith<$Res> {
  __$StockSymbolCopyWithImpl(this._self, this._then);

  final _StockSymbol _self;
  final $Res Function(_StockSymbol) _then;

/// Create a copy of StockSymbol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? name = null,Object? isPrivate = null,}) {
  return _then(_StockSymbol(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
