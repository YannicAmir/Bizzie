// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {

 OnboardingData get onboardingData; int get currentStep; OnboardingStatus get status;// Loading states
 bool get isSubmitting; bool get isLoadingSectors; bool get isAnalyzingBrands; bool get isLoadingHistory;// Analysis Simulation (0-3)
// 0: Initial
// 1: Analyzing your brands
// 2: Identifying public companies
// 3: Building your watchlist (Complete)
 int get analysisStep;// Watchlist Simulation (0-N)
// 0: Initial
// N: Complete (based on detectedCompanies.length)
 int get watchlistStep;// Data from API/RemoteConfig
// Updated to use Sector enum
 List<Sector> get availableSectors; List<HistoricalPrice> get sp500History;// Brand Data
 List<Brand> get globalBrands; List<Brand> get sectorBrands; List<Brand> get selectedBrands; String get customBrandInput;// Error message
 String? get failureMessage;// Feature Highlights Logic
 List<FeatureHighlightItem> get featureHighlights; int get currentHighlightIndex; bool get shouldNavigateToCreateAccount;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isAnalyzingBrands, isAnalyzingBrands) || other.isAnalyzingBrands == isAnalyzingBrands)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.analysisStep, analysisStep) || other.analysisStep == analysisStep)&&(identical(other.watchlistStep, watchlistStep) || other.watchlistStep == watchlistStep)&&const DeepCollectionEquality().equals(other.availableSectors, availableSectors)&&const DeepCollectionEquality().equals(other.sp500History, sp500History)&&const DeepCollectionEquality().equals(other.globalBrands, globalBrands)&&const DeepCollectionEquality().equals(other.sectorBrands, sectorBrands)&&const DeepCollectionEquality().equals(other.selectedBrands, selectedBrands)&&(identical(other.customBrandInput, customBrandInput) || other.customBrandInput == customBrandInput)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&const DeepCollectionEquality().equals(other.featureHighlights, featureHighlights)&&(identical(other.currentHighlightIndex, currentHighlightIndex) || other.currentHighlightIndex == currentHighlightIndex)&&(identical(other.shouldNavigateToCreateAccount, shouldNavigateToCreateAccount) || other.shouldNavigateToCreateAccount == shouldNavigateToCreateAccount));
}


@override
int get hashCode => Object.hashAll([runtimeType,onboardingData,currentStep,status,isSubmitting,isLoadingSectors,isAnalyzingBrands,isLoadingHistory,analysisStep,watchlistStep,const DeepCollectionEquality().hash(availableSectors),const DeepCollectionEquality().hash(sp500History),const DeepCollectionEquality().hash(globalBrands),const DeepCollectionEquality().hash(sectorBrands),const DeepCollectionEquality().hash(selectedBrands),customBrandInput,failureMessage,const DeepCollectionEquality().hash(featureHighlights),currentHighlightIndex,shouldNavigateToCreateAccount]);

@override
String toString() {
  return 'OnboardingState(onboardingData: $onboardingData, currentStep: $currentStep, status: $status, isSubmitting: $isSubmitting, isLoadingSectors: $isLoadingSectors, isAnalyzingBrands: $isAnalyzingBrands, isLoadingHistory: $isLoadingHistory, analysisStep: $analysisStep, watchlistStep: $watchlistStep, availableSectors: $availableSectors, sp500History: $sp500History, globalBrands: $globalBrands, sectorBrands: $sectorBrands, selectedBrands: $selectedBrands, customBrandInput: $customBrandInput, failureMessage: $failureMessage, featureHighlights: $featureHighlights, currentHighlightIndex: $currentHighlightIndex, shouldNavigateToCreateAccount: $shouldNavigateToCreateAccount)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 OnboardingData onboardingData, int currentStep, OnboardingStatus status, bool isSubmitting, bool isLoadingSectors, bool isAnalyzingBrands, bool isLoadingHistory, int analysisStep, int watchlistStep, List<Sector> availableSectors, List<HistoricalPrice> sp500History, List<Brand> globalBrands, List<Brand> sectorBrands, List<Brand> selectedBrands, String customBrandInput, String? failureMessage, List<FeatureHighlightItem> featureHighlights, int currentHighlightIndex, bool shouldNavigateToCreateAccount
});


