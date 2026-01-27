// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_statement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeStatement {

 String get date; String get symbol; String get reportedCurrency; String get period; double get revenue; double get grossProfit; double get operatingIncome; double get netIncome; double get eps; double get ebitda; double get costOfRevenue; double get operatingExpenses; double get costAndExpenses;
/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeStatementCopyWith<IncomeStatement> get copyWith => _$IncomeStatementCopyWithImpl<IncomeStatement>(this as IncomeStatement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeStatement&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.costAndExpenses, costAndExpenses) || other.costAndExpenses == costAndExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,revenue,grossProfit,operatingIncome,netIncome,eps,ebitda,costOfRevenue,operatingExpenses,costAndExpenses);

@override
String toString() {
  return 'IncomeStatement(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, revenue: $revenue, grossProfit: $grossProfit, operatingIncome: $operatingIncome, netIncome: $netIncome, eps: $eps, ebitda: $ebitda, costOfRevenue: $costOfRevenue, operatingExpenses: $operatingExpenses, costAndExpenses: $costAndExpenses)';
}


}

/// @nodoc
abstract mixin class $IncomeStatementCopyWith<$Res>  {
  factory $IncomeStatementCopyWith(IncomeStatement value, $Res Function(IncomeStatement) _then) = _$IncomeStatementCopyWithImpl;
@useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double revenue, double grossProfit, double operatingIncome, double netIncome, double eps, double ebitda, double costOfRevenue, double operatingExpenses, double costAndExpenses
});




}
/// @nodoc
class _$IncomeStatementCopyWithImpl<$Res>
    implements $IncomeStatementCopyWith<$Res> {
  _$IncomeStatementCopyWithImpl(this._self, this._then);

  final IncomeStatement _self;
  final $Res Function(IncomeStatement) _then;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? revenue = null,Object? grossProfit = null,Object? operatingIncome = null,Object? netIncome = null,Object? eps = null,Object? ebitda = null,Object? costOfRevenue = null,Object? operatingExpenses = null,Object? costAndExpenses = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,operatingIncome: null == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double,ebitda: null == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double,costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,costAndExpenses: null == costAndExpenses ? _self.costAndExpenses : costAndExpenses // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeStatement].
extension IncomeStatementPatterns on IncomeStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeStatement value)  $default,){
final _that = this;
switch (_that) {
case _IncomeStatement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeStatement value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double revenue,  double grossProfit,  double operatingIncome,  double netIncome,  double eps,  double ebitda,  double costOfRevenue,  double operatingExpenses,  double costAndExpenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.revenue,_that.grossProfit,_that.operatingIncome,_that.netIncome,_that.eps,_that.ebitda,_that.costOfRevenue,_that.operatingExpenses,_that.costAndExpenses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double revenue,  double grossProfit,  double operatingIncome,  double netIncome,  double eps,  double ebitda,  double costOfRevenue,  double operatingExpenses,  double costAndExpenses)  $default,) {final _that = this;
switch (_that) {
case _IncomeStatement():
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.revenue,_that.grossProfit,_that.operatingIncome,_that.netIncome,_that.eps,_that.ebitda,_that.costOfRevenue,_that.operatingExpenses,_that.costAndExpenses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String symbol,  String reportedCurrency,  String period,  double revenue,  double grossProfit,  double operatingIncome,  double netIncome,  double eps,  double ebitda,  double costOfRevenue,  double operatingExpenses,  double costAndExpenses)?  $default,) {final _that = this;
switch (_that) {
case _IncomeStatement() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.revenue,_that.grossProfit,_that.operatingIncome,_that.netIncome,_that.eps,_that.ebitda,_that.costOfRevenue,_that.operatingExpenses,_that.costAndExpenses);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeStatement implements IncomeStatement {
  const _IncomeStatement({required this.date, required this.symbol, required this.reportedCurrency, required this.period, required this.revenue, required this.grossProfit, required this.operatingIncome, required this.netIncome, required this.eps, required this.ebitda, required this.costOfRevenue, required this.operatingExpenses, required this.costAndExpenses});
  

@override final  String date;
@override final  String symbol;
@override final  String reportedCurrency;
@override final  String period;
@override final  double revenue;
@override final  double grossProfit;
@override final  double operatingIncome;
@override final  double netIncome;
@override final  double eps;
@override final  double ebitda;
@override final  double costOfRevenue;
@override final  double operatingExpenses;
@override final  double costAndExpenses;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeStatementCopyWith<_IncomeStatement> get copyWith => __$IncomeStatementCopyWithImpl<_IncomeStatement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeStatement&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.costAndExpenses, costAndExpenses) || other.costAndExpenses == costAndExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,revenue,grossProfit,operatingIncome,netIncome,eps,ebitda,costOfRevenue,operatingExpenses,costAndExpenses);

@override
String toString() {
  return 'IncomeStatement(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, revenue: $revenue, grossProfit: $grossProfit, operatingIncome: $operatingIncome, netIncome: $netIncome, eps: $eps, ebitda: $ebitda, costOfRevenue: $costOfRevenue, operatingExpenses: $operatingExpenses, costAndExpenses: $costAndExpenses)';
}


}

/// @nodoc
abstract mixin class _$IncomeStatementCopyWith<$Res> implements $IncomeStatementCopyWith<$Res> {
  factory _$IncomeStatementCopyWith(_IncomeStatement value, $Res Function(_IncomeStatement) _then) = __$IncomeStatementCopyWithImpl;
@override @useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double revenue, double grossProfit, double operatingIncome, double netIncome, double eps, double ebitda, double costOfRevenue, double operatingExpenses, double costAndExpenses
});




}
/// @nodoc
class __$IncomeStatementCopyWithImpl<$Res>
    implements _$IncomeStatementCopyWith<$Res> {
  __$IncomeStatementCopyWithImpl(this._self, this._then);

  final _IncomeStatement _self;
  final $Res Function(_IncomeStatement) _then;

/// Create a copy of IncomeStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? revenue = null,Object? grossProfit = null,Object? operatingIncome = null,Object? netIncome = null,Object? eps = null,Object? ebitda = null,Object? costOfRevenue = null,Object? operatingExpenses = null,Object? costAndExpenses = null,}) {
  return _then(_IncomeStatement(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double,grossProfit: null == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double,operatingIncome: null == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double,ebitda: null == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double,costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as double,operatingExpenses: null == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double,costAndExpenses: null == costAndExpenses ? _self.costAndExpenses : costAndExpenses // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
