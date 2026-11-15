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

 OnboardingData get onboardingData; OnboardingStatus get status; bool get isSubmitting; bool get isLoadingSectors; bool get isLoadingHistory; List<SectorViewModel> get availableSectors; List<HistoricalPrice> get sp500History; List<Brand> get selectedBrands; String get customBrandInput; String? get failureMessage; List<FeatureHighlightItem> get featureHighlights; int get currentHighlightIndex; bool get shouldNavigateToCreateAccount; bool get shouldNavigateToBuildingProfile; DateTime? get sessionEntryTime; String get sessionId; OnboardingStep? get lastStep; bool get didSubscribe; String get subscriptionType; OnboardingSkipStatus get skipStatus; OnboardingStep? get skippedAtStep; OnboardingFieldSources? get skipFieldSources; PostOnboardingDestination? get postOnboardingDestination; bool get hasViewedCompanyProfile; String? get savedProfileUid;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&const DeepCollectionEquality().equals(other.availableSectors, availableSectors)&&const DeepCollectionEquality().equals(other.sp500History, sp500History)&&const DeepCollectionEquality().equals(other.selectedBrands, selectedBrands)&&(identical(other.customBrandInput, customBrandInput) || other.customBrandInput == customBrandInput)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&const DeepCollectionEquality().equals(other.featureHighlights, featureHighlights)&&(identical(other.currentHighlightIndex, currentHighlightIndex) || other.currentHighlightIndex == currentHighlightIndex)&&(identical(other.shouldNavigateToCreateAccount, shouldNavigateToCreateAccount) || other.shouldNavigateToCreateAccount == shouldNavigateToCreateAccount)&&(identical(other.shouldNavigateToBuildingProfile, shouldNavigateToBuildingProfile) || other.shouldNavigateToBuildingProfile == shouldNavigateToBuildingProfile)&&(identical(other.sessionEntryTime, sessionEntryTime) || other.sessionEntryTime == sessionEntryTime)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.lastStep, lastStep) || other.lastStep == lastStep)&&(identical(other.didSubscribe, didSubscribe) || other.didSubscribe == didSubscribe)&&(identical(other.subscriptionType, subscriptionType) || other.subscriptionType == subscriptionType)&&(identical(other.skipStatus, skipStatus) || other.skipStatus == skipStatus)&&(identical(other.skippedAtStep, skippedAtStep) || other.skippedAtStep == skippedAtStep)&&(identical(other.skipFieldSources, skipFieldSources) || other.skipFieldSources == skipFieldSources)&&(identical(other.postOnboardingDestination, postOnboardingDestination) || other.postOnboardingDestination == postOnboardingDestination)&&(identical(other.hasViewedCompanyProfile, hasViewedCompanyProfile) || other.hasViewedCompanyProfile == hasViewedCompanyProfile)&&(identical(other.savedProfileUid, savedProfileUid) || other.savedProfileUid == savedProfileUid));
}


@override
int get hashCode => Object.hashAll([runtimeType,onboardingData,status,isSubmitting,isLoadingSectors,isLoadingHistory,const DeepCollectionEquality().hash(availableSectors),const DeepCollectionEquality().hash(sp500History),const DeepCollectionEquality().hash(selectedBrands),customBrandInput,failureMessage,const DeepCollectionEquality().hash(featureHighlights),currentHighlightIndex,shouldNavigateToCreateAccount,shouldNavigateToBuildingProfile,sessionEntryTime,sessionId,lastStep,didSubscribe,subscriptionType,skipStatus,skippedAtStep,skipFieldSources,postOnboardingDestination,hasViewedCompanyProfile,savedProfileUid]);

