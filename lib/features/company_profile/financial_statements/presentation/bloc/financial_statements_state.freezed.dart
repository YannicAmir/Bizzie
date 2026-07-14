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
mixin _$StatementFlow<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFlow<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatementFlow<$T>()';
}


}

/// @nodoc
class $StatementFlowCopyWith<T,$Res>  {
$StatementFlowCopyWith(StatementFlow<T> _, $Res Function(StatementFlow<T>) __);
}


/// Adds pattern-matching-related methods to [StatementFlow].
extension StatementFlowPatterns<T> on StatementFlow<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StatementFlowInitial<T> value)?  initial,TResult Function( StatementFlowLoading<T> value)?  loading,TResult Function( StatementFlowLoaded<T> value)?  loaded,TResult Function( StatementFlowFailure<T> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StatementFlowInitial() when initial != null:
return initial(_that);case StatementFlowLoading() when loading != null:
return loading(_that);case StatementFlowLoaded() when loaded != null:
return loaded(_that);case StatementFlowFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StatementFlowInitial<T> value)  initial,required TResult Function( StatementFlowLoading<T> value)  loading,required TResult Function( StatementFlowLoaded<T> value)  loaded,required TResult Function( StatementFlowFailure<T> value)  failure,}){
final _that = this;
switch (_that) {
case StatementFlowInitial():
return initial(_that);case StatementFlowLoading():
return loading(_that);case StatementFlowLoaded():
return loaded(_that);case StatementFlowFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StatementFlowInitial<T> value)?  initial,TResult? Function( StatementFlowLoading<T> value)?  loading,TResult? Function( StatementFlowLoaded<T> value)?  loaded,TResult? Function( StatementFlowFailure<T> value)?  failure,}){
final _that = this;
switch (_that) {
case StatementFlowInitial() when initial != null:
return initial(_that);case StatementFlowLoading() when loading != null:
return loading(_that);case StatementFlowLoaded() when loaded != null:
return loaded(_that);case StatementFlowFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<T> annual,  List<T> quarterly,  CompanyProfileDataOrigin origin,  DateTime? lastUpdated,  int? loadTimeMs,  String? selectedAnnualDate,  String? selectedQuarterlyDate)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StatementFlowInitial() when initial != null:
return initial();case StatementFlowLoading() when loading != null:
return loading();case StatementFlowLoaded() when loaded != null:
return loaded(_that.annual,_that.quarterly,_that.origin,_that.lastUpdated,_that.loadTimeMs,_that.selectedAnnualDate,_that.selectedQuarterlyDate);case StatementFlowFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<T> annual,  List<T> quarterly,  CompanyProfileDataOrigin origin,  DateTime? lastUpdated,  int? loadTimeMs,  String? selectedAnnualDate,  String? selectedQuarterlyDate)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case StatementFlowInitial():
return initial();case StatementFlowLoading():
return loading();case StatementFlowLoaded():
return loaded(_that.annual,_that.quarterly,_that.origin,_that.lastUpdated,_that.loadTimeMs,_that.selectedAnnualDate,_that.selectedQuarterlyDate);case StatementFlowFailure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<T> annual,  List<T> quarterly,  CompanyProfileDataOrigin origin,  DateTime? lastUpdated,  int? loadTimeMs,  String? selectedAnnualDate,  String? selectedQuarterlyDate)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case StatementFlowInitial() when initial != null:
return initial();case StatementFlowLoading() when loading != null:
return loading();case StatementFlowLoaded() when loaded != null:
return loaded(_that.annual,_that.quarterly,_that.origin,_that.lastUpdated,_that.loadTimeMs,_that.selectedAnnualDate,_that.selectedQuarterlyDate);case StatementFlowFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class StatementFlowInitial<T> implements StatementFlow<T> {
  const StatementFlowInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFlowInitial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatementFlow<$T>.initial()';
}


}




/// @nodoc


class StatementFlowLoading<T> implements StatementFlow<T> {
  const StatementFlowLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFlowLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StatementFlow<$T>.loading()';
}


}




/// @nodoc


class StatementFlowLoaded<T> implements StatementFlow<T> {
  const StatementFlowLoaded({required final  List<T> annual, required final  List<T> quarterly, required this.origin, this.lastUpdated, this.loadTimeMs, this.selectedAnnualDate, this.selectedQuarterlyDate}): _annual = annual,_quarterly = quarterly;
  

