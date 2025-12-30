// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent()';
}


}

/// @nodoc
class $OnboardingEventCopyWith<$Res>  {
$OnboardingEventCopyWith(OnboardingEvent _, $Res Function(OnboardingEvent) __);
}


/// Adds pattern-matching-related methods to [OnboardingEvent].
extension OnboardingEventPatterns on OnboardingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _NameSubmitted value)?  nameSubmitted,TResult Function( _SectorSelected value)?  sectorSelected,TResult Function( _UploadBrands value)?  uploadBrands,TResult Function( _LoadSp500History value)?  loadSp500History,TResult Function( _ConfirmWatchlist value)?  confirmWatchlist,TResult Function( _ExperienceSelected value)?  experienceSelected,TResult Function( _CompleteOnboarding value)?  completeOnboarding,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that);case _UploadBrands() when uploadBrands != null:
return uploadBrands(_that);case _LoadSp500History() when loadSp500History != null:
return loadSp500History(_that);case _ConfirmWatchlist() when confirmWatchlist != null:
return confirmWatchlist(_that);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _NameSubmitted value)  nameSubmitted,required TResult Function( _SectorSelected value)  sectorSelected,required TResult Function( _UploadBrands value)  uploadBrands,required TResult Function( _LoadSp500History value)  loadSp500History,required TResult Function( _ConfirmWatchlist value)  confirmWatchlist,required TResult Function( _ExperienceSelected value)  experienceSelected,required TResult Function( _CompleteOnboarding value)  completeOnboarding,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _NameSubmitted():
return nameSubmitted(_that);case _SectorSelected():
return sectorSelected(_that);case _UploadBrands():
return uploadBrands(_that);case _LoadSp500History():
return loadSp500History(_that);case _ConfirmWatchlist():
return confirmWatchlist(_that);case _ExperienceSelected():
return experienceSelected(_that);case _CompleteOnboarding():
return completeOnboarding(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _NameSubmitted value)?  nameSubmitted,TResult? Function( _SectorSelected value)?  sectorSelected,TResult? Function( _UploadBrands value)?  uploadBrands,TResult? Function( _LoadSp500History value)?  loadSp500History,TResult? Function( _ConfirmWatchlist value)?  confirmWatchlist,TResult? Function( _ExperienceSelected value)?  experienceSelected,TResult? Function( _CompleteOnboarding value)?  completeOnboarding,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that);case _UploadBrands() when uploadBrands != null:
return uploadBrands(_that);case _LoadSp500History() when loadSp500History != null:
return loadSp500History(_that);case _ConfirmWatchlist() when confirmWatchlist != null:
return confirmWatchlist(_that);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSubmitted,TResult Function( String sector)?  sectorSelected,TResult Function( String brandsText)?  uploadBrands,TResult Function()?  loadSp500History,TResult Function( List<Company> confirmedCompanies)?  confirmWatchlist,TResult Function( InvestingExperience experience)?  experienceSelected,TResult Function( String uid,  String fcmToken)?  completeOnboarding,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case _UploadBrands() when uploadBrands != null:
return uploadBrands(_that.brandsText);case _LoadSp500History() when loadSp500History != null:
return loadSp500History();case _ConfirmWatchlist() when confirmWatchlist != null:
return confirmWatchlist(_that.confirmedCompanies);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that.uid,_that.fcmToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSubmitted,required TResult Function( String sector)  sectorSelected,required TResult Function( String brandsText)  uploadBrands,required TResult Function()  loadSp500History,required TResult Function( List<Company> confirmedCompanies)  confirmWatchlist,required TResult Function( InvestingExperience experience)  experienceSelected,required TResult Function( String uid,  String fcmToken)  completeOnboarding,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _NameSubmitted():
return nameSubmitted(_that.name);case _SectorSelected():
return sectorSelected(_that.sector);case _UploadBrands():
return uploadBrands(_that.brandsText);case _LoadSp500History():
return loadSp500History();case _ConfirmWatchlist():
return confirmWatchlist(_that.confirmedCompanies);case _ExperienceSelected():
return experienceSelected(_that.experience);case _CompleteOnboarding():
return completeOnboarding(_that.uid,_that.fcmToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSubmitted,TResult? Function( String sector)?  sectorSelected,TResult? Function( String brandsText)?  uploadBrands,TResult? Function()?  loadSp500History,TResult? Function( List<Company> confirmedCompanies)?  confirmWatchlist,TResult? Function( InvestingExperience experience)?  experienceSelected,TResult? Function( String uid,  String fcmToken)?  completeOnboarding,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case _UploadBrands() when uploadBrands != null:
return uploadBrands(_that.brandsText);case _LoadSp500History() when loadSp500History != null:
return loadSp500History();case _ConfirmWatchlist() when confirmWatchlist != null:
return confirmWatchlist(_that.confirmedCompanies);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that.uid,_that.fcmToken);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements OnboardingEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.started()';
}


}




