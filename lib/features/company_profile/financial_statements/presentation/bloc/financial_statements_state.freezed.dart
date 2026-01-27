// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_statements_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialStatementsState {

 bool get isLoadingIncome; bool get isLoadingBalance; bool get isLoadingCashFlow; Failure? get incomeError; Failure? get balanceError; Failure? get cashFlowError; DateTime? get lastUpdatedIncome; DateTime? get lastUpdatedBalance; DateTime? get lastUpdatedCashFlow; List<IncomeStatement> get annualIncomeStatements; List<IncomeStatement> get quarterlyIncomeStatements; List<BalanceSheet> get annualBalanceSheets; List<BalanceSheet> get quarterlyBalanceSheets; List<CashFlowStatement> get annualCashFlowStatements; List<CashFlowStatement> get quarterlyCashFlowStatements; String get reportedCurrency; FinancialStatementType get selectedType; String? get selectedAnnualIncomeDate; String? get selectedQuarterlyIncomeDate; String? get selectedAnnualBalanceDate; String? get selectedQuarterlyBalanceDate; String? get selectedAnnualCashFlowDate; String? get selectedQuarterlyCashFlowDate;
/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialStatementsStateCopyWith<FinancialStatementsState> get copyWith => _$FinancialStatementsStateCopyWithImpl<FinancialStatementsState>(this as FinancialStatementsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialStatementsState&&(identical(other.isLoadingIncome, isLoadingIncome) || other.isLoadingIncome == isLoadingIncome)&&(identical(other.isLoadingBalance, isLoadingBalance) || other.isLoadingBalance == isLoadingBalance)&&(identical(other.isLoadingCashFlow, isLoadingCashFlow) || other.isLoadingCashFlow == isLoadingCashFlow)&&(identical(other.incomeError, incomeError) || other.incomeError == incomeError)&&(identical(other.balanceError, balanceError) || other.balanceError == balanceError)&&(identical(other.cashFlowError, cashFlowError) || other.cashFlowError == cashFlowError)&&(identical(other.lastUpdatedIncome, lastUpdatedIncome) || other.lastUpdatedIncome == lastUpdatedIncome)&&(identical(other.lastUpdatedBalance, lastUpdatedBalance) || other.lastUpdatedBalance == lastUpdatedBalance)&&(identical(other.lastUpdatedCashFlow, lastUpdatedCashFlow) || other.lastUpdatedCashFlow == lastUpdatedCashFlow)&&const DeepCollectionEquality().equals(other.annualIncomeStatements, annualIncomeStatements)&&const DeepCollectionEquality().equals(other.quarterlyIncomeStatements, quarterlyIncomeStatements)&&const DeepCollectionEquality().equals(other.annualBalanceSheets, annualBalanceSheets)&&const DeepCollectionEquality().equals(other.quarterlyBalanceSheets, quarterlyBalanceSheets)&&const DeepCollectionEquality().equals(other.annualCashFlowStatements, annualCashFlowStatements)&&const DeepCollectionEquality().equals(other.quarterlyCashFlowStatements, quarterlyCashFlowStatements)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.selectedAnnualIncomeDate, selectedAnnualIncomeDate) || other.selectedAnnualIncomeDate == selectedAnnualIncomeDate)&&(identical(other.selectedQuarterlyIncomeDate, selectedQuarterlyIncomeDate) || other.selectedQuarterlyIncomeDate == selectedQuarterlyIncomeDate)&&(identical(other.selectedAnnualBalanceDate, selectedAnnualBalanceDate) || other.selectedAnnualBalanceDate == selectedAnnualBalanceDate)&&(identical(other.selectedQuarterlyBalanceDate, selectedQuarterlyBalanceDate) || other.selectedQuarterlyBalanceDate == selectedQuarterlyBalanceDate)&&(identical(other.selectedAnnualCashFlowDate, selectedAnnualCashFlowDate) || other.selectedAnnualCashFlowDate == selectedAnnualCashFlowDate)&&(identical(other.selectedQuarterlyCashFlowDate, selectedQuarterlyCashFlowDate) || other.selectedQuarterlyCashFlowDate == selectedQuarterlyCashFlowDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoadingIncome,isLoadingBalance,isLoadingCashFlow,incomeError,balanceError,cashFlowError,lastUpdatedIncome,lastUpdatedBalance,lastUpdatedCashFlow,const DeepCollectionEquality().hash(annualIncomeStatements),const DeepCollectionEquality().hash(quarterlyIncomeStatements),const DeepCollectionEquality().hash(annualBalanceSheets),const DeepCollectionEquality().hash(quarterlyBalanceSheets),const DeepCollectionEquality().hash(annualCashFlowStatements),const DeepCollectionEquality().hash(quarterlyCashFlowStatements),reportedCurrency,selectedType,selectedAnnualIncomeDate,selectedQuarterlyIncomeDate,selectedAnnualBalanceDate,selectedQuarterlyBalanceDate,selectedAnnualCashFlowDate,selectedQuarterlyCashFlowDate]);

