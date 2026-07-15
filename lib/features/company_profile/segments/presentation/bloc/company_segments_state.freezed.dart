// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_segments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanySegmentsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanySegmentsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsState()';
}


}

/// @nodoc
class $CompanySegmentsStateCopyWith<$Res>  {
$CompanySegmentsStateCopyWith(CompanySegmentsState _, $Res Function(CompanySegmentsState) __);
}


/// Adds pattern-matching-related methods to [CompanySegmentsState].
extension CompanySegmentsStatePatterns on CompanySegmentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( CompanySegmentsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanySegmentsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( CompanySegmentsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case CompanySegmentsLoaded():
return loaded(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( CompanySegmentsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case CompanySegmentsLoaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String ticker,  RevenueProductSegments productSegments,  RevenueGeographicSegments geographicSegments,  List<String> annualPeriodKeys,  List<String> quarterlyPeriodKeys,  Map<String, int> productColorIndices,  Map<String, int> geographicColorIndices,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  String? selectedAnnualKey,  String? selectedQuarterlyKey,  DateTime? lastUpdated,  SegmentsTabViewState? analyticsState)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanySegmentsLoaded() when loaded != null:
return loaded(_that.ticker,_that.productSegments,_that.geographicSegments,_that.annualPeriodKeys,_that.quarterlyPeriodKeys,_that.productColorIndices,_that.geographicColorIndices,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.selectedAnnualKey,_that.selectedQuarterlyKey,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String ticker,  RevenueProductSegments productSegments,  RevenueGeographicSegments geographicSegments,  List<String> annualPeriodKeys,  List<String> quarterlyPeriodKeys,  Map<String, int> productColorIndices,  Map<String, int> geographicColorIndices,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  String? selectedAnnualKey,  String? selectedQuarterlyKey,  DateTime? lastUpdated,  SegmentsTabViewState? analyticsState)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case CompanySegmentsLoaded():
return loaded(_that.ticker,_that.productSegments,_that.geographicSegments,_that.annualPeriodKeys,_that.quarterlyPeriodKeys,_that.productColorIndices,_that.geographicColorIndices,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.selectedAnnualKey,_that.selectedQuarterlyKey,_that.lastUpdated,_that.analyticsState);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String ticker,  RevenueProductSegments productSegments,  RevenueGeographicSegments geographicSegments,  List<String> annualPeriodKeys,  List<String> quarterlyPeriodKeys,  Map<String, int> productColorIndices,  Map<String, int> geographicColorIndices,  int historyLimit,  CompanyProfileDataOrigin dataOrigin,  bool isAnnualView,  String? selectedAnnualKey,  String? selectedQuarterlyKey,  DateTime? lastUpdated,  SegmentsTabViewState? analyticsState)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case CompanySegmentsLoaded() when loaded != null:
return loaded(_that.ticker,_that.productSegments,_that.geographicSegments,_that.annualPeriodKeys,_that.quarterlyPeriodKeys,_that.productColorIndices,_that.geographicColorIndices,_that.historyLimit,_that.dataOrigin,_that.isAnnualView,_that.selectedAnnualKey,_that.selectedQuarterlyKey,_that.lastUpdated,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanySegmentsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsState.initial()';
}


}




/// @nodoc


class _Loading implements CompanySegmentsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySegmentsState.loading()';
}


}




/// @nodoc


class CompanySegmentsLoaded implements CompanySegmentsState {
  const CompanySegmentsLoaded({required this.ticker, required this.productSegments, required this.geographicSegments, required final  List<String> annualPeriodKeys, required final  List<String> quarterlyPeriodKeys, required final  Map<String, int> productColorIndices, required final  Map<String, int> geographicColorIndices, required this.historyLimit, required this.dataOrigin, this.isAnnualView = true, this.selectedAnnualKey, this.selectedQuarterlyKey, this.lastUpdated, this.analyticsState}): _annualPeriodKeys = annualPeriodKeys,_quarterlyPeriodKeys = quarterlyPeriodKeys,_productColorIndices = productColorIndices,_geographicColorIndices = geographicColorIndices;
  

