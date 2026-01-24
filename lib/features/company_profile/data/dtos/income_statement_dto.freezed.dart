// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_statement_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IncomeStatementDto {

 String get date; String get symbol; String get reportedCurrency; String get cik; String get filingDate; String get acceptedDate; String get fiscalYear; String get period; double? get revenue; double? get costOfRevenue; double? get grossProfit; double? get researchAndDevelopmentExpenses; double? get generalAndAdministrativeExpenses; double? get sellingAndMarketingExpenses; double? get sellingGeneralAndAdministrativeExpenses; double? get otherExpenses; double? get operatingExpenses; double? get costAndExpenses; double? get interestIncome; double? get interestExpense; double? get depreciationAndAmortization; double? get ebitda; double? get ebit; double? get operatingIncome; double? get totalOtherIncomeExpensesNet; double? get incomeBeforeTax; double? get incomeTaxExpense; double? get netIncome; double? get eps; double? get epsDiluted; double? get weightedAverageShsOut; double? get weightedAverageShsOutDil;
/// Create a copy of IncomeStatementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeStatementDtoCopyWith<IncomeStatementDto> get copyWith => _$IncomeStatementDtoCopyWithImpl<IncomeStatementDto>(this as IncomeStatementDto, _$identity);

  /// Serializes this IncomeStatementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeStatementDto&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.cik, cik) || other.cik == cik)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.acceptedDate, acceptedDate) || other.acceptedDate == acceptedDate)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.researchAndDevelopmentExpenses, researchAndDevelopmentExpenses) || other.researchAndDevelopmentExpenses == researchAndDevelopmentExpenses)&&(identical(other.generalAndAdministrativeExpenses, generalAndAdministrativeExpenses) || other.generalAndAdministrativeExpenses == generalAndAdministrativeExpenses)&&(identical(other.sellingAndMarketingExpenses, sellingAndMarketingExpenses) || other.sellingAndMarketingExpenses == sellingAndMarketingExpenses)&&(identical(other.sellingGeneralAndAdministrativeExpenses, sellingGeneralAndAdministrativeExpenses) || other.sellingGeneralAndAdministrativeExpenses == sellingGeneralAndAdministrativeExpenses)&&(identical(other.otherExpenses, otherExpenses) || other.otherExpenses == otherExpenses)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.costAndExpenses, costAndExpenses) || other.costAndExpenses == costAndExpenses)&&(identical(other.interestIncome, interestIncome) || other.interestIncome == interestIncome)&&(identical(other.interestExpense, interestExpense) || other.interestExpense == interestExpense)&&(identical(other.depreciationAndAmortization, depreciationAndAmortization) || other.depreciationAndAmortization == depreciationAndAmortization)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.ebit, ebit) || other.ebit == ebit)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.totalOtherIncomeExpensesNet, totalOtherIncomeExpensesNet) || other.totalOtherIncomeExpensesNet == totalOtherIncomeExpensesNet)&&(identical(other.incomeBeforeTax, incomeBeforeTax) || other.incomeBeforeTax == incomeBeforeTax)&&(identical(other.incomeTaxExpense, incomeTaxExpense) || other.incomeTaxExpense == incomeTaxExpense)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.epsDiluted, epsDiluted) || other.epsDiluted == epsDiluted)&&(identical(other.weightedAverageShsOut, weightedAverageShsOut) || other.weightedAverageShsOut == weightedAverageShsOut)&&(identical(other.weightedAverageShsOutDil, weightedAverageShsOutDil) || other.weightedAverageShsOutDil == weightedAverageShsOutDil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,symbol,reportedCurrency,cik,filingDate,acceptedDate,fiscalYear,period,revenue,costOfRevenue,grossProfit,researchAndDevelopmentExpenses,generalAndAdministrativeExpenses,sellingAndMarketingExpenses,sellingGeneralAndAdministrativeExpenses,otherExpenses,operatingExpenses,costAndExpenses,interestIncome,interestExpense,depreciationAndAmortization,ebitda,ebit,operatingIncome,totalOtherIncomeExpensesNet,incomeBeforeTax,incomeTaxExpense,netIncome,eps,epsDiluted,weightedAverageShsOut,weightedAverageShsOutDil]);

