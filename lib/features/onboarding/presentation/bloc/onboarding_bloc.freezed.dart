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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _NameSubmitted value)?  nameSubmitted,TResult Function( _SectorSelected value)?  sectorSelected,TResult Function( _LoadSp500History value)?  loadSp500History,TResult Function( _ToggleBrand value)?  toggleBrand,TResult Function( _ExperienceSelected value)?  experienceSelected,TResult Function( _NotificationsToggled value)?  notificationsToggled,TResult Function( _CompleteOnboarding value)?  completeOnboarding,TResult Function( _StartAnalysis value)?  startAnalysis,TResult Function( _UpdateAnalysisStep value)?  updateAnalysisStep,TResult Function( _StartWatchlistAddition value)?  startWatchlistAddition,TResult Function( _UpdateWatchlistStep value)?  updateWatchlistStep,TResult Function( _HighlightPageChanged value)?  highlightPageChanged,TResult Function( _HighlightContinuePressed value)?  highlightContinuePressed,TResult Function( _HighlightSkipPressed value)?  highlightSkipPressed,TResult Function( _LandingPageViewed value)?  landingPageViewed,TResult Function( _LoginRequested value)?  loginRequested,TResult Function( _ProfileReadyPageViewed value)?  profileReadyPageViewed,TResult Function( _ProfileReadyContinuePressed value)?  profileReadyContinuePressed,TResult Function( _StepViewed value)?  stepViewed,TResult Function( SubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult Function( _OnboardingFlowFinished value)?  onboardingFlowFinished,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that);case _LoadSp500History() when loadSp500History != null:
return loadSp500History(_that);case _ToggleBrand() when toggleBrand != null:
return toggleBrand(_that);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case _NotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _StartAnalysis() when startAnalysis != null:
return startAnalysis(_that);case _UpdateAnalysisStep() when updateAnalysisStep != null:
return updateAnalysisStep(_that);case _StartWatchlistAddition() when startWatchlistAddition != null:
return startWatchlistAddition(_that);case _UpdateWatchlistStep() when updateWatchlistStep != null:
return updateWatchlistStep(_that);case _HighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case _HighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case _HighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed(_that);case _LandingPageViewed() when landingPageViewed != null:
return landingPageViewed(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _ProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed(_that);case _ProfileReadyContinuePressed() when profileReadyContinuePressed != null:
return profileReadyContinuePressed(_that);case _StepViewed() when stepViewed != null:
return stepViewed(_that);case SubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that);case _OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _NameSubmitted value)  nameSubmitted,required TResult Function( _SectorSelected value)  sectorSelected,required TResult Function( _LoadSp500History value)  loadSp500History,required TResult Function( _ToggleBrand value)  toggleBrand,required TResult Function( _ExperienceSelected value)  experienceSelected,required TResult Function( _NotificationsToggled value)  notificationsToggled,required TResult Function( _CompleteOnboarding value)  completeOnboarding,required TResult Function( _StartAnalysis value)  startAnalysis,required TResult Function( _UpdateAnalysisStep value)  updateAnalysisStep,required TResult Function( _StartWatchlistAddition value)  startWatchlistAddition,required TResult Function( _UpdateWatchlistStep value)  updateWatchlistStep,required TResult Function( _HighlightPageChanged value)  highlightPageChanged,required TResult Function( _HighlightContinuePressed value)  highlightContinuePressed,required TResult Function( _HighlightSkipPressed value)  highlightSkipPressed,required TResult Function( _LandingPageViewed value)  landingPageViewed,required TResult Function( _LoginRequested value)  loginRequested,required TResult Function( _ProfileReadyPageViewed value)  profileReadyPageViewed,required TResult Function( _ProfileReadyContinuePressed value)  profileReadyContinuePressed,required TResult Function( _StepViewed value)  stepViewed,required TResult Function( SubscriptionStatusChanged value)  subscriptionStatusChanged,required TResult Function( _OnboardingFlowFinished value)  onboardingFlowFinished,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _NameSubmitted():
return nameSubmitted(_that);case _SectorSelected():
return sectorSelected(_that);case _LoadSp500History():
return loadSp500History(_that);case _ToggleBrand():
return toggleBrand(_that);case _ExperienceSelected():
return experienceSelected(_that);case _NotificationsToggled():
return notificationsToggled(_that);case _CompleteOnboarding():
return completeOnboarding(_that);case _StartAnalysis():
return startAnalysis(_that);case _UpdateAnalysisStep():
return updateAnalysisStep(_that);case _StartWatchlistAddition():
return startWatchlistAddition(_that);case _UpdateWatchlistStep():
return updateWatchlistStep(_that);case _HighlightPageChanged():
return highlightPageChanged(_that);case _HighlightContinuePressed():
return highlightContinuePressed(_that);case _HighlightSkipPressed():
return highlightSkipPressed(_that);case _LandingPageViewed():
return landingPageViewed(_that);case _LoginRequested():
return loginRequested(_that);case _ProfileReadyPageViewed():
return profileReadyPageViewed(_that);case _ProfileReadyContinuePressed():
return profileReadyContinuePressed(_that);case _StepViewed():
return stepViewed(_that);case SubscriptionStatusChanged():
return subscriptionStatusChanged(_that);case _OnboardingFlowFinished():
return onboardingFlowFinished(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _NameSubmitted value)?  nameSubmitted,TResult? Function( _SectorSelected value)?  sectorSelected,TResult? Function( _LoadSp500History value)?  loadSp500History,TResult? Function( _ToggleBrand value)?  toggleBrand,TResult? Function( _ExperienceSelected value)?  experienceSelected,TResult? Function( _NotificationsToggled value)?  notificationsToggled,TResult? Function( _CompleteOnboarding value)?  completeOnboarding,TResult? Function( _StartAnalysis value)?  startAnalysis,TResult? Function( _UpdateAnalysisStep value)?  updateAnalysisStep,TResult? Function( _StartWatchlistAddition value)?  startWatchlistAddition,TResult? Function( _UpdateWatchlistStep value)?  updateWatchlistStep,TResult? Function( _HighlightPageChanged value)?  highlightPageChanged,TResult? Function( _HighlightContinuePressed value)?  highlightContinuePressed,TResult? Function( _HighlightSkipPressed value)?  highlightSkipPressed,TResult? Function( _LandingPageViewed value)?  landingPageViewed,TResult? Function( _LoginRequested value)?  loginRequested,TResult? Function( _ProfileReadyPageViewed value)?  profileReadyPageViewed,TResult? Function( _ProfileReadyContinuePressed value)?  profileReadyContinuePressed,TResult? Function( _StepViewed value)?  stepViewed,TResult? Function( SubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult? Function( _OnboardingFlowFinished value)?  onboardingFlowFinished,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that);case _LoadSp500History() when loadSp500History != null:
return loadSp500History(_that);case _ToggleBrand() when toggleBrand != null:
return toggleBrand(_that);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case _NotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding(_that);case _StartAnalysis() when startAnalysis != null:
return startAnalysis(_that);case _UpdateAnalysisStep() when updateAnalysisStep != null:
return updateAnalysisStep(_that);case _StartWatchlistAddition() when startWatchlistAddition != null:
return startWatchlistAddition(_that);case _UpdateWatchlistStep() when updateWatchlistStep != null:
return updateWatchlistStep(_that);case _HighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case _HighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case _HighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed(_that);case _LandingPageViewed() when landingPageViewed != null:
return landingPageViewed(_that);case _LoginRequested() when loginRequested != null:
return loginRequested(_that);case _ProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed(_that);case _ProfileReadyContinuePressed() when profileReadyContinuePressed != null:
return profileReadyContinuePressed(_that);case _StepViewed() when stepViewed != null:
return stepViewed(_that);case SubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that);case _OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSubmitted,TResult Function( Sector sector)?  sectorSelected,TResult Function()?  loadSp500History,TResult Function( Brand brand)?  toggleBrand,TResult Function( InvestingExperience experience)?  experienceSelected,TResult Function( bool enabled)?  notificationsToggled,TResult Function()?  completeOnboarding,TResult Function()?  startAnalysis,TResult Function( int step)?  updateAnalysisStep,TResult Function()?  startWatchlistAddition,TResult Function( int step)?  updateWatchlistStep,TResult Function( int index)?  highlightPageChanged,TResult Function()?  highlightContinuePressed,TResult Function()?  highlightSkipPressed,TResult Function()?  landingPageViewed,TResult Function()?  loginRequested,TResult Function()?  profileReadyPageViewed,TResult Function()?  profileReadyContinuePressed,TResult Function( OnboardingStep step)?  stepViewed,TResult Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult Function()?  onboardingFlowFinished,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case _LoadSp500History() when loadSp500History != null:
return loadSp500History();case _ToggleBrand() when toggleBrand != null:
return toggleBrand(_that.brand);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case _NotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding();case _StartAnalysis() when startAnalysis != null:
return startAnalysis();case _UpdateAnalysisStep() when updateAnalysisStep != null:
return updateAnalysisStep(_that.step);case _StartWatchlistAddition() when startWatchlistAddition != null:
return startWatchlistAddition();case _UpdateWatchlistStep() when updateWatchlistStep != null:
return updateWatchlistStep(_that.step);case _HighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case _HighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case _HighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed();case _LandingPageViewed() when landingPageViewed != null:
return landingPageViewed();case _LoginRequested() when loginRequested != null:
return loginRequested();case _ProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed();case _ProfileReadyContinuePressed() when profileReadyContinuePressed != null:
return profileReadyContinuePressed();case _StepViewed() when stepViewed != null:
return stepViewed(_that.step);case SubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case _OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSubmitted,required TResult Function( Sector sector)  sectorSelected,required TResult Function()  loadSp500History,required TResult Function( Brand brand)  toggleBrand,required TResult Function( InvestingExperience experience)  experienceSelected,required TResult Function( bool enabled)  notificationsToggled,required TResult Function()  completeOnboarding,required TResult Function()  startAnalysis,required TResult Function( int step)  updateAnalysisStep,required TResult Function()  startWatchlistAddition,required TResult Function( int step)  updateWatchlistStep,required TResult Function( int index)  highlightPageChanged,required TResult Function()  highlightContinuePressed,required TResult Function()  highlightSkipPressed,required TResult Function()  landingPageViewed,required TResult Function()  loginRequested,required TResult Function()  profileReadyPageViewed,required TResult Function()  profileReadyContinuePressed,required TResult Function( OnboardingStep step)  stepViewed,required TResult Function( bool didSubscribe,  String subscriptionType)  subscriptionStatusChanged,required TResult Function()  onboardingFlowFinished,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _NameSubmitted():
return nameSubmitted(_that.name);case _SectorSelected():
return sectorSelected(_that.sector);case _LoadSp500History():
return loadSp500History();case _ToggleBrand():
return toggleBrand(_that.brand);case _ExperienceSelected():
return experienceSelected(_that.experience);case _NotificationsToggled():
return notificationsToggled(_that.enabled);case _CompleteOnboarding():
return completeOnboarding();case _StartAnalysis():
return startAnalysis();case _UpdateAnalysisStep():
return updateAnalysisStep(_that.step);case _StartWatchlistAddition():
return startWatchlistAddition();case _UpdateWatchlistStep():
return updateWatchlistStep(_that.step);case _HighlightPageChanged():
return highlightPageChanged(_that.index);case _HighlightContinuePressed():
return highlightContinuePressed();case _HighlightSkipPressed():
return highlightSkipPressed();case _LandingPageViewed():
return landingPageViewed();case _LoginRequested():
return loginRequested();case _ProfileReadyPageViewed():
return profileReadyPageViewed();case _ProfileReadyContinuePressed():
return profileReadyContinuePressed();case _StepViewed():
return stepViewed(_that.step);case SubscriptionStatusChanged():
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case _OnboardingFlowFinished():
return onboardingFlowFinished();case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSubmitted,TResult? Function( Sector sector)?  sectorSelected,TResult? Function()?  loadSp500History,TResult? Function( Brand brand)?  toggleBrand,TResult? Function( InvestingExperience experience)?  experienceSelected,TResult? Function( bool enabled)?  notificationsToggled,TResult? Function()?  completeOnboarding,TResult? Function()?  startAnalysis,TResult? Function( int step)?  updateAnalysisStep,TResult? Function()?  startWatchlistAddition,TResult? Function( int step)?  updateWatchlistStep,TResult? Function( int index)?  highlightPageChanged,TResult? Function()?  highlightContinuePressed,TResult? Function()?  highlightSkipPressed,TResult? Function()?  landingPageViewed,TResult? Function()?  loginRequested,TResult? Function()?  profileReadyPageViewed,TResult? Function()?  profileReadyContinuePressed,TResult? Function( OnboardingStep step)?  stepViewed,TResult? Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult? Function()?  onboardingFlowFinished,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _NameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case _SectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case _LoadSp500History() when loadSp500History != null:
return loadSp500History();case _ToggleBrand() when toggleBrand != null:
return toggleBrand(_that.brand);case _ExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case _NotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case _CompleteOnboarding() when completeOnboarding != null:
return completeOnboarding();case _StartAnalysis() when startAnalysis != null:
return startAnalysis();case _UpdateAnalysisStep() when updateAnalysisStep != null:
return updateAnalysisStep(_that.step);case _StartWatchlistAddition() when startWatchlistAddition != null:
return startWatchlistAddition();case _UpdateWatchlistStep() when updateWatchlistStep != null:
return updateWatchlistStep(_that.step);case _HighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case _HighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case _HighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed();case _LandingPageViewed() when landingPageViewed != null:
return landingPageViewed();case _LoginRequested() when loginRequested != null:
return loginRequested();case _ProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed();case _ProfileReadyContinuePressed() when profileReadyContinuePressed != null:
return profileReadyContinuePressed();case _StepViewed() when stepViewed != null:
return stepViewed(_that.step);case SubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case _OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished();case _Reset() when reset != null:
return reset();case _:
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
  

 final  Sector sector;

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
 Sector sector
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
as Sector,
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