$OnboardingDataCopyWith<$Res> get onboardingData;

}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboardingData = null,Object? currentStep = null,Object? status = null,Object? isSubmitting = null,Object? isLoadingSectors = null,Object? isAnalyzingBrands = null,Object? isLoadingHistory = null,Object? analysisStep = null,Object? watchlistStep = null,Object? availableSectors = null,Object? sp500History = null,Object? globalBrands = null,Object? sectorBrands = null,Object? selectedBrands = null,Object? customBrandInput = null,Object? failureMessage = freezed,Object? featureHighlights = null,Object? currentHighlightIndex = null,Object? shouldNavigateToCreateAccount = null,}) {
  return _then(_self.copyWith(
onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isAnalyzingBrands: null == isAnalyzingBrands ? _self.isAnalyzingBrands : isAnalyzingBrands // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,analysisStep: null == analysisStep ? _self.analysisStep : analysisStep // ignore: cast_nullable_to_non_nullable
as int,watchlistStep: null == watchlistStep ? _self.watchlistStep : watchlistStep // ignore: cast_nullable_to_non_nullable
as int,availableSectors: null == availableSectors ? _self.availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<Sector>,sp500History: null == sp500History ? _self.sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,globalBrands: null == globalBrands ? _self.globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,sectorBrands: null == sectorBrands ? _self.sectorBrands : sectorBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,selectedBrands: null == selectedBrands ? _self.selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,customBrandInput: null == customBrandInput ? _self.customBrandInput : customBrandInput // ignore: cast_nullable_to_non_nullable
as String,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,featureHighlights: null == featureHighlights ? _self.featureHighlights : featureHighlights // ignore: cast_nullable_to_non_nullable
as List<FeatureHighlightItem>,currentHighlightIndex: null == currentHighlightIndex ? _self.currentHighlightIndex : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
as int,shouldNavigateToCreateAccount: null == shouldNavigateToCreateAccount ? _self.shouldNavigateToCreateAccount : shouldNavigateToCreateAccount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get onboardingData {
  
  return $OnboardingDataCopyWith<$Res>(_self.onboardingData, (value) {
    return _then(_self.copyWith(onboardingData: value));
  });
}
}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingData onboardingData,  int currentStep,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isAnalyzingBrands,  bool isLoadingHistory,  int analysisStep,  int watchlistStep,  List<Sector> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> globalBrands,  List<Brand> sectorBrands,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.onboardingData,_that.currentStep,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isAnalyzingBrands,_that.isLoadingHistory,_that.analysisStep,_that.watchlistStep,_that.availableSectors,_that.sp500History,_that.globalBrands,_that.sectorBrands,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingData onboardingData,  int currentStep,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isAnalyzingBrands,  bool isLoadingHistory,  int analysisStep,  int watchlistStep,  List<Sector> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> globalBrands,  List<Brand> sectorBrands,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.onboardingData,_that.currentStep,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isAnalyzingBrands,_that.isLoadingHistory,_that.analysisStep,_that.watchlistStep,_that.availableSectors,_that.sp500History,_that.globalBrands,_that.sectorBrands,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingData onboardingData,  int currentStep,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isAnalyzingBrands,  bool isLoadingHistory,  int analysisStep,  int watchlistStep,  List<Sector> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> globalBrands,  List<Brand> sectorBrands,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.onboardingData,_that.currentStep,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isAnalyzingBrands,_that.isLoadingHistory,_that.analysisStep,_that.watchlistStep,_that.availableSectors,_that.sp500History,_that.globalBrands,_that.sectorBrands,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState extends OnboardingState {
  const _OnboardingState({required this.onboardingData, this.currentStep = 0, this.status = OnboardingStatus.initial, this.isSubmitting = false, this.isLoadingSectors = false, this.isAnalyzingBrands = false, this.isLoadingHistory = false, this.analysisStep = 0, this.watchlistStep = 0, final  List<Sector> availableSectors = const [], final  List<HistoricalPrice> sp500History = const [], final  List<Brand> globalBrands = const [], final  List<Brand> sectorBrands = const [], final  List<Brand> selectedBrands = const [], this.customBrandInput = '', this.failureMessage, final  List<FeatureHighlightItem> featureHighlights = const [], this.currentHighlightIndex = 0, this.shouldNavigateToCreateAccount = false}): _availableSectors = availableSectors,_sp500History = sp500History,_globalBrands = globalBrands,_sectorBrands = sectorBrands,_selectedBrands = selectedBrands,_featureHighlights = featureHighlights,super._();
  

@override final  OnboardingData onboardingData;
@override@JsonKey() final  int currentStep;
@override@JsonKey() final  OnboardingStatus status;
// Loading states
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isLoadingSectors;
@override@JsonKey() final  bool isAnalyzingBrands;
@override@JsonKey() final  bool isLoadingHistory;
// Analysis Simulation (0-3)
// 0: Initial
// 1: Analyzing your brands
// 2: Identifying public companies
// 3: Building your watchlist (Complete)
@override@JsonKey() final  int analysisStep;
// Watchlist Simulation (0-N)
// 0: Initial
// N: Complete (based on detectedCompanies.length)
@override@JsonKey() final  int watchlistStep;
// Data from API/RemoteConfig
// Updated to use Sector enum
 final  List<Sector> _availableSectors;
// Data from API/RemoteConfig
// Updated to use Sector enum
@override@JsonKey() List<Sector> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}

 final  List<HistoricalPrice> _sp500History;
@override@JsonKey() List<HistoricalPrice> get sp500History {
  if (_sp500History is EqualUnmodifiableListView) return _sp500History;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sp500History);
}

// Brand Data
 final  List<Brand> _globalBrands;
// Brand Data
@override@JsonKey() List<Brand> get globalBrands {
  if (_globalBrands is EqualUnmodifiableListView) return _globalBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalBrands);
}

 final  List<Brand> _sectorBrands;