@override
String toString() {
  return 'FinancialStatementsState(isLoadingIncome: $isLoadingIncome, isLoadingBalance: $isLoadingBalance, isLoadingCashFlow: $isLoadingCashFlow, incomeError: $incomeError, balanceError: $balanceError, cashFlowError: $cashFlowError, lastUpdatedIncome: $lastUpdatedIncome, lastUpdatedBalance: $lastUpdatedBalance, lastUpdatedCashFlow: $lastUpdatedCashFlow, annualIncomeStatements: $annualIncomeStatements, quarterlyIncomeStatements: $quarterlyIncomeStatements, annualBalanceSheets: $annualBalanceSheets, quarterlyBalanceSheets: $quarterlyBalanceSheets, annualCashFlowStatements: $annualCashFlowStatements, quarterlyCashFlowStatements: $quarterlyCashFlowStatements, reportedCurrency: $reportedCurrency, selectedType: $selectedType, selectedAnnualIncomeDate: $selectedAnnualIncomeDate, selectedQuarterlyIncomeDate: $selectedQuarterlyIncomeDate, selectedAnnualBalanceDate: $selectedAnnualBalanceDate, selectedQuarterlyBalanceDate: $selectedQuarterlyBalanceDate, selectedAnnualCashFlowDate: $selectedAnnualCashFlowDate, selectedQuarterlyCashFlowDate: $selectedQuarterlyCashFlowDate)';
}


}

/// @nodoc
abstract mixin class $FinancialStatementsStateCopyWith<$Res>  {
  factory $FinancialStatementsStateCopyWith(FinancialStatementsState value, $Res Function(FinancialStatementsState) _then) = _$FinancialStatementsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoadingIncome, bool isLoadingBalance, bool isLoadingCashFlow, Failure? incomeError, Failure? balanceError, Failure? cashFlowError, DateTime? lastUpdatedIncome, DateTime? lastUpdatedBalance, DateTime? lastUpdatedCashFlow, List<IncomeStatement> annualIncomeStatements, List<IncomeStatement> quarterlyIncomeStatements, List<BalanceSheet> annualBalanceSheets, List<BalanceSheet> quarterlyBalanceSheets, List<CashFlowStatement> annualCashFlowStatements, List<CashFlowStatement> quarterlyCashFlowStatements, String reportedCurrency, FinancialStatementType selectedType, String? selectedAnnualIncomeDate, String? selectedQuarterlyIncomeDate, String? selectedAnnualBalanceDate, String? selectedQuarterlyBalanceDate, String? selectedAnnualCashFlowDate, String? selectedQuarterlyCashFlowDate
});


