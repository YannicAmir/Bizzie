// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BalanceSheet {

 String get date; String get symbol; String get reportedCurrency; String get period; double get totalAssets; double get totalLiabilities; double get totalEquity; double get cashAndShortTermInvestments; double get totalDebt; double get totalCurrentAssets; double get totalNonCurrentAssets; double get totalCurrentLiabilities; double get totalNonCurrentLiabilities; double get longTermDebt; double get shortTermDebt;
/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSheetCopyWith<BalanceSheet> get copyWith => _$BalanceSheetCopyWithImpl<BalanceSheet>(this as BalanceSheet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSheet&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities)&&(identical(other.totalEquity, totalEquity) || other.totalEquity == totalEquity)&&(identical(other.cashAndShortTermInvestments, cashAndShortTermInvestments) || other.cashAndShortTermInvestments == cashAndShortTermInvestments)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.totalCurrentAssets, totalCurrentAssets) || other.totalCurrentAssets == totalCurrentAssets)&&(identical(other.totalNonCurrentAssets, totalNonCurrentAssets) || other.totalNonCurrentAssets == totalNonCurrentAssets)&&(identical(other.totalCurrentLiabilities, totalCurrentLiabilities) || other.totalCurrentLiabilities == totalCurrentLiabilities)&&(identical(other.totalNonCurrentLiabilities, totalNonCurrentLiabilities) || other.totalNonCurrentLiabilities == totalNonCurrentLiabilities)&&(identical(other.longTermDebt, longTermDebt) || other.longTermDebt == longTermDebt)&&(identical(other.shortTermDebt, shortTermDebt) || other.shortTermDebt == shortTermDebt));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,totalAssets,totalLiabilities,totalEquity,cashAndShortTermInvestments,totalDebt,totalCurrentAssets,totalNonCurrentAssets,totalCurrentLiabilities,totalNonCurrentLiabilities,longTermDebt,shortTermDebt);

@override
String toString() {
  return 'BalanceSheet(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, totalEquity: $totalEquity, cashAndShortTermInvestments: $cashAndShortTermInvestments, totalDebt: $totalDebt, totalCurrentAssets: $totalCurrentAssets, totalNonCurrentAssets: $totalNonCurrentAssets, totalCurrentLiabilities: $totalCurrentLiabilities, totalNonCurrentLiabilities: $totalNonCurrentLiabilities, longTermDebt: $longTermDebt, shortTermDebt: $shortTermDebt)';
}


}

