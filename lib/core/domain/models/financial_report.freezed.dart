// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialReport {

 String get id; String get ticker; DateTime? get dateAnalyzed; DateTime? get filingDate; String get formType; ReportSummary get summary; ReportBalanceSheet get balanceSheet; ReportCashFlow get cashFlow; ReportIncome get income; ReportStockActivity get stockActivity;
/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialReportCopyWith<FinancialReport> get copyWith => _$FinancialReportCopyWithImpl<FinancialReport>(this as FinancialReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialReport&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.dateAnalyzed, dateAnalyzed) || other.dateAnalyzed == dateAnalyzed)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.income, income) || other.income == income)&&(identical(other.stockActivity, stockActivity) || other.stockActivity == stockActivity));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticker,dateAnalyzed,filingDate,formType,summary,balanceSheet,cashFlow,income,stockActivity);

@override
String toString() {
  return 'FinancialReport(id: $id, ticker: $ticker, dateAnalyzed: $dateAnalyzed, filingDate: $filingDate, formType: $formType, summary: $summary, balanceSheet: $balanceSheet, cashFlow: $cashFlow, income: $income, stockActivity: $stockActivity)';
}


}

/// @nodoc
abstract mixin class $FinancialReportCopyWith<$Res>  {
  factory $FinancialReportCopyWith(FinancialReport value, $Res Function(FinancialReport) _then) = _$FinancialReportCopyWithImpl;
@useResult
$Res call({
 String id, String ticker, DateTime? dateAnalyzed, DateTime? filingDate, String formType, ReportSummary summary, ReportBalanceSheet balanceSheet, ReportCashFlow cashFlow, ReportIncome income, ReportStockActivity stockActivity
});


$ReportSummaryCopyWith<$Res> get summary;$ReportBalanceSheetCopyWith<$Res> get balanceSheet;$ReportCashFlowCopyWith<$Res> get cashFlow;$ReportIncomeCopyWith<$Res> get income;$ReportStockActivityCopyWith<$Res> get stockActivity;

}
/// @nodoc
class _$FinancialReportCopyWithImpl<$Res>
    implements $FinancialReportCopyWith<$Res> {
  _$FinancialReportCopyWithImpl(this._self, this._then);

  final FinancialReport _self;
  final $Res Function(FinancialReport) _then;

/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticker = null,Object? dateAnalyzed = freezed,Object? filingDate = freezed,Object? formType = null,Object? summary = null,Object? balanceSheet = null,Object? cashFlow = null,Object? income = null,Object? stockActivity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,dateAnalyzed: freezed == dateAnalyzed ? _self.dateAnalyzed : dateAnalyzed // ignore: cast_nullable_to_non_nullable
as DateTime?,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ReportSummary,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as ReportBalanceSheet,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as ReportCashFlow,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as ReportIncome,stockActivity: null == stockActivity ? _self.stockActivity : stockActivity // ignore: cast_nullable_to_non_nullable
as ReportStockActivity,
  ));
}
/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportSummaryCopyWith<$Res> get summary {
  
  return $ReportSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportBalanceSheetCopyWith<$Res> get balanceSheet {
  
  return $ReportBalanceSheetCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportCashFlowCopyWith<$Res> get cashFlow {
  
  return $ReportCashFlowCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportIncomeCopyWith<$Res> get income {
  
  return $ReportIncomeCopyWith<$Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportStockActivityCopyWith<$Res> get stockActivity {
  
  return $ReportStockActivityCopyWith<$Res>(_self.stockActivity, (value) {
    return _then(_self.copyWith(stockActivity: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialReport].
extension FinancialReportPatterns on FinancialReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialReport value)  $default,){
final _that = this;
switch (_that) {
case _FinancialReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialReport value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ticker,  DateTime? dateAnalyzed,  DateTime? filingDate,  String formType,  ReportSummary summary,  ReportBalanceSheet balanceSheet,  ReportCashFlow cashFlow,  ReportIncome income,  ReportStockActivity stockActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialReport() when $default != null:
return $default(_that.id,_that.ticker,_that.dateAnalyzed,_that.filingDate,_that.formType,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ticker,  DateTime? dateAnalyzed,  DateTime? filingDate,  String formType,  ReportSummary summary,  ReportBalanceSheet balanceSheet,  ReportCashFlow cashFlow,  ReportIncome income,  ReportStockActivity stockActivity)  $default,) {final _that = this;
switch (_that) {
case _FinancialReport():
return $default(_that.id,_that.ticker,_that.dateAnalyzed,_that.filingDate,_that.formType,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ticker,  DateTime? dateAnalyzed,  DateTime? filingDate,  String formType,  ReportSummary summary,  ReportBalanceSheet balanceSheet,  ReportCashFlow cashFlow,  ReportIncome income,  ReportStockActivity stockActivity)?  $default,) {final _that = this;
switch (_that) {
case _FinancialReport() when $default != null:
return $default(_that.id,_that.ticker,_that.dateAnalyzed,_that.filingDate,_that.formType,_that.summary,_that.balanceSheet,_that.cashFlow,_that.income,_that.stockActivity);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialReport implements FinancialReport {
  const _FinancialReport({required this.id, required this.ticker, required this.dateAnalyzed, required this.filingDate, required this.formType, required this.summary, required this.balanceSheet, required this.cashFlow, required this.income, required this.stockActivity});
  

@override final  String id;
@override final  String ticker;
@override final  DateTime? dateAnalyzed;
@override final  DateTime? filingDate;
@override final  String formType;
@override final  ReportSummary summary;
@override final  ReportBalanceSheet balanceSheet;
@override final  ReportCashFlow cashFlow;
@override final  ReportIncome income;
@override final  ReportStockActivity stockActivity;

/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialReportCopyWith<_FinancialReport> get copyWith => __$FinancialReportCopyWithImpl<_FinancialReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialReport&&(identical(other.id, id) || other.id == id)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.dateAnalyzed, dateAnalyzed) || other.dateAnalyzed == dateAnalyzed)&&(identical(other.filingDate, filingDate) || other.filingDate == filingDate)&&(identical(other.formType, formType) || other.formType == formType)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.balanceSheet, balanceSheet) || other.balanceSheet == balanceSheet)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.income, income) || other.income == income)&&(identical(other.stockActivity, stockActivity) || other.stockActivity == stockActivity));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticker,dateAnalyzed,filingDate,formType,summary,balanceSheet,cashFlow,income,stockActivity);

@override
String toString() {
  return 'FinancialReport(id: $id, ticker: $ticker, dateAnalyzed: $dateAnalyzed, filingDate: $filingDate, formType: $formType, summary: $summary, balanceSheet: $balanceSheet, cashFlow: $cashFlow, income: $income, stockActivity: $stockActivity)';
}


}

/// @nodoc
abstract mixin class _$FinancialReportCopyWith<$Res> implements $FinancialReportCopyWith<$Res> {
  factory _$FinancialReportCopyWith(_FinancialReport value, $Res Function(_FinancialReport) _then) = __$FinancialReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String ticker, DateTime? dateAnalyzed, DateTime? filingDate, String formType, ReportSummary summary, ReportBalanceSheet balanceSheet, ReportCashFlow cashFlow, ReportIncome income, ReportStockActivity stockActivity
});


@override $ReportSummaryCopyWith<$Res> get summary;@override $ReportBalanceSheetCopyWith<$Res> get balanceSheet;@override $ReportCashFlowCopyWith<$Res> get cashFlow;@override $ReportIncomeCopyWith<$Res> get income;@override $ReportStockActivityCopyWith<$Res> get stockActivity;

}
/// @nodoc
class __$FinancialReportCopyWithImpl<$Res>
    implements _$FinancialReportCopyWith<$Res> {
  __$FinancialReportCopyWithImpl(this._self, this._then);

  final _FinancialReport _self;
  final $Res Function(_FinancialReport) _then;

/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticker = null,Object? dateAnalyzed = freezed,Object? filingDate = freezed,Object? formType = null,Object? summary = null,Object? balanceSheet = null,Object? cashFlow = null,Object? income = null,Object? stockActivity = null,}) {
  return _then(_FinancialReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,dateAnalyzed: freezed == dateAnalyzed ? _self.dateAnalyzed : dateAnalyzed // ignore: cast_nullable_to_non_nullable
as DateTime?,filingDate: freezed == filingDate ? _self.filingDate : filingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,formType: null == formType ? _self.formType : formType // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ReportSummary,balanceSheet: null == balanceSheet ? _self.balanceSheet : balanceSheet // ignore: cast_nullable_to_non_nullable
as ReportBalanceSheet,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as ReportCashFlow,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as ReportIncome,stockActivity: null == stockActivity ? _self.stockActivity : stockActivity // ignore: cast_nullable_to_non_nullable
as ReportStockActivity,
  ));
}

