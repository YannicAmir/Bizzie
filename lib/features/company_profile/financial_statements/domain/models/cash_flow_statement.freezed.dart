// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_flow_statement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CashFlowStatement {

 String get date; String get symbol; String get reportedCurrency; String get period; double get operatingCashFlow; double get investingCashFlow; double get financingCashFlow; double get capitalExpenditure; double get freeCashFlow; double get dividendsPaid; double get cashAtBeginningOfPeriod; double get cashAtEndOfPeriod;
/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowStatementCopyWith<CashFlowStatement> get copyWith => _$CashFlowStatementCopyWithImpl<CashFlowStatement>(this as CashFlowStatement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowStatement&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.operatingCashFlow, operatingCashFlow) || other.operatingCashFlow == operatingCashFlow)&&(identical(other.investingCashFlow, investingCashFlow) || other.investingCashFlow == investingCashFlow)&&(identical(other.financingCashFlow, financingCashFlow) || other.financingCashFlow == financingCashFlow)&&(identical(other.capitalExpenditure, capitalExpenditure) || other.capitalExpenditure == capitalExpenditure)&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow)&&(identical(other.dividendsPaid, dividendsPaid) || other.dividendsPaid == dividendsPaid)&&(identical(other.cashAtBeginningOfPeriod, cashAtBeginningOfPeriod) || other.cashAtBeginningOfPeriod == cashAtBeginningOfPeriod)&&(identical(other.cashAtEndOfPeriod, cashAtEndOfPeriod) || other.cashAtEndOfPeriod == cashAtEndOfPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,operatingCashFlow,investingCashFlow,financingCashFlow,capitalExpenditure,freeCashFlow,dividendsPaid,cashAtBeginningOfPeriod,cashAtEndOfPeriod);

@override
String toString() {
  return 'CashFlowStatement(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, operatingCashFlow: $operatingCashFlow, investingCashFlow: $investingCashFlow, financingCashFlow: $financingCashFlow, capitalExpenditure: $capitalExpenditure, freeCashFlow: $freeCashFlow, dividendsPaid: $dividendsPaid, cashAtBeginningOfPeriod: $cashAtBeginningOfPeriod, cashAtEndOfPeriod: $cashAtEndOfPeriod)';
}


}

/// @nodoc
abstract mixin class $CashFlowStatementCopyWith<$Res>  {
  factory $CashFlowStatementCopyWith(CashFlowStatement value, $Res Function(CashFlowStatement) _then) = _$CashFlowStatementCopyWithImpl;
@useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double operatingCashFlow, double investingCashFlow, double financingCashFlow, double capitalExpenditure, double freeCashFlow, double dividendsPaid, double cashAtBeginningOfPeriod, double cashAtEndOfPeriod
});




}
/// @nodoc
class _$CashFlowStatementCopyWithImpl<$Res>
    implements $CashFlowStatementCopyWith<$Res> {
  _$CashFlowStatementCopyWithImpl(this._self, this._then);

  final CashFlowStatement _self;
  final $Res Function(CashFlowStatement) _then;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? operatingCashFlow = null,Object? investingCashFlow = null,Object? financingCashFlow = null,Object? capitalExpenditure = null,Object? freeCashFlow = null,Object? dividendsPaid = null,Object? cashAtBeginningOfPeriod = null,Object? cashAtEndOfPeriod = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,operatingCashFlow: null == operatingCashFlow ? _self.operatingCashFlow : operatingCashFlow // ignore: cast_nullable_to_non_nullable
as double,investingCashFlow: null == investingCashFlow ? _self.investingCashFlow : investingCashFlow // ignore: cast_nullable_to_non_nullable
as double,financingCashFlow: null == financingCashFlow ? _self.financingCashFlow : financingCashFlow // ignore: cast_nullable_to_non_nullable
as double,capitalExpenditure: null == capitalExpenditure ? _self.capitalExpenditure : capitalExpenditure // ignore: cast_nullable_to_non_nullable
as double,freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double,dividendsPaid: null == dividendsPaid ? _self.dividendsPaid : dividendsPaid // ignore: cast_nullable_to_non_nullable
as double,cashAtBeginningOfPeriod: null == cashAtBeginningOfPeriod ? _self.cashAtBeginningOfPeriod : cashAtBeginningOfPeriod // ignore: cast_nullable_to_non_nullable
as double,cashAtEndOfPeriod: null == cashAtEndOfPeriod ? _self.cashAtEndOfPeriod : cashAtEndOfPeriod // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CashFlowStatement].
extension CashFlowStatementPatterns on CashFlowStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowStatement value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowStatement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowStatement value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double operatingCashFlow,  double investingCashFlow,  double financingCashFlow,  double capitalExpenditure,  double freeCashFlow,  double dividendsPaid,  double cashAtBeginningOfPeriod,  double cashAtEndOfPeriod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.operatingCashFlow,_that.investingCashFlow,_that.financingCashFlow,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.cashAtBeginningOfPeriod,_that.cashAtEndOfPeriod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double operatingCashFlow,  double investingCashFlow,  double financingCashFlow,  double capitalExpenditure,  double freeCashFlow,  double dividendsPaid,  double cashAtBeginningOfPeriod,  double cashAtEndOfPeriod)  $default,) {final _that = this;
switch (_that) {
case _CashFlowStatement():
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.operatingCashFlow,_that.investingCashFlow,_that.financingCashFlow,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.cashAtBeginningOfPeriod,_that.cashAtEndOfPeriod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String symbol,  String reportedCurrency,  String period,  double operatingCashFlow,  double investingCashFlow,  double financingCashFlow,  double capitalExpenditure,  double freeCashFlow,  double dividendsPaid,  double cashAtBeginningOfPeriod,  double cashAtEndOfPeriod)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowStatement() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.operatingCashFlow,_that.investingCashFlow,_that.financingCashFlow,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.cashAtBeginningOfPeriod,_that.cashAtEndOfPeriod);case _:
  return null;

}
}

}