 final  List<T> _annual;
 List<T> get annual {
  if (_annual is EqualUnmodifiableListView) return _annual;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annual);
}

 final  List<T> _quarterly;
 List<T> get quarterly {
  if (_quarterly is EqualUnmodifiableListView) return _quarterly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterly);
}

 final  CompanyProfileDataOrigin origin;
 final  DateTime? lastUpdated;
 final  int? loadTimeMs;
 final  String? selectedAnnualDate;
 final  String? selectedQuarterlyDate;

/// Create a copy of StatementFlow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatementFlowLoadedCopyWith<T, StatementFlowLoaded<T>> get copyWith => _$StatementFlowLoadedCopyWithImpl<T, StatementFlowLoaded<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFlowLoaded<T>&&const DeepCollectionEquality().equals(other._annual, _annual)&&const DeepCollectionEquality().equals(other._quarterly, _quarterly)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.loadTimeMs, loadTimeMs) || other.loadTimeMs == loadTimeMs)&&(identical(other.selectedAnnualDate, selectedAnnualDate) || other.selectedAnnualDate == selectedAnnualDate)&&(identical(other.selectedQuarterlyDate, selectedQuarterlyDate) || other.selectedQuarterlyDate == selectedQuarterlyDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_annual),const DeepCollectionEquality().hash(_quarterly),origin,lastUpdated,loadTimeMs,selectedAnnualDate,selectedQuarterlyDate);

@override
String toString() {
  return 'StatementFlow<$T>.loaded(annual: $annual, quarterly: $quarterly, origin: $origin, lastUpdated: $lastUpdated, loadTimeMs: $loadTimeMs, selectedAnnualDate: $selectedAnnualDate, selectedQuarterlyDate: $selectedQuarterlyDate)';
}


}