/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportSummaryCopyWith<$Res> get summary {
  
  return $ReportSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportBalanceSheetCopyWith<$Res> get balanceSheet {
  
  return $ReportBalanceSheetCopyWith<$Res>(_self.balanceSheet, (value) {
    return _then(_self.copyWith(balanceSheet: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportCashFlowCopyWith<$Res> get cashFlow {
  
  return $ReportCashFlowCopyWith<$Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportIncomeCopyWith<$Res> get income {
  
  return $ReportIncomeCopyWith<$Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportStockActivityCopyWith<$Res> get stockActivity {
  
  return $ReportStockActivityCopyWith<$Res>(_self.stockActivity, (value) {
    return _then(_self.copyWith(stockActivity: value));
  });
}
}

/// @nodoc
mixin _$ReportSummary {

 String get ticker; String get forwardLooking; int get citationPage; String get reportingCurrency;
/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSummaryCopyWith<ReportSummary> get copyWith => _$ReportSummaryCopyWithImpl<ReportSummary>(this as ReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSummary&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forwardLooking, forwardLooking) || other.forwardLooking == forwardLooking)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.reportingCurrency, reportingCurrency) || other.reportingCurrency == reportingCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forwardLooking,citationPage,reportingCurrency);

@override
String toString() {
  return 'ReportSummary(ticker: $ticker, forwardLooking: $forwardLooking, citationPage: $citationPage, reportingCurrency: $reportingCurrency)';
}


}

/// @nodoc
abstract mixin class $ReportSummaryCopyWith<$Res>  {
  factory $ReportSummaryCopyWith(ReportSummary value, $Res Function(ReportSummary) _then) = _$ReportSummaryCopyWithImpl;
@useResult
$Res call({
 String ticker, String forwardLooking, int citationPage, String reportingCurrency
});




}
/// @nodoc
class _$ReportSummaryCopyWithImpl<$Res>
    implements $ReportSummaryCopyWith<$Res> {
  _$ReportSummaryCopyWithImpl(this._self, this._then);

  final ReportSummary _self;
  final $Res Function(ReportSummary) _then;

/// Create a copy of ReportSummary
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


/// Adds pattern-matching-related methods to [ReportSummary].
extension ReportSummaryPatterns on ReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _ReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSummary() when $default != null:
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
case _ReportSummary() when $default != null:
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
case _ReportSummary():
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
case _ReportSummary() when $default != null:
return $default(_that.ticker,_that.forwardLooking,_that.citationPage,_that.reportingCurrency);case _:
  return null;

}
}

}

/// @nodoc


class _ReportSummary implements ReportSummary {
  const _ReportSummary({required this.ticker, required this.forwardLooking, required this.citationPage, required this.reportingCurrency});
  

@override final  String ticker;
@override final  String forwardLooking;
@override final  int citationPage;
@override final  String reportingCurrency;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSummaryCopyWith<_ReportSummary> get copyWith => __$ReportSummaryCopyWithImpl<_ReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSummary&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.forwardLooking, forwardLooking) || other.forwardLooking == forwardLooking)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.reportingCurrency, reportingCurrency) || other.reportingCurrency == reportingCurrency));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,forwardLooking,citationPage,reportingCurrency);