@override@JsonKey() List<Brand> get sectorBrands {
  if (_sectorBrands is EqualUnmodifiableListView) return _sectorBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sectorBrands);
}

 final  List<Brand> _selectedBrands;
@override@JsonKey() List<Brand> get selectedBrands {
  if (_selectedBrands is EqualUnmodifiableListView) return _selectedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedBrands);
}

@override@JsonKey() final  String customBrandInput;
// Error message
@override final  String? failureMessage;
// Feature Highlights Logic
 final  List<FeatureHighlightItem> _featureHighlights;
// Feature Highlights Logic
@override@JsonKey() List<FeatureHighlightItem> get featureHighlights {
  if (_featureHighlights is EqualUnmodifiableListView) return _featureHighlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featureHighlights);
}

@override@JsonKey() final  int currentHighlightIndex;
@override@JsonKey() final  bool shouldNavigateToCreateAccount;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isAnalyzingBrands, isAnalyzingBrands) || other.isAnalyzingBrands == isAnalyzingBrands)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.analysisStep, analysisStep) || other.analysisStep == analysisStep)&&(identical(other.watchlistStep, watchlistStep) || other.watchlistStep == watchlistStep)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors)&&const DeepCollectionEquality().equals(other._sp500History, _sp500History)&&const DeepCollectionEquality().equals(other._globalBrands, _globalBrands)&&const DeepCollectionEquality().equals(other._sectorBrands, _sectorBrands)&&const DeepCollectionEquality().equals(other._selectedBrands, _selectedBrands)&&(identical(other.customBrandInput, customBrandInput) || other.customBrandInput == customBrandInput)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&const DeepCollectionEquality().equals(other._featureHighlights, _featureHighlights)&&(identical(other.currentHighlightIndex, currentHighlightIndex) || other.currentHighlightIndex == currentHighlightIndex)&&(identical(other.shouldNavigateToCreateAccount, shouldNavigateToCreateAccount) || other.shouldNavigateToCreateAccount == shouldNavigateToCreateAccount));
}