@override
String toString() {
  return 'IncomeStatementDto(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, cik: $cik, filingDate: $filingDate, acceptedDate: $acceptedDate, fiscalYear: $fiscalYear, period: $period, revenue: $revenue, costOfRevenue: $costOfRevenue, grossProfit: $grossProfit, researchAndDevelopmentExpenses: $researchAndDevelopmentExpenses, generalAndAdministrativeExpenses: $generalAndAdministrativeExpenses, sellingAndMarketingExpenses: $sellingAndMarketingExpenses, sellingGeneralAndAdministrativeExpenses: $sellingGeneralAndAdministrativeExpenses, otherExpenses: $otherExpenses, operatingExpenses: $operatingExpenses, costAndExpenses: $costAndExpenses, interestIncome: $interestIncome, interestExpense: $interestExpense, depreciationAndAmortization: $depreciationAndAmortization, ebitda: $ebitda, ebit: $ebit, operatingIncome: $operatingIncome, totalOtherIncomeExpensesNet: $totalOtherIncomeExpensesNet, incomeBeforeTax: $incomeBeforeTax, incomeTaxExpense: $incomeTaxExpense, netIncome: $netIncome, eps: $eps, epsDiluted: $epsDiluted, weightedAverageShsOut: $weightedAverageShsOut, weightedAverageShsOutDil: $weightedAverageShsOutDil)';
}


}