/// @nodoc
abstract mixin class $StatementFlowLoadedCopyWith<T,$Res> implements $StatementFlowCopyWith<T, $Res> {
  factory $StatementFlowLoadedCopyWith(StatementFlowLoaded<T> value, $Res Function(StatementFlowLoaded<T>) _then) = _$StatementFlowLoadedCopyWithImpl;
@useResult
$Res call({
 List<T> annual, List<T> quarterly, CompanyProfileDataOrigin origin, DateTime? lastUpdated, int? loadTimeMs, String? selectedAnnualDate, String? selectedQuarterlyDate
});




}
/// @nodoc
class _$StatementFlowLoadedCopyWithImpl<T,$Res>
    implements $StatementFlowLoadedCopyWith<T, $Res> {
  _$StatementFlowLoadedCopyWithImpl(this._self, this._then);

  final StatementFlowLoaded<T> _self;
  final $Res Function(StatementFlowLoaded<T>) _then;

/// Create a copy of StatementFlow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? annual = null,Object? quarterly = null,Object? origin = null,Object? lastUpdated = freezed,Object? loadTimeMs = freezed,Object? selectedAnnualDate = freezed,Object? selectedQuarterlyDate = freezed,}) {
  return _then(StatementFlowLoaded<T>(
annual: null == annual ? _self._annual : annual // ignore: cast_nullable_to_non_nullable
as List<T>,quarterly: null == quarterly ? _self._quarterly : quarterly // ignore: cast_nullable_to_non_nullable
as List<T>,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,loadTimeMs: freezed == loadTimeMs ? _self.loadTimeMs : loadTimeMs // ignore: cast_nullable_to_non_nullable
as int?,selectedAnnualDate: freezed == selectedAnnualDate ? _self.selectedAnnualDate : selectedAnnualDate // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyDate: freezed == selectedQuarterlyDate ? _self.selectedQuarterlyDate : selectedQuarterlyDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class StatementFlowFailure<T> implements StatementFlow<T> {
  const StatementFlowFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of StatementFlow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatementFlowFailureCopyWith<T, StatementFlowFailure<T>> get copyWith => _$StatementFlowFailureCopyWithImpl<T, StatementFlowFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFlowFailure<T>&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'StatementFlow<$T>.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $StatementFlowFailureCopyWith<T,$Res> implements $StatementFlowCopyWith<T, $Res> {
  factory $StatementFlowFailureCopyWith(StatementFlowFailure<T> value, $Res Function(StatementFlowFailure<T>) _then) = _$StatementFlowFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$StatementFlowFailureCopyWithImpl<T,$Res>
    implements $StatementFlowFailureCopyWith<T, $Res> {
  _$StatementFlowFailureCopyWithImpl(this._self, this._then);

  final StatementFlowFailure<T> _self;
  final $Res Function(StatementFlowFailure<T>) _then;

/// Create a copy of StatementFlow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(StatementFlowFailure<T>(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of StatementFlow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc
mixin _$FinancialStatementsState {

 StatementFlow<IncomeStatement> get income; StatementFlow<BalanceSheet> get balance; StatementFlow<CashFlowStatement> get cashFlow; FinancialStatementType get selectedType; String get reportedCurrency; String? get ticker; int get freePlanHistoryCount;
/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialStatementsStateCopyWith<FinancialStatementsState> get copyWith => _$FinancialStatementsStateCopyWithImpl<FinancialStatementsState>(this as FinancialStatementsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialStatementsState&&(identical(other.income, income) || other.income == income)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.freePlanHistoryCount, freePlanHistoryCount) || other.freePlanHistoryCount == freePlanHistoryCount));
}


@override
int get hashCode => Object.hash(runtimeType,income,balance,cashFlow,selectedType,reportedCurrency,ticker,freePlanHistoryCount);

@override
String toString() {
  return 'FinancialStatementsState(income: $income, balance: $balance, cashFlow: $cashFlow, selectedType: $selectedType, reportedCurrency: $reportedCurrency, ticker: $ticker, freePlanHistoryCount: $freePlanHistoryCount)';
}


}

/// @nodoc
abstract mixin class $FinancialStatementsStateCopyWith<$Res>  {
  factory $FinancialStatementsStateCopyWith(FinancialStatementsState value, $Res Function(FinancialStatementsState) _then) = _$FinancialStatementsStateCopyWithImpl;
@useResult
$Res call({
 StatementFlow<IncomeStatement> income, StatementFlow<BalanceSheet> balance, StatementFlow<CashFlowStatement> cashFlow, FinancialStatementType selectedType, String reportedCurrency, String? ticker, int freePlanHistoryCount
});


$StatementFlowCopyWith<IncomeStatement, $Res> get income;$StatementFlowCopyWith<BalanceSheet, $Res> get balance;$StatementFlowCopyWith<CashFlowStatement, $Res> get cashFlow;

}
/// @nodoc
class _$FinancialStatementsStateCopyWithImpl<$Res>
    implements $FinancialStatementsStateCopyWith<$Res> {
  _$FinancialStatementsStateCopyWithImpl(this._self, this._then);

  final FinancialStatementsState _self;
  final $Res Function(FinancialStatementsState) _then;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? income = null,Object? balance = null,Object? cashFlow = null,Object? selectedType = null,Object? reportedCurrency = null,Object? ticker = freezed,Object? freePlanHistoryCount = null,}) {
  return _then(_self.copyWith(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as StatementFlow<IncomeStatement>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as StatementFlow<BalanceSheet>,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as StatementFlow<CashFlowStatement>,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,freePlanHistoryCount: null == freePlanHistoryCount ? _self.freePlanHistoryCount : freePlanHistoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<IncomeStatement, $Res> get income {
  
  return $StatementFlowCopyWith<IncomeStatement, $Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<BalanceSheet, $Res> get balance {
  
  return $StatementFlowCopyWith<BalanceSheet, $Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<CashFlowStatement, $Res> get cashFlow {
  
  return $StatementFlowCopyWith<CashFlowStatement, $Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FinancialStatementsState value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialStatementsState() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FinancialStatementsState value)  initial,}){
final _that = this;
switch (_that) {
case _FinancialStatementsState():
return initial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FinancialStatementsState value)?  initial,}){
final _that = this;
switch (_that) {
case _FinancialStatementsState() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StatementFlow<IncomeStatement> income,  StatementFlow<BalanceSheet> balance,  StatementFlow<CashFlowStatement> cashFlow,  FinancialStatementType selectedType,  String reportedCurrency,  String? ticker,  int freePlanHistoryCount)?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialStatementsState() when initial != null:
return initial(_that.income,_that.balance,_that.cashFlow,_that.selectedType,_that.reportedCurrency,_that.ticker,_that.freePlanHistoryCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StatementFlow<IncomeStatement> income,  StatementFlow<BalanceSheet> balance,  StatementFlow<CashFlowStatement> cashFlow,  FinancialStatementType selectedType,  String reportedCurrency,  String? ticker,  int freePlanHistoryCount)  initial,}) {final _that = this;
switch (_that) {
case _FinancialStatementsState():
return initial(_that.income,_that.balance,_that.cashFlow,_that.selectedType,_that.reportedCurrency,_that.ticker,_that.freePlanHistoryCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StatementFlow<IncomeStatement> income,  StatementFlow<BalanceSheet> balance,  StatementFlow<CashFlowStatement> cashFlow,  FinancialStatementType selectedType,  String reportedCurrency,  String? ticker,  int freePlanHistoryCount)?  initial,}) {final _that = this;
switch (_that) {
case _FinancialStatementsState() when initial != null:
return initial(_that.income,_that.balance,_that.cashFlow,_that.selectedType,_that.reportedCurrency,_that.ticker,_that.freePlanHistoryCount);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialStatementsState extends FinancialStatementsState {
  const _FinancialStatementsState({this.income = const StatementFlow<IncomeStatement>.initial(), this.balance = const StatementFlow<BalanceSheet>.initial(), this.cashFlow = const StatementFlow<CashFlowStatement>.initial(), this.selectedType = FinancialStatementType.income, this.reportedCurrency = 'USD', this.ticker, required this.freePlanHistoryCount}): super._();
  

@override@JsonKey() final  StatementFlow<IncomeStatement> income;
@override@JsonKey() final  StatementFlow<BalanceSheet> balance;
@override@JsonKey() final  StatementFlow<CashFlowStatement> cashFlow;
@override@JsonKey() final  FinancialStatementType selectedType;
@override@JsonKey() final  String reportedCurrency;
@override final  String? ticker;
@override final  int freePlanHistoryCount;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialStatementsStateCopyWith<_FinancialStatementsState> get copyWith => __$FinancialStatementsStateCopyWithImpl<_FinancialStatementsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialStatementsState&&(identical(other.income, income) || other.income == income)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.cashFlow, cashFlow) || other.cashFlow == cashFlow)&&(identical(other.selectedType, selectedType) || other.selectedType == selectedType)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.freePlanHistoryCount, freePlanHistoryCount) || other.freePlanHistoryCount == freePlanHistoryCount));
}