 final  String ticker;
 final  RevenueProductSegments productSegments;
 final  RevenueGeographicSegments geographicSegments;
 final  List<String> _annualPeriodKeys;
 List<String> get annualPeriodKeys {
  if (_annualPeriodKeys is EqualUnmodifiableListView) return _annualPeriodKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annualPeriodKeys);
}

 final  List<String> _quarterlyPeriodKeys;
 List<String> get quarterlyPeriodKeys {
  if (_quarterlyPeriodKeys is EqualUnmodifiableListView) return _quarterlyPeriodKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quarterlyPeriodKeys);
}

 final  Map<String, int> _productColorIndices;
 Map<String, int> get productColorIndices {
  if (_productColorIndices is EqualUnmodifiableMapView) return _productColorIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_productColorIndices);
}

 final  Map<String, int> _geographicColorIndices;
 Map<String, int> get geographicColorIndices {
  if (_geographicColorIndices is EqualUnmodifiableMapView) return _geographicColorIndices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_geographicColorIndices);
}

 final  int historyLimit;
 final  CompanyProfileDataOrigin dataOrigin;
@JsonKey() final  bool isAnnualView;
 final  String? selectedAnnualKey;
 final  String? selectedQuarterlyKey;
 final  DateTime? lastUpdated;
 final  SegmentsTabViewState? analyticsState;

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanySegmentsLoadedCopyWith<CompanySegmentsLoaded> get copyWith => _$CompanySegmentsLoadedCopyWithImpl<CompanySegmentsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanySegmentsLoaded&&(identical(other.ticker, ticker) || other.ticker == ticker)&&(identical(other.productSegments, productSegments) || other.productSegments == productSegments)&&(identical(other.geographicSegments, geographicSegments) || other.geographicSegments == geographicSegments)&&const DeepCollectionEquality().equals(other._annualPeriodKeys, _annualPeriodKeys)&&const DeepCollectionEquality().equals(other._quarterlyPeriodKeys, _quarterlyPeriodKeys)&&const DeepCollectionEquality().equals(other._productColorIndices, _productColorIndices)&&const DeepCollectionEquality().equals(other._geographicColorIndices, _geographicColorIndices)&&(identical(other.historyLimit, historyLimit) || other.historyLimit == historyLimit)&&(identical(other.dataOrigin, dataOrigin) || other.dataOrigin == dataOrigin)&&(identical(other.isAnnualView, isAnnualView) || other.isAnnualView == isAnnualView)&&(identical(other.selectedAnnualKey, selectedAnnualKey) || other.selectedAnnualKey == selectedAnnualKey)&&(identical(other.selectedQuarterlyKey, selectedQuarterlyKey) || other.selectedQuarterlyKey == selectedQuarterlyKey)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,ticker,productSegments,geographicSegments,const DeepCollectionEquality().hash(_annualPeriodKeys),const DeepCollectionEquality().hash(_quarterlyPeriodKeys),const DeepCollectionEquality().hash(_productColorIndices),const DeepCollectionEquality().hash(_geographicColorIndices),historyLimit,dataOrigin,isAnnualView,selectedAnnualKey,selectedQuarterlyKey,lastUpdated,analyticsState);

