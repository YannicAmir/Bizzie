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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialStatementsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FinancialStatementsEvent()';
}


}

/// @nodoc
class $FinancialStatementsEventCopyWith<$Res>  {
$FinancialStatementsEventCopyWith(FinancialStatementsEvent _, $Res Function(FinancialStatementsEvent) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadIncomeStatements value)?  loadIncomeStatements,TResult Function( LoadBalanceSheets value)?  loadBalanceSheets,TResult Function( LoadCashFlows value)?  loadCashFlows,TResult Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult Function( ViewTypeChanged value)?  viewTypeChanged,TResult Function( IncomeDateSelected value)?  incomeDateSelected,TResult Function( BalanceDateSelected value)?  balanceDateSelected,TResult Function( CashFlowDateSelected value)?  cashFlowDateSelected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case ViewTypeChanged() when viewTypeChanged != null:
return viewTypeChanged(_that);case IncomeDateSelected() when incomeDateSelected != null:
return incomeDateSelected(_that);case BalanceDateSelected() when balanceDateSelected != null:
return balanceDateSelected(_that);case CashFlowDateSelected() when cashFlowDateSelected != null:
return cashFlowDateSelected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadIncomeStatements value)  loadIncomeStatements,required TResult Function( LoadBalanceSheets value)  loadBalanceSheets,required TResult Function( LoadCashFlows value)  loadCashFlows,required TResult Function( StalenessCheckRequested value)  stalenessCheckRequested,required TResult Function( ViewTypeChanged value)  viewTypeChanged,required TResult Function( IncomeDateSelected value)  incomeDateSelected,required TResult Function( BalanceDateSelected value)  balanceDateSelected,required TResult Function( CashFlowDateSelected value)  cashFlowDateSelected,}){
final _that = this;
switch (_that) {
case LoadIncomeStatements():
return loadIncomeStatements(_that);case LoadBalanceSheets():
return loadBalanceSheets(_that);case LoadCashFlows():
return loadCashFlows(_that);case StalenessCheckRequested():
return stalenessCheckRequested(_that);case ViewTypeChanged():
return viewTypeChanged(_that);case IncomeDateSelected():
return incomeDateSelected(_that);case BalanceDateSelected():
return balanceDateSelected(_that);case CashFlowDateSelected():
return cashFlowDateSelected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadIncomeStatements value)?  loadIncomeStatements,TResult? Function( LoadBalanceSheets value)?  loadBalanceSheets,TResult? Function( LoadCashFlows value)?  loadCashFlows,TResult? Function( StalenessCheckRequested value)?  stalenessCheckRequested,TResult? Function( ViewTypeChanged value)?  viewTypeChanged,TResult? Function( IncomeDateSelected value)?  incomeDateSelected,TResult? Function( BalanceDateSelected value)?  balanceDateSelected,TResult? Function( CashFlowDateSelected value)?  cashFlowDateSelected,}){
final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that);case ViewTypeChanged() when viewTypeChanged != null:
return viewTypeChanged(_that);case IncomeDateSelected() when incomeDateSelected != null:
return incomeDateSelected(_that);case BalanceDateSelected() when balanceDateSelected != null:
return balanceDateSelected(_that);case CashFlowDateSelected() when cashFlowDateSelected != null:
return cashFlowDateSelected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticker,  bool forceRefresh)?  loadIncomeStatements,TResult Function( String ticker,  bool forceRefresh)?  loadBalanceSheets,TResult Function( String ticker,  bool forceRefresh)?  loadCashFlows,TResult Function( String ticker,  FinancialStatementType type)?  stalenessCheckRequested,TResult Function( String ticker,  FinancialStatementType type)?  viewTypeChanged,TResult Function( String date,  bool isAnnual)?  incomeDateSelected,TResult Function( String date,  bool isAnnual)?  balanceDateSelected,TResult Function( String date,  bool isAnnual)?  cashFlowDateSelected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker,_that.type);case ViewTypeChanged() when viewTypeChanged != null:
return viewTypeChanged(_that.ticker,_that.type);case IncomeDateSelected() when incomeDateSelected != null:
return incomeDateSelected(_that.date,_that.isAnnual);case BalanceDateSelected() when balanceDateSelected != null:
return balanceDateSelected(_that.date,_that.isAnnual);case CashFlowDateSelected() when cashFlowDateSelected != null:
return cashFlowDateSelected(_that.date,_that.isAnnual);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticker,  bool forceRefresh)  loadIncomeStatements,required TResult Function( String ticker,  bool forceRefresh)  loadBalanceSheets,required TResult Function( String ticker,  bool forceRefresh)  loadCashFlows,required TResult Function( String ticker,  FinancialStatementType type)  stalenessCheckRequested,required TResult Function( String ticker,  FinancialStatementType type)  viewTypeChanged,required TResult Function( String date,  bool isAnnual)  incomeDateSelected,required TResult Function( String date,  bool isAnnual)  balanceDateSelected,required TResult Function( String date,  bool isAnnual)  cashFlowDateSelected,}) {final _that = this;
switch (_that) {
case LoadIncomeStatements():
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets():
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows():
return loadCashFlows(_that.ticker,_that.forceRefresh);case StalenessCheckRequested():
return stalenessCheckRequested(_that.ticker,_that.type);case ViewTypeChanged():
return viewTypeChanged(_that.ticker,_that.type);case IncomeDateSelected():
return incomeDateSelected(_that.date,_that.isAnnual);case BalanceDateSelected():
return balanceDateSelected(_that.date,_that.isAnnual);case CashFlowDateSelected():
return cashFlowDateSelected(_that.date,_that.isAnnual);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticker,  bool forceRefresh)?  loadIncomeStatements,TResult? Function( String ticker,  bool forceRefresh)?  loadBalanceSheets,TResult? Function( String ticker,  bool forceRefresh)?  loadCashFlows,TResult? Function( String ticker,  FinancialStatementType type)?  stalenessCheckRequested,TResult? Function( String ticker,  FinancialStatementType type)?  viewTypeChanged,TResult? Function( String date,  bool isAnnual)?  incomeDateSelected,TResult? Function( String date,  bool isAnnual)?  balanceDateSelected,TResult? Function( String date,  bool isAnnual)?  cashFlowDateSelected,}) {final _that = this;
switch (_that) {
case LoadIncomeStatements() when loadIncomeStatements != null:
return loadIncomeStatements(_that.ticker,_that.forceRefresh);case LoadBalanceSheets() when loadBalanceSheets != null:
return loadBalanceSheets(_that.ticker,_that.forceRefresh);case LoadCashFlows() when loadCashFlows != null:
return loadCashFlows(_that.ticker,_that.forceRefresh);case StalenessCheckRequested() when stalenessCheckRequested != null:
return stalenessCheckRequested(_that.ticker,_that.type);case ViewTypeChanged() when viewTypeChanged != null:
return viewTypeChanged(_that.ticker,_that.type);case IncomeDateSelected() when incomeDateSelected != null:
return incomeDateSelected(_that.date,_that.isAnnual);case BalanceDateSelected() when balanceDateSelected != null:
return balanceDateSelected(_that.date,_that.isAnnual);case CashFlowDateSelected() when cashFlowDateSelected != null:
return cashFlowDateSelected(_that.date,_that.isAnnual);case _:
  return null;

}
}

}