@override
int get hashCode => Object.hash(runtimeType,income,balance,cashFlow,selectedType,reportedCurrency,ticker,freePlanHistoryCount);

@override
String toString() {
  return 'FinancialStatementsState.initial(income: $income, balance: $balance, cashFlow: $cashFlow, selectedType: $selectedType, reportedCurrency: $reportedCurrency, ticker: $ticker, freePlanHistoryCount: $freePlanHistoryCount)';
}


}

/// @nodoc
abstract mixin class _$FinancialStatementsStateCopyWith<$Res> implements $FinancialStatementsStateCopyWith<$Res> {
  factory _$FinancialStatementsStateCopyWith(_FinancialStatementsState value, $Res Function(_FinancialStatementsState) _then) = __$FinancialStatementsStateCopyWithImpl;
@override @useResult
$Res call({
 StatementFlow<IncomeStatement> income, StatementFlow<BalanceSheet> balance, StatementFlow<CashFlowStatement> cashFlow, FinancialStatementType selectedType, String reportedCurrency, String? ticker, int freePlanHistoryCount
});


@override $StatementFlowCopyWith<IncomeStatement, $Res> get income;@override $StatementFlowCopyWith<BalanceSheet, $Res> get balance;@override $StatementFlowCopyWith<CashFlowStatement, $Res> get cashFlow;

}
/// @nodoc
class __$FinancialStatementsStateCopyWithImpl<$Res>
    implements _$FinancialStatementsStateCopyWith<$Res> {
  __$FinancialStatementsStateCopyWithImpl(this._self, this._then);

  final _FinancialStatementsState _self;
  final $Res Function(_FinancialStatementsState) _then;

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? income = null,Object? balance = null,Object? cashFlow = null,Object? selectedType = null,Object? reportedCurrency = null,Object? ticker = freezed,Object? freePlanHistoryCount = null,}) {
  return _then(_FinancialStatementsState(
income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as StatementFlow<IncomeStatement>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as StatementFlow<BalanceSheet>,cashFlow: null == cashFlow ? _self.cashFlow : cashFlow // ignore: cast_nullable_to_non_nullable
as StatementFlow<CashFlowStatement>,selectedType: null == selectedType ? _self.selectedType : selectedType // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,ticker: freezed == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String?,freePlanHistoryCount: null == freePlanHistoryCount ? _self.freePlanHistoryCount : freePlanHistoryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<IncomeStatement, $Res> get income {
  
  return $StatementFlowCopyWith<IncomeStatement, $Res>(_self.income, (value) {
    return _then(_self.copyWith(income: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<BalanceSheet, $Res> get balance {
  
  return $StatementFlowCopyWith<BalanceSheet, $Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of FinancialStatementsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatementFlowCopyWith<CashFlowStatement, $Res> get cashFlow {
  
  return $StatementFlowCopyWith<CashFlowStatement, $Res>(_self.cashFlow, (value) {
    return _then(_self.copyWith(cashFlow: value));
  });
}
}

// dart format on
