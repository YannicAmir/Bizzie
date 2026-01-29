// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_financial_statement_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetFinancialStatementParams {

 String get ticker; String get period;
/// Create a copy of GetFinancialStatementParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetFinancialStatementParamsCopyWith<GetFinancialStatementParams> get copyWith => _$GetFinancialStatementParamsCopyWithImpl<GetFinancialStatementParams>(this as GetFinancialStatementParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetFinancialStatementParams&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,period);

@override
String toString() {
  return 'GetFinancialStatementParams(ticker: $ticker, period: $period)';
}


}

/// @nodoc
abstract mixin class $GetFinancialStatementParamsCopyWith<$Res>  {
  factory $GetFinancialStatementParamsCopyWith(GetFinancialStatementParams value, $Res Function(GetFinancialStatementParams) _then) = _$GetFinancialStatementParamsCopyWithImpl;
@useResult
$Res call({
 String ticker, String period
});




}
/// @nodoc
class _$GetFinancialStatementParamsCopyWithImpl<$Res>
    implements $GetFinancialStatementParamsCopyWith<$Res> {
  _$GetFinancialStatementParamsCopyWithImpl(this._self, this._then);

  final GetFinancialStatementParams _self;
  final $Res Function(GetFinancialStatementParams) _then;

/// Create a copy of GetFinancialStatementParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? period = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetFinancialStatementParams].
extension GetFinancialStatementParamsPatterns on GetFinancialStatementParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetFinancialStatementParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetFinancialStatementParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetFinancialStatementParams value)  $default,){
final _that = this;
switch (_that) {
case _GetFinancialStatementParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetFinancialStatementParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetFinancialStatementParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetFinancialStatementParams() when $default != null:
return $default(_that.ticker,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String period)  $default,) {final _that = this;
switch (_that) {
case _GetFinancialStatementParams():
return $default(_that.ticker,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String period)?  $default,) {final _that = this;
switch (_that) {
case _GetFinancialStatementParams() when $default != null:
return $default(_that.ticker,_that.period);case _:
  return null;

}
}

}

/// @nodoc


class _GetFinancialStatementParams implements GetFinancialStatementParams {
  const _GetFinancialStatementParams({required this.ticker, this.period = 'annual'});
  

@override final  String ticker;
@override@JsonKey() final  String period;

/// Create a copy of GetFinancialStatementParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetFinancialStatementParamsCopyWith<_GetFinancialStatementParams> get copyWith => __$GetFinancialStatementParamsCopyWithImpl<_GetFinancialStatementParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetFinancialStatementParams&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,period);

@override
String toString() {
  return 'GetFinancialStatementParams(ticker: $ticker, period: $period)';
}


}

/// @nodoc
abstract mixin class _$GetFinancialStatementParamsCopyWith<$Res> implements $GetFinancialStatementParamsCopyWith<$Res> {
  factory _$GetFinancialStatementParamsCopyWith(_GetFinancialStatementParams value, $Res Function(_GetFinancialStatementParams) _then) = __$GetFinancialStatementParamsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String period
});




}
/// @nodoc
class __$GetFinancialStatementParamsCopyWithImpl<$Res>
    implements _$GetFinancialStatementParamsCopyWith<$Res> {
  __$GetFinancialStatementParamsCopyWithImpl(this._self, this._then);

  final _GetFinancialStatementParams _self;
  final $Res Function(_GetFinancialStatementParams) _then;

/// Create a copy of GetFinancialStatementParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? period = null,}) {
  return _then(_GetFinancialStatementParams(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
