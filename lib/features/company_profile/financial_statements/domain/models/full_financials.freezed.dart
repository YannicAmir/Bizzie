// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_financials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FullFinancials {

 List<IncomeStatement> get annualIncomeStatements; List<IncomeStatement> get quarterlyIncomeStatements; List<BalanceSheet> get annualBalanceSheets; List<BalanceSheet> get quarterlyBalanceSheets; List<CashFlowStatement> get annualCashFlows; List<CashFlowStatement> get quarterlyCashFlows;
/// Create a copy of FullFinancials
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FullFinancialsCopyWith<FullFinancials> get copyWith => _$FullFinancialsCopyWithImpl<FullFinancials>(this as FullFinancials, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FullFinancials&&const DeepCollectionEquality().equals(other.annualIncomeStatements, annualIncomeStatements)&&const DeepCollectionEquality().equals(other.quarterlyIncomeStatements, quarterlyIncomeStatements)&&const DeepCollectionEquality().equals(other.annualBalanceSheets, annualBalanceSheets)&&const DeepCollectionEquality().equals(other.quarterlyBalanceSheets, quarterlyBalanceSheets)&&const DeepCollectionEquality().equals(other.annualCashFlows, annualCashFlows)&&const DeepCollectionEquality().equals(other.quarterlyCashFlows, quarterlyCashFlows));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(annualIncomeStatements),const DeepCollectionEquality().hash(quarterlyIncomeStatements),const DeepCollectionEquality().hash(annualBalanceSheets),const DeepCollectionEquality().hash(quarterlyBalanceSheets),const DeepCollectionEquality().hash(annualCashFlows),const DeepCollectionEquality().hash(quarterlyCashFlows));

@override
String toString() {
  return 'FullFinancials(annualIncomeStatements: $annualIncomeStatements, quarterlyIncomeStatements: $quarterlyIncomeStatements, annualBalanceSheets: $annualBalanceSheets, quarterlyBalanceSheets: $quarterlyBalanceSheets, annualCashFlows: $annualCashFlows, quarterlyCashFlows: $quarterlyCashFlows)';
}


}

/// @nodoc
abstract mixin class $FullFinancialsCopyWith<$Res>  {
  factory $FullFinancialsCopyWith(FullFinancials value, $Res Function(FullFinancials) _then) = _$FullFinancialsCopyWithImpl;
@useResult
$Res call({
 List<IncomeStatement> annualIncomeStatements, List<IncomeStatement> quarterlyIncomeStatements, List<BalanceSheet> annualBalanceSheets, List<BalanceSheet> quarterlyBalanceSheets, List<CashFlowStatement> annualCashFlows, List<CashFlowStatement> quarterlyCashFlows
});




}
/// @nodoc
class _$FullFinancialsCopyWithImpl<$Res>
    implements $FullFinancialsCopyWith<$Res> {
  _$FullFinancialsCopyWithImpl(this._self, this._then);

  final FullFinancials _self;
  final $Res Function(FullFinancials) _then;

/// Create a copy of FullFinancials
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annualIncomeStatements = null,Object? quarterlyIncomeStatements = null,Object? annualBalanceSheets = null,Object? quarterlyBalanceSheets = null,Object? annualCashFlows = null,Object? quarterlyCashFlows = null,}) {
  return _then(_self.copyWith(
annualIncomeStatements: null == annualIncomeStatements ? _self.annualIncomeStatements : annualIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,quarterlyIncomeStatements: null == quarterlyIncomeStatements ? _self.quarterlyIncomeStatements : quarterlyIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,annualBalanceSheets: null == annualBalanceSheets ? _self.annualBalanceSheets : annualBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,quarterlyBalanceSheets: null == quarterlyBalanceSheets ? _self.quarterlyBalanceSheets : quarterlyBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,annualCashFlows: null == annualCashFlows ? _self.annualCashFlows : annualCashFlows // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,quarterlyCashFlows: null == quarterlyCashFlows ? _self.quarterlyCashFlows : quarterlyCashFlows // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,
  ));
}

}