/// @nodoc
abstract mixin class $BalanceSheetCopyWith<$Res>  {
  factory $BalanceSheetCopyWith(BalanceSheet value, $Res Function(BalanceSheet) _then) = _$BalanceSheetCopyWithImpl;
@useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double totalAssets, double totalLiabilities, double totalEquity, double cashAndShortTermInvestments, double totalDebt, double totalCurrentAssets, double totalNonCurrentAssets, double totalCurrentLiabilities, double totalNonCurrentLiabilities, double longTermDebt, double shortTermDebt
});




}
/// @nodoc
class _$BalanceSheetCopyWithImpl<$Res>
    implements $BalanceSheetCopyWith<$Res> {
  _$BalanceSheetCopyWithImpl(this._self, this._then);

  final BalanceSheet _self;
  final $Res Function(BalanceSheet) _then;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? totalAssets = null,Object? totalLiabilities = null,Object? totalEquity = null,Object? cashAndShortTermInvestments = null,Object? totalDebt = null,Object? totalCurrentAssets = null,Object? totalNonCurrentAssets = null,Object? totalCurrentLiabilities = null,Object? totalNonCurrentLiabilities = null,Object? longTermDebt = null,Object? shortTermDebt = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double,totalEquity: null == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double,cashAndShortTermInvestments: null == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double,totalDebt: null == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double,totalCurrentAssets: null == totalCurrentAssets ? _self.totalCurrentAssets : totalCurrentAssets // ignore: cast_nullable_to_non_nullable
as double,totalNonCurrentAssets: null == totalNonCurrentAssets ? _self.totalNonCurrentAssets : totalNonCurrentAssets // ignore: cast_nullable_to_non_nullable
as double,totalCurrentLiabilities: null == totalCurrentLiabilities ? _self.totalCurrentLiabilities : totalCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double,totalNonCurrentLiabilities: null == totalNonCurrentLiabilities ? _self.totalNonCurrentLiabilities : totalNonCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double,longTermDebt: null == longTermDebt ? _self.longTermDebt : longTermDebt // ignore: cast_nullable_to_non_nullable
as double,shortTermDebt: null == shortTermDebt ? _self.shortTermDebt : shortTermDebt // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BalanceSheet].
extension BalanceSheetPatterns on BalanceSheet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSheet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSheet value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSheet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSheet value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double totalAssets,  double totalLiabilities,  double totalEquity,  double cashAndShortTermInvestments,  double totalDebt,  double totalCurrentAssets,  double totalNonCurrentAssets,  double totalCurrentLiabilities,  double totalNonCurrentLiabilities,  double longTermDebt,  double shortTermDebt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String symbol,  String reportedCurrency,  String period,  double totalAssets,  double totalLiabilities,  double totalEquity,  double cashAndShortTermInvestments,  double totalDebt,  double totalCurrentAssets,  double totalNonCurrentAssets,  double totalCurrentLiabilities,  double totalNonCurrentLiabilities,  double longTermDebt,  double shortTermDebt)  $default,) {final _that = this;
switch (_that) {
case _BalanceSheet():
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String symbol,  String reportedCurrency,  String period,  double totalAssets,  double totalLiabilities,  double totalEquity,  double cashAndShortTermInvestments,  double totalDebt,  double totalCurrentAssets,  double totalNonCurrentAssets,  double totalCurrentLiabilities,  double totalNonCurrentLiabilities,  double longTermDebt,  double shortTermDebt)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSheet() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.cashAndShortTermInvestments,_that.totalDebt,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt);case _:
  return null;

}
}

}

/// @nodoc


class _BalanceSheet implements BalanceSheet {
  const _BalanceSheet({required this.date, required this.symbol, required this.reportedCurrency, required this.period, required this.totalAssets, required this.totalLiabilities, required this.totalEquity, required this.cashAndShortTermInvestments, required this.totalDebt, required this.totalCurrentAssets, required this.totalNonCurrentAssets, required this.totalCurrentLiabilities, required this.totalNonCurrentLiabilities, required this.longTermDebt, required this.shortTermDebt});
  

@override final  String date;
@override final  String symbol;
@override final  String reportedCurrency;
@override final  String period;
@override final  double totalAssets;
@override final  double totalLiabilities;
@override final  double totalEquity;
@override final  double cashAndShortTermInvestments;
@override final  double totalDebt;
@override final  double totalCurrentAssets;
@override final  double totalNonCurrentAssets;
@override final  double totalCurrentLiabilities;
@override final  double totalNonCurrentLiabilities;
@override final  double longTermDebt;
@override final  double shortTermDebt;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSheetCopyWith<_BalanceSheet> get copyWith => __$BalanceSheetCopyWithImpl<_BalanceSheet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSheet&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities)&&(identical(other.totalEquity, totalEquity) || other.totalEquity == totalEquity)&&(identical(other.cashAndShortTermInvestments, cashAndShortTermInvestments) || other.cashAndShortTermInvestments == cashAndShortTermInvestments)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.totalCurrentAssets, totalCurrentAssets) || other.totalCurrentAssets == totalCurrentAssets)&&(identical(other.totalNonCurrentAssets, totalNonCurrentAssets) || other.totalNonCurrentAssets == totalNonCurrentAssets)&&(identical(other.totalCurrentLiabilities, totalCurrentLiabilities) || other.totalCurrentLiabilities == totalCurrentLiabilities)&&(identical(other.totalNonCurrentLiabilities, totalNonCurrentLiabilities) || other.totalNonCurrentLiabilities == totalNonCurrentLiabilities)&&(identical(other.longTermDebt, longTermDebt) || other.longTermDebt == longTermDebt)&&(identical(other.shortTermDebt, shortTermDebt) || other.shortTermDebt == shortTermDebt));
}