/// @nodoc


class LoadIncomeStatements implements FinancialStatementsEvent {
  const LoadIncomeStatements(this.ticker, {this.forceRefresh = false});
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
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
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
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
  

 final  String ticker;
@JsonKey() final  bool forceRefresh;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
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
@useResult
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
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? forceRefresh = null,}) {
  return _then(LoadCashFlows(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StalenessCheckRequested implements FinancialStatementsEvent {
  const StalenessCheckRequested(this.ticker, {this.type = FinancialStatementType.income});
  

 final  String ticker;
@JsonKey() final  FinancialStatementType type;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StalenessCheckRequestedCopyWith<StalenessCheckRequested> get copyWith => _$StalenessCheckRequestedCopyWithImpl<StalenessCheckRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StalenessCheckRequested&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,type);

@override
String toString() {
  return 'FinancialStatementsEvent.stalenessCheckRequested(ticker: $ticker, type: $type)';
}


}

/// @nodoc
abstract mixin class $StalenessCheckRequestedCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $StalenessCheckRequestedCopyWith(StalenessCheckRequested value, $Res Function(StalenessCheckRequested) _then) = _$StalenessCheckRequestedCopyWithImpl;
@useResult
$Res call({
 String ticker, FinancialStatementType type
});




}
/// @nodoc
class _$StalenessCheckRequestedCopyWithImpl<$Res>
    implements $StalenessCheckRequestedCopyWith<$Res> {
  _$StalenessCheckRequestedCopyWithImpl(this._self, this._then);

  final StalenessCheckRequested _self;
  final $Res Function(StalenessCheckRequested) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? type = null,}) {
  return _then(StalenessCheckRequested(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,
  ));
}


}

/// @nodoc


class ViewTypeChanged implements FinancialStatementsEvent {
  const ViewTypeChanged(this.ticker, this.type);
  

 final  String ticker;
 final  FinancialStatementType type;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewTypeChangedCopyWith<ViewTypeChanged> get copyWith => _$ViewTypeChangedCopyWithImpl<ViewTypeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewTypeChanged&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,type);