@override
String toString() {
  return 'ReportSummary(ticker: $ticker, forwardLooking: $forwardLooking, citationPage: $citationPage, reportingCurrency: $reportingCurrency)';
}


}

/// @nodoc
abstract mixin class _$ReportSummaryCopyWith<$Res> implements $ReportSummaryCopyWith<$Res> {
  factory _$ReportSummaryCopyWith(_ReportSummary value, $Res Function(_ReportSummary) _then) = __$ReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 String ticker, String forwardLooking, int citationPage, String reportingCurrency
});




}
/// @nodoc
class __$ReportSummaryCopyWithImpl<$Res>
    implements _$ReportSummaryCopyWith<$Res> {
  __$ReportSummaryCopyWithImpl(this._self, this._then);

  final _ReportSummary _self;
  final $Res Function(_ReportSummary) _then;

/// Create a copy of ReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forwardLooking = null,Object? citationPage = null,Object? reportingCurrency = null,}) {
  return _then(_ReportSummary(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forwardLooking: null == forwardLooking ? _self.forwardLooking : forwardLooking // ignore: cast_nullable_to_non_nullable
as String,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,reportingCurrency: null == reportingCurrency ? _self.reportingCurrency : reportingCurrency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ReportBalanceSheet {

 FinancialMetric get equity; FinancialMetric get totalAssets; FinancialMetric get totalLiabilities;
/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportBalanceSheetCopyWith<ReportBalanceSheet> get copyWith => _$ReportBalanceSheetCopyWithImpl<ReportBalanceSheet>(this as ReportBalanceSheet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportBalanceSheet&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities));
}


@override
int get hashCode => Object.hash(runtimeType,equity,totalAssets,totalLiabilities);

@override
String toString() {
  return 'ReportBalanceSheet(equity: $equity, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities)';
}


}

/// @nodoc
abstract mixin class $ReportBalanceSheetCopyWith<$Res>  {
  factory $ReportBalanceSheetCopyWith(ReportBalanceSheet value, $Res Function(ReportBalanceSheet) _then) = _$ReportBalanceSheetCopyWithImpl;
@useResult
$Res call({
 FinancialMetric equity, FinancialMetric totalAssets, FinancialMetric totalLiabilities
});


$FinancialMetricCopyWith<$Res> get equity;$FinancialMetricCopyWith<$Res> get totalAssets;$FinancialMetricCopyWith<$Res> get totalLiabilities;

}
/// @nodoc
class _$ReportBalanceSheetCopyWithImpl<$Res>
    implements $ReportBalanceSheetCopyWith<$Res> {
  _$ReportBalanceSheetCopyWithImpl(this._self, this._then);

  final ReportBalanceSheet _self;
  final $Res Function(ReportBalanceSheet) _then;

/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? equity = null,Object? totalAssets = null,Object? totalLiabilities = null,}) {
  return _then(_self.copyWith(
equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as FinancialMetric,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as FinancialMetric,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as FinancialMetric,
  ));
}
/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get equity {
  
  return $FinancialMetricCopyWith<$Res>(_self.equity, (value) {
    return _then(_self.copyWith(equity: value));
  });
}/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get totalAssets {
  
  return $FinancialMetricCopyWith<$Res>(_self.totalAssets, (value) {
    return _then(_self.copyWith(totalAssets: value));
  });
}/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get totalLiabilities {
  
  return $FinancialMetricCopyWith<$Res>(_self.totalLiabilities, (value) {
    return _then(_self.copyWith(totalLiabilities: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportBalanceSheet].
extension ReportBalanceSheetPatterns on ReportBalanceSheet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportBalanceSheet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportBalanceSheet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportBalanceSheet value)  $default,){
final _that = this;
switch (_that) {
case _ReportBalanceSheet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportBalanceSheet value)?  $default,){
final _that = this;
switch (_that) {
case _ReportBalanceSheet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetric equity,  FinancialMetric totalAssets,  FinancialMetric totalLiabilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportBalanceSheet() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetric equity,  FinancialMetric totalAssets,  FinancialMetric totalLiabilities)  $default,) {final _that = this;
switch (_that) {
case _ReportBalanceSheet():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetric equity,  FinancialMetric totalAssets,  FinancialMetric totalLiabilities)?  $default,) {final _that = this;
switch (_that) {
case _ReportBalanceSheet() when $default != null:
return $default(_that.equity,_that.totalAssets,_that.totalLiabilities);case _:
  return null;

}
}

}

/// @nodoc


class _ReportBalanceSheet implements ReportBalanceSheet {
  const _ReportBalanceSheet({required this.equity, required this.totalAssets, required this.totalLiabilities});
  

@override final  FinancialMetric equity;
@override final  FinancialMetric totalAssets;
@override final  FinancialMetric totalLiabilities;

/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportBalanceSheetCopyWith<_ReportBalanceSheet> get copyWith => __$ReportBalanceSheetCopyWithImpl<_ReportBalanceSheet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportBalanceSheet&&(identical(other.equity, equity) || other.equity == equity)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities));
}