@override
int get hashCode => Object.hash(runtimeType,date,symbol,reportedCurrency,period,totalAssets,totalLiabilities,totalEquity,cashAndShortTermInvestments,totalDebt,totalCurrentAssets,totalNonCurrentAssets,totalCurrentLiabilities,totalNonCurrentLiabilities,longTermDebt,shortTermDebt);

@override
String toString() {
  return 'BalanceSheet(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, period: $period, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, totalEquity: $totalEquity, cashAndShortTermInvestments: $cashAndShortTermInvestments, totalDebt: $totalDebt, totalCurrentAssets: $totalCurrentAssets, totalNonCurrentAssets: $totalNonCurrentAssets, totalCurrentLiabilities: $totalCurrentLiabilities, totalNonCurrentLiabilities: $totalNonCurrentLiabilities, longTermDebt: $longTermDebt, shortTermDebt: $shortTermDebt)';
}


}

/// @nodoc
abstract mixin class _$BalanceSheetCopyWith<$Res> implements $BalanceSheetCopyWith<$Res> {
  factory _$BalanceSheetCopyWith(_BalanceSheet value, $Res Function(_BalanceSheet) _then) = __$BalanceSheetCopyWithImpl;
@override @useResult
$Res call({
 String date, String symbol, String reportedCurrency, String period, double totalAssets, double totalLiabilities, double totalEquity, double cashAndShortTermInvestments, double totalDebt, double totalCurrentAssets, double totalNonCurrentAssets, double totalCurrentLiabilities, double totalNonCurrentLiabilities, double longTermDebt, double shortTermDebt
});




}
/// @nodoc
class __$BalanceSheetCopyWithImpl<$Res>
    implements _$BalanceSheetCopyWith<$Res> {
  __$BalanceSheetCopyWithImpl(this._self, this._then);

  final _BalanceSheet _self;
  final $Res Function(_BalanceSheet) _then;

/// Create a copy of BalanceSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? symbol = null,Object? reportedCurrency = null,Object? period = null,Object? totalAssets = null,Object? totalLiabilities = null,Object? totalEquity = null,Object? cashAndShortTermInvestments = null,Object? totalDebt = null,Object? totalCurrentAssets = null,Object? totalNonCurrentAssets = null,Object? totalCurrentLiabilities = null,Object? totalNonCurrentLiabilities = null,Object? longTermDebt = null,Object? shortTermDebt = null,}) {
  return _then(_BalanceSheet(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,reportedCurrency: null == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,totalAssets: null == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double,totalLiabilities: null == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double,totalEquity: null == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double,cashAndShortTermInvestments: null == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double,totalDebt: null == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double,totalCurrentAssets: null == totalCurrentAssets ? _self.totalCurrentAssets : totalCurrentAssets // ignore: cast_nullable_to_non_nullable
as double,totalNonCurrentAssets: null == totalNonCurrentAssets ? _self.totalNonCurrentAssets : totalNonCurrentAssets // ignore: cast_nullable_to_non_nullable
as double,totalCurrentLiabilities: null == totalCurrentLiabilities ? _self.totalCurrentLiabilities : totalCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double,totalNonCurrentLiabilities: null == totalNonCurrentLiabilities ? _self.totalNonCurrentLiabilities : totalNonCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double,longTermDebt: null == longTermDebt ? _self.longTermDebt : longTermDebt // ignore: cast_nullable_to_non_nullable
as double,shortTermDebt: null == shortTermDebt ? _self.shortTermDebt : shortTermDebt // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
