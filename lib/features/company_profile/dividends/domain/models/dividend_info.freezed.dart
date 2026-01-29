// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dividend_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DividendInfo {

 String get symbol; List<DividendEvent> get history;
/// Create a copy of DividendInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DividendInfoCopyWith<DividendInfo> get copyWith => _$DividendInfoCopyWithImpl<DividendInfo>(this as DividendInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DividendInfo&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other.history, history));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'DividendInfo(symbol: $symbol, history: $history)';
}


}

/// @nodoc
abstract mixin class $DividendInfoCopyWith<$Res>  {
  factory $DividendInfoCopyWith(DividendInfo value, $Res Function(DividendInfo) _then) = _$DividendInfoCopyWithImpl;
@useResult
$Res call({
 String symbol, List<DividendEvent> history
});




}
/// @nodoc
class _$DividendInfoCopyWithImpl<$Res>
    implements $DividendInfoCopyWith<$Res> {
  _$DividendInfoCopyWithImpl(this._self, this._then);

  final DividendInfo _self;
  final $Res Function(DividendInfo) _then;

/// Create a copy of DividendInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? history = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<DividendEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [DividendInfo].
extension DividendInfoPatterns on DividendInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DividendInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DividendInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DividendInfo value)  $default,){
final _that = this;
switch (_that) {
case _DividendInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DividendInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DividendInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  List<DividendEvent> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DividendInfo() when $default != null:
return $default(_that.symbol,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  List<DividendEvent> history)  $default,) {final _that = this;
switch (_that) {
case _DividendInfo():
return $default(_that.symbol,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  List<DividendEvent> history)?  $default,) {final _that = this;
switch (_that) {
case _DividendInfo() when $default != null:
return $default(_that.symbol,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _DividendInfo implements DividendInfo {
  const _DividendInfo({required this.symbol, required final  List<DividendEvent> history}): _history = history;
  

@override final  String symbol;
 final  List<DividendEvent> _history;
@override List<DividendEvent> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of DividendInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DividendInfoCopyWith<_DividendInfo> get copyWith => __$DividendInfoCopyWithImpl<_DividendInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DividendInfo&&(identical(other.symbol, symbol) || other.symbol == symbol)&&const DeepCollectionEquality().equals(other._history, _history));
}


@override
int get hashCode => Object.hash(runtimeType,symbol,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'DividendInfo(symbol: $symbol, history: $history)';
}


}

/// @nodoc
abstract mixin class _$DividendInfoCopyWith<$Res> implements $DividendInfoCopyWith<$Res> {
  factory _$DividendInfoCopyWith(_DividendInfo value, $Res Function(_DividendInfo) _then) = __$DividendInfoCopyWithImpl;
@override @useResult
$Res call({
 String symbol, List<DividendEvent> history
});




}
/// @nodoc
class __$DividendInfoCopyWithImpl<$Res>
    implements _$DividendInfoCopyWith<$Res> {
  __$DividendInfoCopyWithImpl(this._self, this._then);

  final _DividendInfo _self;
  final $Res Function(_DividendInfo) _then;

/// Create a copy of DividendInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? history = null,}) {
  return _then(_DividendInfo(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<DividendEvent>,
  ));
}


}

// dart format on
