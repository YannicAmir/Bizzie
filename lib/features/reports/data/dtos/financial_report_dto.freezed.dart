// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinancialReportDto {

 String get id;@JsonKey(name: 'summary') ReportSummaryDto get summary;@JsonKey(name: 'balanceSheet') ReportBalanceSheetDto get balanceSheet;@JsonKey(name: 'cashFlow') ReportCashFlowDto get cashFlow;@JsonKey(name: 'income') ReportIncomeDto get income;@JsonKey(name: 'stockActivity') ReportStockActivityDto get stockActivity; String? get filingDate;@TimestampConverter() DateTime? get dateAnalyzed; String? get formType; String? get ticker;
/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialReportDtoCopyWith<FinancialReportDto> get copyWith => _$FinancialReportDtoCopyWithImpl<FinancialReportDto>(this as FinancialReportDto, _$identity);

  /// Serializes this FinancialReportDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.income, income) || other.income == income)&&(identical(other.stockActivity, stockActivity) || other.stockActivity == stockActivity)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.dateAnalyzed, dateAnalyzed) || other.dateAnalyzed == dateAnalyzed)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,summary,balanceSheet,cashFlow,income,stockActivity,filingDate,dateAnalyzed,formType,ticker);

@override
String toString() {
  return 'FinancialReportDto(id: $id, summary: $summary, balanceSheet: $balanceSheet, cashFlow: $cashFlow, income: $income, stockActivity: $stockActivity, filingDate: $filingDate, dateAnalyzed: $dateAnalyzed, formType: $formType, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class $FinancialReportDtoCopyWith<$Res>  {
  factory $FinancialReportDtoCopyWith(FinancialReportDto value, $Res Function(FinancialReportDto) _then) = _$FinancialReportDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'summary') ReportSummaryDto summary,@JsonKey(name: 'balanceSheet') ReportBalanceSheetDto balanceSheet,@JsonKey(name: 'cashFlow') ReportCashFlowDto cashFlow,@JsonKey(name: 'income') ReportIncomeDto income,@JsonKey(name: 'stockActivity') ReportStockActivityDto stockActivity, String? filingDate,@TimestampConverter() DateTime? dateAnalyzed, String? formType, String? ticker
});


$ReportSummaryDtoCopyWith<$Res> get summary;$ReportBalanceSheetDtoCopyWith<$Res> get balanceSheet;$ReportCashFlowDtoCopyWith<$Res> get cashFlow;$ReportIncomeDtoCopyWith<$Res> get income;$ReportStockActivityDtoCopyWith<$Res> get stockActivity;

}
/// @nodoc
class _$FinancialReportDtoCopyWithImpl<$Res>
    implements $FinancialReportDtoCopyWith<$Res> {
  _$FinancialReportDtoCopyWithImpl(this._self, this._then);

  final FinancialReportDto _self;
  final $Res Function(FinancialReportDto) _then;

/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? summary = null,Object? balanceSheet = null,Object? cashFlow = null,Object? income = null,Object? stockActivity = null,Object? filingDate = freezed,Object? dateAnalyzed = freezed,Object? formType = freezed,Object? ticker = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ReportSummaryDto,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as ReportBalanceSheetDto,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as ReportCashFlowDto,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as ReportIncomeDto,stockActivity: null == stockActivity ? _self.stockActivity : stockActivity // ignore: cast_nullable_to_non_nullable
as ReportStockActivityDto,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String?,dateAnalyzed: freezed == dateAnalyzed ? _self.dateAnalyzed : dateAnalyzed // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportSummaryDtoCopyWith<$Res> get summary {
  
  return $ReportSummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportBalanceSheetDtoCopyWith<$Res> get balanceSheet {
  
  return $ReportBalanceSheetDtoCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportCashFlowDtoCopyWith<$Res> get cashFlow {
  
  return $ReportCashFlowDtoCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportIncomeDtoCopyWith<$Res> get income {
  
  return $ReportIncomeDtoCopyWith<$Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportStockActivityDtoCopyWith<$Res> get stockActivity {
  
  return $ReportStockActivityDtoCopyWith<$Res>(_self.stockActivity, (value) {
    return _then(_self.copyWith(stockActivity: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialReportDto].
extension FinancialReportDtoPatterns on FinancialReportDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialReportDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialReportDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialReportDto value)  $default,){
final _that = this;
switch (_that) {
case _FinancialReportDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialReportDto value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialReportDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'summary')  ReportSummaryDto summary, @JsonKey(name: 'balanceSheet')  ReportBalanceSheetDto balanceSheet, @JsonKey(name: 'cashFlow')  ReportCashFlowDto cashFlow, @JsonKey(name: 'income')  ReportIncomeDto income, @JsonKey(name: 'stockActivity')  ReportStockActivityDto stockActivity,  String? filingDate, @TimestampConverter()  DateTime? dateAnalyzed,  String? formType,  String? ticker)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialReportDto() when $default != null:
return $default(_that.id,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity,_that.filingDate,_that.dateAnalyzed,_that.formType,_that.ticker);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'summary')  ReportSummaryDto summary, @JsonKey(name: 'balanceSheet')  ReportBalanceSheetDto balanceSheet, @JsonKey(name: 'cashFlow')  ReportCashFlowDto cashFlow, @JsonKey(name: 'income')  ReportIncomeDto income, @JsonKey(name: 'stockActivity')  ReportStockActivityDto stockActivity,  String? filingDate, @TimestampConverter()  DateTime? dateAnalyzed,  String? formType,  String? ticker)  $default,) {final _that = this;
switch (_that) {
case _FinancialReportDto():
return $default(_that.id,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity,_that.filingDate,_that.dateAnalyzed,_that.formType,_that.ticker);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'summary')  ReportSummaryDto summary, @JsonKey(name: 'balanceSheet')  ReportBalanceSheetDto balanceSheet, @JsonKey(name: 'cashFlow')  ReportCashFlowDto cashFlow, @JsonKey(name: 'income')  ReportIncomeDto income, @JsonKey(name: 'stockActivity')  ReportStockActivityDto stockActivity,  String? filingDate, @TimestampConverter()  DateTime? dateAnalyzed,  String? formType,  String? ticker)?  $default,) {final _that = this;
switch (_that) {
case _FinancialReportDto() when $default != null:
return $default(_that.id,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity,_that.filingDate,_that.dateAnalyzed,_that.formType,_that.ticker);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialReportDto extends FinancialReportDto {
  const _FinancialReportDto({required this.id, @JsonKey(name: 'summary') required this.summary, @JsonKey(name: 'balanceSheet') required this.balanceSheet, @JsonKey(name: 'cashFlow') required this.cashFlow, @JsonKey(name: 'income') required this.income, @JsonKey(name: 'stockActivity') required this.stockActivity, this.filingDate, @TimestampConverter() this.dateAnalyzed, this.formType, this.ticker}): super._();
  factory _FinancialReportDto.fromJson(Map<String, dynamic> json) => _$FinancialReportDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'summary') final  ReportSummaryDto summary;
@override@JsonKey(name: 'balanceSheet') final  ReportBalanceSheetDto balanceSheet;
@override@JsonKey(name: 'cashFlow') final  ReportCashFlowDto cashFlow;
@override@JsonKey(name: 'income') final  ReportIncomeDto income;
@override@JsonKey(name: 'stockActivity') final  ReportStockActivityDto stockActivity;
@override final  String? filingDate;
@override@TimestampConverter() final  DateTime? dateAnalyzed;
@override final  String? formType;
@override final  String? ticker;

/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialReportDtoCopyWith<_FinancialReportDto> get copyWith => __$FinancialReportDtoCopyWithImpl<_FinancialReportDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialReportDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialReportDto&&(identical(other.id, id) || other.id == id)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.income, income) || other.income == income)&&(identical(other.stockActivity, stockActivity) || other.stockActivity == stockActivity)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.dateAnalyzed, dateAnalyzed) || other.dateAnalyzed == dateAnalyzed)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.ticker, ticker) || other.ticker == ticker));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,summary,balanceSheet,cashFlow,income,stockActivity,filingDate,dateAnalyzed,formType,ticker);