/// @nodoc


class _NameSubmitted implements OnboardingEvent {
  const _NameSubmitted(this.name);
  

 final  String name;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameSubmittedCopyWith<_NameSubmitted> get copyWith => __$NameSubmittedCopyWithImpl<_NameSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameSubmitted&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'OnboardingEvent.nameSubmitted(name: $name)';
}


}

/// @nodoc
abstract mixin class _$NameSubmittedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$NameSubmittedCopyWith(_NameSubmitted value, $Res Function(_NameSubmitted) _then) = __$NameSubmittedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$NameSubmittedCopyWithImpl<$Res>
    implements _$NameSubmittedCopyWith<$Res> {
  __$NameSubmittedCopyWithImpl(this._self, this._then);

  final _NameSubmitted _self;
  final $Res Function(_NameSubmitted) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_NameSubmitted(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SectorSelected implements OnboardingEvent {
  const _SectorSelected(this.sector);
  

 final  String sector;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectorSelectedCopyWith<_SectorSelected> get copyWith => __$SectorSelectedCopyWithImpl<_SectorSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectorSelected&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'OnboardingEvent.sectorSelected(sector: $sector)';
}


}

/// @nodoc
abstract mixin class _$SectorSelectedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$SectorSelectedCopyWith(_SectorSelected value, $Res Function(_SectorSelected) _then) = __$SectorSelectedCopyWithImpl;
@useResult
$Res call({
 String sector
});




}
/// @nodoc
class __$SectorSelectedCopyWithImpl<$Res>
    implements _$SectorSelectedCopyWith<$Res> {
  __$SectorSelectedCopyWithImpl(this._self, this._then);

  final _SectorSelected _self;
  final $Res Function(_SectorSelected) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sector = null,}) {
  return _then(_SectorSelected(
null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UploadBrands implements OnboardingEvent {
  const _UploadBrands(this.brandsText);
  

 final  String brandsText;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadBrandsCopyWith<_UploadBrands> get copyWith => __$UploadBrandsCopyWithImpl<_UploadBrands>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadBrands&&(identical(other.brandsText, brandsText) || other.brandsText == brandsText));
}


@override
int get hashCode => Object.hash(runtimeType,brandsText);

@override
String toString() {
  return 'OnboardingEvent.uploadBrands(brandsText: $brandsText)';
}


}

/// @nodoc
abstract mixin class _$UploadBrandsCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$UploadBrandsCopyWith(_UploadBrands value, $Res Function(_UploadBrands) _then) = __$UploadBrandsCopyWithImpl;
@useResult
$Res call({
 String brandsText
});




}
/// @nodoc
class __$UploadBrandsCopyWithImpl<$Res>
    implements _$UploadBrandsCopyWith<$Res> {
  __$UploadBrandsCopyWithImpl(this._self, this._then);

  final _UploadBrands _self;
  final $Res Function(_UploadBrands) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brandsText = null,}) {
  return _then(_UploadBrands(
null == brandsText ? _self.brandsText : brandsText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadSp500History implements OnboardingEvent {
  const _LoadSp500History();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSp500History);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.loadSp500History()';
}


}




/// @nodoc


class _ConfirmWatchlist implements OnboardingEvent {
  const _ConfirmWatchlist(final  List<Company> confirmedCompanies): _confirmedCompanies = confirmedCompanies;
  

 final  List<Company> _confirmedCompanies;
 List<Company> get confirmedCompanies {
  if (_confirmedCompanies is EqualUnmodifiableListView) return _confirmedCompanies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_confirmedCompanies);
}


/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmWatchlistCopyWith<_ConfirmWatchlist> get copyWith => __$ConfirmWatchlistCopyWithImpl<_ConfirmWatchlist>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmWatchlist&&const DeepCollectionEquality().equals(other._confirmedCompanies, _confirmedCompanies));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_confirmedCompanies));