@override
String toString() {
  return 'CompanySegmentsState.loaded(ticker: $ticker, productSegments: $productSegments, geographicSegments: $geographicSegments, annualPeriodKeys: $annualPeriodKeys, quarterlyPeriodKeys: $quarterlyPeriodKeys, productColorIndices: $productColorIndices, geographicColorIndices: $geographicColorIndices, historyLimit: $historyLimit, dataOrigin: $dataOrigin, isAnnualView: $isAnnualView, selectedAnnualKey: $selectedAnnualKey, selectedQuarterlyKey: $selectedQuarterlyKey, lastUpdated: $lastUpdated, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $CompanySegmentsLoadedCopyWith<$Res> implements $CompanySegmentsStateCopyWith<$Res> {
  factory $CompanySegmentsLoadedCopyWith(CompanySegmentsLoaded value, $Res Function(CompanySegmentsLoaded) _then) = _$CompanySegmentsLoadedCopyWithImpl;
@useResult
$Res call({
 String ticker, RevenueProductSegments productSegments, RevenueGeographicSegments geographicSegments, List<String> annualPeriodKeys, List<String> quarterlyPeriodKeys, Map<String, int> productColorIndices, Map<String, int> geographicColorIndices, int historyLimit, CompanyProfileDataOrigin dataOrigin, bool isAnnualView, String? selectedAnnualKey, String? selectedQuarterlyKey, DateTime? lastUpdated, SegmentsTabViewState? analyticsState
});


$RevenueProductSegmentsCopyWith<$Res> get productSegments;$RevenueGeographicSegmentsCopyWith<$Res> get geographicSegments;$SegmentsTabViewStateCopyWith<$Res>? get analyticsState;

}
/// @nodoc
class _$CompanySegmentsLoadedCopyWithImpl<$Res>
    implements $CompanySegmentsLoadedCopyWith<$Res> {
  _$CompanySegmentsLoadedCopyWithImpl(this._self, this._then);

  final CompanySegmentsLoaded _self;
  final $Res Function(CompanySegmentsLoaded) _then;

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticker = null,Object? productSegments = null,Object? geographicSegments = null,Object? annualPeriodKeys = null,Object? quarterlyPeriodKeys = null,Object? productColorIndices = null,Object? geographicColorIndices = null,Object? historyLimit = null,Object? dataOrigin = null,Object? isAnnualView = null,Object? selectedAnnualKey = freezed,Object? selectedQuarterlyKey = freezed,Object? lastUpdated = freezed,Object? analyticsState = freezed,}) {
  return _then(CompanySegmentsLoaded(
ticker: null == ticker ? _self.ticker : ticker // ignore: cast_nullable_to_non_nullable
as String,productSegments: null == productSegments ? _self.productSegments : productSegments // ignore: cast_nullable_to_non_nullable
as RevenueProductSegments,geographicSegments: null == geographicSegments ? _self.geographicSegments : geographicSegments // ignore: cast_nullable_to_non_nullable
as RevenueGeographicSegments,annualPeriodKeys: null == annualPeriodKeys ? _self._annualPeriodKeys : annualPeriodKeys // ignore: cast_nullable_to_non_nullable
as List<String>,quarterlyPeriodKeys: null == quarterlyPeriodKeys ? _self._quarterlyPeriodKeys : quarterlyPeriodKeys // ignore: cast_nullable_to_non_nullable
as List<String>,productColorIndices: null == productColorIndices ? _self._productColorIndices : productColorIndices // ignore: cast_nullable_to_non_nullable
as Map<String, int>,geographicColorIndices: null == geographicColorIndices ? _self._geographicColorIndices : geographicColorIndices // ignore: cast_nullable_to_non_nullable
as Map<String, int>,historyLimit: null == historyLimit ? _self.historyLimit : historyLimit // ignore: cast_nullable_to_non_nullable
as int,dataOrigin: null == dataOrigin ? _self.dataOrigin : dataOrigin // ignore: cast_nullable_to_non_nullable
as CompanyProfileDataOrigin,isAnnualView: null == isAnnualView ? _self.isAnnualView : isAnnualView // ignore: cast_nullable_to_non_nullable
as bool,selectedAnnualKey: freezed == selectedAnnualKey ? _self.selectedAnnualKey : selectedAnnualKey // ignore: cast_nullable_to_non_nullable
as String?,selectedQuarterlyKey: freezed == selectedQuarterlyKey ? _self.selectedQuarterlyKey : selectedQuarterlyKey // ignore: cast_nullable_to_non_nullable
as String?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,analyticsState: freezed == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as SegmentsTabViewState?,
  ));
}

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueProductSegmentsCopyWith<$Res> get productSegments {
  
  return $RevenueProductSegmentsCopyWith<$Res>(_self.productSegments, (value) {
    return _then(_self.copyWith(productSegments: value));
  });
}/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RevenueGeographicSegmentsCopyWith<$Res> get geographicSegments {
  
  return $RevenueGeographicSegmentsCopyWith<$Res>(_self.geographicSegments, (value) {
    return _then(_self.copyWith(geographicSegments: value));
  });
}/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SegmentsTabViewStateCopyWith<$Res>? get analyticsState {
    if (_self.analyticsState == null) {
    return null;
  }

  return $SegmentsTabViewStateCopyWith<$Res>(_self.analyticsState!, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanySegmentsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CompanySegmentsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanySegmentsStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanySegmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