@override
String toString() {
  return 'FinancialReportDto(id: $id, summary: $summary, balanceSheet: $balanceSheet, cashFlow: $cashFlow, income: $income, stockActivity: $stockActivity, filingDate: $filingDate, dateAnalyzed: $dateAnalyzed, formType: $formType, ticker: $ticker)';
}


}

/// @nodoc
abstract mixin class _$FinancialReportDtoCopyWith<$Res> implements $FinancialReportDtoCopyWith<$Res> {
  factory _$FinancialReportDtoCopyWith(_FinancialReportDto value, $Res Function(_FinancialReportDto) _then) = __$FinancialReportDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'summary') ReportSummaryDto summary,@JsonKey(name: 'balanceSheet') ReportBalanceSheetDto balanceSheet,@JsonKey(name: 'cashFlow') ReportCashFlowDto cashFlow,@JsonKey(name: 'income') ReportIncomeDto income,@JsonKey(name: 'stockActivity') ReportStockActivityDto stockActivity, String? filingDate,@TimestampConverter() DateTime? dateAnalyzed, String? formType, String? ticker
});


@override $ReportSummaryDtoCopyWith<$Res> get summary;@override $ReportBalanceSheetDtoCopyWith<$Res> get balanceSheet;@override $ReportCashFlowDtoCopyWith<$Res> get cashFlow;@override $ReportIncomeDtoCopyWith<$Res> get income;@override $ReportStockActivityDtoCopyWith<$Res> get stockActivity;

}
/// @nodoc
class __$FinancialReportDtoCopyWithImpl<$Res>
    implements _$FinancialReportDtoCopyWith<$Res> {
  __$FinancialReportDtoCopyWithImpl(this._self, this._then);

  final _FinancialReportDto _self;
  final $Res Function(_FinancialReportDto) _then;

/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? summary = null,Object? balanceSheet = null,Object? cashFlow = null,Object? income = null,Object? stockActivity = null,Object? filingDate = freezed,Object? dateAnalyzed = freezed,Object? formType = freezed,Object? ticker = freezed,}) {
  return _then(_FinancialReportDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ReportSummaryDto,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as ReportBalanceSheetDto,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as ReportCashFlowDto,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as ReportIncomeDto,stockActivity: null == stockActivity ? _self.stockActivity : stockActivity // ignore: cast_nullable_to_non_nullable
as ReportStockActivityDto,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as String?,dateAnalyzed: freezed == dateAnalyzed ? _self.dateAnalyzed : dateAnalyzed // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: freezed == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String?,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportSummaryDtoCopyWith<$Res> get summary {
  
  return $ReportSummaryDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportBalanceSheetDtoCopyWith<$Res> get balanceSheet {
  
  return $ReportBalanceSheetDtoCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportCashFlowDtoCopyWith<$Res> get cashFlow {
  
  return $ReportCashFlowDtoCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportIncomeDtoCopyWith<$Res> get income {
  
  return $ReportIncomeDtoCopyWith<$Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialReportDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportStockActivityDtoCopyWith<$Res> get stockActivity {
  
  return $ReportStockActivityDtoCopyWith<$Res>(_self.stockActivity, (value) {
    return _then(_self.copyWith(stockActivity: value));
  });
}
}


/// @nodoc
mixin _$ReportSummaryDto {

 String get ticker; String get forwardLooking; int get citationPage; String get reportingCurrency;
/// Create a copy of ReportSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSummaryDtoCopyWith<ReportSummaryDto> get copyWith => _$ReportSummaryDtoCopyWithImpl<ReportSummaryDto>(this as ReportSummaryDto, _$identity);

  /// Serializes this ReportSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSummaryDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forwardLooking, forwardLooking) || other.forwardLooking == forwardLooking)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.reportingCurrency, reportingCurrency) || other.reportingCurrency == reportingCurrency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,forwardLooking,citationPage,reportingCurrency);

@override
String toString() {
  return 'ReportSummaryDto(ticker: $ticker, forwardLooking: $forwardLooking, citationPage: $citationPage, reportingCurrency: $reportingCurrency)';
}


}

/// @nodoc
abstract mixin class $ReportSummaryDtoCopyWith<$Res>  {
  factory $ReportSummaryDtoCopyWith(ReportSummaryDto value, $Res Function(ReportSummaryDto) _then) = _$ReportSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String ticker, String forwardLooking, int citationPage, String reportingCurrency
});




}
/// @nodoc
class _$ReportSummaryDtoCopyWithImpl<$Res>
    implements $ReportSummaryDtoCopyWith<$Res> {
  _$ReportSummaryDtoCopyWithImpl(this._self, this._then);

  final ReportSummaryDto _self;
  final $Res Function(ReportSummaryDto) _then;

/// Create a copy of ReportSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticker = null,Object? forwardLooking = null,Object? citationPage = null,Object? reportingCurrency = null,}) {
  return _then(_self.copyWith(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forwardLooking: null == forwardLooking ? _self.forwardLooking : forwardLooking // ignore: cast_nullable_to_non_nullable
as String,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,reportingCurrency: null == reportingCurrency ? _self.reportingCurrency : reportingCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportSummaryDto].
extension ReportSummaryDtoPatterns on ReportSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticker,  String forwardLooking,  int citationPage,  String reportingCurrency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportSummaryDto() when $default != null:
return $default(_that.ticker,_that.forwardLooking,_that.citationPage,_that.reportingCurrency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticker,  String forwardLooking,  int citationPage,  String reportingCurrency)  $default,) {final _that = this;
switch (_that) {
case _ReportSummaryDto():
return $default(_that.ticker,_that.forwardLooking,_that.citationPage,_that.reportingCurrency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticker,  String forwardLooking,  int citationPage,  String reportingCurrency)?  $default,) {final _that = this;
switch (_that) {
case _ReportSummaryDto() when $default != null:
return $default(_that.ticker,_that.forwardLooking,_that.citationPage,_that.reportingCurrency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportSummaryDto extends ReportSummaryDto {
  const _ReportSummaryDto({this.ticker = '', this.forwardLooking = '', this.citationPage = 0, this.reportingCurrency = 'USD'}): super._();
  factory _ReportSummaryDto.fromJson(Map<String, dynamic> json) => _$ReportSummaryDtoFromJson(json);

@override@JsonKey() final  String ticker;
@override@JsonKey() final  String forwardLooking;
@override@JsonKey() final  int citationPage;
@override@JsonKey() final  String reportingCurrency;

/// Create a copy of ReportSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSummaryDtoCopyWith<_ReportSummaryDto> get copyWith => __$ReportSummaryDtoCopyWithImpl<_ReportSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSummaryDto&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forwardLooking, forwardLooking) || other.forwardLooking == forwardLooking)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.reportingCurrency, reportingCurrency) || other.reportingCurrency == reportingCurrency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ticker,forwardLooking,citationPage,reportingCurrency);

@override
String toString() {
  return 'ReportSummaryDto(ticker: $ticker, forwardLooking: $forwardLooking, citationPage: $citationPage, reportingCurrency: $reportingCurrency)';
}


}

/// @nodoc
abstract mixin class _$ReportSummaryDtoCopyWith<$Res> implements $ReportSummaryDtoCopyWith<$Res> {
  factory _$ReportSummaryDtoCopyWith(_ReportSummaryDto value, $Res Function(_ReportSummaryDto) _then) = __$ReportSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String forwardLooking, int citationPage, String reportingCurrency
});




}
/// @nodoc
class __$ReportSummaryDtoCopyWithImpl<$Res>
    implements _$ReportSummaryDtoCopyWith<$Res> {
  __$ReportSummaryDtoCopyWithImpl(this._self, this._then);

  final _ReportSummaryDto _self;
  final $Res Function(_ReportSummaryDto) _then;

/// Create a copy of ReportSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forwardLooking = null,Object? citationPage = null,Object? reportingCurrency = null,}) {
  return _then(_ReportSummaryDto(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forwardLooking: null == forwardLooking ? _self.forwardLooking : forwardLooking // ignore: cast_nullable_to_non_nullable
as String,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,reportingCurrency: null == reportingCurrency ? _self.reportingCurrency : reportingCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReportBalanceSheetDto {

 FinancialMetricDto get equity; FinancialMetricDto get totalAssets; FinancialMetricDto get totalLiabilities;
/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportBalanceSheetDtoCopyWith<ReportBalanceSheetDto> get copyWith => _$ReportBalanceSheetDtoCopyWithImpl<ReportBalanceSheetDto>(this as ReportBalanceSheetDto, _$identity);

  /// Serializes this ReportBalanceSheetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportBalanceSheetDto&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,equity,totalAssets,totalLiabilities);

@override
String toString() {
  return 'ReportBalanceSheetDto(equity: $equity, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities)';
}


}

/// @nodoc
abstract mixin class $ReportBalanceSheetDtoCopyWith<$Res>  {
  factory $ReportBalanceSheetDtoCopyWith(ReportBalanceSheetDto value, $Res Function(ReportBalanceSheetDto) _then) = _$ReportBalanceSheetDtoCopyWithImpl;
@useResult
$Res call({
 FinancialMetricDto equity, FinancialMetricDto totalAssets, FinancialMetricDto totalLiabilities
});


$FinancialMetricDtoCopyWith<$Res> get equity;$FinancialMetricDtoCopyWith<$Res> get totalAssets;$FinancialMetricDtoCopyWith<$Res> get totalLiabilities;

}
/// @nodoc
class _$ReportBalanceSheetDtoCopyWithImpl<$Res>
    implements $ReportBalanceSheetDtoCopyWith<$Res> {
  _$ReportBalanceSheetDtoCopyWithImpl(this._self, this._then);

  final ReportBalanceSheetDto _self;
  final $Res Function(ReportBalanceSheetDto) _then;

/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equity = null,Object? totalAssets = null,Object? totalLiabilities = null,}) {
  return _then(_self.copyWith(
equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,
  ));
}
/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get equity {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.equity, (value) {
    return _then(_self.copyWith(equity: value));
  });
}/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get totalAssets {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.totalAssets, (value) {
    return _then(_self.copyWith(totalAssets: value));
  });
}/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get totalLiabilities {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.totalLiabilities, (value) {
    return _then(_self.copyWith(totalLiabilities: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportBalanceSheetDto].
extension ReportBalanceSheetDtoPatterns on ReportBalanceSheetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportBalanceSheetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportBalanceSheetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportBalanceSheetDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportBalanceSheetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportBalanceSheetDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportBalanceSheetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetricDto equity,  FinancialMetricDto totalAssets,  FinancialMetricDto totalLiabilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportBalanceSheetDto() when $default != null:
return $default(_that.equity,_that.totalAssets,_that.totalLiabilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetricDto equity,  FinancialMetricDto totalAssets,  FinancialMetricDto totalLiabilities)  $default,) {final _that = this;
switch (_that) {
case _ReportBalanceSheetDto():
return $default(_that.equity,_that.totalAssets,_that.totalLiabilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetricDto equity,  FinancialMetricDto totalAssets,  FinancialMetricDto totalLiabilities)?  $default,) {final _that = this;
switch (_that) {
case _ReportBalanceSheetDto() when $default != null:
return $default(_that.equity,_that.totalAssets,_that.totalLiabilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportBalanceSheetDto extends ReportBalanceSheetDto {
  const _ReportBalanceSheetDto({required this.equity, required this.totalAssets, required this.totalLiabilities}): super._();
  factory _ReportBalanceSheetDto.fromJson(Map<String, dynamic> json) => _$ReportBalanceSheetDtoFromJson(json);

@override final  FinancialMetricDto equity;
@override final  FinancialMetricDto totalAssets;
@override final  FinancialMetricDto totalLiabilities;

/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportBalanceSheetDtoCopyWith<_ReportBalanceSheetDto> get copyWith => __$ReportBalanceSheetDtoCopyWithImpl<_ReportBalanceSheetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportBalanceSheetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportBalanceSheetDto&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,equity,totalAssets,totalLiabilities);

@override
String toString() {
  return 'ReportBalanceSheetDto(equity: $equity, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities)';
}


}

/// @nodoc
abstract mixin class _$ReportBalanceSheetDtoCopyWith<$Res> implements $ReportBalanceSheetDtoCopyWith<$Res> {
  factory _$ReportBalanceSheetDtoCopyWith(_ReportBalanceSheetDto value, $Res Function(_ReportBalanceSheetDto) _then) = __$ReportBalanceSheetDtoCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetricDto equity, FinancialMetricDto totalAssets, FinancialMetricDto totalLiabilities
});


@override $FinancialMetricDtoCopyWith<$Res> get equity;@override $FinancialMetricDtoCopyWith<$Res> get totalAssets;@override $FinancialMetricDtoCopyWith<$Res> get totalLiabilities;

}
/// @nodoc
class __$ReportBalanceSheetDtoCopyWithImpl<$Res>
    implements _$ReportBalanceSheetDtoCopyWith<$Res> {
  __$ReportBalanceSheetDtoCopyWithImpl(this._self, this._then);

  final _ReportBalanceSheetDto _self;
  final $Res Function(_ReportBalanceSheetDto) _then;

/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equity = null,Object? totalAssets = null,Object? totalLiabilities = null,}) {
  return _then(_ReportBalanceSheetDto(
equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,
  ));
}

/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get equity {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.equity, (value) {
    return _then(_self.copyWith(equity: value));
  });
}/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get totalAssets {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.totalAssets, (value) {
    return _then(_self.copyWith(totalAssets: value));
  });
}/// Create a copy of ReportBalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get totalLiabilities {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.totalLiabilities, (value) {
    return _then(_self.copyWith(totalLiabilities: value));
  });
}
}


/// @nodoc
mixin _$ReportCashFlowDto {

 FinancialMetricWithDriverDto get freeCashFlow;
/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCashFlowDtoCopyWith<ReportCashFlowDto> get copyWith => _$ReportCashFlowDtoCopyWithImpl<ReportCashFlowDto>(this as ReportCashFlowDto, _$identity);

  /// Serializes this ReportCashFlowDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportCashFlowDto&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,freeCashFlow);

@override
String toString() {
  return 'ReportCashFlowDto(freeCashFlow: $freeCashFlow)';
}


}

/// @nodoc
abstract mixin class $ReportCashFlowDtoCopyWith<$Res>  {
  factory $ReportCashFlowDtoCopyWith(ReportCashFlowDto value, $Res Function(ReportCashFlowDto) _then) = _$ReportCashFlowDtoCopyWithImpl;
@useResult
$Res call({
 FinancialMetricWithDriverDto freeCashFlow
});


$FinancialMetricWithDriverDtoCopyWith<$Res> get freeCashFlow;

}
/// @nodoc
class _$ReportCashFlowDtoCopyWithImpl<$Res>
    implements $ReportCashFlowDtoCopyWith<$Res> {
  _$ReportCashFlowDtoCopyWithImpl(this._self, this._then);

  final ReportCashFlowDto _self;
  final $Res Function(ReportCashFlowDto) _then;

/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? freeCashFlow = null,}) {
  return _then(_self.copyWith(
freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,
  ));
}
/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get freeCashFlow {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.freeCashFlow, (value) {
    return _then(_self.copyWith(freeCashFlow: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportCashFlowDto].
extension ReportCashFlowDtoPatterns on ReportCashFlowDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportCashFlowDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportCashFlowDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportCashFlowDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportCashFlowDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportCashFlowDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportCashFlowDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetricWithDriverDto freeCashFlow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportCashFlowDto() when $default != null:
return $default(_that.freeCashFlow);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetricWithDriverDto freeCashFlow)  $default,) {final _that = this;
switch (_that) {
case _ReportCashFlowDto():
return $default(_that.freeCashFlow);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetricWithDriverDto freeCashFlow)?  $default,) {final _that = this;
switch (_that) {
case _ReportCashFlowDto() when $default != null:
return $default(_that.freeCashFlow);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportCashFlowDto extends ReportCashFlowDto {
  const _ReportCashFlowDto({required this.freeCashFlow}): super._();
  factory _ReportCashFlowDto.fromJson(Map<String, dynamic> json) => _$ReportCashFlowDtoFromJson(json);

@override final  FinancialMetricWithDriverDto freeCashFlow;

/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCashFlowDtoCopyWith<_ReportCashFlowDto> get copyWith => __$ReportCashFlowDtoCopyWithImpl<_ReportCashFlowDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportCashFlowDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportCashFlowDto&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,freeCashFlow);

@override
String toString() {
  return 'ReportCashFlowDto(freeCashFlow: $freeCashFlow)';
}


}

/// @nodoc
abstract mixin class _$ReportCashFlowDtoCopyWith<$Res> implements $ReportCashFlowDtoCopyWith<$Res> {
  factory _$ReportCashFlowDtoCopyWith(_ReportCashFlowDto value, $Res Function(_ReportCashFlowDto) _then) = __$ReportCashFlowDtoCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetricWithDriverDto freeCashFlow
});


@override $FinancialMetricWithDriverDtoCopyWith<$Res> get freeCashFlow;

}
/// @nodoc
class __$ReportCashFlowDtoCopyWithImpl<$Res>
    implements _$ReportCashFlowDtoCopyWith<$Res> {
  __$ReportCashFlowDtoCopyWithImpl(this._self, this._then);

  final _ReportCashFlowDto _self;
  final $Res Function(_ReportCashFlowDto) _then;

/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? freeCashFlow = null,}) {
  return _then(_ReportCashFlowDto(
freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,
  ));
}