@override
String toString() {
  return 'FinancialStatementsEvent.viewTypeChanged(ticker: $ticker, type: $type)';
}


}

/// @nodoc
abstract mixin class $ViewTypeChangedCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $ViewTypeChangedCopyWith(ViewTypeChanged value, $Res Function(ViewTypeChanged) _then) = _$ViewTypeChangedCopyWithImpl;
@useResult
$Res call({
 String ticker, FinancialStatementType type
});




}
/// @nodoc
class _$ViewTypeChangedCopyWithImpl<$Res>
    implements $ViewTypeChangedCopyWith<$Res> {
  _$ViewTypeChangedCopyWithImpl(this._self, this._then);

  final ViewTypeChanged _self;
  final $Res Function(ViewTypeChanged) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? type = null,}) {
  return _then(ViewTypeChanged(
null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FinancialStatementType,
  ));
}


}

/// @nodoc


class IncomeDateSelected implements FinancialStatementsEvent {
  const IncomeDateSelected(this.date, {required this.isAnnual});
  

 final  String date;
 final  bool isAnnual;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeDateSelectedCopyWith<IncomeDateSelected> get copyWith => _$IncomeDateSelectedCopyWithImpl<IncomeDateSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeDateSelected&&(identical(other.date, date) || other.date == date)&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,date,isAnnual);

@override
String toString() {
  return 'FinancialStatementsEvent.incomeDateSelected(date: $date, isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $IncomeDateSelectedCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $IncomeDateSelectedCopyWith(IncomeDateSelected value, $Res Function(IncomeDateSelected) _then) = _$IncomeDateSelectedCopyWithImpl;
@useResult
$Res call({
 String date, bool isAnnual
});




}
/// @nodoc
class _$IncomeDateSelectedCopyWithImpl<$Res>
    implements $IncomeDateSelectedCopyWith<$Res> {
  _$IncomeDateSelectedCopyWithImpl(this._self, this._then);

  final IncomeDateSelected _self;
  final $Res Function(IncomeDateSelected) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isAnnual = null,}) {
  return _then(IncomeDateSelected(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class BalanceDateSelected implements FinancialStatementsEvent {
  const BalanceDateSelected(this.date, {required this.isAnnual});
  

 final  String date;
 final  bool isAnnual;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceDateSelectedCopyWith<BalanceDateSelected> get copyWith => _$BalanceDateSelectedCopyWithImpl<BalanceDateSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceDateSelected&&(identical(other.date, date) || other.date == date)&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,date,isAnnual);

@override
String toString() {
  return 'FinancialStatementsEvent.balanceDateSelected(date: $date, isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $BalanceDateSelectedCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $BalanceDateSelectedCopyWith(BalanceDateSelected value, $Res Function(BalanceDateSelected) _then) = _$BalanceDateSelectedCopyWithImpl;
@useResult
$Res call({
 String date, bool isAnnual
});




}
/// @nodoc
class _$BalanceDateSelectedCopyWithImpl<$Res>
    implements $BalanceDateSelectedCopyWith<$Res> {
  _$BalanceDateSelectedCopyWithImpl(this._self, this._then);

  final BalanceDateSelected _self;
  final $Res Function(BalanceDateSelected) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isAnnual = null,}) {
  return _then(BalanceDateSelected(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CashFlowDateSelected implements FinancialStatementsEvent {
  const CashFlowDateSelected(this.date, {required this.isAnnual});
  

 final  String date;
 final  bool isAnnual;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashFlowDateSelectedCopyWith<CashFlowDateSelected> get copyWith => _$CashFlowDateSelectedCopyWithImpl<CashFlowDateSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowDateSelected&&(identical(other.date, date) || other.date == date)&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,date,isAnnual);

@override
String toString() {
  return 'FinancialStatementsEvent.cashFlowDateSelected(date: $date, isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $CashFlowDateSelectedCopyWith<$Res> implements $FinancialStatementsEventCopyWith<$Res> {
  factory $CashFlowDateSelectedCopyWith(CashFlowDateSelected value, $Res Function(CashFlowDateSelected) _then) = _$CashFlowDateSelectedCopyWithImpl;
@useResult
$Res call({
 String date, bool isAnnual
});




}
/// @nodoc
class _$CashFlowDateSelectedCopyWithImpl<$Res>
    implements $CashFlowDateSelectedCopyWith<$Res> {
  _$CashFlowDateSelectedCopyWithImpl(this._self, this._then);

  final CashFlowDateSelected _self;
  final $Res Function(CashFlowDateSelected) _then;

/// Create a copy of FinancialStatementsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isAnnual = null,}) {
  return _then(CashFlowDateSelected(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