$FailureCopyWith<$Res>? get incomeError;$FailureCopyWith<$Res>? get balanceError;$FailureCopyWith<$Res>? get cashFlowError;

}
/// @nodoc
class _$FinancialStatementsStateCopyWithImpl<$Res>
    implements $FinancialStatementsStateCopyWith<$Res> {
  _$FinancialStatementsStateCopyWithImpl(this._self, this._then);

  final FinancialStatementsState _self;
  final $Res Function(FinancialStatementsState) _then;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoadingIncome = null,Object? isLoadingBalance = null,Object? isLoadingCashFlow = null,Object? incomeError = freezed,Object? balanceError = freezed,Object? cashFlowError = freezed,Object? lastUpdatedIncome = freezed,Object? lastUpdatedBalance = freezed,Object? lastUpdatedCashFlow = freezed,Object? annualIncomeStatements = null,Object? quarterlyIncomeStatements = null,Object? annualBalanceSheets = null,Object? quarterlyBalanceSheets = null,Object? annualCashFlowStatements = null,Object? quarterlyCashFlowStatements = null,Object? reportedCurrency = null,Object? selectedType = null,Object? selectedAnnualIncomeDate = freezed,Object? selectedQuarterlyIncomeDate = freezed,Object? selectedAnnualBalanceDate = freezed,Object? selectedQuarterlyBalanceDate = freezed,Object? selectedAnnualCashFlowDate = freezed,Object? selectedQuarterlyCashFlowDate = freezed,}) {
  return _then(_self.copyWith(
isLoadingIncome: null == isLoadingIncome ? _self.isLoadingIncome : isLoadingIncome // ignore: cast_nullable_to_non_nullable
as bool,isLoadingBalance: null == isLoadingBalance ? _self.isLoadingBalance : isLoadingBalance // ignore: cast_nullable_to_non_nullable
as bool,isLoadingCashFlow: null == isLoadingCashFlow ? _self.isLoadingCashFlow : isLoadingCashFlow // ignore: cast_nullable_to_non_nullable
as bool,incomeError: freezed == incomeError ? _self.incomeError : incomeError // ignore: cast_nullable_to_non_nullable
as Failure?,balanceError: freezed == balanceError ? _self.balanceError : balanceError // ignore: cast_nullable_to_non_nullable
as Failure?,cashFlowError: freezed == cashFlowError ? _self.cashFlowError : cashFlowError // ignore: cast_nullable_to_non_nullable
as Failure?,lastUpdatedIncome: freezed == lastUpdatedIncome ? _self.lastUpdatedIncome : lastUpdatedIncome // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedBalance: freezed == lastUpdatedBalance ? _self.lastUpdatedBalance : lastUpdatedBalance // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedCashFlow: freezed == lastUpdatedCashFlow ? _self.lastUpdatedCashFlow : lastUpdatedCashFlow // ignore: cast_nullable_to_non_nullable
as DateTime?,annualIncomeStatements: null == annualIncomeStatements ? _self.annualIncomeStatements : annualIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,quarterlyIncomeStatements: null == quarterlyIncomeStatements ? _self.quarterlyIncomeStatements : quarterlyIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,annualBalanceSheets: null == annualBalanceSheets ? _self.annualBalanceSheets : annualBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,quarterlyBalanceSheets: null == quarterlyBalanceSheets ? _self.quarterlyBalanceSheets : quarterlyBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,annualCashFlowStatements: null == annualCashFlowStatements ? _self.annualCashFlowStatements : annualCashFlowStatements // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,quarterlyCashFlowStatements: null == quarterlyCashFlowStatements ? _self.quarterlyCashFlowStatements : quarterlyCashFlowStatements // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,selectedAnnualIncomeDate: freezed == selectedAnnualIncomeDate ? _self.selectedAnnualIncomeDate : selectedAnnualIncomeDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyIncomeDate: freezed == selectedQuarterlyIncomeDate ? _self.selectedQuarterlyIncomeDate : selectedQuarterlyIncomeDate // ignore: cast_nullable_to_non_nullable
as String?,selectedAnnualBalanceDate: freezed == selectedAnnualBalanceDate ? _self.selectedAnnualBalanceDate : selectedAnnualBalanceDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyBalanceDate: freezed == selectedQuarterlyBalanceDate ? _self.selectedQuarterlyBalanceDate : selectedQuarterlyBalanceDate // ignore: cast_nullable_to_non_nullable
as String?,selectedAnnualCashFlowDate: freezed == selectedAnnualCashFlowDate ? _self.selectedAnnualCashFlowDate : selectedAnnualCashFlowDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyCashFlowDate: freezed == selectedQuarterlyCashFlowDate ? _self.selectedQuarterlyCashFlowDate : selectedQuarterlyCashFlowDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get incomeError {
    if (_self.incomeError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.incomeError!, (value) {
    return _then(_self.copyWith(incomeError: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get balanceError {
    if (_self.balanceError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.balanceError!, (value) {
    return _then(_self.copyWith(balanceError: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get cashFlowError {
    if (_self.cashFlowError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.cashFlowError!, (value) {
    return _then(_self.copyWith(cashFlowError: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancialStatementsState].
extension FinancialStatementsStatePatterns on FinancialStatementsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialStatementsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialStatementsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialStatementsState value)  $default,){
final _that = this;
switch (_that) {
case _FinancialStatementsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialStatementsState value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialStatementsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoadingIncome,  bool isLoadingBalance,  bool isLoadingCashFlow,  Failure? incomeError,  Failure? balanceError,  Failure? cashFlowError,  DateTime? lastUpdatedIncome,  DateTime? lastUpdatedBalance,  DateTime? lastUpdatedCashFlow,  List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlowStatements,  List<CashFlowStatement> quarterlyCashFlowStatements,  String reportedCurrency,  FinancialStatementType selectedType,  String? selectedAnnualIncomeDate,  String? selectedQuarterlyIncomeDate,  String? selectedAnnualBalanceDate,  String? selectedQuarterlyBalanceDate,  String? selectedAnnualCashFlowDate,  String? selectedQuarterlyCashFlowDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialStatementsState() when $default != null:
return $default(_that.isLoadingIncome,_that.isLoadingBalance,_that.isLoadingCashFlow,_that.incomeError,_that.balanceError,_that.cashFlowError,_that.lastUpdatedIncome,_that.lastUpdatedBalance,_that.lastUpdatedCashFlow,_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlowStatements,_that.quarterlyCashFlowStatements,_that.reportedCurrency,_that.selectedType,_that.selectedAnnualIncomeDate,_that.selectedQuarterlyIncomeDate,_that.selectedAnnualBalanceDate,_that.selectedQuarterlyBalanceDate,_that.selectedAnnualCashFlowDate,_that.selectedQuarterlyCashFlowDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoadingIncome,  bool isLoadingBalance,  bool isLoadingCashFlow,  Failure? incomeError,  Failure? balanceError,  Failure? cashFlowError,  DateTime? lastUpdatedIncome,  DateTime? lastUpdatedBalance,  DateTime? lastUpdatedCashFlow,  List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlowStatements,  List<CashFlowStatement> quarterlyCashFlowStatements,  String reportedCurrency,  FinancialStatementType selectedType,  String? selectedAnnualIncomeDate,  String? selectedQuarterlyIncomeDate,  String? selectedAnnualBalanceDate,  String? selectedQuarterlyBalanceDate,  String? selectedAnnualCashFlowDate,  String? selectedQuarterlyCashFlowDate)  $default,) {final _that = this;
switch (_that) {
case _FinancialStatementsState():
return $default(_that.isLoadingIncome,_that.isLoadingBalance,_that.isLoadingCashFlow,_that.incomeError,_that.balanceError,_that.cashFlowError,_that.lastUpdatedIncome,_that.lastUpdatedBalance,_that.lastUpdatedCashFlow,_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlowStatements,_that.quarterlyCashFlowStatements,_that.reportedCurrency,_that.selectedType,_that.selectedAnnualIncomeDate,_that.selectedQuarterlyIncomeDate,_that.selectedAnnualBalanceDate,_that.selectedQuarterlyBalanceDate,_that.selectedAnnualCashFlowDate,_that.selectedQuarterlyCashFlowDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoadingIncome,  bool isLoadingBalance,  bool isLoadingCashFlow,  Failure? incomeError,  Failure? balanceError,  Failure? cashFlowError,  DateTime? lastUpdatedIncome,  DateTime? lastUpdatedBalance,  DateTime? lastUpdatedCashFlow,  List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlowStatements,  List<CashFlowStatement> quarterlyCashFlowStatements,  String reportedCurrency,  FinancialStatementType selectedType,  String? selectedAnnualIncomeDate,  String? selectedQuarterlyIncomeDate,  String? selectedAnnualBalanceDate,  String? selectedQuarterlyBalanceDate,  String? selectedAnnualCashFlowDate,  String? selectedQuarterlyCashFlowDate)?  $default,) {final _that = this;
switch (_that) {
case _FinancialStatementsState() when $default != null:
return $default(_that.isLoadingIncome,_that.isLoadingBalance,_that.isLoadingCashFlow,_that.incomeError,_that.balanceError,_that.cashFlowError,_that.lastUpdatedIncome,_that.lastUpdatedBalance,_that.lastUpdatedCashFlow,_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlowStatements,_that.quarterlyCashFlowStatements,_that.reportedCurrency,_that.selectedType,_that.selectedAnnualIncomeDate,_that.selectedQuarterlyIncomeDate,_that.selectedAnnualBalanceDate,_that.selectedQuarterlyBalanceDate,_that.selectedAnnualCashFlowDate,_that.selectedQuarterlyCashFlowDate);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialStatementsState implements FinancialStatementsState {
  const _FinancialStatementsState({this.isLoadingIncome = false, this.isLoadingBalance = false, this.isLoadingCashFlow = false, this.incomeError, this.balanceError, this.cashFlowError, this.lastUpdatedIncome, this.lastUpdatedBalance, this.lastUpdatedCashFlow, final  List<IncomeStatement> annualIncomeStatements = const [], final  List<IncomeStatement> quarterlyIncomeStatements = const [], final  List<BalanceSheet> annualBalanceSheets = const [], final  List<BalanceSheet> quarterlyBalanceSheets = const [], final  List<CashFlowStatement> annualCashFlowStatements = const [], final  List<CashFlowStatement> quarterlyCashFlowStatements = const [], this.reportedCurrency = 'USD', this.selectedType = FinancialStatementType.income, this.selectedAnnualIncomeDate, this.selectedQuarterlyIncomeDate, this.selectedAnnualBalanceDate, this.selectedQuarterlyBalanceDate, this.selectedAnnualCashFlowDate, this.selectedQuarterlyCashFlowDate}): _annualIncomeStatements = annualIncomeStatements,_quarterlyIncomeStatements = quarterlyIncomeStatements,_annualBalanceSheets = annualBalanceSheets,_quarterlyBalanceSheets = quarterlyBalanceSheets,_annualCashFlowStatements = annualCashFlowStatements,_quarterlyCashFlowStatements = quarterlyCashFlowStatements;
  

@override@JsonKey() final  bool isLoadingIncome;
@override@JsonKey() final  bool isLoadingBalance;
@override@JsonKey() final  bool isLoadingCashFlow;
@override final  Failure? incomeError;
@override final  Failure? balanceError;
@override final  Failure? cashFlowError;
@override final  DateTime? lastUpdatedIncome;
@override final  DateTime? lastUpdatedBalance;
@override final  DateTime? lastUpdatedCashFlow;
 final  List<IncomeStatement> _annualIncomeStatements;
@override@JsonKey() List<IncomeStatement> get annualIncomeStatements {
  if (_annualIncomeStatements is EqualUnmodifiableListView) return _annualIncomeStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualIncomeStatements);
}

 final  List<IncomeStatement> _quarterlyIncomeStatements;
@override@JsonKey() List<IncomeStatement> get quarterlyIncomeStatements {
  if (_quarterlyIncomeStatements is EqualUnmodifiableListView) return _quarterlyIncomeStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyIncomeStatements);
}

 final  List<BalanceSheet> _annualBalanceSheets;
@override@JsonKey() List<BalanceSheet> get annualBalanceSheets {
  if (_annualBalanceSheets is EqualUnmodifiableListView) return _annualBalanceSheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualBalanceSheets);
}

 final  List<BalanceSheet> _quarterlyBalanceSheets;
@override@JsonKey() List<BalanceSheet> get quarterlyBalanceSheets {
  if (_quarterlyBalanceSheets is EqualUnmodifiableListView) return _quarterlyBalanceSheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyBalanceSheets);
}

 final  List<CashFlowStatement> _annualCashFlowStatements;
@override@JsonKey() List<CashFlowStatement> get annualCashFlowStatements {
  if (_annualCashFlowStatements is EqualUnmodifiableListView) return _annualCashFlowStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualCashFlowStatements);
}

 final  List<CashFlowStatement> _quarterlyCashFlowStatements;
@override@JsonKey() List<CashFlowStatement> get quarterlyCashFlowStatements {
  if (_quarterlyCashFlowStatements is EqualUnmodifiableListView) return _quarterlyCashFlowStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyCashFlowStatements);
}

@override@JsonKey() final  String reportedCurrency;
@override@JsonKey() final  FinancialStatementType selectedType;
@override final  String? selectedAnnualIncomeDate;
@override final  String? selectedQuarterlyIncomeDate;
@override final  String? selectedAnnualBalanceDate;
@override final  String? selectedQuarterlyBalanceDate;
@override final  String? selectedAnnualCashFlowDate;
@override final  String? selectedQuarterlyCashFlowDate;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialStatementsStateCopyWith<_FinancialStatementsState> get copyWith => __$FinancialStatementsStateCopyWithImpl<_FinancialStatementsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialStatementsState&&(identical(other.isLoadingIncome, isLoadingIncome) || other.isLoadingIncome == isLoadingIncome)&&(identical(other.isLoadingBalance, isLoadingBalance) || other.isLoadingBalance == isLoadingBalance)&&(identical(other.isLoadingCashFlow, isLoadingCashFlow) || other.isLoadingCashFlow == isLoadingCashFlow)&&(identical(other.incomeError, incomeError) || other.incomeError == incomeError)&&(identical(other.balanceError, balanceError) || other.balanceError == balanceError)&&(identical(other.cashFlowError, cashFlowError) || other.cashFlowError == cashFlowError)&&(identical(other.lastUpdatedIncome, lastUpdatedIncome) || other.lastUpdatedIncome == lastUpdatedIncome)&&(identical(other.lastUpdatedBalance, lastUpdatedBalance) || other.lastUpdatedBalance == lastUpdatedBalance)&&(identical(other.lastUpdatedCashFlow, lastUpdatedCashFlow) || other.lastUpdatedCashFlow == lastUpdatedCashFlow)&&const DeepCollectionEquality().equals(other._annualIncomeStatements, _annualIncomeStatements)&&const DeepCollectionEquality().equals(other._quarterlyIncomeStatements, _quarterlyIncomeStatements)&&const DeepCollectionEquality().equals(other._annualBalanceSheets, _annualBalanceSheets)&&const DeepCollectionEquality().equals(other._quarterlyBalanceSheets, _quarterlyBalanceSheets)&&const DeepCollectionEquality().equals(other._annualCashFlowStatements, _annualCashFlowStatements)&&const DeepCollectionEquality().equals(other._quarterlyCashFlowStatements, _quarterlyCashFlowStatements)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.selectedAnnualIncomeDate, selectedAnnualIncomeDate) || other.selectedAnnualIncomeDate == selectedAnnualIncomeDate)&&(identical(other.selectedQuarterlyIncomeDate, selectedQuarterlyIncomeDate) || other.selectedQuarterlyIncomeDate == selectedQuarterlyIncomeDate)&&(identical(other.selectedAnnualBalanceDate, selectedAnnualBalanceDate) || other.selectedAnnualBalanceDate == selectedAnnualBalanceDate)&&(identical(other.selectedQuarterlyBalanceDate, selectedQuarterlyBalanceDate) || other.selectedQuarterlyBalanceDate == selectedQuarterlyBalanceDate)&&(identical(other.selectedAnnualCashFlowDate, selectedAnnualCashFlowDate) || other.selectedAnnualCashFlowDate == selectedAnnualCashFlowDate)&&(identical(other.selectedQuarterlyCashFlowDate, selectedQuarterlyCashFlowDate) || other.selectedQuarterlyCashFlowDate == selectedQuarterlyCashFlowDate));
}


@override
int get hashCode => Object.hashAll([runtimeType,isLoadingIncome,isLoadingBalance,isLoadingCashFlow,incomeError,balanceError,cashFlowError,lastUpdatedIncome,lastUpdatedBalance,lastUpdatedCashFlow,const DeepCollectionEquality().hash(_annualIncomeStatements),const DeepCollectionEquality().hash(_quarterlyIncomeStatements),const DeepCollectionEquality().hash(_annualBalanceSheets),const DeepCollectionEquality().hash(_quarterlyBalanceSheets),const DeepCollectionEquality().hash(_annualCashFlowStatements),const DeepCollectionEquality().hash(_quarterlyCashFlowStatements),reportedCurrency,selectedType,selectedAnnualIncomeDate,selectedQuarterlyIncomeDate,selectedAnnualBalanceDate,selectedQuarterlyBalanceDate,selectedAnnualCashFlowDate,selectedQuarterlyCashFlowDate]);

@override
String toString() {
  return 'FinancialStatementsState(isLoadingIncome: $isLoadingIncome, isLoadingBalance: $isLoadingBalance, isLoadingCashFlow: $isLoadingCashFlow, incomeError: $incomeError, balanceError: $balanceError, cashFlowError: $cashFlowError, lastUpdatedIncome: $lastUpdatedIncome, lastUpdatedBalance: $lastUpdatedBalance, lastUpdatedCashFlow: $lastUpdatedCashFlow, annualIncomeStatements: $annualIncomeStatements, quarterlyIncomeStatements: $quarterlyIncomeStatements, annualBalanceSheets: $annualBalanceSheets, quarterlyBalanceSheets: $quarterlyBalanceSheets, annualCashFlowStatements: $annualCashFlowStatements, quarterlyCashFlowStatements: $quarterlyCashFlowStatements, reportedCurrency: $reportedCurrency, selectedType: $selectedType, selectedAnnualIncomeDate: $selectedAnnualIncomeDate, selectedQuarterlyIncomeDate: $selectedQuarterlyIncomeDate, selectedAnnualBalanceDate: $selectedAnnualBalanceDate, selectedQuarterlyBalanceDate: $selectedQuarterlyBalanceDate, selectedAnnualCashFlowDate: $selectedAnnualCashFlowDate, selectedQuarterlyCashFlowDate: $selectedQuarterlyCashFlowDate)';
}


}

/// @nodoc
abstract mixin class _$FinancialStatementsStateCopyWith<$Res> implements $FinancialStatementsStateCopyWith<$Res> {
  factory _$FinancialStatementsStateCopyWith(_FinancialStatementsState value, $Res Function(_FinancialStatementsState) _then) = __$FinancialStatementsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoadingIncome, bool isLoadingBalance, bool isLoadingCashFlow, Failure? incomeError, Failure? balanceError, Failure? cashFlowError, DateTime? lastUpdatedIncome, DateTime? lastUpdatedBalance, DateTime? lastUpdatedCashFlow, List<IncomeStatement> annualIncomeStatements, List<IncomeStatement> quarterlyIncomeStatements, List<BalanceSheet> annualBalanceSheets, List<BalanceSheet> quarterlyBalanceSheets, List<CashFlowStatement> annualCashFlowStatements, List<CashFlowStatement> quarterlyCashFlowStatements, String reportedCurrency, FinancialStatementType selectedType, String? selectedAnnualIncomeDate, String? selectedQuarterlyIncomeDate, String? selectedAnnualBalanceDate, String? selectedQuarterlyBalanceDate, String? selectedAnnualCashFlowDate, String? selectedQuarterlyCashFlowDate
});


@override $FailureCopyWith<$Res>? get incomeError;@override $FailureCopyWith<$Res>? get balanceError;@override $FailureCopyWith<$Res>? get cashFlowError;

}
/// @nodoc
class __$FinancialStatementsStateCopyWithImpl<$Res>
    implements _$FinancialStatementsStateCopyWith<$Res> {
  __$FinancialStatementsStateCopyWithImpl(this._self, this._then);

  final _FinancialStatementsState _self;
  final $Res Function(_FinancialStatementsState) _then;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoadingIncome = null,Object? isLoadingBalance = null,Object? isLoadingCashFlow = null,Object? incomeError = freezed,Object? balanceError = freezed,Object? cashFlowError = freezed,Object? lastUpdatedIncome = freezed,Object? lastUpdatedBalance = freezed,Object? lastUpdatedCashFlow = freezed,Object? annualIncomeStatements = null,Object? quarterlyIncomeStatements = null,Object? annualBalanceSheets = null,Object? quarterlyBalanceSheets = null,Object? annualCashFlowStatements = null,Object? quarterlyCashFlowStatements = null,Object? reportedCurrency = null,Object? selectedType = null,Object? selectedAnnualIncomeDate = freezed,Object? selectedQuarterlyIncomeDate = freezed,Object? selectedAnnualBalanceDate = freezed,Object? selectedQuarterlyBalanceDate = freezed,Object? selectedAnnualCashFlowDate = freezed,Object? selectedQuarterlyCashFlowDate = freezed,}) {
  return _then(_FinancialStatementsState(
isLoadingIncome: null == isLoadingIncome ? _self.isLoadingIncome : isLoadingIncome // ignore: cast_nullable_to_non_nullable
as bool,isLoadingBalance: null == isLoadingBalance ? _self.isLoadingBalance : isLoadingBalance // ignore: cast_nullable_to_non_nullable
as bool,isLoadingCashFlow: null == isLoadingCashFlow ? _self.isLoadingCashFlow : isLoadingCashFlow // ignore: cast_nullable_to_non_nullable
as bool,incomeError: freezed == incomeError ? _self.incomeError : incomeError // ignore: cast_nullable_to_non_nullable
as Failure?,balanceError: freezed == balanceError ? _self.balanceError : balanceError // ignore: cast_nullable_to_non_nullable
as Failure?,cashFlowError: freezed == cashFlowError ? _self.cashFlowError : cashFlowError // ignore: cast_nullable_to_non_nullable
as Failure?,lastUpdatedIncome: freezed == lastUpdatedIncome ? _self.lastUpdatedIncome : lastUpdatedIncome // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedBalance: freezed == lastUpdatedBalance ? _self.lastUpdatedBalance : lastUpdatedBalance // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedCashFlow: freezed == lastUpdatedCashFlow ? _self.lastUpdatedCashFlow : lastUpdatedCashFlow // ignore: cast_nullable_to_non_nullable
as DateTime?,annualIncomeStatements: null == annualIncomeStatements ? _self._annualIncomeStatements : annualIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,quarterlyIncomeStatements: null == quarterlyIncomeStatements ? _self._quarterlyIncomeStatements : quarterlyIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,annualBalanceSheets: null == annualBalanceSheets ? _self._annualBalanceSheets : annualBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,quarterlyBalanceSheets: null == quarterlyBalanceSheets ? _self._quarterlyBalanceSheets : quarterlyBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,annualCashFlowStatements: null == annualCashFlowStatements ? _self._annualCashFlowStatements : annualCashFlowStatements // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,quarterlyCashFlowStatements: null == quarterlyCashFlowStatements ? _self._quarterlyCashFlowStatements : quarterlyCashFlowStatements // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,selectedAnnualIncomeDate: freezed == selectedAnnualIncomeDate ? _self.selectedAnnualIncomeDate : selectedAnnualIncomeDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyIncomeDate: freezed == selectedQuarterlyIncomeDate ? _self.selectedQuarterlyIncomeDate : selectedQuarterlyIncomeDate // ignore: cast_nullable_to_non_nullable
as String?,selectedAnnualBalanceDate: freezed == selectedAnnualBalanceDate ? _self.selectedAnnualBalanceDate : selectedAnnualBalanceDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyBalanceDate: freezed == selectedQuarterlyBalanceDate ? _self.selectedQuarterlyBalanceDate : selectedQuarterlyBalanceDate // ignore: cast_nullable_to_non_nullable
as String?,selectedAnnualCashFlowDate: freezed == selectedAnnualCashFlowDate ? _self.selectedAnnualCashFlowDate : selectedAnnualCashFlowDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyCashFlowDate: freezed == selectedQuarterlyCashFlowDate ? _self.selectedQuarterlyCashFlowDate : selectedQuarterlyCashFlowDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get incomeError {
    if (_self.incomeError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.incomeError!, (value) {
    return _then(_self.copyWith(incomeError: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get balanceError {
    if (_self.balanceError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.balanceError!, (value) {
    return _then(_self.copyWith(balanceError: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get cashFlowError {
    if (_self.cashFlowError == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.cashFlowError!, (value) {
    return _then(_self.copyWith(cashFlowError: value));
  });
}
}

// dart format on
