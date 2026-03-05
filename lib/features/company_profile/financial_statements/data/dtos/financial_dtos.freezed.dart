// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinancialStatementDto {

 String? get date; String? get symbol; String? get period;// Income
 double? get revenue; double? get netIncome; double? get eps; double? get ebitda; double? get operatingIncome; double? get grossProfit;// Balance Sheet
 double? get totalAssets; double? get totalLiabilities; double? get totalEquity; double? get totalStockholdersEquity; double? get cashAndShortTermInvestments; double? get totalDebt;// Cash Flow
 double? get operatingCashFlow; double? get netCashProvidedByOperatingActivities; double? get investingCashFlow; double? get netCashProvidedByInvestingActivities; double? get financingCashFlow; double? get netCashProvidedByFinancingActivities; double? get capitalExpenditure; double? get freeCashFlow; double? get dividendsPaid; double? get netDividendsPaid; double? get weightedAverageShsOut; String? get link; String? get finalLink;
/// Create a copy of FinancialStatementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialStatementDtoCopyWith<FinancialStatementDto> get copyWith => _$FinancialStatementDtoCopyWithImpl<FinancialStatementDto>(this as FinancialStatementDto, _$identity);

  /// Serializes this FinancialStatementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialStatementDto&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities)&&(identical(other.totalEquity, totalEquity) || other.totalEquity == totalEquity)&&(identical(other.totalStockholdersEquity, totalStockholdersEquity) || other.totalStockholdersEquity == totalStockholdersEquity)&&(identical(other.cashAndShortTermInvestments, cashAndShortTermInvestments) || other.cashAndShortTermInvestments == cashAndShortTermInvestments)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.operatingCashFlow, operatingCashFlow) || other.operatingCashFlow == operatingCashFlow)&&(identical(other.netCashProvidedByOperatingActivities, netCashProvidedByOperatingActivities) || other.netCashProvidedByOperatingActivities == netCashProvidedByOperatingActivities)&&(identical(other.investingCashFlow, investingCashFlow) || other.investingCashFlow == investingCashFlow)&&(identical(other.netCashProvidedByInvestingActivities, netCashProvidedByInvestingActivities) || other.netCashProvidedByInvestingActivities == netCashProvidedByInvestingActivities)&&(identical(other.financingCashFlow, financingCashFlow) || other.financingCashFlow == financingCashFlow)&&(identical(other.netCashProvidedByFinancingActivities, netCashProvidedByFinancingActivities) || other.netCashProvidedByFinancingActivities == netCashProvidedByFinancingActivities)&&(identical(other.capitalExpenditure, capitalExpenditure) || other.capitalExpenditure == capitalExpenditure)&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow)&&(identical(other.dividendsPaid, dividendsPaid) || other.dividendsPaid == dividendsPaid)&&(identical(other.netDividendsPaid, netDividendsPaid) || other.netDividendsPaid == netDividendsPaid)&&(identical(other.weightedAverageShsOut, weightedAverageShsOut) || other.weightedAverageShsOut == weightedAverageShsOut)&&(identical(other.link, link) || other.link == link)&&(identical(other.finalLink, finalLink) || other.finalLink == finalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,symbol,period,revenue,netIncome,eps,ebitda,operatingIncome,grossProfit,totalAssets,totalLiabilities,totalEquity,totalStockholdersEquity,cashAndShortTermInvestments,totalDebt,operatingCashFlow,netCashProvidedByOperatingActivities,investingCashFlow,netCashProvidedByInvestingActivities,financingCashFlow,netCashProvidedByFinancingActivities,capitalExpenditure,freeCashFlow,dividendsPaid,netDividendsPaid,weightedAverageShsOut,link,finalLink]);