class _ToggleBrand implements OnboardingEvent {
  const _ToggleBrand(this.brand);
  

 final  Brand brand;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleBrandCopyWith<_ToggleBrand> get copyWith => __$ToggleBrandCopyWithImpl<_ToggleBrand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleBrand&&(identical(other.brand, brand) || other.brand == brand));
}


@override
int get hashCode => Object.hash(runtimeType,brand);

@override
String toString() {
  return 'OnboardingEvent.toggleBrand(brand: $brand)';
}


}

/// @nodoc
abstract mixin class _$ToggleBrandCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$ToggleBrandCopyWith(_ToggleBrand value, $Res Function(_ToggleBrand) _then) = __$ToggleBrandCopyWithImpl;
@useResult
$Res call({
 Brand brand
});


$BrandCopyWith<$Res> get brand;

}
/// @nodoc
class __$ToggleBrandCopyWithImpl<$Res>
    implements _$ToggleBrandCopyWith<$Res> {
  __$ToggleBrandCopyWithImpl(this._self, this._then);

  final _ToggleBrand _self;
  final $Res Function(_ToggleBrand) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brand = null,}) {
  return _then(_ToggleBrand(
null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand,
  ));
}

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandCopyWith<$Res> get brand {
  
  return $BrandCopyWith<$Res>(_self.brand, (value) {
    return _then(_self.copyWith(brand: value));
  });
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


class _NotificationsToggled implements OnboardingEvent {
  const _NotificationsToggled(this.enabled);
  

 final  bool enabled;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsToggledCopyWith<_NotificationsToggled> get copyWith => __$NotificationsToggledCopyWithImpl<_NotificationsToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsToggled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'OnboardingEvent.notificationsToggled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$NotificationsToggledCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$NotificationsToggledCopyWith(_NotificationsToggled value, $Res Function(_NotificationsToggled) _then) = __$NotificationsToggledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$NotificationsToggledCopyWithImpl<$Res>
    implements _$NotificationsToggledCopyWith<$Res> {
  __$NotificationsToggledCopyWithImpl(this._self, this._then);

  final _NotificationsToggled _self;
  final $Res Function(_NotificationsToggled) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_NotificationsToggled(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _CompleteOnboarding implements OnboardingEvent {
  const _CompleteOnboarding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteOnboarding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.completeOnboarding()';
}


}




/// @nodoc


class _StartAnalysis implements OnboardingEvent {
  const _StartAnalysis();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartAnalysis);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.startAnalysis()';
}


}




/// @nodoc


class _UpdateAnalysisStep implements OnboardingEvent {
  const _UpdateAnalysisStep(this.step);
  

 final  int step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateAnalysisStepCopyWith<_UpdateAnalysisStep> get copyWith => __$UpdateAnalysisStepCopyWithImpl<_UpdateAnalysisStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateAnalysisStep&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.updateAnalysisStep(step: $step)';
}


}