/// @nodoc
abstract mixin class $IncomeStatementDtoCopyWith<$Res>  {
  factory $IncomeStatementDtoCopyWith(IncomeStatementDto value, $Res Function(IncomeStatementDto) _then) = _$IncomeStatementDtoCopyWithImpl;
@useResult
$Res call({
 String date, String symbol, String reportedCurrency, String cik, String filingDate, String acceptedDate, String fiscalYear, String period, double? revenue, double? costOfRevenue, double? grossProfit, double? researchAndDevelopmentExpenses, double? generalAndAdministrativeExpenses, double? sellingAndMarketingExpenses, double? sellingGeneralAndAdministrativeExpenses, double? otherExpenses, double? operatingExpenses, double? costAndExpenses, double? interestIncome, double? interestExpense, double? depreciationAndAmortization, double? ebitda, double? ebit, double? operatingIncome, double? totalOtherIncomeExpensesNet, double? incomeBeforeTax, double? incomeTaxExpense, double? netIncome, double? eps, double? epsDiluted, double? weightedAverageShsOut, double? weightedAverageShsOutDil
});




}
/// @nodoc
class _$IncomeStatementDtoCopyWithImpl<$Res>
    implements $IncomeStatementDtoCopyWith<$Res> {
  _$IncomeStatementDtoCopyWithImpl(this._self, this._then);

  final IncomeStatementDto _self;
  final $Res Function(IncomeStatementDto) _then;

/// Create a copy of IncomeStatementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? cik = null,Object? filingDate = null,Object? acceptedDate = null,Object? fiscalYear = null,Object? period = null,Object? revenue = freezed,Object? costOfRevenue = freezed,Object? grossProfit = freezed,Object? researchAndDevelopmentExpenses = freezed,Object? generalAndAdministrativeExpenses = freezed,Object? sellingAndMarketingExpenses = freezed,Object? sellingGeneralAndAdministrativeExpenses = freezed,Object? otherExpenses = freezed,Object? operatingExpenses = freezed,Object? costAndExpenses = freezed,Object? interestIncome = freezed,Object? interestExpense = freezed,Object? depreciationAndAmortization = freezed,Object? ebitda = freezed,Object? ebit = freezed,Object? operatingIncome = freezed,Object? totalOtherIncomeExpensesNet = freezed,Object? incomeBeforeTax = freezed,Object? incomeTaxExpense = freezed,Object? netIncome = freezed,Object? eps = freezed,Object? epsDiluted = freezed,Object? weightedAverageShsOut = freezed,Object? weightedAverageShsOutDil = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,cik: null == cik ? _self.cik : cik // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String,acceptedDate: null == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String,fiscalYear: null == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,costOfRevenue: freezed == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as double?,grossProfit: freezed == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double?,researchAndDevelopmentExpenses: freezed == researchAndDevelopmentExpenses ? _self.researchAndDevelopmentExpenses : researchAndDevelopmentExpenses // ignore: cast_nullable_to_non_nullable
as double?,generalAndAdministrativeExpenses: freezed == generalAndAdministrativeExpenses ? _self.generalAndAdministrativeExpenses : generalAndAdministrativeExpenses // ignore: cast_nullable_to_non_nullable
as double?,sellingAndMarketingExpenses: freezed == sellingAndMarketingExpenses ? _self.sellingAndMarketingExpenses : sellingAndMarketingExpenses // ignore: cast_nullable_to_non_nullable
as double?,sellingGeneralAndAdministrativeExpenses: freezed == sellingGeneralAndAdministrativeExpenses ? _self.sellingGeneralAndAdministrativeExpenses : sellingGeneralAndAdministrativeExpenses // ignore: cast_nullable_to_non_nullable
as double?,otherExpenses: freezed == otherExpenses ? _self.otherExpenses : otherExpenses // ignore: cast_nullable_to_non_nullable
as double?,operatingExpenses: freezed == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double?,costAndExpenses: freezed == costAndExpenses ? _self.costAndExpenses : costAndExpenses // ignore: cast_nullable_to_non_nullable
as double?,interestIncome: freezed == interestIncome ? _self.interestIncome : interestIncome // ignore: cast_nullable_to_non_nullable
as double?,interestExpense: freezed == interestExpense ? _self.interestExpense : interestExpense // ignore: cast_nullable_to_non_nullable
as double?,depreciationAndAmortization: freezed == depreciationAndAmortization ? _self.depreciationAndAmortization : depreciationAndAmortization // ignore: cast_nullable_to_non_nullable
as double?,ebitda: freezed == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double?,ebit: freezed == ebit ? _self.ebit : ebit // ignore: cast_nullable_to_non_nullable
as double?,operatingIncome: freezed == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double?,totalOtherIncomeExpensesNet: freezed == totalOtherIncomeExpensesNet ? _self.totalOtherIncomeExpensesNet : totalOtherIncomeExpensesNet // ignore: cast_nullable_to_non_nullable
as double?,incomeBeforeTax: freezed == incomeBeforeTax ? _self.incomeBeforeTax : incomeBeforeTax // ignore: cast_nullable_to_non_nullable
as double?,incomeTaxExpense: freezed == incomeTaxExpense ? _self.incomeTaxExpense : incomeTaxExpense // ignore: cast_nullable_to_non_nullable
as double?,netIncome: freezed == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,epsDiluted: freezed == epsDiluted ? _self.epsDiluted : epsDiluted // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOut: freezed == weightedAverageShsOut ? _self.weightedAverageShsOut : weightedAverageShsOut // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOutDil: freezed == weightedAverageShsOutDil ? _self.weightedAverageShsOutDil : weightedAverageShsOutDil // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeStatementDto].
extension IncomeStatementDtoPatterns on IncomeStatementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeStatementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeStatementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeStatementDto value)  $default,){
final _that = this;
switch (_that) {
case _IncomeStatementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeStatementDto value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeStatementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String cik,  String filingDate,  String acceptedDate,  String fiscalYear,  String period,  double? revenue,  double? costOfRevenue,  double? grossProfit,  double? researchAndDevelopmentExpenses,  double? generalAndAdministrativeExpenses,  double? sellingAndMarketingExpenses,  double? sellingGeneralAndAdministrativeExpenses,  double? otherExpenses,  double? operatingExpenses,  double? costAndExpenses,  double? interestIncome,  double? interestExpense,  double? depreciationAndAmortization,  double? ebitda,  double? ebit,  double? operatingIncome,  double? totalOtherIncomeExpensesNet,  double? incomeBeforeTax,  double? incomeTaxExpense,  double? netIncome,  double? eps,  double? epsDiluted,  double? weightedAverageShsOut,  double? weightedAverageShsOutDil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeStatementDto() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.filingDate,_that.acceptedDate,_that.fiscalYear,_that.period,_that.revenue,_that.costOfRevenue,_that.grossProfit,_that.researchAndDevelopmentExpenses,_that.generalAndAdministrativeExpenses,_that.sellingAndMarketingExpenses,_that.sellingGeneralAndAdministrativeExpenses,_that.otherExpenses,_that.operatingExpenses,_that.costAndExpenses,_that.interestIncome,_that.interestExpense,_that.depreciationAndAmortization,_that.ebitda,_that.ebit,_that.operatingIncome,_that.totalOtherIncomeExpensesNet,_that.incomeBeforeTax,_that.incomeTaxExpense,_that.netIncome,_that.eps,_that.epsDiluted,_that.weightedAverageShsOut,_that.weightedAverageShsOutDil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String cik,  String filingDate,  String acceptedDate,  String fiscalYear,  String period,  double? revenue,  double? costOfRevenue,  double? grossProfit,  double? researchAndDevelopmentExpenses,  double? generalAndAdministrativeExpenses,  double? sellingAndMarketingExpenses,  double? sellingGeneralAndAdministrativeExpenses,  double? otherExpenses,  double? operatingExpenses,  double? costAndExpenses,  double? interestIncome,  double? interestExpense,  double? depreciationAndAmortization,  double? ebitda,  double? ebit,  double? operatingIncome,  double? totalOtherIncomeExpensesNet,  double? incomeBeforeTax,  double? incomeTaxExpense,  double? netIncome,  double? eps,  double? epsDiluted,  double? weightedAverageShsOut,  double? weightedAverageShsOutDil)  $default,) {final _that = this;
switch (_that) {
case _IncomeStatementDto():
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.filingDate,_that.acceptedDate,_that.fiscalYear,_that.period,_that.revenue,_that.costOfRevenue,_that.grossProfit,_that.researchAndDevelopmentExpenses,_that.generalAndAdministrativeExpenses,_that.sellingAndMarketingExpenses,_that.sellingGeneralAndAdministrativeExpenses,_that.otherExpenses,_that.operatingExpenses,_that.costAndExpenses,_that.interestIncome,_that.interestExpense,_that.depreciationAndAmortization,_that.ebitda,_that.ebit,_that.operatingIncome,_that.totalOtherIncomeExpensesNet,_that.incomeBeforeTax,_that.incomeTaxExpense,_that.netIncome,_that.eps,_that.epsDiluted,_that.weightedAverageShsOut,_that.weightedAverageShsOutDil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String symbol,  String reportedCurrency,  String cik,  String filingDate,  String acceptedDate,  String fiscalYear,  String period,  double? revenue,  double? costOfRevenue,  double? grossProfit,  double? researchAndDevelopmentExpenses,  double? generalAndAdministrativeExpenses,  double? sellingAndMarketingExpenses,  double? sellingGeneralAndAdministrativeExpenses,  double? otherExpenses,  double? operatingExpenses,  double? costAndExpenses,  double? interestIncome,  double? interestExpense,  double? depreciationAndAmortization,  double? ebitda,  double? ebit,  double? operatingIncome,  double? totalOtherIncomeExpensesNet,  double? incomeBeforeTax,  double? incomeTaxExpense,  double? netIncome,  double? eps,  double? epsDiluted,  double? weightedAverageShsOut,  double? weightedAverageShsOutDil)?  $default,) {final _that = this;
switch (_that) {
case _IncomeStatementDto() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.filingDate,_that.acceptedDate,_that.fiscalYear,_that.period,_that.revenue,_that.costOfRevenue,_that.grossProfit,_that.researchAndDevelopmentExpenses,_that.generalAndAdministrativeExpenses,_that.sellingAndMarketingExpenses,_that.sellingGeneralAndAdministrativeExpenses,_that.otherExpenses,_that.operatingExpenses,_that.costAndExpenses,_that.interestIncome,_that.interestExpense,_that.depreciationAndAmortization,_that.ebitda,_that.ebit,_that.operatingIncome,_that.totalOtherIncomeExpensesNet,_that.incomeBeforeTax,_that.incomeTaxExpense,_that.netIncome,_that.eps,_that.epsDiluted,_that.weightedAverageShsOut,_that.weightedAverageShsOutDil);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomeStatementDto implements IncomeStatementDto {
  const _IncomeStatementDto({required this.date, required this.symbol, required this.reportedCurrency, required this.cik, required this.filingDate, required this.acceptedDate, required this.fiscalYear, required this.period, this.revenue, this.costOfRevenue, this.grossProfit, this.researchAndDevelopmentExpenses, this.generalAndAdministrativeExpenses, this.sellingAndMarketingExpenses, this.sellingGeneralAndAdministrativeExpenses, this.otherExpenses, this.operatingExpenses, this.costAndExpenses, this.interestIncome, this.interestExpense, this.depreciationAndAmortization, this.ebitda, this.ebit, this.operatingIncome, this.totalOtherIncomeExpensesNet, this.incomeBeforeTax, this.incomeTaxExpense, this.netIncome, this.eps, this.epsDiluted, this.weightedAverageShsOut, this.weightedAverageShsOutDil});
  factory _IncomeStatementDto.fromJson(Map<String, dynamic> json) => _$IncomeStatementDtoFromJson(json);

@override final  String date;
@override final  String symbol;
@override final  String reportedCurrency;
@override final  String cik;
@override final  String filingDate;
@override final  String acceptedDate;
@override final  String fiscalYear;
@override final  String period;
@override final  double? revenue;
@override final  double? costOfRevenue;
@override final  double? grossProfit;
@override final  double? researchAndDevelopmentExpenses;
@override final  double? generalAndAdministrativeExpenses;
@override final  double? sellingAndMarketingExpenses;
@override final  double? sellingGeneralAndAdministrativeExpenses;
@override final  double? otherExpenses;
@override final  double? operatingExpenses;
@override final  double? costAndExpenses;
@override final  double? interestIncome;
@override final  double? interestExpense;
@override final  double? depreciationAndAmortization;
@override final  double? ebitda;
@override final  double? ebit;
@override final  double? operatingIncome;
@override final  double? totalOtherIncomeExpensesNet;
@override final  double? incomeBeforeTax;
@override final  double? incomeTaxExpense;
@override final  double? netIncome;
@override final  double? eps;
@override final  double? epsDiluted;
@override final  double? weightedAverageShsOut;
@override final  double? weightedAverageShsOutDil;

/// Create a copy of IncomeStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeStatementDtoCopyWith<_IncomeStatementDto> get copyWith => __$IncomeStatementDtoCopyWithImpl<_IncomeStatementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomeStatementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeStatementDto&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.cik, cik) || other.cik == cik)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.acceptedDate, acceptedDate) || other.acceptedDate == acceptedDate)&&(identical(other.fiscalYear, fiscalYear) || other.fiscalYear == fiscalYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.researchAndDevelopmentExpenses, researchAndDevelopmentExpenses) || other.researchAndDevelopmentExpenses == researchAndDevelopmentExpenses)&&(identical(other.generalAndAdministrativeExpenses, generalAndAdministrativeExpenses) || other.generalAndAdministrativeExpenses == generalAndAdministrativeExpenses)&&(identical(other.sellingAndMarketingExpenses, sellingAndMarketingExpenses) || other.sellingAndMarketingExpenses == sellingAndMarketingExpenses)&&(identical(other.sellingGeneralAndAdministrativeExpenses, sellingGeneralAndAdministrativeExpenses) || other.sellingGeneralAndAdministrativeExpenses == sellingGeneralAndAdministrativeExpenses)&&(identical(other.otherExpenses, otherExpenses) || other.otherExpenses == otherExpenses)&&(identical(other.operatingExpenses, operatingExpenses) || other.operatingExpenses == operatingExpenses)&&(identical(other.costAndExpenses, costAndExpenses) || other.costAndExpenses == costAndExpenses)&&(identical(other.interestIncome, interestIncome) || other.interestIncome == interestIncome)&&(identical(other.interestExpense, interestExpense) || other.interestExpense == interestExpense)&&(identical(other.depreciationAndAmortization, depreciationAndAmortization) || other.depreciationAndAmortization == depreciationAndAmortization)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.ebit, ebit) || other.ebit == ebit)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.totalOtherIncomeExpensesNet, totalOtherIncomeExpensesNet) || other.totalOtherIncomeExpensesNet == totalOtherIncomeExpensesNet)&&(identical(other.incomeBeforeTax, incomeBeforeTax) || other.incomeBeforeTax == incomeBeforeTax)&&(identical(other.incomeTaxExpense, incomeTaxExpense) || other.incomeTaxExpense == incomeTaxExpense)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.epsDiluted, epsDiluted) || other.epsDiluted == epsDiluted)&&(identical(other.weightedAverageShsOut, weightedAverageShsOut) || other.weightedAverageShsOut == weightedAverageShsOut)&&(identical(other.weightedAverageShsOutDil, weightedAverageShsOutDil) || other.weightedAverageShsOutDil == weightedAverageShsOutDil));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,symbol,reportedCurrency,cik,filingDate,acceptedDate,fiscalYear,period,revenue,costOfRevenue,grossProfit,researchAndDevelopmentExpenses,generalAndAdministrativeExpenses,sellingAndMarketingExpenses,sellingGeneralAndAdministrativeExpenses,otherExpenses,operatingExpenses,costAndExpenses,interestIncome,interestExpense,depreciationAndAmortization,ebitda,ebit,operatingIncome,totalOtherIncomeExpensesNet,incomeBeforeTax,incomeTaxExpense,netIncome,eps,epsDiluted,weightedAverageShsOut,weightedAverageShsOutDil]);

@override
String toString() {
  return 'IncomeStatementDto(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, cik: $cik, filingDate: $filingDate, acceptedDate: $acceptedDate, fiscalYear: $fiscalYear, period: $period, revenue: $revenue, costOfRevenue: $costOfRevenue, grossProfit: $grossProfit, researchAndDevelopmentExpenses: $researchAndDevelopmentExpenses, generalAndAdministrativeExpenses: $generalAndAdministrativeExpenses, sellingAndMarketingExpenses: $sellingAndMarketingExpenses, sellingGeneralAndAdministrativeExpenses: $sellingGeneralAndAdministrativeExpenses, otherExpenses: $otherExpenses, operatingExpenses: $operatingExpenses, costAndExpenses: $costAndExpenses, interestIncome: $interestIncome, interestExpense: $interestExpense, depreciationAndAmortization: $depreciationAndAmortization, ebitda: $ebitda, ebit: $ebit, operatingIncome: $operatingIncome, totalOtherIncomeExpensesNet: $totalOtherIncomeExpensesNet, incomeBeforeTax: $incomeBeforeTax, incomeTaxExpense: $incomeTaxExpense, netIncome: $netIncome, eps: $eps, epsDiluted: $epsDiluted, weightedAverageShsOut: $weightedAverageShsOut, weightedAverageShsOutDil: $weightedAverageShsOutDil)';
}


}

/// @nodoc
abstract mixin class _$IncomeStatementDtoCopyWith<$Res> implements $IncomeStatementDtoCopyWith<$Res> {
  factory _$IncomeStatementDtoCopyWith(_IncomeStatementDto value, $Res Function(_IncomeStatementDto) _then) = __$IncomeStatementDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String symbol, String reportedCurrency, String cik, String filingDate, String acceptedDate, String fiscalYear, String period, double? revenue, double? costOfRevenue, double? grossProfit, double? researchAndDevelopmentExpenses, double? generalAndAdministrativeExpenses, double? sellingAndMarketingExpenses, double? sellingGeneralAndAdministrativeExpenses, double? otherExpenses, double? operatingExpenses, double? costAndExpenses, double? interestIncome, double? interestExpense, double? depreciationAndAmortization, double? ebitda, double? ebit, double? operatingIncome, double? totalOtherIncomeExpensesNet, double? incomeBeforeTax, double? incomeTaxExpense, double? netIncome, double? eps, double? epsDiluted, double? weightedAverageShsOut, double? weightedAverageShsOutDil
});




}
/// @nodoc
class __$IncomeStatementDtoCopyWithImpl<$Res>
    implements _$IncomeStatementDtoCopyWith<$Res> {
  __$IncomeStatementDtoCopyWithImpl(this._self, this._then);

  final _IncomeStatementDto _self;
  final $Res Function(_IncomeStatementDto) _then;

/// Create a copy of IncomeStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? cik = null,Object? filingDate = null,Object? acceptedDate = null,Object? fiscalYear = null,Object? period = null,Object? revenue = freezed,Object? costOfRevenue = freezed,Object? grossProfit = freezed,Object? researchAndDevelopmentExpenses = freezed,Object? generalAndAdministrativeExpenses = freezed,Object? sellingAndMarketingExpenses = freezed,Object? sellingGeneralAndAdministrativeExpenses = freezed,Object? otherExpenses = freezed,Object? operatingExpenses = freezed,Object? costAndExpenses = freezed,Object? interestIncome = freezed,Object? interestExpense = freezed,Object? depreciationAndAmortization = freezed,Object? ebitda = freezed,Object? ebit = freezed,Object? operatingIncome = freezed,Object? totalOtherIncomeExpensesNet = freezed,Object? incomeBeforeTax = freezed,Object? incomeTaxExpense = freezed,Object? netIncome = freezed,Object? eps = freezed,Object? epsDiluted = freezed,Object? weightedAverageShsOut = freezed,Object? weightedAverageShsOutDil = freezed,}) {
  return _then(_IncomeStatementDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,cik: null == cik ? _self.cik : cik // ignore: cast_nullable_to_non_nullable
as String,filingDate: null == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String,acceptedDate: null == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String,fiscalYear: null == fiscalYear ? _self.fiscalYear : fiscalYear // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,costOfRevenue: freezed == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as double?,grossProfit: freezed == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double?,researchAndDevelopmentExpenses: freezed == researchAndDevelopmentExpenses ? _self.researchAndDevelopmentExpenses : researchAndDevelopmentExpenses // ignore: cast_nullable_to_non_nullable
as double?,generalAndAdministrativeExpenses: freezed == generalAndAdministrativeExpenses ? _self.generalAndAdministrativeExpenses : generalAndAdministrativeExpenses // ignore: cast_nullable_to_non_nullable
as double?,sellingAndMarketingExpenses: freezed == sellingAndMarketingExpenses ? _self.sellingAndMarketingExpenses : sellingAndMarketingExpenses // ignore: cast_nullable_to_non_nullable
as double?,sellingGeneralAndAdministrativeExpenses: freezed == sellingGeneralAndAdministrativeExpenses ? _self.sellingGeneralAndAdministrativeExpenses : sellingGeneralAndAdministrativeExpenses // ignore: cast_nullable_to_non_nullable
as double?,otherExpenses: freezed == otherExpenses ? _self.otherExpenses : otherExpenses // ignore: cast_nullable_to_non_nullable
as double?,operatingExpenses: freezed == operatingExpenses ? _self.operatingExpenses : operatingExpenses // ignore: cast_nullable_to_non_nullable
as double?,costAndExpenses: freezed == costAndExpenses ? _self.costAndExpenses : costAndExpenses // ignore: cast_nullable_to_non_nullable
as double?,interestIncome: freezed == interestIncome ? _self.interestIncome : interestIncome // ignore: cast_nullable_to_non_nullable
as double?,interestExpense: freezed == interestExpense ? _self.interestExpense : interestExpense // ignore: cast_nullable_to_non_nullable
as double?,depreciationAndAmortization: freezed == depreciationAndAmortization ? _self.depreciationAndAmortization : depreciationAndAmortization // ignore: cast_nullable_to_non_nullable
as double?,ebitda: freezed == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double?,ebit: freezed == ebit ? _self.ebit : ebit // ignore: cast_nullable_to_non_nullable
as double?,operatingIncome: freezed == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double?,totalOtherIncomeExpensesNet: freezed == totalOtherIncomeExpensesNet ? _self.totalOtherIncomeExpensesNet : totalOtherIncomeExpensesNet // ignore: cast_nullable_to_non_nullable
as double?,incomeBeforeTax: freezed == incomeBeforeTax ? _self.incomeBeforeTax : incomeBeforeTax // ignore: cast_nullable_to_non_nullable
as double?,incomeTaxExpense: freezed == incomeTaxExpense ? _self.incomeTaxExpense : incomeTaxExpense // ignore: cast_nullable_to_non_nullable
as double?,netIncome: freezed == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,epsDiluted: freezed == epsDiluted ? _self.epsDiluted : epsDiluted // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOut: freezed == weightedAverageShsOut ? _self.weightedAverageShsOut : weightedAverageShsOut // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOutDil: freezed == weightedAverageShsOutDil ? _self.weightedAverageShsOutDil : weightedAverageShsOutDil // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