@override
int get hashCode => Object.hashAll([runtimeType,onboardingData,currentStep,status,isSubmitting,isLoadingSectors,isAnalyzingBrands,isLoadingHistory,analysisStep,watchlistStep,const DeepCollectionEquality().hash(_availableSectors),const DeepCollectionEquality().hash(_sp500History),const DeepCollectionEquality().hash(_globalBrands),const DeepCollectionEquality().hash(_sectorBrands),const DeepCollectionEquality().hash(_selectedBrands),customBrandInput,failureMessage,const DeepCollectionEquality().hash(_featureHighlights),currentHighlightIndex,shouldNavigateToCreateAccount]);

@override
String toString() {
  return 'OnboardingState(onboardingData: $onboardingData, currentStep: $currentStep, status: $status, isSubmitting: $isSubmitting, isLoadingSectors: $isLoadingSectors, isAnalyzingBrands: $isAnalyzingBrands, isLoadingHistory: $isLoadingHistory, analysisStep: $analysisStep, watchlistStep: $watchlistStep, availableSectors: $availableSectors, sp500History: $sp500History, globalBrands: $globalBrands, sectorBrands: $sectorBrands, selectedBrands: $selectedBrands, customBrandInput: $customBrandInput, failureMessage: $failureMessage, featureHighlights: $featureHighlights, currentHighlightIndex: $currentHighlightIndex, shouldNavigateToCreateAccount: $shouldNavigateToCreateAccount)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 OnboardingData onboardingData, int currentStep, OnboardingStatus status, bool isSubmitting, bool isLoadingSectors, bool isAnalyzingBrands, bool isLoadingHistory, int analysisStep, int watchlistStep, List<Sector> availableSectors, List<HistoricalPrice> sp500History, List<Brand> globalBrands, List<Brand> sectorBrands, List<Brand> selectedBrands, String customBrandInput, String? failureMessage, List<FeatureHighlightItem> featureHighlights, int currentHighlightIndex, bool shouldNavigateToCreateAccount
});


@override $OnboardingDataCopyWith<$Res> get onboardingData;

}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboardingData = null,Object? currentStep = null,Object? status = null,Object? isSubmitting = null,Object? isLoadingSectors = null,Object? isAnalyzingBrands = null,Object? isLoadingHistory = null,Object? analysisStep = null,Object? watchlistStep = null,Object? availableSectors = null,Object? sp500History = null,Object? globalBrands = null,Object? sectorBrands = null,Object? selectedBrands = null,Object? customBrandInput = null,Object? failureMessage = freezed,Object? featureHighlights = null,Object? currentHighlightIndex = null,Object? shouldNavigateToCreateAccount = null,}) {
  return _then(_OnboardingState(
onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isAnalyzingBrands: null == isAnalyzingBrands ? _self.isAnalyzingBrands : isAnalyzingBrands // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,analysisStep: null == analysisStep ? _self.analysisStep : analysisStep // ignore: cast_nullable_to_non_nullable
as int,watchlistStep: null == watchlistStep ? _self.watchlistStep : watchlistStep // ignore: cast_nullable_to_non_nullable
as int,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<Sector>,sp500History: null == sp500History ? _self._sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,globalBrands: null == globalBrands ? _self._globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,sectorBrands: null == sectorBrands ? _self._sectorBrands : sectorBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,selectedBrands: null == selectedBrands ? _self._selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,customBrandInput: null == customBrandInput ? _self.customBrandInput : customBrandInput // ignore: cast_nullable_to_non_nullable
as String,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,featureHighlights: null == featureHighlights ? _self._featureHighlights : featureHighlights // ignore: cast_nullable_to_non_nullable
as List<FeatureHighlightItem>,currentHighlightIndex: null == currentHighlightIndex ? _self.currentHighlightIndex : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
as int,shouldNavigateToCreateAccount: null == shouldNavigateToCreateAccount ? _self.shouldNavigateToCreateAccount : shouldNavigateToCreateAccount // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res> get onboardingData {
  
  return $OnboardingDataCopyWith<$Res>(_self.onboardingData, (value) {
    return _then(_self.copyWith(onboardingData: value));
  });
}
}

// dart format on
