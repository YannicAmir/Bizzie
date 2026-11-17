// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_sheet_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BalanceSheetDto {

 String? get date; String? get symbol; String? get reportedCurrency; String? get cik; String? get fillingDate; String? get acceptedDate; String? get calendarYear; String? get period; double? get totalAssets; double? get totalLiabilities; double? get totalEquity; double? get totalCurrentAssets; double? get totalNonCurrentAssets; double? get totalCurrentLiabilities; double? get totalNonCurrentLiabilities; double? get longTermDebt; double? get shortTermDebt; double? get cashAndShortTermInvestments; double? get netDebt; double? get totalDebt;
/// Create a copy of BalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSheetDtoCopyWith<BalanceSheetDto> get copyWith => _$BalanceSheetDtoCopyWithImpl<BalanceSheetDto>(this as BalanceSheetDto, _$identity);

  /// Serializes this BalanceSheetDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BalanceSheetDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSheetDto&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.symbol, _this.symbol) || other.symbol == _this.symbol)&&(identical(other.reportedCurrency, _this.reportedCurrency) || other.reportedCurrency == _this.reportedCurrency)&&(identical(other.cik, _this.cik) || other.cik == _this.cik)&&(identical(other.fillingDate, _this.fillingDate) || other.fillingDate == _this.fillingDate)&&(identical(other.acceptedDate, _this.acceptedDate) || other.acceptedDate == _this.acceptedDate)&&(identical(other.calendarYear, _this.calendarYear) || other.calendarYear == _this.calendarYear)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.totalAssets, _this.totalAssets) || other.totalAssets == _this.totalAssets)&&(identical(other.totalLiabilities, _this.totalLiabilities) || other.totalLiabilities == _this.totalLiabilities)&&(identical(other.totalEquity, _this.totalEquity) || other.totalEquity == _this.totalEquity)&&(identical(other.totalCurrentAssets, _this.totalCurrentAssets) || other.totalCurrentAssets == _this.totalCurrentAssets)&&(identical(other.totalNonCurrentAssets, _this.totalNonCurrentAssets) || other.totalNonCurrentAssets == _this.totalNonCurrentAssets)&&(identical(other.totalCurrentLiabilities, _this.totalCurrentLiabilities) || other.totalCurrentLiabilities == _this.totalCurrentLiabilities)&&(identical(other.totalNonCurrentLiabilities, _this.totalNonCurrentLiabilities) || other.totalNonCurrentLiabilities == _this.totalNonCurrentLiabilities)&&(identical(other.longTermDebt, _this.longTermDebt) || other.longTermDebt == _this.longTermDebt)&&(identical(other.shortTermDebt, _this.shortTermDebt) || other.shortTermDebt == _this.shortTermDebt)&&(identical(other.cashAndShortTermInvestments, _this.cashAndShortTermInvestments) || other.cashAndShortTermInvestments == _this.cashAndShortTermInvestments)&&(identical(other.netDebt, _this.netDebt) || other.netDebt == _this.netDebt)&&(identical(other.totalDebt, _this.totalDebt) || other.totalDebt == _this.totalDebt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BalanceSheetDto;
  return Object.hashAll([runtimeType,_this.date,_this.symbol,_this.reportedCurrency,_this.cik,_this.fillingDate,_this.acceptedDate,_this.calendarYear,_this.period,_this.totalAssets,_this.totalLiabilities,_this.totalEquity,_this.totalCurrentAssets,_this.totalNonCurrentAssets,_this.totalCurrentLiabilities,_this.totalNonCurrentLiabilities,_this.longTermDebt,_this.shortTermDebt,_this.cashAndShortTermInvestments,_this.netDebt,_this.totalDebt]);
}