@override
String toString() {
  return 'FinancialStatementDto(date: $date, symbol: $symbol, period: $period, revenue: $revenue, netIncome: $netIncome, eps: $eps, ebitda: $ebitda, operatingIncome: $operatingIncome, grossProfit: $grossProfit, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, totalEquity: $totalEquity, totalStockholdersEquity: $totalStockholdersEquity, cashAndShortTermInvestments: $cashAndShortTermInvestments, totalDebt: $totalDebt, operatingCashFlow: $operatingCashFlow, netCashProvidedByOperatingActivities: $netCashProvidedByOperatingActivities, investingCashFlow: $investingCashFlow, netCashProvidedByInvestingActivities: $netCashProvidedByInvestingActivities, financingCashFlow: $financingCashFlow, netCashProvidedByFinancingActivities: $netCashProvidedByFinancingActivities, capitalExpenditure: $capitalExpenditure, freeCashFlow: $freeCashFlow, dividendsPaid: $dividendsPaid, netDividendsPaid: $netDividendsPaid, weightedAverageShsOut: $weightedAverageShsOut, link: $link, finalLink: $finalLink)';
}


}

/// @nodoc
abstract mixin class $FinancialStatementDtoCopyWith<$Res>  {
  factory $FinancialStatementDtoCopyWith(FinancialStatementDto value, $Res Function(FinancialStatementDto) _then) = _$FinancialStatementDtoCopyWithImpl;
@useResult
$Res call({
 String? date, String? symbol, String? period, double? revenue, double? netIncome, double? eps, double? ebitda, double? operatingIncome, double? grossProfit, double? totalAssets, double? totalLiabilities, double? totalEquity, double? totalStockholdersEquity, double? cashAndShortTermInvestments, double? totalDebt, double? operatingCashFlow, double? netCashProvidedByOperatingActivities, double? investingCashFlow, double? netCashProvidedByInvestingActivities, double? financingCashFlow, double? netCashProvidedByFinancingActivities, double? capitalExpenditure, double? freeCashFlow, double? dividendsPaid, double? netDividendsPaid, double? weightedAverageShsOut, String? link, String? finalLink
});




}
/// @nodoc
class _$FinancialStatementDtoCopyWithImpl<$Res>
    implements $FinancialStatementDtoCopyWith<$Res> {
  _$FinancialStatementDtoCopyWithImpl(this._self, this._then);

  final FinancialStatementDto _self;
  final $Res Function(FinancialStatementDto) _then;

/// Create a copy of FinancialStatementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? symbol = freezed,Object? period = freezed,Object? revenue = freezed,Object? netIncome = freezed,Object? eps = freezed,Object? ebitda = freezed,Object? operatingIncome = freezed,Object? grossProfit = freezed,Object? totalAssets = freezed,Object? totalLiabilities = freezed,Object? totalEquity = freezed,Object? totalStockholdersEquity = freezed,Object? cashAndShortTermInvestments = freezed,Object? totalDebt = freezed,Object? operatingCashFlow = freezed,Object? netCashProvidedByOperatingActivities = freezed,Object? investingCashFlow = freezed,Object? netCashProvidedByInvestingActivities = freezed,Object? financingCashFlow = freezed,Object? netCashProvidedByFinancingActivities = freezed,Object? capitalExpenditure = freezed,Object? freeCashFlow = freezed,Object? dividendsPaid = freezed,Object? netDividendsPaid = freezed,Object? weightedAverageShsOut = freezed,Object? link = freezed,Object? finalLink = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,netIncome: freezed == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,ebitda: freezed == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double?,operatingIncome: freezed == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double?,grossProfit: freezed == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double?,totalAssets: freezed == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double?,totalLiabilities: freezed == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalEquity: freezed == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double?,totalStockholdersEquity: freezed == totalStockholdersEquity ? _self.totalStockholdersEquity : totalStockholdersEquity // ignore: cast_nullable_to_non_nullable
as double?,cashAndShortTermInvestments: freezed == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double?,totalDebt: freezed == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double?,operatingCashFlow: freezed == operatingCashFlow ? _self.operatingCashFlow : operatingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByOperatingActivities: freezed == netCashProvidedByOperatingActivities ? _self.netCashProvidedByOperatingActivities : netCashProvidedByOperatingActivities // ignore: cast_nullable_to_non_nullable
as double?,investingCashFlow: freezed == investingCashFlow ? _self.investingCashFlow : investingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByInvestingActivities: freezed == netCashProvidedByInvestingActivities ? _self.netCashProvidedByInvestingActivities : netCashProvidedByInvestingActivities // ignore: cast_nullable_to_non_nullable
as double?,financingCashFlow: freezed == financingCashFlow ? _self.financingCashFlow : financingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByFinancingActivities: freezed == netCashProvidedByFinancingActivities ? _self.netCashProvidedByFinancingActivities : netCashProvidedByFinancingActivities // ignore: cast_nullable_to_non_nullable
as double?,capitalExpenditure: freezed == capitalExpenditure ? _self.capitalExpenditure : capitalExpenditure // ignore: cast_nullable_to_non_nullable
as double?,freeCashFlow: freezed == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double?,dividendsPaid: freezed == dividendsPaid ? _self.dividendsPaid : dividendsPaid // ignore: cast_nullable_to_non_nullable
as double?,netDividendsPaid: freezed == netDividendsPaid ? _self.netDividendsPaid : netDividendsPaid // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOut: freezed == weightedAverageShsOut ? _self.weightedAverageShsOut : weightedAverageShsOut // ignore: cast_nullable_to_non_nullable
as double?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,finalLink: freezed == finalLink ? _self.finalLink : finalLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialStatementDto].
extension FinancialStatementDtoPatterns on FinancialStatementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialStatementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialStatementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialStatementDto value)  $default,){
final _that = this;
switch (_that) {
case _FinancialStatementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialStatementDto value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialStatementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  String? symbol,  String? period,  double? revenue,  double? netIncome,  double? eps,  double? ebitda,  double? operatingIncome,  double? grossProfit,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalStockholdersEquity,  double? cashAndShortTermInvestments,  double? totalDebt,  double? operatingCashFlow,  double? netCashProvidedByOperatingActivities,  double? investingCashFlow,  double? netCashProvidedByInvestingActivities,  double? financingCashFlow,  double? netCashProvidedByFinancingActivities,  double? capitalExpenditure,  double? freeCashFlow,  double? dividendsPaid,  double? netDividendsPaid,  double? weightedAverageShsOut,  String? link,  String? finalLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialStatementDto() when $default != null:
return $default(_that.date,_that.symbol,_that.period,_that.revenue,_that.netIncome,_that.eps,_that.ebitda,_that.operatingIncome,_that.grossProfit,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalStockholdersEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.operatingCashFlow,_that.netCashProvidedByOperatingActivities,_that.investingCashFlow,_that.netCashProvidedByInvestingActivities,_that.financingCashFlow,_that.netCashProvidedByFinancingActivities,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.netDividendsPaid,_that.weightedAverageShsOut,_that.link,_that.finalLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  String? symbol,  String? period,  double? revenue,  double? netIncome,  double? eps,  double? ebitda,  double? operatingIncome,  double? grossProfit,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalStockholdersEquity,  double? cashAndShortTermInvestments,  double? totalDebt,  double? operatingCashFlow,  double? netCashProvidedByOperatingActivities,  double? investingCashFlow,  double? netCashProvidedByInvestingActivities,  double? financingCashFlow,  double? netCashProvidedByFinancingActivities,  double? capitalExpenditure,  double? freeCashFlow,  double? dividendsPaid,  double? netDividendsPaid,  double? weightedAverageShsOut,  String? link,  String? finalLink)  $default,) {final _that = this;
switch (_that) {
case _FinancialStatementDto():
return $default(_that.date,_that.symbol,_that.period,_that.revenue,_that.netIncome,_that.eps,_that.ebitda,_that.operatingIncome,_that.grossProfit,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalStockholdersEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.operatingCashFlow,_that.netCashProvidedByOperatingActivities,_that.investingCashFlow,_that.netCashProvidedByInvestingActivities,_that.financingCashFlow,_that.netCashProvidedByFinancingActivities,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.netDividendsPaid,_that.weightedAverageShsOut,_that.link,_that.finalLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  String? symbol,  String? period,  double? revenue,  double? netIncome,  double? eps,  double? ebitda,  double? operatingIncome,  double? grossProfit,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalStockholdersEquity,  double? cashAndShortTermInvestments,  double? totalDebt,  double? operatingCashFlow,  double? netCashProvidedByOperatingActivities,  double? investingCashFlow,  double? netCashProvidedByInvestingActivities,  double? financingCashFlow,  double? netCashProvidedByFinancingActivities,  double? capitalExpenditure,  double? freeCashFlow,  double? dividendsPaid,  double? netDividendsPaid,  double? weightedAverageShsOut,  String? link,  String? finalLink)?  $default,) {final _that = this;
switch (_that) {
case _FinancialStatementDto() when $default != null:
return $default(_that.date,_that.symbol,_that.period,_that.revenue,_that.netIncome,_that.eps,_that.ebitda,_that.operatingIncome,_that.grossProfit,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalStockholdersEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.operatingCashFlow,_that.netCashProvidedByOperatingActivities,_that.investingCashFlow,_that.netCashProvidedByInvestingActivities,_that.financingCashFlow,_that.netCashProvidedByFinancingActivities,_that.capitalExpenditure,_that.freeCashFlow,_that.dividendsPaid,_that.netDividendsPaid,_that.weightedAverageShsOut,_that.link,_that.finalLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialStatementDto implements FinancialStatementDto {
  const _FinancialStatementDto({this.date, this.symbol, this.period, this.revenue, this.netIncome, this.eps, this.ebitda, this.operatingIncome, this.grossProfit, this.totalAssets, this.totalLiabilities, this.totalEquity, this.totalStockholdersEquity, this.cashAndShortTermInvestments, this.totalDebt, this.operatingCashFlow, this.netCashProvidedByOperatingActivities, this.investingCashFlow, this.netCashProvidedByInvestingActivities, this.financingCashFlow, this.netCashProvidedByFinancingActivities, this.capitalExpenditure, this.freeCashFlow, this.dividendsPaid, this.netDividendsPaid, this.weightedAverageShsOut, this.link, this.finalLink});
  factory _FinancialStatementDto.fromJson(Map<String, dynamic> json) => _$FinancialStatementDtoFromJson(json);

@override final  String? date;
@override final  String? symbol;
@override final  String? period;
// Income
@override final  double? revenue;
@override final  double? netIncome;
@override final  double? eps;
@override final  double? ebitda;
@override final  double? operatingIncome;
@override final  double? grossProfit;
// Balance Sheet
@override final  double? totalAssets;
@override final  double? totalLiabilities;
@override final  double? totalEquity;
@override final  double? totalStockholdersEquity;
@override final  double? cashAndShortTermInvestments;
@override final  double? totalDebt;
// Cash Flow
@override final  double? operatingCashFlow;
@override final  double? netCashProvidedByOperatingActivities;
@override final  double? investingCashFlow;
@override final  double? netCashProvidedByInvestingActivities;
@override final  double? financingCashFlow;
@override final  double? netCashProvidedByFinancingActivities;
@override final  double? capitalExpenditure;
@override final  double? freeCashFlow;
@override final  double? dividendsPaid;
@override final  double? netDividendsPaid;
@override final  double? weightedAverageShsOut;
@override final  String? link;
@override final  String? finalLink;

/// Create a copy of FinancialStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialStatementDtoCopyWith<_FinancialStatementDto> get copyWith => __$FinancialStatementDtoCopyWithImpl<_FinancialStatementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialStatementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialStatementDto&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.period, period) || other.period == period)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.ebitda, ebitda) || other.ebitda == ebitda)&&(identical(other.operatingIncome, operatingIncome) || other.operatingIncome == operatingIncome)&&(identical(other.grossProfit, grossProfit) || other.grossProfit == grossProfit)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities)&&(identical(other.totalEquity, totalEquity) || other.totalEquity == totalEquity)&&(identical(other.totalStockholdersEquity, totalStockholdersEquity) || other.totalStockholdersEquity == totalStockholdersEquity)&&(identical(other.cashAndShortTermInvestments, cashAndShortTermInvestments) || other.cashAndShortTermInvestments == cashAndShortTermInvestments)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.operatingCashFlow, operatingCashFlow) || other.operatingCashFlow == operatingCashFlow)&&(identical(other.netCashProvidedByOperatingActivities, netCashProvidedByOperatingActivities) || other.netCashProvidedByOperatingActivities == netCashProvidedByOperatingActivities)&&(identical(other.investingCashFlow, investingCashFlow) || other.investingCashFlow == investingCashFlow)&&(identical(other.netCashProvidedByInvestingActivities, netCashProvidedByInvestingActivities) || other.netCashProvidedByInvestingActivities == netCashProvidedByInvestingActivities)&&(identical(other.financingCashFlow, financingCashFlow) || other.financingCashFlow == financingCashFlow)&&(identical(other.netCashProvidedByFinancingActivities, netCashProvidedByFinancingActivities) || other.netCashProvidedByFinancingActivities == netCashProvidedByFinancingActivities)&&(identical(other.capitalExpenditure, capitalExpenditure) || other.capitalExpenditure == capitalExpenditure)&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow)&&(identical(other.dividendsPaid, dividendsPaid) || other.dividendsPaid == dividendsPaid)&&(identical(other.netDividendsPaid, netDividendsPaid) || other.netDividendsPaid == netDividendsPaid)&&(identical(other.weightedAverageShsOut, weightedAverageShsOut) || other.weightedAverageShsOut == weightedAverageShsOut)&&(identical(other.link, link) || other.link == link)&&(identical(other.finalLink, finalLink) || other.finalLink == finalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,date,symbol,period,revenue,netIncome,eps,ebitda,operatingIncome,grossProfit,totalAssets,totalLiabilities,totalEquity,totalStockholdersEquity,cashAndShortTermInvestments,totalDebt,operatingCashFlow,netCashProvidedByOperatingActivities,investingCashFlow,netCashProvidedByInvestingActivities,financingCashFlow,netCashProvidedByFinancingActivities,capitalExpenditure,freeCashFlow,dividendsPaid,netDividendsPaid,weightedAverageShsOut,link,finalLink]);

@override
String toString() {
  return 'FinancialStatementDto(date: $date, symbol: $symbol, period: $period, revenue: $revenue, netIncome: $netIncome, eps: $eps, ebitda: $ebitda, operatingIncome: $operatingIncome, grossProfit: $grossProfit, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, totalEquity: $totalEquity, totalStockholdersEquity: $totalStockholdersEquity, cashAndShortTermInvestments: $cashAndShortTermInvestments, totalDebt: $totalDebt, operatingCashFlow: $operatingCashFlow, netCashProvidedByOperatingActivities: $netCashProvidedByOperatingActivities, investingCashFlow: $investingCashFlow, netCashProvidedByInvestingActivities: $netCashProvidedByInvestingActivities, financingCashFlow: $financingCashFlow, netCashProvidedByFinancingActivities: $netCashProvidedByFinancingActivities, capitalExpenditure: $capitalExpenditure, freeCashFlow: $freeCashFlow, dividendsPaid: $dividendsPaid, netDividendsPaid: $netDividendsPaid, weightedAverageShsOut: $weightedAverageShsOut, link: $link, finalLink: $finalLink)';
}


}

/// @nodoc
abstract mixin class _$FinancialStatementDtoCopyWith<$Res> implements $FinancialStatementDtoCopyWith<$Res> {
  factory _$FinancialStatementDtoCopyWith(_FinancialStatementDto value, $Res Function(_FinancialStatementDto) _then) = __$FinancialStatementDtoCopyWithImpl;
@override @useResult
$Res call({
 String? date, String? symbol, String? period, double? revenue, double? netIncome, double? eps, double? ebitda, double? operatingIncome, double? grossProfit, double? totalAssets, double? totalLiabilities, double? totalEquity, double? totalStockholdersEquity, double? cashAndShortTermInvestments, double? totalDebt, double? operatingCashFlow, double? netCashProvidedByOperatingActivities, double? investingCashFlow, double? netCashProvidedByInvestingActivities, double? financingCashFlow, double? netCashProvidedByFinancingActivities, double? capitalExpenditure, double? freeCashFlow, double? dividendsPaid, double? netDividendsPaid, double? weightedAverageShsOut, String? link, String? finalLink
});




}
/// @nodoc
class __$FinancialStatementDtoCopyWithImpl<$Res>
    implements _$FinancialStatementDtoCopyWith<$Res> {
  __$FinancialStatementDtoCopyWithImpl(this._self, this._then);

  final _FinancialStatementDto _self;
  final $Res Function(_FinancialStatementDto) _then;

/// Create a copy of FinancialStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? symbol = freezed,Object? period = freezed,Object? revenue = freezed,Object? netIncome = freezed,Object? eps = freezed,Object? ebitda = freezed,Object? operatingIncome = freezed,Object? grossProfit = freezed,Object? totalAssets = freezed,Object? totalLiabilities = freezed,Object? totalEquity = freezed,Object? totalStockholdersEquity = freezed,Object? cashAndShortTermInvestments = freezed,Object? totalDebt = freezed,Object? operatingCashFlow = freezed,Object? netCashProvidedByOperatingActivities = freezed,Object? investingCashFlow = freezed,Object? netCashProvidedByInvestingActivities = freezed,Object? financingCashFlow = freezed,Object? netCashProvidedByFinancingActivities = freezed,Object? capitalExpenditure = freezed,Object? freeCashFlow = freezed,Object? dividendsPaid = freezed,Object? netDividendsPaid = freezed,Object? weightedAverageShsOut = freezed,Object? link = freezed,Object? finalLink = freezed,}) {
  return _then(_FinancialStatementDto(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,revenue: freezed == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as double?,netIncome: freezed == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as double?,eps: freezed == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as double?,ebitda: freezed == ebitda ? _self.ebitda : ebitda // ignore: cast_nullable_to_non_nullable
as double?,operatingIncome: freezed == operatingIncome ? _self.operatingIncome : operatingIncome // ignore: cast_nullable_to_non_nullable
as double?,grossProfit: freezed == grossProfit ? _self.grossProfit : grossProfit // ignore: cast_nullable_to_non_nullable
as double?,totalAssets: freezed == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double?,totalLiabilities: freezed == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalEquity: freezed == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double?,totalStockholdersEquity: freezed == totalStockholdersEquity ? _self.totalStockholdersEquity : totalStockholdersEquity // ignore: cast_nullable_to_non_nullable
as double?,cashAndShortTermInvestments: freezed == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double?,totalDebt: freezed == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double?,operatingCashFlow: freezed == operatingCashFlow ? _self.operatingCashFlow : operatingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByOperatingActivities: freezed == netCashProvidedByOperatingActivities ? _self.netCashProvidedByOperatingActivities : netCashProvidedByOperatingActivities // ignore: cast_nullable_to_non_nullable
as double?,investingCashFlow: freezed == investingCashFlow ? _self.investingCashFlow : investingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByInvestingActivities: freezed == netCashProvidedByInvestingActivities ? _self.netCashProvidedByInvestingActivities : netCashProvidedByInvestingActivities // ignore: cast_nullable_to_non_nullable
as double?,financingCashFlow: freezed == financingCashFlow ? _self.financingCashFlow : financingCashFlow // ignore: cast_nullable_to_non_nullable
as double?,netCashProvidedByFinancingActivities: freezed == netCashProvidedByFinancingActivities ? _self.netCashProvidedByFinancingActivities : netCashProvidedByFinancingActivities // ignore: cast_nullable_to_non_nullable
as double?,capitalExpenditure: freezed == capitalExpenditure ? _self.capitalExpenditure : capitalExpenditure // ignore: cast_nullable_to_non_nullable
as double?,freeCashFlow: freezed == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as double?,dividendsPaid: freezed == dividendsPaid ? _self.dividendsPaid : dividendsPaid // ignore: cast_nullable_to_non_nullable
as double?,netDividendsPaid: freezed == netDividendsPaid ? _self.netDividendsPaid : netDividendsPaid // ignore: cast_nullable_to_non_nullable
as double?,weightedAverageShsOut: freezed == weightedAverageShsOut ? _self.weightedAverageShsOut : weightedAverageShsOut // ignore: cast_nullable_to_non_nullable
as double?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,finalLink: freezed == finalLink ? _self.finalLink : finalLink // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