/// Adds pattern-matching-related methods to [FullFinancials].
extension FullFinancialsPatterns on FullFinancials {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FullFinancials value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FullFinancials() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FullFinancials value)  $default,){
final _that = this;
switch (_that) {
case _FullFinancials():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FullFinancials value)?  $default,){
final _that = this;
switch (_that) {
case _FullFinancials() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlows,  List<CashFlowStatement> quarterlyCashFlows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FullFinancials() when $default != null:
return $default(_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlows,_that.quarterlyCashFlows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlows,  List<CashFlowStatement> quarterlyCashFlows)  $default,) {final _that = this;
switch (_that) {
case _FullFinancials():
return $default(_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlows,_that.quarterlyCashFlows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IncomeStatement> annualIncomeStatements,  List<IncomeStatement> quarterlyIncomeStatements,  List<BalanceSheet> annualBalanceSheets,  List<BalanceSheet> quarterlyBalanceSheets,  List<CashFlowStatement> annualCashFlows,  List<CashFlowStatement> quarterlyCashFlows)?  $default,) {final _that = this;
switch (_that) {
case _FullFinancials() when $default != null:
return $default(_that.annualIncomeStatements,_that.quarterlyIncomeStatements,_that.annualBalanceSheets,_that.quarterlyBalanceSheets,_that.annualCashFlows,_that.quarterlyCashFlows);case _:
  return null;

}
}

}

/// @nodoc


class _FullFinancials implements FullFinancials {
  const _FullFinancials({required final  List<IncomeStatement> annualIncomeStatements, required final  List<IncomeStatement> quarterlyIncomeStatements, required final  List<BalanceSheet> annualBalanceSheets, required final  List<BalanceSheet> quarterlyBalanceSheets, required final  List<CashFlowStatement> annualCashFlows, required final  List<CashFlowStatement> quarterlyCashFlows}): _annualIncomeStatements = annualIncomeStatements,_quarterlyIncomeStatements = quarterlyIncomeStatements,_annualBalanceSheets = annualBalanceSheets,_quarterlyBalanceSheets = quarterlyBalanceSheets,_annualCashFlows = annualCashFlows,_quarterlyCashFlows = quarterlyCashFlows;
  

 final  List<IncomeStatement> _annualIncomeStatements;
@override List<IncomeStatement> get annualIncomeStatements {
  if (_annualIncomeStatements is EqualUnmodifiableListView) return _annualIncomeStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualIncomeStatements);
}

 final  List<IncomeStatement> _quarterlyIncomeStatements;
@override List<IncomeStatement> get quarterlyIncomeStatements {
  if (_quarterlyIncomeStatements is EqualUnmodifiableListView) return _quarterlyIncomeStatements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyIncomeStatements);
}

 final  List<BalanceSheet> _annualBalanceSheets;
@override List<BalanceSheet> get annualBalanceSheets {
  if (_annualBalanceSheets is EqualUnmodifiableListView) return _annualBalanceSheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualBalanceSheets);
}

 final  List<BalanceSheet> _quarterlyBalanceSheets;
@override List<BalanceSheet> get quarterlyBalanceSheets {
  if (_quarterlyBalanceSheets is EqualUnmodifiableListView) return _quarterlyBalanceSheets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyBalanceSheets);
}

 final  List<CashFlowStatement> _annualCashFlows;
@override List<CashFlowStatement> get annualCashFlows {
  if (_annualCashFlows is EqualUnmodifiableListView) return _annualCashFlows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualCashFlows);
}

 final  List<CashFlowStatement> _quarterlyCashFlows;
@override List<CashFlowStatement> get quarterlyCashFlows {
  if (_quarterlyCashFlows is EqualUnmodifiableListView) return _quarterlyCashFlows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyCashFlows);
}