@override
String toString() {
  final _this = this as BalanceSheetDto;
  return 'BalanceSheetDto(date: ${_this.date}, symbol: ${_this.symbol}, reportedCurrency: ${_this.reportedCurrency}, cik: ${_this.cik}, fillingDate: ${_this.fillingDate}, acceptedDate: ${_this.acceptedDate}, calendarYear: ${_this.calendarYear}, period: ${_this.period}, totalAssets: ${_this.totalAssets}, totalLiabilities: ${_this.totalLiabilities}, totalEquity: ${_this.totalEquity}, totalCurrentAssets: ${_this.totalCurrentAssets}, totalNonCurrentAssets: ${_this.totalNonCurrentAssets}, totalCurrentLiabilities: ${_this.totalCurrentLiabilities}, totalNonCurrentLiabilities: ${_this.totalNonCurrentLiabilities}, longTermDebt: ${_this.longTermDebt}, shortTermDebt: ${_this.shortTermDebt}, cashAndShortTermInvestments: ${_this.cashAndShortTermInvestments}, netDebt: ${_this.netDebt}, totalDebt: ${_this.totalDebt})';
}


}

/// @nodoc
abstract mixin class $BalanceSheetDtoCopyWith<$Res>  {
  factory $BalanceSheetDtoCopyWith(BalanceSheetDto value, $Res Function(BalanceSheetDto) _then) = _$BalanceSheetDtoCopyWithImpl;
@useResult
$Res call({
 String? date, String? symbol, String? reportedCurrency, String? cik, String? fillingDate, String? acceptedDate, String? calendarYear, String? period, double? totalAssets, double? totalLiabilities, double? totalEquity, double? totalCurrentAssets, double? totalNonCurrentAssets, double? totalCurrentLiabilities, double? totalNonCurrentLiabilities, double? longTermDebt, double? shortTermDebt, double? cashAndShortTermInvestments, double? netDebt, double? totalDebt
});




}
/// @nodoc
class _$BalanceSheetDtoCopyWithImpl<$Res>
    implements $BalanceSheetDtoCopyWith<$Res> {
  _$BalanceSheetDtoCopyWithImpl(this._self, this._then);

  final BalanceSheetDto _self;
  final $Res Function(BalanceSheetDto) _then;

/// Create a copy of BalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? symbol = freezed,Object? reportedCurrency = freezed,Object? cik = freezed,Object? fillingDate = freezed,Object? acceptedDate = freezed,Object? calendarYear = freezed,Object? period = freezed,Object? totalAssets = freezed,Object? totalLiabilities = freezed,Object? totalEquity = freezed,Object? totalCurrentAssets = freezed,Object? totalNonCurrentAssets = freezed,Object? totalCurrentLiabilities = freezed,Object? totalNonCurrentLiabilities = freezed,Object? longTermDebt = freezed,Object? shortTermDebt = freezed,Object? cashAndShortTermInvestments = freezed,Object? netDebt = freezed,Object? totalDebt = freezed,}) {
  return _then(BalanceSheetDto(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,reportedCurrency: freezed == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String?,cik: freezed == cik ? _self.cik : cik // ignore: cast_nullable_to_non_nullable
as String?,fillingDate: freezed == fillingDate ? _self.fillingDate : fillingDate // ignore: cast_nullable_to_non_nullable
as String?,acceptedDate: freezed == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String?,calendarYear: freezed == calendarYear ? _self.calendarYear : calendarYear // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,totalAssets: freezed == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double?,totalLiabilities: freezed == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalEquity: freezed == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double?,totalCurrentAssets: freezed == totalCurrentAssets ? _self.totalCurrentAssets : totalCurrentAssets // ignore: cast_nullable_to_non_nullable
as double?,totalNonCurrentAssets: freezed == totalNonCurrentAssets ? _self.totalNonCurrentAssets : totalNonCurrentAssets // ignore: cast_nullable_to_non_nullable
as double?,totalCurrentLiabilities: freezed == totalCurrentLiabilities ? _self.totalCurrentLiabilities : totalCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalNonCurrentLiabilities: freezed == totalNonCurrentLiabilities ? _self.totalNonCurrentLiabilities : totalNonCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double?,longTermDebt: freezed == longTermDebt ? _self.longTermDebt : longTermDebt // ignore: cast_nullable_to_non_nullable
as double?,shortTermDebt: freezed == shortTermDebt ? _self.shortTermDebt : shortTermDebt // ignore: cast_nullable_to_non_nullable
as double?,cashAndShortTermInvestments: freezed == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double?,netDebt: freezed == netDebt ? _self.netDebt : netDebt // ignore: cast_nullable_to_non_nullable
as double?,totalDebt: freezed == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BalanceSheetDto].
extension BalanceSheetDtoPatterns on BalanceSheetDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSheetDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSheetDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSheetDto value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSheetDto value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSheetDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  String? symbol,  String? reportedCurrency,  String? cik,  String? fillingDate,  String? acceptedDate,  String? calendarYear,  String? period,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalCurrentAssets,  double? totalNonCurrentAssets,  double? totalCurrentLiabilities,  double? totalNonCurrentLiabilities,  double? longTermDebt,  double? shortTermDebt,  double? cashAndShortTermInvestments,  double? netDebt,  double? totalDebt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSheetDto() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.fillingDate,_that.acceptedDate,_that.calendarYear,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt,_that.cashAndShortTermInvestments,_that.netDebt,_that.totalDebt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  String? symbol,  String? reportedCurrency,  String? cik,  String? fillingDate,  String? acceptedDate,  String? calendarYear,  String? period,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalCurrentAssets,  double? totalNonCurrentAssets,  double? totalCurrentLiabilities,  double? totalNonCurrentLiabilities,  double? longTermDebt,  double? shortTermDebt,  double? cashAndShortTermInvestments,  double? netDebt,  double? totalDebt)  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetDto():
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.fillingDate,_that.acceptedDate,_that.calendarYear,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt,_that.cashAndShortTermInvestments,_that.netDebt,_that.totalDebt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  String? symbol,  String? reportedCurrency,  String? cik,  String? fillingDate,  String? acceptedDate,  String? calendarYear,  String? period,  double? totalAssets,  double? totalLiabilities,  double? totalEquity,  double? totalCurrentAssets,  double? totalNonCurrentAssets,  double? totalCurrentLiabilities,  double? totalNonCurrentLiabilities,  double? longTermDebt,  double? shortTermDebt,  double? cashAndShortTermInvestments,  double? netDebt,  double? totalDebt)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSheetDto() when $default != null:
return $default(_that.date,_that.symbol,_that.reportedCurrency,_that.cik,_that.fillingDate,_that.acceptedDate,_that.calendarYear,_that.period,_that.totalAssets,_that.totalLiabilities,_that.totalEquity,_that.totalCurrentAssets,_that.totalNonCurrentAssets,_that.totalCurrentLiabilities,_that.totalNonCurrentLiabilities,_that.longTermDebt,_that.shortTermDebt,_that.cashAndShortTermInvestments,_that.netDebt,_that.totalDebt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BalanceSheetDto extends BalanceSheetDto {
  const _BalanceSheetDto({this.date, this.symbol, this.reportedCurrency, this.cik, this.fillingDate, this.acceptedDate, this.calendarYear, this.period, this.totalAssets, this.totalLiabilities, this.totalEquity, this.totalCurrentAssets, this.totalNonCurrentAssets, this.totalCurrentLiabilities, this.totalNonCurrentLiabilities, this.longTermDebt, this.shortTermDebt, this.cashAndShortTermInvestments, this.netDebt, this.totalDebt}): super._();
  factory _BalanceSheetDto.fromJson(Map<String, dynamic> json) => _$BalanceSheetDtoFromJson(json);

@override final  String? date;
@override final  String? symbol;
@override final  String? reportedCurrency;
@override final  String? cik;
@override final  String? fillingDate;
@override final  String? acceptedDate;
@override final  String? calendarYear;
@override final  String? period;
@override final  double? totalAssets;
@override final  double? totalLiabilities;
@override final  double? totalEquity;
@override final  double? totalCurrentAssets;
@override final  double? totalNonCurrentAssets;
@override final  double? totalCurrentLiabilities;
@override final  double? totalNonCurrentLiabilities;
@override final  double? longTermDebt;
@override final  double? shortTermDebt;
@override final  double? cashAndShortTermInvestments;
@override final  double? netDebt;
@override final  double? totalDebt;

/// Create a copy of BalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSheetDtoCopyWith<_BalanceSheetDto> get copyWith => __$BalanceSheetDtoCopyWithImpl<_BalanceSheetDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BalanceSheetDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSheetDto&&(identical(other.date, date) || other.date == date)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.reportedCurrency, reportedCurrency) || other.reportedCurrency == reportedCurrency)&&(identical(other.cik, cik) || other.cik == cik)&&(identical(other.fillingDate, fillingDate) || other.fillingDate == fillingDate)&&(identical(other.acceptedDate, acceptedDate) || other.acceptedDate == acceptedDate)&&(identical(other.calendarYear, calendarYear) || other.calendarYear == calendarYear)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalAssets, totalAssets) || other.totalAssets == totalAssets)&&(identical(other.totalLiabilities, totalLiabilities) || other.totalLiabilities == totalLiabilities)&&(identical(other.totalEquity, totalEquity) || other.totalEquity == totalEquity)&&(identical(other.totalCurrentAssets, totalCurrentAssets) || other.totalCurrentAssets == totalCurrentAssets)&&(identical(other.totalNonCurrentAssets, totalNonCurrentAssets) || other.totalNonCurrentAssets == totalNonCurrentAssets)&&(identical(other.totalCurrentLiabilities, totalCurrentLiabilities) || other.totalCurrentLiabilities == totalCurrentLiabilities)&&(identical(other.totalNonCurrentLiabilities, totalNonCurrentLiabilities) || other.totalNonCurrentLiabilities == totalNonCurrentLiabilities)&&(identical(other.longTermDebt, longTermDebt) || other.longTermDebt == longTermDebt)&&(identical(other.shortTermDebt, shortTermDebt) || other.shortTermDebt == shortTermDebt)&&(identical(other.cashAndShortTermInvestments, cashAndShortTermInvestments) || other.cashAndShortTermInvestments == cashAndShortTermInvestments)&&(identical(other.netDebt, netDebt) || other.netDebt == netDebt)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,date,symbol,reportedCurrency,cik,fillingDate,acceptedDate,calendarYear,period,totalAssets,totalLiabilities,totalEquity,totalCurrentAssets,totalNonCurrentAssets,totalCurrentLiabilities,totalNonCurrentLiabilities,longTermDebt,shortTermDebt,cashAndShortTermInvestments,netDebt,totalDebt]);
}

@override
String toString() {
    return 'BalanceSheetDto(date: $date, symbol: $symbol, reportedCurrency: $reportedCurrency, cik: $cik, fillingDate: $fillingDate, acceptedDate: $acceptedDate, calendarYear: $calendarYear, period: $period, totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, totalEquity: $totalEquity, totalCurrentAssets: $totalCurrentAssets, totalNonCurrentAssets: $totalNonCurrentAssets, totalCurrentLiabilities: $totalCurrentLiabilities, totalNonCurrentLiabilities: $totalNonCurrentLiabilities, longTermDebt: $longTermDebt, shortTermDebt: $shortTermDebt, cashAndShortTermInvestments: $cashAndShortTermInvestments, netDebt: $netDebt, totalDebt: $totalDebt)';
}


}