/// @nodoc
abstract mixin class _$UpdateAnalysisStepCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$UpdateAnalysisStepCopyWith(_UpdateAnalysisStep value, $Res Function(_UpdateAnalysisStep) _then) = __$UpdateAnalysisStepCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class __$UpdateAnalysisStepCopyWithImpl<$Res>
    implements _$UpdateAnalysisStepCopyWith<$Res> {
  __$UpdateAnalysisStepCopyWithImpl(this._self, this._then);

  final _UpdateAnalysisStep _self;
  final $Res Function(_UpdateAnalysisStep) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(_UpdateAnalysisStep(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StartWatchlistAddition implements OnboardingEvent {
  const _StartWatchlistAddition();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartWatchlistAddition);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.startWatchlistAddition()';
}


}




/// @nodoc


class _UpdateWatchlistStep implements OnboardingEvent {
  const _UpdateWatchlistStep(this.step);
  

 final  int step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateWatchlistStepCopyWith<_UpdateWatchlistStep> get copyWith => __$UpdateWatchlistStepCopyWithImpl<_UpdateWatchlistStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateWatchlistStep&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.updateWatchlistStep(step: $step)';
}


}

/// @nodoc
abstract mixin class _$UpdateWatchlistStepCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$UpdateWatchlistStepCopyWith(_UpdateWatchlistStep value, $Res Function(_UpdateWatchlistStep) _then) = __$UpdateWatchlistStepCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class __$UpdateWatchlistStepCopyWithImpl<$Res>
    implements _$UpdateWatchlistStepCopyWith<$Res> {
  __$UpdateWatchlistStepCopyWithImpl(this._self, this._then);

  final _UpdateWatchlistStep _self;
  final $Res Function(_UpdateWatchlistStep) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(_UpdateWatchlistStep(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _HighlightPageChanged implements OnboardingEvent {
  const _HighlightPageChanged(this.index);
  

 final  int index;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HighlightPageChangedCopyWith<_HighlightPageChanged> get copyWith => __$HighlightPageChangedCopyWithImpl<_HighlightPageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighlightPageChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OnboardingEvent.highlightPageChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class _$HighlightPageChangedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$HighlightPageChangedCopyWith(_HighlightPageChanged value, $Res Function(_HighlightPageChanged) _then) = __$HighlightPageChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$HighlightPageChangedCopyWithImpl<$Res>
    implements _$HighlightPageChangedCopyWith<$Res> {
  __$HighlightPageChangedCopyWithImpl(this._self, this._then);

  final _HighlightPageChanged _self;
  final $Res Function(_HighlightPageChanged) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_HighlightPageChanged(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _HighlightContinuePressed implements OnboardingEvent {
  const _HighlightContinuePressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighlightContinuePressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.highlightContinuePressed()';
}


}




/// @nodoc


class _HighlightSkipPressed implements OnboardingEvent {
  const _HighlightSkipPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HighlightSkipPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.highlightSkipPressed()';
}


}




/// @nodoc


class _LandingPageViewed implements OnboardingEvent {
  const _LandingPageViewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandingPageViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.landingPageViewed()';
}


}




/// @nodoc


class _LoginRequested implements OnboardingEvent {
  const _LoginRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.loginRequested()';
}


}




/// @nodoc


class _ProfileReadyPageViewed implements OnboardingEvent {
  const _ProfileReadyPageViewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileReadyPageViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.profileReadyPageViewed()';
}


}




/// @nodoc


class _ProfileReadyContinuePressed implements OnboardingEvent {
  const _ProfileReadyContinuePressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileReadyContinuePressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.profileReadyContinuePressed()';
}


}




