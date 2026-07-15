// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileState()';
}


}

/// @nodoc
class $CompanyProfileStateCopyWith<$Res>  {
$CompanyProfileStateCopyWith(CompanyProfileState _, $Res Function(CompanyProfileState) __);
}


/// Adds pattern-matching-related methods to [CompanyProfileState].
extension CompanyProfileStatePatterns on CompanyProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Active value)?  active,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Active() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Active value)  active,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Active():
return active(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Active value)?  active,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Active() when active != null:
return active(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  Set<String> viewedTabs,  String activeTabName,  int accumulatedSeconds,  DateTime lastActiveStartTime,  bool initiallyWatchlisted,  bool currentWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  BizzieLifecycleState lifecycleState)?  active,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Active() when active != null:
return active(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.viewedTabs,_that.activeTabName,_that.accumulatedSeconds,_that.lastActiveStartTime,_that.initiallyWatchlisted,_that.currentWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.lifecycleState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  Set<String> viewedTabs,  String activeTabName,  int accumulatedSeconds,  DateTime lastActiveStartTime,  bool initiallyWatchlisted,  bool currentWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  BizzieLifecycleState lifecycleState)  active,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Active():
return active(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.viewedTabs,_that.activeTabName,_that.accumulatedSeconds,_that.lastActiveStartTime,_that.initiallyWatchlisted,_that.currentWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.lifecycleState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String sessionId,  String ticker,  String companyName,  String? industry,  String? sector,  Set<String> viewedTabs,  String activeTabName,  int accumulatedSeconds,  DateTime lastActiveStartTime,  bool initiallyWatchlisted,  bool currentWatchlisted,  bool isCompany,  bool isEtf,  bool isFund,  BizzieLifecycleState lifecycleState)?  active,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Active() when active != null:
return active(_that.sessionId,_that.ticker,_that.companyName,_that.industry,_that.sector,_that.viewedTabs,_that.activeTabName,_that.accumulatedSeconds,_that.lastActiveStartTime,_that.initiallyWatchlisted,_that.currentWatchlisted,_that.isCompany,_that.isEtf,_that.isFund,_that.lifecycleState);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements CompanyProfileState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyProfileState.initial()';
}


}




/// @nodoc


class Active implements CompanyProfileState {
  const Active({required this.sessionId, required this.ticker, required this.companyName, required this.industry, required this.sector, required final  Set<String> viewedTabs, required this.activeTabName, required this.accumulatedSeconds, required this.lastActiveStartTime, required this.initiallyWatchlisted, required this.currentWatchlisted, required this.isCompany, required this.isEtf, required this.isFund, required this.lifecycleState}): _viewedTabs = viewedTabs;
  

 final  String sessionId;
 final  String ticker;
 final  String companyName;
 final  String? industry;
 final  String? sector;
 final  Set<String> _viewedTabs;
 Set<String> get viewedTabs {
  if (_viewedTabs is EqualUnmodifiableSetView) return _viewedTabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_viewedTabs);
}

 final  String activeTabName;
 final  int accumulatedSeconds;
 final  DateTime lastActiveStartTime;
 final  bool initiallyWatchlisted;
 final  bool currentWatchlisted;
 final  bool isCompany;
 final  bool isEtf;
 final  bool isFund;
 final  BizzieLifecycleState lifecycleState;

/// Create a copy of CompanyProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveCopyWith<Active> get copyWith => _$ActiveCopyWithImpl<Active>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Active&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.sector, sector) || other.sector == sector)&&const DeepCollectionEquality().equals(other._viewedTabs, _viewedTabs)&&(identical(other.activeTabName, activeTabName) || other.activeTabName == activeTabName)&&(identical(other.accumulatedSeconds, accumulatedSeconds) || other.accumulatedSeconds == accumulatedSeconds)&&(identical(other.lastActiveStartTime, lastActiveStartTime) || other.lastActiveStartTime == lastActiveStartTime)&&(identical(other.initiallyWatchlisted, initiallyWatchlisted) || other.initiallyWatchlisted == initiallyWatchlisted)&&(identical(other.currentWatchlisted, currentWatchlisted) || other.currentWatchlisted == currentWatchlisted)&&(identical(other.isCompany, isCompany) || other.isCompany == isCompany)&&(identical(other.isEtf, isEtf) || other.isEtf == isEtf)&&(identical(other.isFund, isFund) || other.isFund == isFund)&&(identical(other.lifecycleState, lifecycleState) || other.lifecycleState == lifecycleState));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,ticker,companyName,industry,sector,const DeepCollectionEquality().hash(_viewedTabs),activeTabName,accumulatedSeconds,lastActiveStartTime,initiallyWatchlisted,currentWatchlisted,isCompany,isEtf,isFund,lifecycleState);