@override
String toString() {
  return 'OnboardingEvent.confirmWatchlist(confirmedCompanies: $confirmedCompanies)';
}


}

/// @nodoc
abstract mixin class _$ConfirmWatchlistCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$ConfirmWatchlistCopyWith(_ConfirmWatchlist value, $Res Function(_ConfirmWatchlist) _then) = __$ConfirmWatchlistCopyWithImpl;
@useResult
$Res call({
 List<Company> confirmedCompanies
});




}
/// @nodoc
class __$ConfirmWatchlistCopyWithImpl<$Res>
    implements _$ConfirmWatchlistCopyWith<$Res> {
  __$ConfirmWatchlistCopyWithImpl(this._self, this._then);

  final _ConfirmWatchlist _self;
  final $Res Function(_ConfirmWatchlist) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? confirmedCompanies = null,}) {
  return _then(_ConfirmWatchlist(
null == confirmedCompanies ? _self._confirmedCompanies : confirmedCompanies // ignore: cast_nullable_to_non_nullable
as List<Company>,
  ));
}


}

/// @nodoc


class _ExperienceSelected implements OnboardingEvent {
  const _ExperienceSelected(this.experience);
  

 final  InvestingExperience experience;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperienceSelectedCopyWith<_ExperienceSelected> get copyWith => __$ExperienceSelectedCopyWithImpl<_ExperienceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExperienceSelected&&(identical(other.experience, experience) || other.experience == experience));
}


@override
int get hashCode => Object.hash(runtimeType,experience);

@override
String toString() {
  return 'OnboardingEvent.experienceSelected(experience: $experience)';
}


}

/// @nodoc
abstract mixin class _$ExperienceSelectedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$ExperienceSelectedCopyWith(_ExperienceSelected value, $Res Function(_ExperienceSelected) _then) = __$ExperienceSelectedCopyWithImpl;
@useResult
$Res call({
 InvestingExperience experience
});




}
/// @nodoc
class __$ExperienceSelectedCopyWithImpl<$Res>
    implements _$ExperienceSelectedCopyWith<$Res> {
  __$ExperienceSelectedCopyWithImpl(this._self, this._then);

  final _ExperienceSelected _self;
  final $Res Function(_ExperienceSelected) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? experience = null,}) {
  return _then(_ExperienceSelected(
null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,
  ));
}


}

/// @nodoc


class _CompleteOnboarding implements OnboardingEvent {
  const _CompleteOnboarding({required this.uid, required this.fcmToken});
  

 final  String uid;
 final  String fcmToken;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteOnboardingCopyWith<_CompleteOnboarding> get copyWith => __$CompleteOnboardingCopyWithImpl<_CompleteOnboarding>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteOnboarding&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}


@override
int get hashCode => Object.hash(runtimeType,uid,fcmToken);