@override
String toString() {
  return 'OnboardingState(onboardingData: $onboardingData, status: $status, isSubmitting: $isSubmitting, isLoadingSectors: $isLoadingSectors, isLoadingHistory: $isLoadingHistory, availableSectors: $availableSectors, sp500History: $sp500History, selectedBrands: $selectedBrands, customBrandInput: $customBrandInput, failureMessage: $failureMessage, featureHighlights: $featureHighlights, currentHighlightIndex: $currentHighlightIndex, shouldNavigateToCreateAccount: $shouldNavigateToCreateAccount, shouldNavigateToBuildingProfile: $shouldNavigateToBuildingProfile, sessionEntryTime: $sessionEntryTime, sessionId: $sessionId, lastStep: $lastStep, didSubscribe: $didSubscribe, subscriptionType: $subscriptionType, skipStatus: $skipStatus, skippedAtStep: $skippedAtStep, skipFieldSources: $skipFieldSources, postOnboardingDestination: $postOnboardingDestination, hasViewedCompanyProfile: $hasViewedCompanyProfile, savedProfileUid: $savedProfileUid)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 OnboardingData onboardingData, OnboardingStatus status, bool isSubmitting, bool isLoadingSectors, bool isLoadingHistory, List<SectorViewModel> availableSectors, List<HistoricalPrice> sp500History, List<Brand> selectedBrands, String customBrandInput, String? failureMessage, List<FeatureHighlightItem> featureHighlights, int currentHighlightIndex, bool shouldNavigateToCreateAccount, bool shouldNavigateToBuildingProfile, DateTime? sessionEntryTime, String sessionId, OnboardingStep? lastStep, bool didSubscribe, String subscriptionType, OnboardingSkipStatus skipStatus, OnboardingStep? skippedAtStep, OnboardingFieldSources? skipFieldSources, PostOnboardingDestination? postOnboardingDestination, bool hasViewedCompanyProfile, String? savedProfileUid
});