@override
int get hashCode => Object.hash(runtimeType,equity,totalAssets,totalLiabilities);

@override
String toString() {
  return 'ReportBalanceSheet(equity: $equity, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities)';
}


}

/// @nodoc
abstract mixin class _$ReportBalanceSheetCopyWith<$Res> implements $ReportBalanceSheetCopyWith<$Res> {
  factory _$ReportBalanceSheetCopyWith(_ReportBalanceSheet value, $Res Function(_ReportBalanceSheet) _then) = __$ReportBalanceSheetCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetric equity, FinancialMetric totalAssets, FinancialMetric totalLiabilities
});


@override $FinancialMetricCopyWith<$Res> get equity;@override $FinancialMetricCopyWith<$Res> get totalAssets;@override $FinancialMetricCopyWith<$Res> get totalLiabilities;

}
/// @nodoc
class __$ReportBalanceSheetCopyWithImpl<$Res>
    implements _$ReportBalanceSheetCopyWith<$Res> {
  __$ReportBalanceSheetCopyWithImpl(this._self, this._then);

  final _ReportBalanceSheet _self;
  final $Res Function(_ReportBalanceSheet) _then;

/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? equity = null,Object? totalAssets = null,Object? totalLiabilities = null,}) {
  return _then(_ReportBalanceSheet(
equity: null == equity ? _self.equity : equity // ignore: cast_nullable_to_non_nullable
as FinancialMetric,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as FinancialMetric,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as FinancialMetric,
  ));
}

/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get equity {
  
  return $FinancialMetricCopyWith<$Res>(_self.equity, (value) {
    return _then(_self.copyWith(equity: value));
  });
}/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get totalAssets {
  
  return $FinancialMetricCopyWith<$Res>(_self.totalAssets, (value) {
    return _then(_self.copyWith(totalAssets: value));
  });
}/// Create a copy of ReportBalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get totalLiabilities {
  
  return $FinancialMetricCopyWith<$Res>(_self.totalLiabilities, (value) {
    return _then(_self.copyWith(totalLiabilities: value));
  });
}
}

/// @nodoc
mixin _$ReportCashFlow {

 FinancialMetricWithDriver get freeCashFlow;
/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCashFlowCopyWith<ReportCashFlow> get copyWith => _$ReportCashFlowCopyWithImpl<ReportCashFlow>(this as ReportCashFlow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportCashFlow&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow));
}


@override
int get hashCode => Object.hash(runtimeType,freeCashFlow);

@override
String toString() {
  return 'ReportCashFlow(freeCashFlow: $freeCashFlow)';
}


}

/// @nodoc
abstract mixin class $ReportCashFlowCopyWith<$Res>  {
  factory $ReportCashFlowCopyWith(ReportCashFlow value, $Res Function(ReportCashFlow) _then) = _$ReportCashFlowCopyWithImpl;
@useResult
$Res call({
 FinancialMetricWithDriver freeCashFlow
});


$FinancialMetricWithDriverCopyWith<$Res> get freeCashFlow;

}
/// @nodoc
class _$ReportCashFlowCopyWithImpl<$Res>
    implements $ReportCashFlowCopyWith<$Res> {
  _$ReportCashFlowCopyWithImpl(this._self, this._then);

  final ReportCashFlow _self;
  final $Res Function(ReportCashFlow) _then;

/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? freeCashFlow = null,}) {
  return _then(_self.copyWith(
freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,
  ));
}
/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get freeCashFlow {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.freeCashFlow, (value) {
    return _then(_self.copyWith(freeCashFlow: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportCashFlow].
extension ReportCashFlowPatterns on ReportCashFlow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportCashFlow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportCashFlow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportCashFlow value)  $default,){
final _that = this;
switch (_that) {
case _ReportCashFlow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportCashFlow value)?  $default,){
final _that = this;
switch (_that) {
case _ReportCashFlow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetricWithDriver freeCashFlow)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportCashFlow() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetricWithDriver freeCashFlow)  $default,) {final _that = this;
switch (_that) {
case _ReportCashFlow():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetricWithDriver freeCashFlow)?  $default,) {final _that = this;
switch (_that) {
case _ReportCashFlow() when $default != null:
return $default(_that.freeCashFlow);case _:
  return null;

}
}

}

/// @nodoc


class _ReportCashFlow implements ReportCashFlow {
  const _ReportCashFlow({required this.freeCashFlow});
  

@override final  FinancialMetricWithDriver freeCashFlow;

/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCashFlowCopyWith<_ReportCashFlow> get copyWith => __$ReportCashFlowCopyWithImpl<_ReportCashFlow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportCashFlow&&(identical(other.freeCashFlow, freeCashFlow) || other.freeCashFlow == freeCashFlow));
}