/// Create a copy of FullFinancials
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FullFinancialsCopyWith<_FullFinancials> get copyWith => __$FullFinancialsCopyWithImpl<_FullFinancials>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FullFinancials&&const DeepCollectionEquality().equals(other._annualIncomeStatements, _annualIncomeStatements)&&const DeepCollectionEquality().equals(other._quarterlyIncomeStatements, _quarterlyIncomeStatements)&&const DeepCollectionEquality().equals(other._annualBalanceSheets, _annualBalanceSheets)&&const DeepCollectionEquality().equals(other._quarterlyBalanceSheets, _quarterlyBalanceSheets)&&const DeepCollectionEquality().equals(other._annualCashFlows, _annualCashFlows)&&const DeepCollectionEquality().equals(other._quarterlyCashFlows, _quarterlyCashFlows));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_annualIncomeStatements),const DeepCollectionEquality().hash(_quarterlyIncomeStatements),const DeepCollectionEquality().hash(_annualBalanceSheets),const DeepCollectionEquality().hash(_quarterlyBalanceSheets),const DeepCollectionEquality().hash(_annualCashFlows),const DeepCollectionEquality().hash(_quarterlyCashFlows));

@override
String toString() {
  return 'FullFinancials(annualIncomeStatements: $annualIncomeStatements, quarterlyIncomeStatements: $quarterlyIncomeStatements, annualBalanceSheets: $annualBalanceSheets, quarterlyBalanceSheets: $quarterlyBalanceSheets, annualCashFlows: $annualCashFlows, quarterlyCashFlows: $quarterlyCashFlows)';
}


}

/// @nodoc
abstract mixin class _$FullFinancialsCopyWith<$Res> implements $FullFinancialsCopyWith<$Res> {
  factory _$FullFinancialsCopyWith(_FullFinancials value, $Res Function(_FullFinancials) _then) = __$FullFinancialsCopyWithImpl;
@override @useResult
$Res call({
 List<IncomeStatement> annualIncomeStatements, List<IncomeStatement> quarterlyIncomeStatements, List<BalanceSheet> annualBalanceSheets, List<BalanceSheet> quarterlyBalanceSheets, List<CashFlowStatement> annualCashFlows, List<CashFlowStatement> quarterlyCashFlows
});




}
/// @nodoc
class __$FullFinancialsCopyWithImpl<$Res>
    implements _$FullFinancialsCopyWith<$Res> {
  __$FullFinancialsCopyWithImpl(this._self, this._then);

  final _FullFinancials _self;
  final $Res Function(_FullFinancials) _then;

/// Create a copy of FullFinancials
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? annualIncomeStatements = null,Object? quarterlyIncomeStatements = null,Object? annualBalanceSheets = null,Object? quarterlyBalanceSheets = null,Object? annualCashFlows = null,Object? quarterlyCashFlows = null,}) {
  return _then(_FullFinancials(
annualIncomeStatements: null == annualIncomeStatements ? _self._annualIncomeStatements : annualIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,quarterlyIncomeStatements: null == quarterlyIncomeStatements ? _self._quarterlyIncomeStatements : quarterlyIncomeStatements // ignore: cast_nullable_to_non_nullable
as List<IncomeStatement>,annualBalanceSheets: null == annualBalanceSheets ? _self._annualBalanceSheets : annualBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,quarterlyBalanceSheets: null == quarterlyBalanceSheets ? _self._quarterlyBalanceSheets : quarterlyBalanceSheets // ignore: cast_nullable_to_non_nullable
as List<BalanceSheet>,annualCashFlows: null == annualCashFlows ? _self._annualCashFlows : annualCashFlows // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,quarterlyCashFlows: null == quarterlyCashFlows ? _self._quarterlyCashFlows : quarterlyCashFlows // ignore: cast_nullable_to_non_nullable
as List<CashFlowStatement>,
  ));
}


}

// dart format on
