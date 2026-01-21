// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_statements_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialStatementsEvent {

 String get ticker; bool get forceRefresh;
/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialStatementsEventCopyWith<FinancialStatementsEvent> get copyWith => _$FinancialStatementsEventCopyWithImpl<FinancialStatementsEvent>(this as FinancialStatementsEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialStatementsEvent&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'FinancialStatementsEvent(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $FinancialStatementsEventCopyWith<$Res>  {
  factory $FinancialStatementsEventCopyWith(FinancialStatementsEvent value, $Res Function(FinancialStatementsEvent) _then) = _$FinancialStatementsEventCopyWithImpl;
@useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$FinancialStatementsEventCopyWithImpl<$Res>
    implements $FinancialStatementsEventCopyWith<$Res> {
  _$FinancialStatementsEventCopyWithImpl(this._self, this._then);

  final FinancialStatementsEvent _self;
  final $Res Function(FinancialStatementsEvent) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialStatementsEvent].
extension FinancialStatementsEventPatterns on FinancialStatementsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadIncomeStatements value)?  loadIncomeStatements,TResult Function( LoadBalanceSheets value)?  loadBalanceSheets,TResult Function( LoadCashFlows value)?  loadCashFlows,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadIncomeStatements value)  loadIncomeStatements,required TResult Function( LoadBalanceSheets value)  loadBalanceSheets,required TResult Function( LoadCashFlows value)  loadCashFlows,}){
final _that = this;
switch (_that) {
case LoadIncomeStatements():
return loadIncomeStatements(_that);case LoadBalanceSheets():
return loadBalanceSheets(_that);case LoadCashFlows():
return loadCashFlows(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadIncomeStatements value)?  loadIncomeStatements,TResult? Function( LoadBalanceSheets value)?  loadBalanceSheets,TResult? Function( LoadCashFlows value)?  loadCashFlows,}){
final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadIncomeStatements,TResult Function( String ticker,  bool forceRefresh)?  loadBalanceSheets,TResult Function( String ticker,  bool forceRefresh)?  loadCashFlows,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that.ticker,_that.forceRefresh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadIncomeStatements,required TResult Function( String ticker,  bool forceRefresh)  loadBalanceSheets,required TResult Function( String ticker,  bool forceRefresh)  loadCashFlows,}) {final _that = this;
switch (_that) {
case LoadIncomeStatements():
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets():
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows():
return loadCashFlows(_that.ticker,_that.forceRefresh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadIncomeStatements,TResult? Function( String ticker,  bool forceRefresh)?  loadBalanceSheets,TResult? Function( String ticker,  bool forceRefresh)?  loadCashFlows,}) {final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that.ticker,_that.forceRefresh);case _:
  return null;

}
}

}

/// @nodoc


class LoadIncomeStatements implements FinancialStatementsEvent {
  const LoadIncomeStatements(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@override@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadIncomeStatementsCopyWith<LoadIncomeStatements> get copyWith => _$LoadIncomeStatementsCopyWithImpl<LoadIncomeStatements>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadIncomeStatements&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'FinancialStatementsEvent.loadIncomeStatements(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadIncomeStatementsCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $LoadIncomeStatementsCopyWith(LoadIncomeStatements value, $Res Function(LoadIncomeStatements) _then) = _$LoadIncomeStatementsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadIncomeStatementsCopyWithImpl<$Res>
    implements $LoadIncomeStatementsCopyWith<$Res> {
  _$LoadIncomeStatementsCopyWithImpl(this._self, this._then);

  final LoadIncomeStatements _self;
  final $Res Function(LoadIncomeStatements) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadIncomeStatements(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoadBalanceSheets implements FinancialStatementsEvent {
  const LoadBalanceSheets(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@override@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadBalanceSheetsCopyWith<LoadBalanceSheets> get copyWith => _$LoadBalanceSheetsCopyWithImpl<LoadBalanceSheets>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadBalanceSheets&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'FinancialStatementsEvent.loadBalanceSheets(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadBalanceSheetsCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $LoadBalanceSheetsCopyWith(LoadBalanceSheets value, $Res Function(LoadBalanceSheets) _then) = _$LoadBalanceSheetsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadBalanceSheetsCopyWithImpl<$Res>
    implements $LoadBalanceSheetsCopyWith<$Res> {
  _$LoadBalanceSheetsCopyWithImpl(this._self, this._then);

  final LoadBalanceSheets _self;
  final $Res Function(LoadBalanceSheets) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadBalanceSheets(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LoadCashFlows implements FinancialStatementsEvent {
  const LoadCashFlows(this.ticker, {this.forceRefresh = false});
  

@override final  String ticker;
@override@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadCashFlowsCopyWith<LoadCashFlows> get copyWith => _$LoadCashFlowsCopyWithImpl<LoadCashFlows>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadCashFlows&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forceRefresh);

@override
String toString() {
  return 'FinancialStatementsEvent.loadCashFlows(ticker: $ticker, forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $LoadCashFlowsCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $LoadCashFlowsCopyWith(LoadCashFlows value, $Res Function(LoadCashFlows) _then) = _$LoadCashFlowsCopyWithImpl;
@override @useResult
$Res call({
 String ticker, bool forceRefresh
});




}
/// @nodoc
class _$LoadCashFlowsCopyWithImpl<$Res>
    implements $LoadCashFlowsCopyWith<$Res> {
  _$LoadCashFlowsCopyWithImpl(this._self, this._then);

  final LoadCashFlows _self;
  final $Res Function(LoadCashFlows) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadCashFlows(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