/// @nodoc


class _StepViewed implements OnboardingEvent {
  const _StepViewed(this.step);
  

 final  OnboardingStep step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepViewedCopyWith<_StepViewed> get copyWith => __$StepViewedCopyWithImpl<_StepViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepViewed&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.stepViewed(step: $step)';
}


}

/// @nodoc
abstract mixin class _$StepViewedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory _$StepViewedCopyWith(_StepViewed value, $Res Function(_StepViewed) _then) = __$StepViewedCopyWithImpl;
@useResult
$Res call({
 OnboardingStep step
});




}
/// @nodoc
class __$StepViewedCopyWithImpl<$Res>
    implements _$StepViewedCopyWith<$Res> {
  __$StepViewedCopyWithImpl(this._self, this._then);

  final _StepViewed _self;
  final $Res Function(_StepViewed) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(_StepViewed(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,
  ));
}


}

/// @nodoc


class SubscriptionStatusChanged implements OnboardingEvent {
  const SubscriptionStatusChanged({required this.didSubscribe, required this.subscriptionType});
  

 final  bool didSubscribe;
 final  String subscriptionType;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusChangedCopyWith<SubscriptionStatusChanged> get copyWith => _$SubscriptionStatusChangedCopyWithImpl<SubscriptionStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusChanged&&(identical(other.didSubscribe, didSubscribe) || other.didSubscribe == didSubscribe)&&(identical(other.subscriptionType, subscriptionType) || other.subscriptionType == subscriptionType));
}