/// Create a copy of ReportCashFlowDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get freeCashFlow {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.freeCashFlow, (value) {
    return _then(_self.copyWith(freeCashFlow: value));
  });
}
}


/// @nodoc
mixin _$ReportIncomeDto {

 FinancialMetricDto get costOfRevenue; FinancialMetricDto get eps; FinancialMetricWithDriverDto get netIncome; FinancialMetricWithDriverDto get revenue; FinancialMetricWithDriverDto get totalExpenses;
/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportIncomeDtoCopyWith<ReportIncomeDto> get copyWith => _$ReportIncomeDtoCopyWithImpl<ReportIncomeDto>(this as ReportIncomeDto, _$identity);

  /// Serializes this ReportIncomeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportIncomeDto&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,costOfRevenue,eps,netIncome,revenue,totalExpenses);

@override
String toString() {
  return 'ReportIncomeDto(costOfRevenue: $costOfRevenue, eps: $eps, netIncome: $netIncome, revenue: $revenue, totalExpenses: $totalExpenses)';
}


}

/// @nodoc
abstract mixin class $ReportIncomeDtoCopyWith<$Res>  {
  factory $ReportIncomeDtoCopyWith(ReportIncomeDto value, $Res Function(ReportIncomeDto) _then) = _$ReportIncomeDtoCopyWithImpl;
@useResult
$Res call({
 FinancialMetricDto costOfRevenue, FinancialMetricDto eps, FinancialMetricWithDriverDto netIncome, FinancialMetricWithDriverDto revenue, FinancialMetricWithDriverDto totalExpenses
});


$FinancialMetricDtoCopyWith<$Res> get costOfRevenue;$FinancialMetricDtoCopyWith<$Res> get eps;$FinancialMetricWithDriverDtoCopyWith<$Res> get netIncome;$FinancialMetricWithDriverDtoCopyWith<$Res> get revenue;$FinancialMetricWithDriverDtoCopyWith<$Res> get totalExpenses;

}
/// @nodoc
class _$ReportIncomeDtoCopyWithImpl<$Res>
    implements $ReportIncomeDtoCopyWith<$Res> {
  _$ReportIncomeDtoCopyWithImpl(this._self, this._then);

  final ReportIncomeDto _self;
  final $Res Function(ReportIncomeDto) _then;

/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? costOfRevenue = null,Object? eps = null,Object? netIncome = null,Object? revenue = null,Object? totalExpenses = null,}) {
  return _then(_self.copyWith(
costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,
  ));
}
/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get costOfRevenue {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.costOfRevenue, (value) {
    return _then(_self.copyWith(costOfRevenue: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get eps {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.eps, (value) {
    return _then(_self.copyWith(eps: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get netIncome {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.netIncome, (value) {
    return _then(_self.copyWith(netIncome: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get revenue {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get totalExpenses {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportIncomeDto].
extension ReportIncomeDtoPatterns on ReportIncomeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportIncomeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportIncomeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportIncomeDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportIncomeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportIncomeDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportIncomeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetricDto costOfRevenue,  FinancialMetricDto eps,  FinancialMetricWithDriverDto netIncome,  FinancialMetricWithDriverDto revenue,  FinancialMetricWithDriverDto totalExpenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportIncomeDto() when $default != null:
return $default(_that.costOfRevenue,_that.eps,_that.netIncome,_that.revenue,_that.totalExpenses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetricDto costOfRevenue,  FinancialMetricDto eps,  FinancialMetricWithDriverDto netIncome,  FinancialMetricWithDriverDto revenue,  FinancialMetricWithDriverDto totalExpenses)  $default,) {final _that = this;
switch (_that) {
case _ReportIncomeDto():
return $default(_that.costOfRevenue,_that.eps,_that.netIncome,_that.revenue,_that.totalExpenses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetricDto costOfRevenue,  FinancialMetricDto eps,  FinancialMetricWithDriverDto netIncome,  FinancialMetricWithDriverDto revenue,  FinancialMetricWithDriverDto totalExpenses)?  $default,) {final _that = this;
switch (_that) {
case _ReportIncomeDto() when $default != null:
return $default(_that.costOfRevenue,_that.eps,_that.netIncome,_that.revenue,_that.totalExpenses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportIncomeDto extends ReportIncomeDto {
  const _ReportIncomeDto({required this.costOfRevenue, required this.eps, required this.netIncome, required this.revenue, required this.totalExpenses}): super._();
  factory _ReportIncomeDto.fromJson(Map<String, dynamic> json) => _$ReportIncomeDtoFromJson(json);

@override final  FinancialMetricDto costOfRevenue;
@override final  FinancialMetricDto eps;
@override final  FinancialMetricWithDriverDto netIncome;
@override final  FinancialMetricWithDriverDto revenue;
@override final  FinancialMetricWithDriverDto totalExpenses;

/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportIncomeDtoCopyWith<_ReportIncomeDto> get copyWith => __$ReportIncomeDtoCopyWithImpl<_ReportIncomeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportIncomeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportIncomeDto&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,costOfRevenue,eps,netIncome,revenue,totalExpenses);

@override
String toString() {
  return 'ReportIncomeDto(costOfRevenue: $costOfRevenue, eps: $eps, netIncome: $netIncome, revenue: $revenue, totalExpenses: $totalExpenses)';
}


}

/// @nodoc
abstract mixin class _$ReportIncomeDtoCopyWith<$Res> implements $ReportIncomeDtoCopyWith<$Res> {
  factory _$ReportIncomeDtoCopyWith(_ReportIncomeDto value, $Res Function(_ReportIncomeDto) _then) = __$ReportIncomeDtoCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetricDto costOfRevenue, FinancialMetricDto eps, FinancialMetricWithDriverDto netIncome, FinancialMetricWithDriverDto revenue, FinancialMetricWithDriverDto totalExpenses
});


@override $FinancialMetricDtoCopyWith<$Res> get costOfRevenue;@override $FinancialMetricDtoCopyWith<$Res> get eps;@override $FinancialMetricWithDriverDtoCopyWith<$Res> get netIncome;@override $FinancialMetricWithDriverDtoCopyWith<$Res> get revenue;@override $FinancialMetricWithDriverDtoCopyWith<$Res> get totalExpenses;

}
/// @nodoc
class __$ReportIncomeDtoCopyWithImpl<$Res>
    implements _$ReportIncomeDtoCopyWith<$Res> {
  __$ReportIncomeDtoCopyWithImpl(this._self, this._then);

  final _ReportIncomeDto _self;
  final $Res Function(_ReportIncomeDto) _then;

/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? costOfRevenue = null,Object? eps = null,Object? netIncome = null,Object? revenue = null,Object? totalExpenses = null,}) {
  return _then(_ReportIncomeDto(
costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as FinancialMetricDto,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriverDto,
  ));
}

/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get costOfRevenue {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.costOfRevenue, (value) {
    return _then(_self.copyWith(costOfRevenue: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<$Res> get eps {
  
  return $FinancialMetricDtoCopyWith<$Res>(_self.eps, (value) {
    return _then(_self.copyWith(eps: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get netIncome {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.netIncome, (value) {
    return _then(_self.copyWith(netIncome: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get revenue {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ReportIncomeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<$Res> get totalExpenses {
  
  return $FinancialMetricWithDriverDtoCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}
}


/// @nodoc
mixin _$ReportStockActivityDto {

 int get citationPage;@ForceDoubleNullable() double? get issuedShares;@ForceDoubleNullable() double? get netStockChangeShares;@ForceDoubleNullable() double? get repurchasedShares;
/// Create a copy of ReportStockActivityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportStockActivityDtoCopyWith<ReportStockActivityDto> get copyWith => _$ReportStockActivityDtoCopyWithImpl<ReportStockActivityDto>(this as ReportStockActivityDto, _$identity);

  /// Serializes this ReportStockActivityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportStockActivityDto&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.issuedShares, issuedShares) || other.issuedShares == issuedShares)&&(identical(other.netStockChangeShares, netStockChangeShares) || other.netStockChangeShares == netStockChangeShares)&&(identical(other.repurchasedShares, repurchasedShares) || other.repurchasedShares == repurchasedShares));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,citationPage,issuedShares,netStockChangeShares,repurchasedShares);

@override
String toString() {
  return 'ReportStockActivityDto(citationPage: $citationPage, issuedShares: $issuedShares, netStockChangeShares: $netStockChangeShares, repurchasedShares: $repurchasedShares)';
}


}

/// @nodoc
abstract mixin class $ReportStockActivityDtoCopyWith<$Res>  {
  factory $ReportStockActivityDtoCopyWith(ReportStockActivityDto value, $Res Function(ReportStockActivityDto) _then) = _$ReportStockActivityDtoCopyWithImpl;
@useResult
$Res call({
 int citationPage,@ForceDoubleNullable() double? issuedShares,@ForceDoubleNullable() double? netStockChangeShares,@ForceDoubleNullable() double? repurchasedShares
});




}
/// @nodoc
class _$ReportStockActivityDtoCopyWithImpl<$Res>
    implements $ReportStockActivityDtoCopyWith<$Res> {
  _$ReportStockActivityDtoCopyWithImpl(this._self, this._then);

  final ReportStockActivityDto _self;
  final $Res Function(ReportStockActivityDto) _then;

/// Create a copy of ReportStockActivityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? citationPage = null,Object? issuedShares = freezed,Object? netStockChangeShares = freezed,Object? repurchasedShares = freezed,}) {
  return _then(_self.copyWith(
citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,issuedShares: freezed == issuedShares ? _self.issuedShares : issuedShares // ignore: cast_nullable_to_non_nullable
as double?,netStockChangeShares: freezed == netStockChangeShares ? _self.netStockChangeShares : netStockChangeShares // ignore: cast_nullable_to_non_nullable
as double?,repurchasedShares: freezed == repurchasedShares ? _self.repurchasedShares : repurchasedShares // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportStockActivityDto].
extension ReportStockActivityDtoPatterns on ReportStockActivityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportStockActivityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportStockActivityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportStockActivityDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportStockActivityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportStockActivityDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportStockActivityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int citationPage, @ForceDoubleNullable()  double? issuedShares, @ForceDoubleNullable()  double? netStockChangeShares, @ForceDoubleNullable()  double? repurchasedShares)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportStockActivityDto() when $default != null:
return $default(_that.citationPage,_that.issuedShares,_that.netStockChangeShares,_that.repurchasedShares);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int citationPage, @ForceDoubleNullable()  double? issuedShares, @ForceDoubleNullable()  double? netStockChangeShares, @ForceDoubleNullable()  double? repurchasedShares)  $default,) {final _that = this;
switch (_that) {
case _ReportStockActivityDto():
return $default(_that.citationPage,_that.issuedShares,_that.netStockChangeShares,_that.repurchasedShares);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int citationPage, @ForceDoubleNullable()  double? issuedShares, @ForceDoubleNullable()  double? netStockChangeShares, @ForceDoubleNullable()  double? repurchasedShares)?  $default,) {final _that = this;
switch (_that) {
case _ReportStockActivityDto() when $default != null:
return $default(_that.citationPage,_that.issuedShares,_that.netStockChangeShares,_that.repurchasedShares);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportStockActivityDto extends ReportStockActivityDto {
  const _ReportStockActivityDto({this.citationPage = 0, @ForceDoubleNullable() this.issuedShares, @ForceDoubleNullable() this.netStockChangeShares, @ForceDoubleNullable() this.repurchasedShares}): super._();
  factory _ReportStockActivityDto.fromJson(Map<String, dynamic> json) => _$ReportStockActivityDtoFromJson(json);

@override@JsonKey() final  int citationPage;
@override@ForceDoubleNullable() final  double? issuedShares;
@override@ForceDoubleNullable() final  double? netStockChangeShares;
@override@ForceDoubleNullable() final  double? repurchasedShares;

/// Create a copy of ReportStockActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportStockActivityDtoCopyWith<_ReportStockActivityDto> get copyWith => __$ReportStockActivityDtoCopyWithImpl<_ReportStockActivityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportStockActivityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportStockActivityDto&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.issuedShares, issuedShares) || other.issuedShares == issuedShares)&&(identical(other.netStockChangeShares, netStockChangeShares) || other.netStockChangeShares == netStockChangeShares)&&(identical(other.repurchasedShares, repurchasedShares) || other.repurchasedShares == repurchasedShares));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,citationPage,issuedShares,netStockChangeShares,repurchasedShares);

@override
String toString() {
  return 'ReportStockActivityDto(citationPage: $citationPage, issuedShares: $issuedShares, netStockChangeShares: $netStockChangeShares, repurchasedShares: $repurchasedShares)';
}


}

/// @nodoc
abstract mixin class _$ReportStockActivityDtoCopyWith<$Res> implements $ReportStockActivityDtoCopyWith<$Res> {
  factory _$ReportStockActivityDtoCopyWith(_ReportStockActivityDto value, $Res Function(_ReportStockActivityDto) _then) = __$ReportStockActivityDtoCopyWithImpl;
@override @useResult
$Res call({
 int citationPage,@ForceDoubleNullable() double? issuedShares,@ForceDoubleNullable() double? netStockChangeShares,@ForceDoubleNullable() double? repurchasedShares
});




}
/// @nodoc
class __$ReportStockActivityDtoCopyWithImpl<$Res>
    implements _$ReportStockActivityDtoCopyWith<$Res> {
  __$ReportStockActivityDtoCopyWithImpl(this._self, this._then);

  final _ReportStockActivityDto _self;
  final $Res Function(_ReportStockActivityDto) _then;

/// Create a copy of ReportStockActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? citationPage = null,Object? issuedShares = freezed,Object? netStockChangeShares = freezed,Object? repurchasedShares = freezed,}) {
  return _then(_ReportStockActivityDto(
citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,issuedShares: freezed == issuedShares ? _self.issuedShares : issuedShares // ignore: cast_nullable_to_non_nullable
as double?,netStockChangeShares: freezed == netStockChangeShares ? _self.netStockChangeShares : netStockChangeShares // ignore: cast_nullable_to_non_nullable
as double?,repurchasedShares: freezed == repurchasedShares ? _self.repurchasedShares : repurchasedShares // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$FinancialMetricDto {

@ForceDouble() double get amount;@ForceDouble() double get changeAmount;@ForceDouble() double get changePercent; int get citationPage;
/// Create a copy of FinancialMetricDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialMetricDtoCopyWith<FinancialMetricDto> get copyWith => _$FinancialMetricDtoCopyWithImpl<FinancialMetricDto>(this as FinancialMetricDto, _$identity);

  /// Serializes this FinancialMetricDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialMetricDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage);

@override
String toString() {
  return 'FinancialMetricDto(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage)';
}


}

/// @nodoc
abstract mixin class $FinancialMetricDtoCopyWith<$Res>  {
  factory $FinancialMetricDtoCopyWith(FinancialMetricDto value, $Res Function(FinancialMetricDto) _then) = _$FinancialMetricDtoCopyWithImpl;
@useResult
$Res call({
@ForceDouble() double amount,@ForceDouble() double changeAmount,@ForceDouble() double changePercent, int citationPage
});




}
/// @nodoc
class _$FinancialMetricDtoCopyWithImpl<$Res>
    implements $FinancialMetricDtoCopyWith<$Res> {
  _$FinancialMetricDtoCopyWithImpl(this._self, this._then);

  final FinancialMetricDto _self;
  final $Res Function(FinancialMetricDto) _then;

/// Create a copy of FinancialMetricDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialMetricDto].
extension FinancialMetricDtoPatterns on FinancialMetricDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialMetricDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialMetricDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialMetricDto value)  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialMetricDto value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialMetricDto() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage)  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricDto():
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage)?  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricDto() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialMetricDto extends FinancialMetricDto {
  const _FinancialMetricDto({@ForceDouble() this.amount = 0.0, @ForceDouble() this.changeAmount = 0.0, @ForceDouble() this.changePercent = 0.0, this.citationPage = 0}): super._();
  factory _FinancialMetricDto.fromJson(Map<String, dynamic> json) => _$FinancialMetricDtoFromJson(json);

@override@JsonKey()@ForceDouble() final  double amount;
@override@JsonKey()@ForceDouble() final  double changeAmount;
@override@JsonKey()@ForceDouble() final  double changePercent;
@override@JsonKey() final  int citationPage;

/// Create a copy of FinancialMetricDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialMetricDtoCopyWith<_FinancialMetricDto> get copyWith => __$FinancialMetricDtoCopyWithImpl<_FinancialMetricDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialMetricDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialMetricDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage);

@override
String toString() {
  return 'FinancialMetricDto(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage)';
}


}

/// @nodoc
abstract mixin class _$FinancialMetricDtoCopyWith<$Res> implements $FinancialMetricDtoCopyWith<$Res> {
  factory _$FinancialMetricDtoCopyWith(_FinancialMetricDto value, $Res Function(_FinancialMetricDto) _then) = __$FinancialMetricDtoCopyWithImpl;
@override @useResult
$Res call({
@ForceDouble() double amount,@ForceDouble() double changeAmount,@ForceDouble() double changePercent, int citationPage
});




}
/// @nodoc
class __$FinancialMetricDtoCopyWithImpl<$Res>
    implements _$FinancialMetricDtoCopyWith<$Res> {
  __$FinancialMetricDtoCopyWithImpl(this._self, this._then);

  final _FinancialMetricDto _self;
  final $Res Function(_FinancialMetricDto) _then;

/// Create a copy of FinancialMetricDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,}) {
  return _then(_FinancialMetricDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FinancialMetricWithDriverDto {

@ForceDouble() double get amount;@ForceDouble() double get changeAmount;@ForceDouble() double get changePercent; int get citationPage; String? get driver;
/// Create a copy of FinancialMetricWithDriverDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverDtoCopyWith<FinancialMetricWithDriverDto> get copyWith => _$FinancialMetricWithDriverDtoCopyWithImpl<FinancialMetricWithDriverDto>(this as FinancialMetricWithDriverDto, _$identity);

  /// Serializes this FinancialMetricWithDriverDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialMetricWithDriverDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage,driver);

@override
String toString() {
  return 'FinancialMetricWithDriverDto(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $FinancialMetricWithDriverDtoCopyWith<$Res>  {
  factory $FinancialMetricWithDriverDtoCopyWith(FinancialMetricWithDriverDto value, $Res Function(FinancialMetricWithDriverDto) _then) = _$FinancialMetricWithDriverDtoCopyWithImpl;
@useResult
$Res call({
@ForceDouble() double amount,@ForceDouble() double changeAmount,@ForceDouble() double changePercent, int citationPage, String? driver
});




}
/// @nodoc
class _$FinancialMetricWithDriverDtoCopyWithImpl<$Res>
    implements $FinancialMetricWithDriverDtoCopyWith<$Res> {
  _$FinancialMetricWithDriverDtoCopyWithImpl(this._self, this._then);

  final FinancialMetricWithDriverDto _self;
  final $Res Function(FinancialMetricWithDriverDto) _then;

/// Create a copy of FinancialMetricWithDriverDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,Object? driver = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialMetricWithDriverDto].
extension FinancialMetricWithDriverDtoPatterns on FinancialMetricWithDriverDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialMetricWithDriverDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialMetricWithDriverDto value)  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialMetricWithDriverDto value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage,  String? driver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage,_that.driver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage,  String? driver)  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto():
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage,_that.driver);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@ForceDouble()  double amount, @ForceDouble()  double changeAmount, @ForceDouble()  double changePercent,  int citationPage,  String? driver)?  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriverDto() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage,_that.driver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancialMetricWithDriverDto extends FinancialMetricWithDriverDto {
  const _FinancialMetricWithDriverDto({@ForceDouble() this.amount = 0.0, @ForceDouble() this.changeAmount = 0.0, @ForceDouble() this.changePercent = 0.0, this.citationPage = 0, this.driver}): super._();
  factory _FinancialMetricWithDriverDto.fromJson(Map<String, dynamic> json) => _$FinancialMetricWithDriverDtoFromJson(json);

@override@JsonKey()@ForceDouble() final  double amount;
@override@JsonKey()@ForceDouble() final  double changeAmount;
@override@JsonKey()@ForceDouble() final  double changePercent;
@override@JsonKey() final  int citationPage;
@override final  String? driver;

/// Create a copy of FinancialMetricWithDriverDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialMetricWithDriverDtoCopyWith<_FinancialMetricWithDriverDto> get copyWith => __$FinancialMetricWithDriverDtoCopyWithImpl<_FinancialMetricWithDriverDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancialMetricWithDriverDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialMetricWithDriverDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage,driver);

@override
String toString() {
  return 'FinancialMetricWithDriverDto(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage, driver: $driver)';
}


}

/// @nodoc
abstract mixin class _$FinancialMetricWithDriverDtoCopyWith<$Res> implements $FinancialMetricWithDriverDtoCopyWith<$Res> {
  factory _$FinancialMetricWithDriverDtoCopyWith(_FinancialMetricWithDriverDto value, $Res Function(_FinancialMetricWithDriverDto) _then) = __$FinancialMetricWithDriverDtoCopyWithImpl;
@override @useResult
$Res call({
@ForceDouble() double amount,@ForceDouble() double changeAmount,@ForceDouble() double changePercent, int citationPage, String? driver
});




}
/// @nodoc
class __$FinancialMetricWithDriverDtoCopyWithImpl<$Res>
    implements _$FinancialMetricWithDriverDtoCopyWith<$Res> {
  __$FinancialMetricWithDriverDtoCopyWithImpl(this._self, this._then);

  final _FinancialMetricWithDriverDto _self;
  final $Res Function(_FinancialMetricWithDriverDto) _then;

/// Create a copy of FinancialMetricWithDriverDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,Object? driver = freezed,}) {
  return _then(_FinancialMetricWithDriverDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