@override
String toString() {
  return 'CompanyProfileState.active(sessionId: $sessionId, ticker: $ticker, companyName: $companyName, industry: $industry, sector: $sector, viewedTabs: $viewedTabs, activeTabName: $activeTabName, accumulatedSeconds: $accumulatedSeconds, lastActiveStartTime: $lastActiveStartTime, initiallyWatchlisted: $initiallyWatchlisted, currentWatchlisted: $currentWatchlisted, isCompany: $isCompany, isEtf: $isEtf, isFund: $isFund, lifecycleState: $lifecycleState)';
}


}

/// @nodoc
abstract mixin class $ActiveCopyWith<$Res> implements $CompanyProfileStateCopyWith<$Res> {
  factory $ActiveCopyWith(Active value, $Res Function(Active) _then) = _$ActiveCopyWithImpl;
@useResult
$Res call({
 String sessionId, String ticker, String companyName, String? industry, String? sector, Set<String> viewedTabs, String activeTabName, int accumulatedSeconds, DateTime lastActiveStartTime, bool initiallyWatchlisted, bool currentWatchlisted, bool isCompany, bool isEtf, bool isFund, BizzieLifecycleState lifecycleState
});




}
/// @nodoc
class _$ActiveCopyWithImpl<$Res>
    implements $ActiveCopyWith<$Res> {
  _$ActiveCopyWithImpl(this._self, this._then);

  final Active _self;
  final $Res Function(Active) _then;

/// Create a copy of CompanyProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? ticker = null,Object? companyName = null,Object? industry = freezed,Object? sector = freezed,Object? viewedTabs = null,Object? activeTabName = null,Object? accumulatedSeconds = null,Object? lastActiveStartTime = null,Object? initiallyWatchlisted = null,Object? currentWatchlisted = null,Object? isCompany = null,Object? isEtf = null,Object? isFund = null,Object? lifecycleState = null,}) {
  return _then(Active(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,sector: freezed == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String?,viewedTabs: null == viewedTabs ? _self._viewedTabs : viewedTabs // ignore: cast_nullable_to_non_nullable
as Set<String>,activeTabName: null == activeTabName ? _self.activeTabName : activeTabName // ignore: cast_nullable_to_non_nullable
as String,accumulatedSeconds: null == accumulatedSeconds ? _self.accumulatedSeconds : accumulatedSeconds // ignore: cast_nullable_to_non_nullable
as int,lastActiveStartTime: null == lastActiveStartTime ? _self.lastActiveStartTime : lastActiveStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,initiallyWatchlisted: null == initiallyWatchlisted ? _self.initiallyWatchlisted : initiallyWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,currentWatchlisted: null == currentWatchlisted ? _self.currentWatchlisted : currentWatchlisted // ignore: cast_nullable_to_non_nullable
as bool,isCompany: null == isCompany ? _self.isCompany : isCompany // ignore: cast_nullable_to_non_nullable
as bool,isEtf: null == isEtf ? _self.isEtf : isEtf // ignore: cast_nullable_to_non_nullable
as bool,isFund: null == isFund ? _self.isFund : isFund // ignore: cast_nullable_to_non_nullable
as bool,lifecycleState: null == lifecycleState ? _self.lifecycleState : lifecycleState // ignore: cast_nullable_to_non_nullable
as BizzieLifecycleState,
  ));
}


}

// dart format on