@override
int get hashCode => Object.hash(runtimeType,didSubscribe,subscriptionType);

@override
String toString() {
  return 'OnboardingEvent.subscriptionStatusChanged(didSubscribe: $didSubscribe, subscriptionType: $subscriptionType)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusChangedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $SubscriptionStatusChangedCopyWith(SubscriptionStatusChanged value, $Res Function(SubscriptionStatusChanged) _then) = _$SubscriptionStatusChangedCopyWithImpl;
@useResult
$Res call({
 bool didSubscribe, String subscriptionType
});




}
/// @nodoc
class _$SubscriptionStatusChangedCopyWithImpl<$Res>
    implements $SubscriptionStatusChangedCopyWith<$Res> {
  _$SubscriptionStatusChangedCopyWithImpl(this._self, this._then);

  final SubscriptionStatusChanged _self;
  final $Res Function(SubscriptionStatusChanged) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? didSubscribe = null,Object? subscriptionType = null,}) {
  return _then(SubscriptionStatusChanged(
didSubscribe: null == didSubscribe ? _self.didSubscribe : didSubscribe // ignore: cast_nullable_to_non_nullable
as bool,subscriptionType: null == subscriptionType ? _self.subscriptionType : subscriptionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _OnboardingFlowFinished implements OnboardingEvent {
  const _OnboardingFlowFinished();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingFlowFinished);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.onboardingFlowFinished()';
}


}




/// @nodoc


class _Reset implements OnboardingEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.reset()';
}


}




// dart format on