$OnboardingDataCopyWith<$Res> get onboardingData;$OnboardingFieldSourcesCopyWith<$Res>? get skipFieldSources;$PostOnboardingDestinationCopyWith<$Res>? get postOnboardingDestination;

}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboardingData = null,Object? status = null,Object? isSubmitting = null,Object? isLoadingSectors = null,Object? isLoadingHistory = null,Object? availableSectors = null,Object? sp500History = null,Object? selectedBrands = null,Object? customBrandInput = null,Object? failureMessage = freezed,Object? featureHighlights = null,Object? currentHighlightIndex = null,Object? shouldNavigateToCreateAccount = null,Object? shouldNavigateToBuildingProfile = null,Object? sessionEntryTime = freezed,Object? sessionId = null,Object? lastStep = freezed,Object? didSubscribe = null,Object? subscriptionType = null,Object? skipStatus = null,Object? skippedAtStep = freezed,Object? skipFieldSources = freezed,Object? postOnboardingDestination = freezed,Object? hasViewedCompanyProfile = null,Object? savedProfileUid = freezed,}) {
  return _then(_self.copyWith(
onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,availableSectors: null == availableSectors ? _self.availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,sp500History: null == sp500History ? _self.sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,selectedBrands: null == selectedBrands ? _self.selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,customBrandInput: null == customBrandInput ? _self.customBrandInput : customBrandInput // ignore: cast_nullable_to_non_nullable
as String,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,featureHighlights: null == featureHighlights ? _self.featureHighlights : featureHighlights // ignore: cast_nullable_to_non_nullable
as List<FeatureHighlightItem>,currentHighlightIndex: null == currentHighlightIndex ? _self.currentHighlightIndex : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
as int,shouldNavigateToCreateAccount: null == shouldNavigateToCreateAccount ? _self.shouldNavigateToCreateAccount : shouldNavigateToCreateAccount // ignore: cast_nullable_to_non_nullable
as bool,shouldNavigateToBuildingProfile: null == shouldNavigateToBuildingProfile ? _self.shouldNavigateToBuildingProfile : shouldNavigateToBuildingProfile // ignore: cast_nullable_to_non_nullable
as bool,sessionEntryTime: freezed == sessionEntryTime ? _self.sessionEntryTime : sessionEntryTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,lastStep: freezed == lastStep ? _self.lastStep : lastStep // ignore: cast_nullable_to_non_nullable
as OnboardingStep?,didSubscribe: null == didSubscribe ? _self.didSubscribe : didSubscribe // ignore: cast_nullable_to_non_nullable
as bool,subscriptionType: null == subscriptionType ? _self.subscriptionType : subscriptionType // ignore: cast_nullable_to_non_nullable
as String,skipStatus: null == skipStatus ? _self.skipStatus : skipStatus // ignore: cast_nullable_to_non_nullable
as OnboardingSkipStatus,skippedAtStep: freezed == skippedAtStep ? _self.skippedAtStep : skippedAtStep // ignore: cast_nullable_to_non_nullable
as OnboardingStep?,skipFieldSources: freezed == skipFieldSources ? _self.skipFieldSources : skipFieldSources // ignore: cast_nullable_to_non_nullable
as OnboardingFieldSources?,postOnboardingDestination: freezed == postOnboardingDestination ? _self.postOnboardingDestination : postOnboardingDestination // ignore: cast_nullable_to_non_nullable
as PostOnboardingDestination?,hasViewedCompanyProfile: null == hasViewedCompanyProfile ? _self.hasViewedCompanyProfile : hasViewedCompanyProfile // ignore: cast_nullable_to_non_nullable
as bool,savedProfileUid: freezed == savedProfileUid ? _self.savedProfileUid : savedProfileUid // ignore: cast_nullable_to_non_nullable
as String?,
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
}/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<$Res>? get skipFieldSources {
    if (_self.skipFieldSources == null) {
    return null;
  }

  return $OnboardingFieldSourcesCopyWith<$Res>(_self.skipFieldSources!, (value) {
    return _then(_self.copyWith(skipFieldSources: value));
  });
}/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostOnboardingDestinationCopyWith<$Res>? get postOnboardingDestination {
    if (_self.postOnboardingDestination == null) {
    return null;
  }

  return $PostOnboardingDestinationCopyWith<$Res>(_self.postOnboardingDestination!, (value) {
    return _then(_self.copyWith(postOnboardingDestination: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _OnboardingState value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when initial != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _OnboardingState value)  initial,}){
final _that = this;
switch (_that) {
case _OnboardingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _OnboardingState value)?  initial,}){
final _that = this;
switch (_that) {
case _OnboardingState() when initial != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( OnboardingData onboardingData,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isLoadingHistory,  List<SectorViewModel> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount,  bool shouldNavigateToBuildingProfile,  DateTime? sessionEntryTime,  String sessionId,  OnboardingStep? lastStep,  bool didSubscribe,  String subscriptionType,  OnboardingSkipStatus skipStatus,  OnboardingStep? skippedAtStep,  OnboardingFieldSources? skipFieldSources,  PostOnboardingDestination? postOnboardingDestination,  bool hasViewedCompanyProfile,  String? savedProfileUid)?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when initial != null:
return initial(_that.onboardingData,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isLoadingHistory,_that.availableSectors,_that.sp500History,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount,_that.shouldNavigateToBuildingProfile,_that.sessionEntryTime,_that.sessionId,_that.lastStep,_that.didSubscribe,_that.subscriptionType,_that.skipStatus,_that.skippedAtStep,_that.skipFieldSources,_that.postOnboardingDestination,_that.hasViewedCompanyProfile,_that.savedProfileUid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( OnboardingData onboardingData,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isLoadingHistory,  List<SectorViewModel> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount,  bool shouldNavigateToBuildingProfile,  DateTime? sessionEntryTime,  String sessionId,  OnboardingStep? lastStep,  bool didSubscribe,  String subscriptionType,  OnboardingSkipStatus skipStatus,  OnboardingStep? skippedAtStep,  OnboardingFieldSources? skipFieldSources,  PostOnboardingDestination? postOnboardingDestination,  bool hasViewedCompanyProfile,  String? savedProfileUid)  initial,}) {final _that = this;
switch (_that) {
case _OnboardingState():
return initial(_that.onboardingData,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isLoadingHistory,_that.availableSectors,_that.sp500History,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount,_that.shouldNavigateToBuildingProfile,_that.sessionEntryTime,_that.sessionId,_that.lastStep,_that.didSubscribe,_that.subscriptionType,_that.skipStatus,_that.skippedAtStep,_that.skipFieldSources,_that.postOnboardingDestination,_that.hasViewedCompanyProfile,_that.savedProfileUid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( OnboardingData onboardingData,  OnboardingStatus status,  bool isSubmitting,  bool isLoadingSectors,  bool isLoadingHistory,  List<SectorViewModel> availableSectors,  List<HistoricalPrice> sp500History,  List<Brand> selectedBrands,  String customBrandInput,  String? failureMessage,  List<FeatureHighlightItem> featureHighlights,  int currentHighlightIndex,  bool shouldNavigateToCreateAccount,  bool shouldNavigateToBuildingProfile,  DateTime? sessionEntryTime,  String sessionId,  OnboardingStep? lastStep,  bool didSubscribe,  String subscriptionType,  OnboardingSkipStatus skipStatus,  OnboardingStep? skippedAtStep,  OnboardingFieldSources? skipFieldSources,  PostOnboardingDestination? postOnboardingDestination,  bool hasViewedCompanyProfile,  String? savedProfileUid)?  initial,}) {final _that = this;
switch (_that) {
case _OnboardingState() when initial != null:
return initial(_that.onboardingData,_that.status,_that.isSubmitting,_that.isLoadingSectors,_that.isLoadingHistory,_that.availableSectors,_that.sp500History,_that.selectedBrands,_that.customBrandInput,_that.failureMessage,_that.featureHighlights,_that.currentHighlightIndex,_that.shouldNavigateToCreateAccount,_that.shouldNavigateToBuildingProfile,_that.sessionEntryTime,_that.sessionId,_that.lastStep,_that.didSubscribe,_that.subscriptionType,_that.skipStatus,_that.skippedAtStep,_that.skipFieldSources,_that.postOnboardingDestination,_that.hasViewedCompanyProfile,_that.savedProfileUid);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState extends OnboardingState {
  const _OnboardingState({this.onboardingData = const OnboardingData(), this.status = OnboardingStatus.initial, this.isSubmitting = false, this.isLoadingSectors = false, this.isLoadingHistory = false, final  List<SectorViewModel> availableSectors = const [], final  List<HistoricalPrice> sp500History = const [], final  List<Brand> selectedBrands = const [], this.customBrandInput = '', this.failureMessage, final  List<FeatureHighlightItem> featureHighlights = const [], this.currentHighlightIndex = 0, this.shouldNavigateToCreateAccount = false, this.shouldNavigateToBuildingProfile = false, this.sessionEntryTime, this.sessionId = '', this.lastStep, this.didSubscribe = false, this.subscriptionType = 'none', this.skipStatus = OnboardingSkipStatus.initial, this.skippedAtStep, this.skipFieldSources, this.postOnboardingDestination, this.hasViewedCompanyProfile = false, this.savedProfileUid}): _availableSectors = availableSectors,_sp500History = sp500History,_selectedBrands = selectedBrands,_featureHighlights = featureHighlights,super._();
  

@override@JsonKey() final  OnboardingData onboardingData;
@override@JsonKey() final  OnboardingStatus status;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isLoadingSectors;
@override@JsonKey() final  bool isLoadingHistory;
 final  List<SectorViewModel> _availableSectors;
@override@JsonKey() List<SectorViewModel> get availableSectors {
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

 final  List<Brand> _selectedBrands;
@override@JsonKey() List<Brand> get selectedBrands {
  if (_selectedBrands is EqualUnmodifiableListView) return _selectedBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedBrands);
}

@override@JsonKey() final  String customBrandInput;
@override final  String? failureMessage;
 final  List<FeatureHighlightItem> _featureHighlights;
@override@JsonKey() List<FeatureHighlightItem> get featureHighlights {
  if (_featureHighlights is EqualUnmodifiableListView) return _featureHighlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featureHighlights);
}

@override@JsonKey() final  int currentHighlightIndex;
@override@JsonKey() final  bool shouldNavigateToCreateAccount;
@override@JsonKey() final  bool shouldNavigateToBuildingProfile;
@override final  DateTime? sessionEntryTime;
@override@JsonKey() final  String sessionId;
@override final  OnboardingStep? lastStep;
@override@JsonKey() final  bool didSubscribe;
@override@JsonKey() final  String subscriptionType;
@override@JsonKey() final  OnboardingSkipStatus skipStatus;
@override final  OnboardingStep? skippedAtStep;
@override final  OnboardingFieldSources? skipFieldSources;
@override final  PostOnboardingDestination? postOnboardingDestination;
@override@JsonKey() final  bool hasViewedCompanyProfile;
@override final  String? savedProfileUid;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&(identical(other.status, status) || other.status == status)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors)&&const DeepCollectionEquality().equals(other._sp500History, _sp500History)&&const DeepCollectionEquality().equals(other._selectedBrands, _selectedBrands)&&(identical(other.customBrandInput, customBrandInput) || other.customBrandInput == customBrandInput)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&const DeepCollectionEquality().equals(other._featureHighlights, _featureHighlights)&&(identical(other.currentHighlightIndex, currentHighlightIndex) || other.currentHighlightIndex == currentHighlightIndex)&&(identical(other.shouldNavigateToCreateAccount, shouldNavigateToCreateAccount) || other.shouldNavigateToCreateAccount == shouldNavigateToCreateAccount)&&(identical(other.shouldNavigateToBuildingProfile, shouldNavigateToBuildingProfile) || other.shouldNavigateToBuildingProfile == shouldNavigateToBuildingProfile)&&(identical(other.sessionEntryTime, sessionEntryTime) || other.sessionEntryTime == sessionEntryTime)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.lastStep, lastStep) || other.lastStep == lastStep)&&(identical(other.didSubscribe, didSubscribe) || other.didSubscribe == didSubscribe)&&(identical(other.subscriptionType, subscriptionType) || other.subscriptionType == subscriptionType)&&(identical(other.skipStatus, skipStatus) || other.skipStatus == skipStatus)&&(identical(other.skippedAtStep, skippedAtStep) || other.skippedAtStep == skippedAtStep)&&(identical(other.skipFieldSources, skipFieldSources) || other.skipFieldSources == skipFieldSources)&&(identical(other.postOnboardingDestination, postOnboardingDestination) || other.postOnboardingDestination == postOnboardingDestination)&&(identical(other.hasViewedCompanyProfile, hasViewedCompanyProfile) || other.hasViewedCompanyProfile == hasViewedCompanyProfile)&&(identical(other.savedProfileUid, savedProfileUid) || other.savedProfileUid == savedProfileUid));
}


@override
int get hashCode => Object.hashAll([runtimeType,onboardingData,status,isSubmitting,isLoadingSectors,isLoadingHistory,const DeepCollectionEquality().hash(_availableSectors),const DeepCollectionEquality().hash(_sp500History),const DeepCollectionEquality().hash(_selectedBrands),customBrandInput,failureMessage,const DeepCollectionEquality().hash(_featureHighlights),currentHighlightIndex,shouldNavigateToCreateAccount,shouldNavigateToBuildingProfile,sessionEntryTime,sessionId,lastStep,didSubscribe,subscriptionType,skipStatus,skippedAtStep,skipFieldSources,postOnboardingDestination,hasViewedCompanyProfile,savedProfileUid]);

@override
String toString() {
  return 'OnboardingState.initial(onboardingData: $onboardingData, status: $status, isSubmitting: $isSubmitting, isLoadingSectors: $isLoadingSectors, isLoadingHistory: $isLoadingHistory, availableSectors: $availableSectors, sp500History: $sp500History, selectedBrands: $selectedBrands, customBrandInput: $customBrandInput, failureMessage: $failureMessage, featureHighlights: $featureHighlights, currentHighlightIndex: $currentHighlightIndex, shouldNavigateToCreateAccount: $shouldNavigateToCreateAccount, shouldNavigateToBuildingProfile: $shouldNavigateToBuildingProfile, sessionEntryTime: $sessionEntryTime, sessionId: $sessionId, lastStep: $lastStep, didSubscribe: $didSubscribe, subscriptionType: $subscriptionType, skipStatus: $skipStatus, skippedAtStep: $skippedAtStep, skipFieldSources: $skipFieldSources, postOnboardingDestination: $postOnboardingDestination, hasViewedCompanyProfile: $hasViewedCompanyProfile, savedProfileUid: $savedProfileUid)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 OnboardingData onboardingData, OnboardingStatus status, bool isSubmitting, bool isLoadingSectors, bool isLoadingHistory, List<SectorViewModel> availableSectors, List<HistoricalPrice> sp500History, List<Brand> selectedBrands, String customBrandInput, String? failureMessage, List<FeatureHighlightItem> featureHighlights, int currentHighlightIndex, bool shouldNavigateToCreateAccount, bool shouldNavigateToBuildingProfile, DateTime? sessionEntryTime, String sessionId, OnboardingStep? lastStep, bool didSubscribe, String subscriptionType, OnboardingSkipStatus skipStatus, OnboardingStep? skippedAtStep, OnboardingFieldSources? skipFieldSources, PostOnboardingDestination? postOnboardingDestination, bool hasViewedCompanyProfile, String? savedProfileUid
});


@override $OnboardingDataCopyWith<$Res> get onboardingData;@override $OnboardingFieldSourcesCopyWith<$Res>? get skipFieldSources;@override $PostOnboardingDestinationCopyWith<$Res>? get postOnboardingDestination;

}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboardingData = null,Object? status = null,Object? isSubmitting = null,Object? isLoadingSectors = null,Object? isLoadingHistory = null,Object? availableSectors = null,Object? sp500History = null,Object? selectedBrands = null,Object? customBrandInput = null,Object? failureMessage = freezed,Object? featureHighlights = null,Object? currentHighlightIndex = null,Object? shouldNavigateToCreateAccount = null,Object? shouldNavigateToBuildingProfile = null,Object? sessionEntryTime = freezed,Object? sessionId = null,Object? lastStep = freezed,Object? didSubscribe = null,Object? subscriptionType = null,Object? skipStatus = null,Object? skippedAtStep = freezed,Object? skipFieldSources = freezed,Object? postOnboardingDestination = freezed,Object? hasViewedCompanyProfile = null,Object? savedProfileUid = freezed,}) {
  return _then(_OnboardingState(
onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<SectorViewModel>,sp500History: null == sp500History ? _self._sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,selectedBrands: null == selectedBrands ? _self._selectedBrands : selectedBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,customBrandInput: null == customBrandInput ? _self.customBrandInput : customBrandInput // ignore: cast_nullable_to_non_nullable
as String,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,featureHighlights: null == featureHighlights ? _self._featureHighlights : featureHighlights // ignore: cast_nullable_to_non_nullable
as List<FeatureHighlightItem>,currentHighlightIndex: null == currentHighlightIndex ? _self.currentHighlightIndex : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
as int,shouldNavigateToCreateAccount: null == shouldNavigateToCreateAccount ? _self.shouldNavigateToCreateAccount : shouldNavigateToCreateAccount // ignore: cast_nullable_to_non_nullable
as bool,shouldNavigateToBuildingProfile: null == shouldNavigateToBuildingProfile ? _self.shouldNavigateToBuildingProfile : shouldNavigateToBuildingProfile // ignore: cast_nullable_to_non_nullable
as bool,sessionEntryTime: freezed == sessionEntryTime ? _self.sessionEntryTime : sessionEntryTime // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,lastStep: freezed == lastStep ? _self.lastStep : lastStep // ignore: cast_nullable_to_non_nullable
as OnboardingStep?,didSubscribe: null == didSubscribe ? _self.didSubscribe : didSubscribe // ignore: cast_nullable_to_non_nullable
as bool,subscriptionType: null == subscriptionType ? _self.subscriptionType : subscriptionType // ignore: cast_nullable_to_non_nullable
as String,skipStatus: null == skipStatus ? _self.skipStatus : skipStatus // ignore: cast_nullable_to_non_nullable
as OnboardingSkipStatus,skippedAtStep: freezed == skippedAtStep ? _self.skippedAtStep : skippedAtStep // ignore: cast_nullable_to_non_nullable
as OnboardingStep?,skipFieldSources: freezed == skipFieldSources ? _self.skipFieldSources : skipFieldSources // ignore: cast_nullable_to_non_nullable
as OnboardingFieldSources?,postOnboardingDestination: freezed == postOnboardingDestination ? _self.postOnboardingDestination : postOnboardingDestination // ignore: cast_nullable_to_non_nullable
as PostOnboardingDestination?,hasViewedCompanyProfile: null == hasViewedCompanyProfile ? _self.hasViewedCompanyProfile : hasViewedCompanyProfile // ignore: cast_nullable_to_non_nullable
as bool,savedProfileUid: freezed == savedProfileUid ? _self.savedProfileUid : savedProfileUid // ignore: cast_nullable_to_non_nullable
as String?,
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
}/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingFieldSourcesCopyWith<$Res>? get skipFieldSources {
    if (_self.skipFieldSources == null) {
    return null;
  }

  return $OnboardingFieldSourcesCopyWith<$Res>(_self.skipFieldSources!, (value) {
    return _then(_self.copyWith(skipFieldSources: value));
  });
}/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostOnboardingDestinationCopyWith<$Res>? get postOnboardingDestination {
    if (_self.postOnboardingDestination == null) {
    return null;
  }

  return $PostOnboardingDestinationCopyWith<$Res>(_self.postOnboardingDestination!, (value) {
    return _then(_self.copyWith(postOnboardingDestination: value));
  });
}
}

// dart format on