@override
int get hashCode => Object.hash(runtimeType,freeCashFlow);

@override
String toString() {
  return 'ReportCashFlow(freeCashFlow: $freeCashFlow)';
}


}

/// @nodoc
abstract mixin class _$ReportCashFlowCopyWith<$Res> implements $ReportCashFlowCopyWith<$Res> {
  factory _$ReportCashFlowCopyWith(_ReportCashFlow value, $Res Function(_ReportCashFlow) _then) = __$ReportCashFlowCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetricWithDriver freeCashFlow
});


@override $FinancialMetricWithDriverCopyWith<$Res> get freeCashFlow;

}
/// @nodoc
class __$ReportCashFlowCopyWithImpl<$Res>
    implements _$ReportCashFlowCopyWith<$Res> {
  __$ReportCashFlowCopyWithImpl(this._self, this._then);

  final _ReportCashFlow _self;
  final $Res Function(_ReportCashFlow) _then;

/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? freeCashFlow = null,}) {
  return _then(_ReportCashFlow(
freeCashFlow: null == freeCashFlow ? _self.freeCashFlow : freeCashFlow // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,
  ));
}

/// Create a copy of ReportCashFlow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get freeCashFlow {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.freeCashFlow, (value) {
    return _then(_self.copyWith(freeCashFlow: value));
  });
}
}

/// @nodoc
mixin _$ReportIncome {

 FinancialMetric get costOfRevenue; FinancialMetric get eps; FinancialMetricWithDriver get netIncome; FinancialMetricWithDriver get revenue; FinancialMetricWithDriver get totalExpenses;
/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportIncomeCopyWith<ReportIncome> get copyWith => _$ReportIncomeCopyWithImpl<ReportIncome>(this as ReportIncome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportIncome&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,costOfRevenue,eps,netIncome,revenue,totalExpenses);

@override
String toString() {
  return 'ReportIncome(costOfRevenue: $costOfRevenue, eps: $eps, netIncome: $netIncome, revenue: $revenue, totalExpenses: $totalExpenses)';
}


}

