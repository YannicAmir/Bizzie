// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_filings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyFilings {

 List<FinancialReport> get reports; List<SecFiling> get filings; List<WeeklyReport> get weeklyReports;
/// Create a copy of CompanyFilings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyFilingsCopyWith<CompanyFilings> get copyWith => _$CompanyFilingsCopyWithImpl<CompanyFilings>(this as CompanyFilings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyFilings&&const DeepCollectionEquality().equals(other.reports, reports)&&const DeepCollectionEquality().equals(other.filings, filings)&&const DeepCollectionEquality().equals(other.weeklyReports, weeklyReports));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reports),const DeepCollectionEquality().hash(filings),const DeepCollectionEquality().hash(weeklyReports));

@override
String toString() {
  return 'CompanyFilings(reports: $reports, filings: $filings, weeklyReports: $weeklyReports)';
}


}

/// @nodoc
abstract mixin class $CompanyFilingsCopyWith<$Res>  {
  factory $CompanyFilingsCopyWith(CompanyFilings value, $Res Function(CompanyFilings) _then) = _$CompanyFilingsCopyWithImpl;
@useResult
$Res call({
 List<FinancialReport> reports, List<SecFiling> filings, List<WeeklyReport> weeklyReports
});




}
/// @nodoc
class _$CompanyFilingsCopyWithImpl<$Res>
    implements $CompanyFilingsCopyWith<$Res> {
  _$CompanyFilingsCopyWithImpl(this._self, this._then);

  final CompanyFilings _self;
  final $Res Function(CompanyFilings) _then;

/// Create a copy of CompanyFilings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reports = null,Object? filings = null,Object? weeklyReports = null,}) {
  return _then(_self.copyWith(
reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,filings: null == filings ? _self.filings : filings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,weeklyReports: null == weeklyReports ? _self.weeklyReports : weeklyReports // ignore: cast_nullable_to_non_nullable
as List<WeeklyReport>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyFilings].
extension CompanyFilingsPatterns on CompanyFilings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyFilings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyFilings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyFilings value)  $default,){
final _that = this;
switch (_that) {
case _CompanyFilings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyFilings value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyFilings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FinancialReport> reports,  List<SecFiling> filings,  List<WeeklyReport> weeklyReports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyFilings() when $default != null:
return $default(_that.reports,_that.filings,_that.weeklyReports);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FinancialReport> reports,  List<SecFiling> filings,  List<WeeklyReport> weeklyReports)  $default,) {final _that = this;
switch (_that) {
case _CompanyFilings():
return $default(_that.reports,_that.filings,_that.weeklyReports);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FinancialReport> reports,  List<SecFiling> filings,  List<WeeklyReport> weeklyReports)?  $default,) {final _that = this;
switch (_that) {
case _CompanyFilings() when $default != null:
return $default(_that.reports,_that.filings,_that.weeklyReports);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyFilings implements CompanyFilings {
  const _CompanyFilings({final  List<FinancialReport> reports = const [], final  List<SecFiling> filings = const [], final  List<WeeklyReport> weeklyReports = const []}): _reports = reports,_filings = filings,_weeklyReports = weeklyReports;
  

 final  List<FinancialReport> _reports;
@override@JsonKey() List<FinancialReport> get reports {
  if (_reports is EqualUnmodifiableListView) return _reports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reports);
}

 final  List<SecFiling> _filings;
@override@JsonKey() List<SecFiling> get filings {
  if (_filings is EqualUnmodifiableListView) return _filings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filings);
}

 final  List<WeeklyReport> _weeklyReports;
@override@JsonKey() List<WeeklyReport> get weeklyReports {
  if (_weeklyReports is EqualUnmodifiableListView) return _weeklyReports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyReports);
}


/// Create a copy of CompanyFilings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyFilingsCopyWith<_CompanyFilings> get copyWith => __$CompanyFilingsCopyWithImpl<_CompanyFilings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyFilings&&const DeepCollectionEquality().equals(other._reports, _reports)&&const DeepCollectionEquality().equals(other._filings, _filings)&&const DeepCollectionEquality().equals(other._weeklyReports, _weeklyReports));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reports),const DeepCollectionEquality().hash(_filings),const DeepCollectionEquality().hash(_weeklyReports));

@override
String toString() {
  return 'CompanyFilings(reports: $reports, filings: $filings, weeklyReports: $weeklyReports)';
}


}

/// @nodoc
abstract mixin class _$CompanyFilingsCopyWith<$Res> implements $CompanyFilingsCopyWith<$Res> {
  factory _$CompanyFilingsCopyWith(_CompanyFilings value, $Res Function(_CompanyFilings) _then) = __$CompanyFilingsCopyWithImpl;
@override @useResult
$Res call({
 List<FinancialReport> reports, List<SecFiling> filings, List<WeeklyReport> weeklyReports
});




}
/// @nodoc
class __$CompanyFilingsCopyWithImpl<$Res>
    implements _$CompanyFilingsCopyWith<$Res> {
  __$CompanyFilingsCopyWithImpl(this._self, this._then);

  final _CompanyFilings _self;
  final $Res Function(_CompanyFilings) _then;

/// Create a copy of CompanyFilings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reports = null,Object? filings = null,Object? weeklyReports = null,}) {
  return _then(_CompanyFilings(
reports: null == reports ? _self._reports : reports // ignore: cast_nullable_to_non_nullable
as List<FinancialReport>,filings: null == filings ? _self._filings : filings // ignore: cast_nullable_to_non_nullable
as List<SecFiling>,weeklyReports: null == weeklyReports ? _self._weeklyReports : weeklyReports // ignore: cast_nullable_to_non_nullable
as List<WeeklyReport>,
  ));
}


}

// dart format on