/// @nodoc


class _CashFlowStatement implements CashFlowStatement {
  const _CashFlowStatement({required this.date, required this.symbol, required this.reportedCurrency, required this.period, required this.operatingCashFlow, required this.investingCashFlow, required this.financingCashFlow, required this.capitalExpenditure, required this.freeCashFlow, required this.dividendsPaid, required this.cashAtBeginningOfPeriod, required this.cashAtEndOfPeriod});
  

@override final  String date;
@override final  String symbol;
@override final  String reportedCurrency;
@override final  String period;
@override final  double operatingCashFlow;
@override final  double investingCashFlow;
@override final  double financingCashFlow;
@override final  double capitalExpenditure;
@override final  double freeCashFlow;
@override final  double dividendsPaid;
@override final  double cashAtBeginningOfPeriod;
@override final  double cashAtEndOfPeriod;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashFlowStatementCopyWith<_CashFlowStatement> get copyWith => __$CashFlowStatementCopyWithImpl<_CashFlowStatement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowStatement&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.operatingCashFlow, operatingCashFlow) || other.operatingCashFlow == operatingCashFlow)&&(identical(other.investingCashFlow, investingCashFlow) || other.investingCashFlow == investingCashFlow)&&(identical(other.financingCashFlow, financingCashFlow) || other.financingCashFlow == financingCashFlow)&&(identical(other.capitalExpenditure, capitalExpenditure) || other.capitalExpenditure == capitalExpenditure)&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow)&&(identical(other.dividendsPaid, dividendsPaid) || other.dividendsPaid == dividendsPaid)&&(identical(other.cashAtBeginningOfPeriod, cashAtBeginningOfPeriod) || other.cashAtBeginningOfPeriod == cashAtBeginningOfPeriod)&&(identical(other.cashAtEndOfPeriod, cashAtEndOfPeriod) || other.cashAtEndOfPeriod == cashAtEndOfPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,operatingCashFlow,investingCashFlow,financingCashFlow,capitalExpenditure,freeCashFlow,dividendsPaid,cashAtBeginningOfPeriod,cashAtEndOfPeriod);

@override
String toString() {
  return 'CashFlowStatement(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, operatingCashFlow: $operatingCashFlow, investingCashFlow: $investingCashFlow, financingCashFlow: $financingCashFlow, capitalExpenditure: $capitalExpenditure, freeCashFlow: $freeCashFlow, dividendsPaid: $dividendsPaid, cashAtBeginningOfPeriod: $cashAtBeginningOfPeriod, cashAtEndOfPeriod: $cashAtEndOfPeriod)';
}


}

/// @nodoc
abstract mixin class _$CashFlowStatementCopyWith<$Res> implements $CashFlowStatementCopyWith<$Res> {
  factory _$CashFlowStatementCopyWith(_CashFlowStatement value, $Res Function(_CashFlowStatement) _then) = __$CashFlowStatementCopyWithImpl;
@override @useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double operatingCashFlow, double investingCashFlow, double financingCashFlow, double capitalExpenditure, double freeCashFlow, double dividendsPaid, double cashAtBeginningOfPeriod, double cashAtEndOfPeriod
});




}
/// @nodoc
class __$CashFlowStatementCopyWithImpl<$Res>
    implements _$CashFlowStatementCopyWith<$Res> {
  __$CashFlowStatementCopyWithImpl(this._self, this._then);

  final _CashFlowStatement _self;
  final $Res Function(_CashFlowStatement) _then;

/// Create a copy of CashFlowStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? operatingCashFlow = null,Object? investingCashFlow = null,Object? financingCashFlow = null,Object? capitalExpenditure = null,Object? freeCashFlow = null,Object? dividendsPaid = null,Object? cashAtBeginningOfPeriod = null,Object? cashAtEndOfPeriod = null,}) {
  return _then(_CashFlowStatement(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,operatingCashFlow: null == operatingCashFlow ? _self.operatingCashFlow : operatingCashFlow // ignore: cast_nullable_to_non_nullable
as double,investingCashFlow: null == investingCashFlow ? _self.investingCashFlow : investingCashFlow // ignore: cast_nullable_to_non_nullable
as double,financingCashFlow: null == financingCashFlow ? _self.financingCashFlow : financingCashFlow // ignore: cast_nullable_to_non_nullable
as double,capitalExpenditure: null == capitalExpenditure ? _self.capitalExpenditure : capitalExpenditure // ignore: cast_nullable_to_non_nullable
as double,freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double,dividendsPaid: null == dividendsPaid ? _self.dividendsPaid : dividendsPaid // ignore: cast_nullable_to_non_nullable
as double,cashAtBeginningOfPeriod: null == cashAtBeginningOfPeriod ? _self.cashAtBeginningOfPeriod : cashAtBeginningOfPeriod // ignore: cast_nullable_to_non_nullable
as double,cashAtEndOfPeriod: null == cashAtEndOfPeriod ? _self.cashAtEndOfPeriod : cashAtEndOfPeriod // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