@override
String toString() {
  return 'OnboardingEvent.completeOnboarding(uid: $uid, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$CompleteOnboardingCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$CompleteOnboardingCopyWith(_CompleteOnboarding value, $Res Function(_CompleteOnboarding) _then) = __$CompleteOnboardingCopyWithImpl;
@useResult
$Res call({
 String uid, String fcmToken
});




}
/// @nodoc
class __$CompleteOnboardingCopyWithImpl<$Res>
    implements _$CompleteOnboardingCopyWith<$Res> {
  __$CompleteOnboardingCopyWithImpl(this._self, this._then);

  final _CompleteOnboarding _self;
  final $Res Function(_CompleteOnboarding) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? fcmToken = null,}) {
  return _then(_CompleteOnboarding(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,fcmToken: null == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$OnboardingState {

 List<Company> get detectedCompanies; List<HistoricalPrice> get sp500History; OnboardingStatus get status; OnboardingData get onboardingData; List<String> get availableSectors; bool get isLoadingSectors; bool get isLoadingHistory; bool get isAnalyzingBrands; bool get isSubmitting; String? get failureMessage; int get currentStep;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&const DeepCollectionEquality().equals(other.detectedCompanies, detectedCompanies)&&const DeepCollectionEquality().equals(other.sp500History, sp500History)&&(identical(other.status, status) || other.status == status)&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&const DeepCollectionEquality().equals(other.availableSectors, availableSectors)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isAnalyzingBrands, isAnalyzingBrands) || other.isAnalyzingBrands == isAnalyzingBrands)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(detectedCompanies),const DeepCollectionEquality().hash(sp500History),status,onboardingData,const DeepCollectionEquality().hash(availableSectors),isLoadingSectors,isLoadingHistory,isAnalyzingBrands,isSubmitting,failureMessage,currentStep);

@override
String toString() {
  return 'OnboardingState(detectedCompanies: $detectedCompanies, sp500History: $sp500History, status: $status, onboardingData: $onboardingData, availableSectors: $availableSectors, isLoadingSectors: $isLoadingSectors, isLoadingHistory: $isLoadingHistory, isAnalyzingBrands: $isAnalyzingBrands, isSubmitting: $isSubmitting, failureMessage: $failureMessage, currentStep: $currentStep)';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 List<Company> detectedCompanies, List<HistoricalPrice> sp500History, OnboardingStatus status, OnboardingData onboardingData, List<String> availableSectors, bool isLoadingSectors, bool isLoadingHistory, bool isAnalyzingBrands, bool isSubmitting, String? failureMessage, int currentStep
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
@pragma('vm:prefer-inline') @override $Res call({Object? detectedCompanies = null,Object? sp500History = null,Object? status = null,Object? onboardingData = null,Object? availableSectors = null,Object? isLoadingSectors = null,Object? isLoadingHistory = null,Object? isAnalyzingBrands = null,Object? isSubmitting = null,Object? failureMessage = freezed,Object? currentStep = null,}) {
  return _then(_self.copyWith(
detectedCompanies: null == detectedCompanies ? _self.detectedCompanies : detectedCompanies // ignore: cast_nullable_to_non_nullable
as List<Company>,sp500History: null == sp500History ? _self.sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,availableSectors: null == availableSectors ? _self.availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<String>,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isAnalyzingBrands: null == isAnalyzingBrands ? _self.isAnalyzingBrands : isAnalyzingBrands // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Company> detectedCompanies,  List<HistoricalPrice> sp500History,  OnboardingStatus status,  OnboardingData onboardingData,  List<String> availableSectors,  bool isLoadingSectors,  bool isLoadingHistory,  bool isAnalyzingBrands,  bool isSubmitting,  String? failureMessage,  int currentStep)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.detectedCompanies,_that.sp500History,_that.status,_that.onboardingData,_that.availableSectors,_that.isLoadingSectors,_that.isLoadingHistory,_that.isAnalyzingBrands,_that.isSubmitting,_that.failureMessage,_that.currentStep);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Company> detectedCompanies,  List<HistoricalPrice> sp500History,  OnboardingStatus status,  OnboardingData onboardingData,  List<String> availableSectors,  bool isLoadingSectors,  bool isLoadingHistory,  bool isAnalyzingBrands,  bool isSubmitting,  String? failureMessage,  int currentStep)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.detectedCompanies,_that.sp500History,_that.status,_that.onboardingData,_that.availableSectors,_that.isLoadingSectors,_that.isLoadingHistory,_that.isAnalyzingBrands,_that.isSubmitting,_that.failureMessage,_that.currentStep);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Company> detectedCompanies,  List<HistoricalPrice> sp500History,  OnboardingStatus status,  OnboardingData onboardingData,  List<String> availableSectors,  bool isLoadingSectors,  bool isLoadingHistory,  bool isAnalyzingBrands,  bool isSubmitting,  String? failureMessage,  int currentStep)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.detectedCompanies,_that.sp500History,_that.status,_that.onboardingData,_that.availableSectors,_that.isLoadingSectors,_that.isLoadingHistory,_that.isAnalyzingBrands,_that.isSubmitting,_that.failureMessage,_that.currentStep);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState implements OnboardingState {
  const _OnboardingState({final  List<Company> detectedCompanies = const [], final  List<HistoricalPrice> sp500History = const [], this.status = OnboardingStatus.initial, this.onboardingData = const OnboardingData(), final  List<String> availableSectors = const [], this.isLoadingSectors = false, this.isLoadingHistory = false, this.isAnalyzingBrands = false, this.isSubmitting = false, this.failureMessage, this.currentStep = 1}): _detectedCompanies = detectedCompanies,_sp500History = sp500History,_availableSectors = availableSectors;
  

 final  List<Company> _detectedCompanies;
@override@JsonKey() List<Company> get detectedCompanies {
  if (_detectedCompanies is EqualUnmodifiableListView) return _detectedCompanies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedCompanies);
}

 final  List<HistoricalPrice> _sp500History;
@override@JsonKey() List<HistoricalPrice> get sp500History {
  if (_sp500History is EqualUnmodifiableListView) return _sp500History;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sp500History);
}

@override@JsonKey() final  OnboardingStatus status;
@override@JsonKey() final  OnboardingData onboardingData;
 final  List<String> _availableSectors;
@override@JsonKey() List<String> get availableSectors {
  if (_availableSectors is EqualUnmodifiableListView) return _availableSectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableSectors);
}

@override@JsonKey() final  bool isLoadingSectors;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool isAnalyzingBrands;
@override@JsonKey() final  bool isSubmitting;
@override final  String? failureMessage;
@override@JsonKey() final  int currentStep;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&const DeepCollectionEquality().equals(other._detectedCompanies, _detectedCompanies)&&const DeepCollectionEquality().equals(other._sp500History, _sp500History)&&(identical(other.status, status) || other.status == status)&&(identical(other.onboardingData, onboardingData) || other.onboardingData == onboardingData)&&const DeepCollectionEquality().equals(other._availableSectors, _availableSectors)&&(identical(other.isLoadingSectors, isLoadingSectors) || other.isLoadingSectors == isLoadingSectors)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.isAnalyzingBrands, isAnalyzingBrands) || other.isAnalyzingBrands == isAnalyzingBrands)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_detectedCompanies),const DeepCollectionEquality().hash(_sp500History),status,onboardingData,const DeepCollectionEquality().hash(_availableSectors),isLoadingSectors,isLoadingHistory,isAnalyzingBrands,isSubmitting,failureMessage,currentStep);