/// @nodoc
abstract mixin class $ReportIncomeCopyWith<$Res>  {
  factory $ReportIncomeCopyWith(ReportIncome value, $Res Function(ReportIncome) _then) = _$ReportIncomeCopyWithImpl;
@useResult
$Res call({
 FinancialMetric costOfRevenue, FinancialMetric eps, FinancialMetricWithDriver netIncome, FinancialMetricWithDriver revenue, FinancialMetricWithDriver totalExpenses
});


$FinancialMetricCopyWith<$Res> get costOfRevenue;$FinancialMetricCopyWith<$Res> get eps;$FinancialMetricWithDriverCopyWith<$Res> get netIncome;$FinancialMetricWithDriverCopyWith<$Res> get revenue;$FinancialMetricWithDriverCopyWith<$Res> get totalExpenses;

}
/// @nodoc
class _$ReportIncomeCopyWithImpl<$Res>
    implements $ReportIncomeCopyWith<$Res> {
  _$ReportIncomeCopyWithImpl(this._self, this._then);

  final ReportIncome _self;
  final $Res Function(ReportIncome) _then;

/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? costOfRevenue = null,Object? eps = null,Object? netIncome = null,Object? revenue = null,Object? totalExpenses = null,}) {
  return _then(_self.copyWith(
costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as FinancialMetric,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as FinancialMetric,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,
  ));
}
/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get costOfRevenue {
  
  return $FinancialMetricCopyWith<$Res>(_self.costOfRevenue, (value) {
    return _then(_self.copyWith(costOfRevenue: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get eps {
  
  return $FinancialMetricCopyWith<$Res>(_self.eps, (value) {
    return _then(_self.copyWith(eps: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get netIncome {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.netIncome, (value) {
    return _then(_self.copyWith(netIncome: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get revenue {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get totalExpenses {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportIncome].
extension ReportIncomePatterns on ReportIncome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportIncome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportIncome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportIncome value)  $default,){
final _that = this;
switch (_that) {
case _ReportIncome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportIncome value)?  $default,){
final _that = this;
switch (_that) {
case _ReportIncome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinancialMetric costOfRevenue,  FinancialMetric eps,  FinancialMetricWithDriver netIncome,  FinancialMetricWithDriver revenue,  FinancialMetricWithDriver totalExpenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportIncome() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinancialMetric costOfRevenue,  FinancialMetric eps,  FinancialMetricWithDriver netIncome,  FinancialMetricWithDriver revenue,  FinancialMetricWithDriver totalExpenses)  $default,) {final _that = this;
switch (_that) {
case _ReportIncome():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinancialMetric costOfRevenue,  FinancialMetric eps,  FinancialMetricWithDriver netIncome,  FinancialMetricWithDriver revenue,  FinancialMetricWithDriver totalExpenses)?  $default,) {final _that = this;
switch (_that) {
case _ReportIncome() when $default != null:
return $default(_that.costOfRevenue,_that.eps,_that.netIncome,_that.revenue,_that.totalExpenses);case _:
  return null;

}
}

}

/// @nodoc


class _ReportIncome implements ReportIncome {
  const _ReportIncome({required this.costOfRevenue, required this.eps, required this.netIncome, required this.revenue, required this.totalExpenses});
  

@override final  FinancialMetric costOfRevenue;
@override final  FinancialMetric eps;
@override final  FinancialMetricWithDriver netIncome;
@override final  FinancialMetricWithDriver revenue;
@override final  FinancialMetricWithDriver totalExpenses;

/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportIncomeCopyWith<_ReportIncome> get copyWith => __$ReportIncomeCopyWithImpl<_ReportIncome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportIncome&&(identical(other.costOfRevenue, costOfRevenue) || other.costOfRevenue == costOfRevenue)&&(identical(other.eps, eps) || other.eps == eps)&&(identical(other.netIncome, netIncome) || other.netIncome == netIncome)&&(identical(other.revenue, revenue) || other.revenue == revenue)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,costOfRevenue,eps,netIncome,revenue,totalExpenses);

@override
String toString() {
  return 'ReportIncome(costOfRevenue: $costOfRevenue, eps: $eps, netIncome: $netIncome, revenue: $revenue, totalExpenses: $totalExpenses)';
}


}

/// @nodoc
abstract mixin class _$ReportIncomeCopyWith<$Res> implements $ReportIncomeCopyWith<$Res> {
  factory _$ReportIncomeCopyWith(_ReportIncome value, $Res Function(_ReportIncome) _then) = __$ReportIncomeCopyWithImpl;
@override @useResult
$Res call({
 FinancialMetric costOfRevenue, FinancialMetric eps, FinancialMetricWithDriver netIncome, FinancialMetricWithDriver revenue, FinancialMetricWithDriver totalExpenses
});


@override $FinancialMetricCopyWith<$Res> get costOfRevenue;@override $FinancialMetricCopyWith<$Res> get eps;@override $FinancialMetricWithDriverCopyWith<$Res> get netIncome;@override $FinancialMetricWithDriverCopyWith<$Res> get revenue;@override $FinancialMetricWithDriverCopyWith<$Res> get totalExpenses;

}
/// @nodoc
class __$ReportIncomeCopyWithImpl<$Res>
    implements _$ReportIncomeCopyWith<$Res> {
  __$ReportIncomeCopyWithImpl(this._self, this._then);

  final _ReportIncome _self;
  final $Res Function(_ReportIncome) _then;

/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? costOfRevenue = null,Object? eps = null,Object? netIncome = null,Object? revenue = null,Object? totalExpenses = null,}) {
  return _then(_ReportIncome(
costOfRevenue: null == costOfRevenue ? _self.costOfRevenue : costOfRevenue // ignore: cast_nullable_to_non_nullable
as FinancialMetric,eps: null == eps ? _self.eps : eps // ignore: cast_nullable_to_non_nullable
as FinancialMetric,netIncome: null == netIncome ? _self.netIncome : netIncome // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,revenue: null == revenue ? _self.revenue : revenue // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as FinancialMetricWithDriver,
  ));
}

/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get costOfRevenue {
  
  return $FinancialMetricCopyWith<$Res>(_self.costOfRevenue, (value) {
    return _then(_self.copyWith(costOfRevenue: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<$Res> get eps {
  
  return $FinancialMetricCopyWith<$Res>(_self.eps, (value) {
    return _then(_self.copyWith(eps: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get netIncome {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.netIncome, (value) {
    return _then(_self.copyWith(netIncome: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get revenue {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.revenue, (value) {
    return _then(_self.copyWith(revenue: value));
  });
}/// Create a copy of ReportIncome
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<$Res> get totalExpenses {
  
  return $FinancialMetricWithDriverCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}
}

/// @nodoc
mixin _$ReportStockActivity {

 int get citationPage; double? get issuedShares; double? get netStockChangeShares; double? get repurchasedShares;
/// Create a copy of ReportStockActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportStockActivityCopyWith<ReportStockActivity> get copyWith => _$ReportStockActivityCopyWithImpl<ReportStockActivity>(this as ReportStockActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportStockActivity&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.issuedShares, issuedShares) || other.issuedShares == issuedShares)&&(identical(other.netStockChangeShares, netStockChangeShares) || other.netStockChangeShares == netStockChangeShares)&&(identical(other.repurchasedShares, repurchasedShares) || other.repurchasedShares == repurchasedShares));
}


@override
int get hashCode => Object.hash(runtimeType,citationPage,issuedShares,netStockChangeShares,repurchasedShares);

@override
String toString() {
  return 'ReportStockActivity(citationPage: $citationPage, issuedShares: $issuedShares, netStockChangeShares: $netStockChangeShares, repurchasedShares: $repurchasedShares)';
}


}

/// @nodoc
abstract mixin class $ReportStockActivityCopyWith<$Res>  {
  factory $ReportStockActivityCopyWith(ReportStockActivity value, $Res Function(ReportStockActivity) _then) = _$ReportStockActivityCopyWithImpl;
@useResult
$Res call({
 int citationPage, double? issuedShares, double? netStockChangeShares, double? repurchasedShares
});




}
/// @nodoc
class _$ReportStockActivityCopyWithImpl<$Res>
    implements $ReportStockActivityCopyWith<$Res> {
  _$ReportStockActivityCopyWithImpl(this._self, this._then);

  final ReportStockActivity _self;
  final $Res Function(ReportStockActivity) _then;

/// Create a copy of ReportStockActivity
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


/// Adds pattern-matching-related methods to [ReportStockActivity].
extension ReportStockActivityPatterns on ReportStockActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportStockActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportStockActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportStockActivity value)  $default,){
final _that = this;
switch (_that) {
case _ReportStockActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportStockActivity value)?  $default,){
final _that = this;
switch (_that) {
case _ReportStockActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int citationPage,  double? issuedShares,  double? netStockChangeShares,  double? repurchasedShares)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportStockActivity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int citationPage,  double? issuedShares,  double? netStockChangeShares,  double? repurchasedShares)  $default,) {final _that = this;
switch (_that) {
case _ReportStockActivity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int citationPage,  double? issuedShares,  double? netStockChangeShares,  double? repurchasedShares)?  $default,) {final _that = this;
switch (_that) {
case _ReportStockActivity() when $default != null:
return $default(_that.citationPage,_that.issuedShares,_that.netStockChangeShares,_that.repurchasedShares);case _:
  return null;

}
}

}

/// @nodoc


class _ReportStockActivity implements ReportStockActivity {
  const _ReportStockActivity({required this.citationPage, this.issuedShares, this.netStockChangeShares, this.repurchasedShares});
  

@override final  int citationPage;
@override final  double? issuedShares;
@override final  double? netStockChangeShares;
@override final  double? repurchasedShares;

/// Create a copy of ReportStockActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportStockActivityCopyWith<_ReportStockActivity> get copyWith => __$ReportStockActivityCopyWithImpl<_ReportStockActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportStockActivity&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.issuedShares, issuedShares) || other.issuedShares == issuedShares)&&(identical(other.netStockChangeShares, netStockChangeShares) || other.netStockChangeShares == netStockChangeShares)&&(identical(other.repurchasedShares, repurchasedShares) || other.repurchasedShares == repurchasedShares));
}


@override
int get hashCode => Object.hash(runtimeType,citationPage,issuedShares,netStockChangeShares,repurchasedShares);

@override
String toString() {
  return 'ReportStockActivity(citationPage: $citationPage, issuedShares: $issuedShares, netStockChangeShares: $netStockChangeShares, repurchasedShares: $repurchasedShares)';
}


}

/// @nodoc
abstract mixin class _$ReportStockActivityCopyWith<$Res> implements $ReportStockActivityCopyWith<$Res> {
  factory _$ReportStockActivityCopyWith(_ReportStockActivity value, $Res Function(_ReportStockActivity) _then) = __$ReportStockActivityCopyWithImpl;
@override @useResult
$Res call({
 int citationPage, double? issuedShares, double? netStockChangeShares, double? repurchasedShares
});




}
/// @nodoc
class __$ReportStockActivityCopyWithImpl<$Res>
    implements _$ReportStockActivityCopyWith<$Res> {
  __$ReportStockActivityCopyWithImpl(this._self, this._then);

  final _ReportStockActivity _self;
  final $Res Function(_ReportStockActivity) _then;

/// Create a copy of ReportStockActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? citationPage = null,Object? issuedShares = freezed,Object? netStockChangeShares = freezed,Object? repurchasedShares = freezed,}) {
  return _then(_ReportStockActivity(
citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,issuedShares: freezed == issuedShares ? _self.issuedShares : issuedShares // ignore: cast_nullable_to_non_nullable
as double?,netStockChangeShares: freezed == netStockChangeShares ? _self.netStockChangeShares : netStockChangeShares // ignore: cast_nullable_to_non_nullable
as double?,repurchasedShares: freezed == repurchasedShares ? _self.repurchasedShares : repurchasedShares // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$FinancialMetric {

 double get amount; double get changeAmount; double get changePercent; int get citationPage;
/// Create a copy of FinancialMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialMetricCopyWith<FinancialMetric> get copyWith => _$FinancialMetricCopyWithImpl<FinancialMetric>(this as FinancialMetric, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialMetric&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage));
}


@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage);

@override
String toString() {
  return 'FinancialMetric(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage)';
}


}

/// @nodoc
abstract mixin class $FinancialMetricCopyWith<$Res>  {
  factory $FinancialMetricCopyWith(FinancialMetric value, $Res Function(FinancialMetric) _then) = _$FinancialMetricCopyWithImpl;
@useResult
$Res call({
 double amount, double changeAmount, double changePercent, int citationPage
});




}
/// @nodoc
class _$FinancialMetricCopyWithImpl<$Res>
    implements $FinancialMetricCopyWith<$Res> {
  _$FinancialMetricCopyWithImpl(this._self, this._then);

  final FinancialMetric _self;
  final $Res Function(FinancialMetric) _then;

/// Create a copy of FinancialMetric
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


/// Adds pattern-matching-related methods to [FinancialMetric].
extension FinancialMetricPatterns on FinancialMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialMetric value)  $default,){
final _that = this;
switch (_that) {
case _FinancialMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialMetric value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  double changeAmount,  double changePercent,  int citationPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialMetric() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  double changeAmount,  double changePercent,  int citationPage)  $default,) {final _that = this;
switch (_that) {
case _FinancialMetric():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  double changeAmount,  double changePercent,  int citationPage)?  $default,) {final _that = this;
switch (_that) {
case _FinancialMetric() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialMetric implements FinancialMetric {
  const _FinancialMetric({required this.amount, required this.changeAmount, required this.changePercent, required this.citationPage});
  

@override final  double amount;
@override final  double changeAmount;
@override final  double changePercent;
@override final  int citationPage;

/// Create a copy of FinancialMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialMetricCopyWith<_FinancialMetric> get copyWith => __$FinancialMetricCopyWithImpl<_FinancialMetric>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialMetric&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage));
}


@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage);

@override
String toString() {
  return 'FinancialMetric(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage)';
}


}

/// @nodoc
abstract mixin class _$FinancialMetricCopyWith<$Res> implements $FinancialMetricCopyWith<$Res> {
  factory _$FinancialMetricCopyWith(_FinancialMetric value, $Res Function(_FinancialMetric) _then) = __$FinancialMetricCopyWithImpl;
@override @useResult
$Res call({
 double amount, double changeAmount, double changePercent, int citationPage
});




}
/// @nodoc
class __$FinancialMetricCopyWithImpl<$Res>
    implements _$FinancialMetricCopyWith<$Res> {
  __$FinancialMetricCopyWithImpl(this._self, this._then);

  final _FinancialMetric _self;
  final $Res Function(_FinancialMetric) _then;

/// Create a copy of FinancialMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,}) {
  return _then(_FinancialMetric(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,changeAmount: null == changeAmount ? _self.changeAmount : changeAmount // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,citationPage: null == citationPage ? _self.citationPage : citationPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$FinancialMetricWithDriver {

 double get amount; double get changeAmount; double get changePercent; int get citationPage; String? get driver;
/// Create a copy of FinancialMetricWithDriver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialMetricWithDriverCopyWith<FinancialMetricWithDriver> get copyWith => _$FinancialMetricWithDriverCopyWithImpl<FinancialMetricWithDriver>(this as FinancialMetricWithDriver, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialMetricWithDriver&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.driver, driver) || other.driver == driver));
}


@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage,driver);

@override
String toString() {
  return 'FinancialMetricWithDriver(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $FinancialMetricWithDriverCopyWith<$Res>  {
  factory $FinancialMetricWithDriverCopyWith(FinancialMetricWithDriver value, $Res Function(FinancialMetricWithDriver) _then) = _$FinancialMetricWithDriverCopyWithImpl;
@useResult
$Res call({
 double amount, double changeAmount, double changePercent, int citationPage, String? driver
});




}
/// @nodoc
class _$FinancialMetricWithDriverCopyWithImpl<$Res>
    implements $FinancialMetricWithDriverCopyWith<$Res> {
  _$FinancialMetricWithDriverCopyWithImpl(this._self, this._then);

  final FinancialMetricWithDriver _self;
  final $Res Function(FinancialMetricWithDriver) _then;

/// Create a copy of FinancialMetricWithDriver
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


/// Adds pattern-matching-related methods to [FinancialMetricWithDriver].
extension FinancialMetricWithDriverPatterns on FinancialMetricWithDriver {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialMetricWithDriver value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriver() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialMetricWithDriver value)  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriver():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialMetricWithDriver value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialMetricWithDriver() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  double changeAmount,  double changePercent,  int citationPage,  String? driver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriver() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  double changeAmount,  double changePercent,  int citationPage,  String? driver)  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriver():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  double changeAmount,  double changePercent,  int citationPage,  String? driver)?  $default,) {final _that = this;
switch (_that) {
case _FinancialMetricWithDriver() when $default != null:
return $default(_that.amount,_that.changeAmount,_that.changePercent,_that.citationPage,_that.driver);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialMetricWithDriver implements FinancialMetricWithDriver {
  const _FinancialMetricWithDriver({required this.amount, required this.changeAmount, required this.changePercent, required this.citationPage, this.driver});
  

@override final  double amount;
@override final  double changeAmount;
@override final  double changePercent;
@override final  int citationPage;
@override final  String? driver;

/// Create a copy of FinancialMetricWithDriver
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialMetricWithDriverCopyWith<_FinancialMetricWithDriver> get copyWith => __$FinancialMetricWithDriverCopyWithImpl<_FinancialMetricWithDriver>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialMetricWithDriver&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.changeAmount, changeAmount) || other.changeAmount == changeAmount)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent)&&(identical(other.citationPage, citationPage) || other.citationPage == citationPage)&&(identical(other.driver, driver) || other.driver == driver));
}


@override
int get hashCode => Object.hash(runtimeType,amount,changeAmount,changePercent,citationPage,driver);

@override
String toString() {
  return 'FinancialMetricWithDriver(amount: $amount, changeAmount: $changeAmount, changePercent: $changePercent, citationPage: $citationPage, driver: $driver)';
}


}

/// @nodoc
abstract mixin class _$FinancialMetricWithDriverCopyWith<$Res> implements $FinancialMetricWithDriverCopyWith<$Res> {
  factory _$FinancialMetricWithDriverCopyWith(_FinancialMetricWithDriver value, $Res Function(_FinancialMetricWithDriver) _then) = __$FinancialMetricWithDriverCopyWithImpl;
@override @useResult
$Res call({
 double amount, double changeAmount, double changePercent, int citationPage, String? driver
});




}
/// @nodoc
class __$FinancialMetricWithDriverCopyWithImpl<$Res>
    implements _$FinancialMetricWithDriverCopyWith<$Res> {
  __$FinancialMetricWithDriverCopyWithImpl(this._self, this._then);

  final _FinancialMetricWithDriver _self;
  final $Res Function(_FinancialMetricWithDriver) _then;

/// Create a copy of FinancialMetricWithDriver
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? changeAmount = null,Object? changePercent = null,Object? citationPage = null,Object? driver = freezed,}) {
  return _then(_FinancialMetricWithDriver(
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