/// @nodoc
abstract mixin class _$BalanceSheetDtoCopyWith<$Res> implements $BalanceSheetDtoCopyWith<$Res> {
  factory _$BalanceSheetDtoCopyWith(_BalanceSheetDto value, $Res Function(_BalanceSheetDto) _then) = __$BalanceSheetDtoCopyWithImpl;
@override @useResult
$Res call({
 String? date, String? symbol, String? reportedCurrency, String? cik, String? fillingDate, String? acceptedDate, String? calendarYear, String? period, double? totalAssets, double? totalLiabilities, double? totalEquity, double? totalCurrentAssets, double? totalNonCurrentAssets, double? totalCurrentLiabilities, double? totalNonCurrentLiabilities, double? longTermDebt, double? shortTermDebt, double? cashAndShortTermInvestments, double? netDebt, double? totalDebt
});




}
/// @nodoc
class __$BalanceSheetDtoCopyWithImpl<$Res>
    implements _$BalanceSheetDtoCopyWith<$Res> {
  __$BalanceSheetDtoCopyWithImpl(this._self, this._then);

  final _BalanceSheetDto _self;
  final $Res Function(_BalanceSheetDto) _then;

/// Create a copy of BalanceSheetDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? symbol = freezed,Object? reportedCurrency = freezed,Object? cik = freezed,Object? fillingDate = freezed,Object? acceptedDate = freezed,Object? calendarYear = freezed,Object? period = freezed,Object? totalAssets = freezed,Object? totalLiabilities = freezed,Object? totalEquity = freezed,Object? totalCurrentAssets = freezed,Object? totalNonCurrentAssets = freezed,Object? totalCurrentLiabilities = freezed,Object? totalNonCurrentLiabilities = freezed,Object? longTermDebt = freezed,Object? shortTermDebt = freezed,Object? cashAndShortTermInvestments = freezed,Object? netDebt = freezed,Object? totalDebt = freezed,}) {
  return _then(_BalanceSheetDto(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,reportedCurrency: freezed == reportedCurrency ? _self.reportedCurrency : reportedCurrency // ignore: cast_nullable_to_non_nullable
as String?,cik: freezed == cik ? _self.cik : cik // ignore: cast_nullable_to_non_nullable
as String?,fillingDate: freezed == fillingDate ? _self.fillingDate : fillingDate // ignore: cast_nullable_to_non_nullable
as String?,acceptedDate: freezed == acceptedDate ? _self.acceptedDate : acceptedDate // ignore: cast_nullable_to_non_nullable
as String?,calendarYear: freezed == calendarYear ? _self.calendarYear : calendarYear // ignore: cast_nullable_to_non_nullable
as String?,period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String?,totalAssets: freezed == totalAssets ? _self.totalAssets : totalAssets // ignore: cast_nullable_to_non_nullable
as double?,totalLiabilities: freezed == totalLiabilities ? _self.totalLiabilities : totalLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalEquity: freezed == totalEquity ? _self.totalEquity : totalEquity // ignore: cast_nullable_to_non_nullable
as double?,totalCurrentAssets: freezed == totalCurrentAssets ? _self.totalCurrentAssets : totalCurrentAssets // ignore: cast_nullable_to_non_nullable
as double?,totalNonCurrentAssets: freezed == totalNonCurrentAssets ? _self.totalNonCurrentAssets : totalNonCurrentAssets // ignore: cast_nullable_to_non_nullable
as double?,totalCurrentLiabilities: freezed == totalCurrentLiabilities ? _self.totalCurrentLiabilities : totalCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double?,totalNonCurrentLiabilities: freezed == totalNonCurrentLiabilities ? _self.totalNonCurrentLiabilities : totalNonCurrentLiabilities // ignore: cast_nullable_to_non_nullable
as double?,longTermDebt: freezed == longTermDebt ? _self.longTermDebt : longTermDebt // ignore: cast_nullable_to_non_nullable
as double?,shortTermDebt: freezed == shortTermDebt ? _self.shortTermDebt : shortTermDebt // ignore: cast_nullable_to_non_nullable
as double?,cashAndShortTermInvestments: freezed == cashAndShortTermInvestments ? _self.cashAndShortTermInvestments : cashAndShortTermInvestments // ignore: cast_nullable_to_non_nullable
as double?,netDebt: freezed == netDebt ? _self.netDebt : netDebt // ignore: cast_nullable_to_non_nullable
as double?,totalDebt: freezed == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