@override
String toString() {
  return 'OnboardingState(detectedCompanies: $detectedCompanies, sp500History: $sp500History, status: $status, onboardingData: $onboardingData, availableSectors: $availableSectors, isLoadingSectors: $isLoadingSectors, isLoadingHistory: $isLoadingHistory, isAnalyzingBrands: $isAnalyzingBrands, isSubmitting: $isSubmitting, failureMessage: $failureMessage, currentStep: $currentStep)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 List<Company> detectedCompanies, List<HistoricalPrice> sp500History, OnboardingStatus status, OnboardingData onboardingData, List<String> availableSectors, bool isLoadingSectors, bool isLoadingHistory, bool isAnalyzingBrands, bool isSubmitting, String? failureMessage, int currentStep
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
@override @pragma('vm:prefer-inline') $Res call({Object? detectedCompanies = null,Object? sp500History = null,Object? status = null,Object? onboardingData = null,Object? availableSectors = null,Object? isLoadingSectors = null,Object? isLoadingHistory = null,Object? isAnalyzingBrands = null,Object? isSubmitting = null,Object? failureMessage = freezed,Object? currentStep = null,}) {
  return _then(_OnboardingState(
detectedCompanies: null == detectedCompanies ? _self._detectedCompanies : detectedCompanies // ignore: cast_nullable_to_non_nullable
as List<Company>,sp500History: null == sp500History ? _self._sp500History : sp500History // ignore: cast_nullable_to_non_nullable
as List<HistoricalPrice>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OnboardingStatus,onboardingData: null == onboardingData ? _self.onboardingData : onboardingData // ignore: cast_nullable_to_non_nullable
as OnboardingData,availableSectors: null == availableSectors ? _self._availableSectors : availableSectors // ignore: cast_nullable_to_non_nullable
as List<String>,isLoadingSectors: null == isLoadingSectors ? _self.isLoadingSectors : isLoadingSectors // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,isAnalyzingBrands: null == isAnalyzingBrands ? _self.isAnalyzingBrands : isAnalyzingBrands // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,
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
