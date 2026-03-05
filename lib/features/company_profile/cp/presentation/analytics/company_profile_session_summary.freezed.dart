// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileSessionSummary {

 String get sessionId; String get ticker; String get companyName; String? get industry; String? get sector; int get tabsCount; List<String> get tabsList; int get durationSeconds; bool get isWatchlisted; bool get initWatchlisted; bool get isCompany; bool get isEtf; bool get isFund; bool get isFinal;
/// Create a copy of CompanyProfileSessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileSessionSummaryCopyWith<CompanyProfileSessionSummary> get copyWith => _$CompanyProfileSessionSummaryCopyWithImpl<CompanyProfileSessionSummary>(this as CompanyProfileSessionSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileSessionSummary&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.tabsCount, tabsCount) || other.tabsCount == tabsCount)&&const DeepCollectionEquality().equals(other.tabsList, tabsList)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted)&&(identical(other.initWatchlisted, initWatchlisted) || other.initWatchlisted == initWatchlisted)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,ticker,companyName,industry,sector,tabsCount,const DeepCollectionEquality().hash(tabsList),durationSeconds,isWatchlisted,initWatchlisted,isCompany,isEtf,isFund,isFinal);

@override
String toString() {
  return 'CompanyProfileSessionSummary(sessionId: $sessionId, ticker: $ticker, companyName: $companyName, industry: $industry, sector: $sector, tabsCount: $tabsCount, tabsList: $tabsList, durationSeconds: $durationSeconds, isWatchlisted: $isWatchlisted, initWatchlisted: $initWatchlisted, isCompany: $isCompany, isEtf: $isEtf, isFund: $isFund, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileSessionSummaryCopyWith<$Res>  {
  factory $CompanyProfileSessionSummaryCopyWith(CompanyProfileSessionSummary value, $Res Function(CompanyProfileSessionSummary) _then) = _$CompanyProfileSessionSummaryCopyWithImpl;
@useResult
$Res call({
 String sessionId, String ticker, String companyName, String? industry, String? sector, int tabsCount, List<String> tabsList, int durationSeconds, bool isWatchlisted, bool initWatchlisted, bool isCompany, bool isEtf, bool isFund, bool isFinal
});




}
/// @nodoc
class _$CompanyProfileSessionSummaryCopyWithImpl<$Res>
    implements $CompanyProfileSessionSummaryCopyWith<$Res> {
  _$CompanyProfileSessionSummaryCopyWithImpl(this._self, this._then);

  final CompanyProfileSessionSummary _self;
  final $Res Function(CompanyProfileSessionSummary) _then;

/// Create a copy of CompanyProfileSessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? ticker = null,Object? companyName = null,Object? industry = freezed,Object? sector = freezed,Object? tabsCount = null,Object? tabsList = null,Object? durationSeconds = null,Object? isWatchlisted = null,Object? initWatchlisted = null,Object? isCompany = null,Object? isEtf = null,Object? isFund = null,Object? isFinal = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,tabsCount: null == tabsCount ? _self.tabsCount : tabsCount // ignore: cast_nullable_to_non_nullable
as int,tabsList: null == tabsList ? _self.tabsList : tabsList // ignore: cast_nullable_to_non_nullable
as List<String>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,isWatchlisted: null == isWatchlisted ? _self.isWatchlisted : isWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,initWatchlisted: null == initWatchlisted ? _self.initWatchlisted : initWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyProfileSessionSummary].
extension CompanyProfileSessionSummaryPatterns on CompanyProfileSessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyProfileSessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyProfileSessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyProfileSessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  int tabsCount,  List<String> tabsList,  int durationSeconds,  bool isWatchlisted,  bool initWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  bool isFinal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary() when $default != null:
return $default(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.tabsCount,_that.tabsList,_that.durationSeconds,_that.isWatchlisted,_that.initWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.isFinal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  int tabsCount,  List<String> tabsList,  int durationSeconds,  bool isWatchlisted,  bool initWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  bool isFinal)  $default,) {final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary():
return $default(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.tabsCount,_that.tabsList,_that.durationSeconds,_that.isWatchlisted,_that.initWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.isFinal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  int tabsCount,  List<String> tabsList,  int durationSeconds,  bool isWatchlisted,  bool initWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  bool isFinal)?  $default,) {final _that = this;
switch (_that) {
case _CompanyProfileSessionSummary() when $default != null:
return $default(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.tabsCount,_that.tabsList,_that.durationSeconds,_that.isWatchlisted,_that.initWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.isFinal);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyProfileSessionSummary extends CompanyProfileSessionSummary {
  const _CompanyProfileSessionSummary({required this.sessionId, required this.ticker, required this.companyName, this.industry, this.sector, required this.tabsCount, required final  List<String> tabsList, required this.durationSeconds, required this.isWatchlisted, required this.initWatchlisted, required this.isCompany, required this.isEtf, required this.isFund, required this.isFinal}): _tabsList = tabsList,super._();
  

@override final  String sessionId;
@override final  String ticker;
@override final  String companyName;
@override final  String? industry;
@override final  String? sector;
@override final  int tabsCount;
 final  List<String> _tabsList;
@override List<String> get tabsList {
  if (_tabsList is EqualUnmodifiableListView) return _tabsList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tabsList);
}

@override final  int durationSeconds;
@override final  bool isWatchlisted;
@override final  bool initWatchlisted;
@override final  bool isCompany;
@override final  bool isEtf;
@override final  bool isFund;
@override final  bool isFinal;

/// Create a copy of CompanyProfileSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyProfileSessionSummaryCopyWith<_CompanyProfileSessionSummary> get copyWith => __$CompanyProfileSessionSummaryCopyWithImpl<_CompanyProfileSessionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyProfileSessionSummary&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.sector, sector) || other.sector == sector)&&(identical(other.tabsCount, tabsCount) || other.tabsCount == tabsCount)&&const DeepCollectionEquality().equals(other._tabsList, _tabsList)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.isWatchlisted, isWatchlisted) || other.isWatchlisted == isWatchlisted)&&(identical(other.initWatchlisted, initWatchlisted) || other.initWatchlisted == initWatchlisted)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,ticker,companyName,industry,sector,tabsCount,const DeepCollectionEquality().hash(_tabsList),durationSeconds,isWatchlisted,initWatchlisted,isCompany,isEtf,isFund,isFinal);

@override
String toString() {
  return 'CompanyProfileSessionSummary(sessionId: $sessionId, ticker: $ticker, companyName: $companyName, industry: $industry, sector: $sector, tabsCount: $tabsCount, tabsList: $tabsList, durationSeconds: $durationSeconds, isWatchlisted: $isWatchlisted, initWatchlisted: $initWatchlisted, isCompany: $isCompany, isEtf: $isEtf, isFund: $isFund, isFinal: $isFinal)';
}


}

/// @nodoc
abstract mixin class _$CompanyProfileSessionSummaryCopyWith<$Res> implements $CompanyProfileSessionSummaryCopyWith<$Res> {
  factory _$CompanyProfileSessionSummaryCopyWith(_CompanyProfileSessionSummary value, $Res Function(_CompanyProfileSessionSummary) _then) = __$CompanyProfileSessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String ticker, String companyName, String? industry, String? sector, int tabsCount, List<String> tabsList, int durationSeconds, bool isWatchlisted, bool initWatchlisted, bool isCompany, bool isEtf, bool isFund, bool isFinal
});




}
/// @nodoc
class __$CompanyProfileSessionSummaryCopyWithImpl<$Res>
    implements _$CompanyProfileSessionSummaryCopyWith<$Res> {
  __$CompanyProfileSessionSummaryCopyWithImpl(this._self, this._then);

  final _CompanyProfileSessionSummary _self;
  final $Res Function(_CompanyProfileSessionSummary) _then;

/// Create a copy of CompanyProfileSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? ticker = null,Object? companyName = null,Object? industry = freezed,Object? sector = freezed,Object? tabsCount = null,Object? tabsList = null,Object? durationSeconds = null,Object? isWatchlisted = null,Object? initWatchlisted = null,Object? isCompany = null,Object? isEtf = null,Object? isFund = null,Object? isFinal = null,}) {
  return _then(_CompanyProfileSessionSummary(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,tabsCount: null == tabsCount ? _self.tabsCount : tabsCount // ignore: cast_nullable_to_non_nullable
as int,tabsList: null == tabsList ? _self._tabsList : tabsList // ignore: cast_nullable_to_non_nullable
as List<String>,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,isWatchlisted: null == isWatchlisted ? _self.isWatchlisted : isWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,initWatchlisted: null == initWatchlisted ? _self.initWatchlisted : initWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
