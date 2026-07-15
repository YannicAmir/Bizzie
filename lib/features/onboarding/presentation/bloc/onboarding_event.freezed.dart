// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_event.dart';

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingStarted value)?  started,TResult Function( OnboardingNameSubmitted value)?  nameSubmitted,TResult Function( OnboardingSectorSelected value)?  sectorSelected,TResult Function( OnboardingSp500HistoryRequested value)?  sp500HistoryRequested,TResult Function( OnboardingBrandToggled value)?  brandToggled,TResult Function( OnboardingExperienceSelected value)?  experienceSelected,TResult Function( OnboardingNotificationsToggled value)?  notificationsToggled,TResult Function( OnboardingCompletionRequested value)?  completionRequested,TResult Function( OnboardingAnalysisStarted value)?  analysisStarted,TResult Function( OnboardingAnalysisStepUpdated value)?  analysisStepUpdated,TResult Function( OnboardingWatchlistAdditionStarted value)?  watchlistAdditionStarted,TResult Function( OnboardingWatchlistStepUpdated value)?  watchlistStepUpdated,TResult Function( OnboardingHighlightPageChanged value)?  highlightPageChanged,TResult Function( OnboardingHighlightContinuePressed value)?  highlightContinuePressed,TResult Function( OnboardingHighlightSkipPressed value)?  highlightSkipPressed,TResult Function( OnboardingLandingPageViewed value)?  landingPageViewed,TResult Function( OnboardingLoginRequested value)?  loginRequested,TResult Function( OnboardingProfileReadyPageViewed value)?  profileReadyPageViewed,TResult Function( OnboardingStepViewed value)?  stepViewed,TResult Function( OnboardingSubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult Function( OnboardingFlowFinished value)?  onboardingFlowFinished,TResult Function( OnboardingReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started(_that);case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested(_that);case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested(_that);case OnboardingAnalysisStarted() when analysisStarted != null:
return analysisStarted(_that);case OnboardingAnalysisStepUpdated() when analysisStepUpdated != null:
return analysisStepUpdated(_that);case OnboardingWatchlistAdditionStarted() when watchlistAdditionStarted != null:
return watchlistAdditionStarted(_that);case OnboardingWatchlistStepUpdated() when watchlistStepUpdated != null:
return watchlistStepUpdated(_that);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case OnboardingHighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed(_that);case OnboardingLandingPageViewed() when landingPageViewed != null:
return landingPageViewed(_that);case OnboardingLoginRequested() when loginRequested != null:
return loginRequested(_that);case OnboardingProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed(_that);case OnboardingStepViewed() when stepViewed != null:
return stepViewed(_that);case OnboardingSubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that);case OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished(_that);case OnboardingReset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingStarted value)  started,required TResult Function( OnboardingNameSubmitted value)  nameSubmitted,required TResult Function( OnboardingSectorSelected value)  sectorSelected,required TResult Function( OnboardingSp500HistoryRequested value)  sp500HistoryRequested,required TResult Function( OnboardingBrandToggled value)  brandToggled,required TResult Function( OnboardingExperienceSelected value)  experienceSelected,required TResult Function( OnboardingNotificationsToggled value)  notificationsToggled,required TResult Function( OnboardingCompletionRequested value)  completionRequested,required TResult Function( OnboardingAnalysisStarted value)  analysisStarted,required TResult Function( OnboardingAnalysisStepUpdated value)  analysisStepUpdated,required TResult Function( OnboardingWatchlistAdditionStarted value)  watchlistAdditionStarted,required TResult Function( OnboardingWatchlistStepUpdated value)  watchlistStepUpdated,required TResult Function( OnboardingHighlightPageChanged value)  highlightPageChanged,required TResult Function( OnboardingHighlightContinuePressed value)  highlightContinuePressed,required TResult Function( OnboardingHighlightSkipPressed value)  highlightSkipPressed,required TResult Function( OnboardingLandingPageViewed value)  landingPageViewed,required TResult Function( OnboardingLoginRequested value)  loginRequested,required TResult Function( OnboardingProfileReadyPageViewed value)  profileReadyPageViewed,required TResult Function( OnboardingStepViewed value)  stepViewed,required TResult Function( OnboardingSubscriptionStatusChanged value)  subscriptionStatusChanged,required TResult Function( OnboardingFlowFinished value)  onboardingFlowFinished,required TResult Function( OnboardingReset value)  reset,}){
final _that = this;
switch (_that) {
case OnboardingStarted():
return started(_that);case OnboardingNameSubmitted():
return nameSubmitted(_that);case OnboardingSectorSelected():
return sectorSelected(_that);case OnboardingSp500HistoryRequested():
return sp500HistoryRequested(_that);case OnboardingBrandToggled():
return brandToggled(_that);case OnboardingExperienceSelected():
return experienceSelected(_that);case OnboardingNotificationsToggled():
return notificationsToggled(_that);case OnboardingCompletionRequested():
return completionRequested(_that);case OnboardingAnalysisStarted():
return analysisStarted(_that);case OnboardingAnalysisStepUpdated():
return analysisStepUpdated(_that);case OnboardingWatchlistAdditionStarted():
return watchlistAdditionStarted(_that);case OnboardingWatchlistStepUpdated():
return watchlistStepUpdated(_that);case OnboardingHighlightPageChanged():
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed():
return highlightContinuePressed(_that);case OnboardingHighlightSkipPressed():
return highlightSkipPressed(_that);case OnboardingLandingPageViewed():
return landingPageViewed(_that);case OnboardingLoginRequested():
return loginRequested(_that);case OnboardingProfileReadyPageViewed():
return profileReadyPageViewed(_that);case OnboardingStepViewed():
return stepViewed(_that);case OnboardingSubscriptionStatusChanged():
return subscriptionStatusChanged(_that);case OnboardingFlowFinished():
return onboardingFlowFinished(_that);case OnboardingReset():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingStarted value)?  started,TResult? Function( OnboardingNameSubmitted value)?  nameSubmitted,TResult? Function( OnboardingSectorSelected value)?  sectorSelected,TResult? Function( OnboardingSp500HistoryRequested value)?  sp500HistoryRequested,TResult? Function( OnboardingBrandToggled value)?  brandToggled,TResult? Function( OnboardingExperienceSelected value)?  experienceSelected,TResult? Function( OnboardingNotificationsToggled value)?  notificationsToggled,TResult? Function( OnboardingCompletionRequested value)?  completionRequested,TResult? Function( OnboardingAnalysisStarted value)?  analysisStarted,TResult? Function( OnboardingAnalysisStepUpdated value)?  analysisStepUpdated,TResult? Function( OnboardingWatchlistAdditionStarted value)?  watchlistAdditionStarted,TResult? Function( OnboardingWatchlistStepUpdated value)?  watchlistStepUpdated,TResult? Function( OnboardingHighlightPageChanged value)?  highlightPageChanged,TResult? Function( OnboardingHighlightContinuePressed value)?  highlightContinuePressed,TResult? Function( OnboardingHighlightSkipPressed value)?  highlightSkipPressed,TResult? Function( OnboardingLandingPageViewed value)?  landingPageViewed,TResult? Function( OnboardingLoginRequested value)?  loginRequested,TResult? Function( OnboardingProfileReadyPageViewed value)?  profileReadyPageViewed,TResult? Function( OnboardingStepViewed value)?  stepViewed,TResult? Function( OnboardingSubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult? Function( OnboardingFlowFinished value)?  onboardingFlowFinished,TResult? Function( OnboardingReset value)?  reset,}){
final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started(_that);case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested(_that);case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested(_that);case OnboardingAnalysisStarted() when analysisStarted != null:
return analysisStarted(_that);case OnboardingAnalysisStepUpdated() when analysisStepUpdated != null:
return analysisStepUpdated(_that);case OnboardingWatchlistAdditionStarted() when watchlistAdditionStarted != null:
return watchlistAdditionStarted(_that);case OnboardingWatchlistStepUpdated() when watchlistStepUpdated != null:
return watchlistStepUpdated(_that);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case OnboardingHighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed(_that);case OnboardingLandingPageViewed() when landingPageViewed != null:
return landingPageViewed(_that);case OnboardingLoginRequested() when loginRequested != null:
return loginRequested(_that);case OnboardingProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed(_that);case OnboardingStepViewed() when stepViewed != null:
return stepViewed(_that);case OnboardingSubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that);case OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished(_that);case OnboardingReset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSubmitted,TResult Function( Sector sector)?  sectorSelected,TResult Function()?  sp500HistoryRequested,TResult Function( Brand brand)?  brandToggled,TResult Function( InvestingExperience experience)?  experienceSelected,TResult Function( bool enabled)?  notificationsToggled,TResult Function()?  completionRequested,TResult Function()?  analysisStarted,TResult Function( int step)?  analysisStepUpdated,TResult Function()?  watchlistAdditionStarted,TResult Function( int step)?  watchlistStepUpdated,TResult Function( int index)?  highlightPageChanged,TResult Function()?  highlightContinuePressed,TResult Function()?  highlightSkipPressed,TResult Function()?  landingPageViewed,TResult Function()?  loginRequested,TResult Function()?  profileReadyPageViewed,TResult Function( OnboardingStep step)?  stepViewed,TResult Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult Function()?  onboardingFlowFinished,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started();case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested();case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that.brand);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested();case OnboardingAnalysisStarted() when analysisStarted != null:
return analysisStarted();case OnboardingAnalysisStepUpdated() when analysisStepUpdated != null:
return analysisStepUpdated(_that.step);case OnboardingWatchlistAdditionStarted() when watchlistAdditionStarted != null:
return watchlistAdditionStarted();case OnboardingWatchlistStepUpdated() when watchlistStepUpdated != null:
return watchlistStepUpdated(_that.step);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case OnboardingHighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed();case OnboardingLandingPageViewed() when landingPageViewed != null:
return landingPageViewed();case OnboardingLoginRequested() when loginRequested != null:
return loginRequested();case OnboardingProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed();case OnboardingStepViewed() when stepViewed != null:
return stepViewed(_that.step);case OnboardingSubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished();case OnboardingReset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSubmitted,required TResult Function( Sector sector)  sectorSelected,required TResult Function()  sp500HistoryRequested,required TResult Function( Brand brand)  brandToggled,required TResult Function( InvestingExperience experience)  experienceSelected,required TResult Function( bool enabled)  notificationsToggled,required TResult Function()  completionRequested,required TResult Function()  analysisStarted,required TResult Function( int step)  analysisStepUpdated,required TResult Function()  watchlistAdditionStarted,required TResult Function( int step)  watchlistStepUpdated,required TResult Function( int index)  highlightPageChanged,required TResult Function()  highlightContinuePressed,required TResult Function()  highlightSkipPressed,required TResult Function()  landingPageViewed,required TResult Function()  loginRequested,required TResult Function()  profileReadyPageViewed,required TResult Function( OnboardingStep step)  stepViewed,required TResult Function( bool didSubscribe,  String subscriptionType)  subscriptionStatusChanged,required TResult Function()  onboardingFlowFinished,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case OnboardingStarted():
return started();case OnboardingNameSubmitted():
return nameSubmitted(_that.name);case OnboardingSectorSelected():
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested():
return sp500HistoryRequested();case OnboardingBrandToggled():
return brandToggled(_that.brand);case OnboardingExperienceSelected():
return experienceSelected(_that.experience);case OnboardingNotificationsToggled():
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested():
return completionRequested();case OnboardingAnalysisStarted():
return analysisStarted();case OnboardingAnalysisStepUpdated():
return analysisStepUpdated(_that.step);case OnboardingWatchlistAdditionStarted():
return watchlistAdditionStarted();case OnboardingWatchlistStepUpdated():
return watchlistStepUpdated(_that.step);case OnboardingHighlightPageChanged():
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed():
return highlightContinuePressed();case OnboardingHighlightSkipPressed():
return highlightSkipPressed();case OnboardingLandingPageViewed():
return landingPageViewed();case OnboardingLoginRequested():
return loginRequested();case OnboardingProfileReadyPageViewed():
return profileReadyPageViewed();case OnboardingStepViewed():
return stepViewed(_that.step);case OnboardingSubscriptionStatusChanged():
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case OnboardingFlowFinished():
return onboardingFlowFinished();case OnboardingReset():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSubmitted,TResult? Function( Sector sector)?  sectorSelected,TResult? Function()?  sp500HistoryRequested,TResult? Function( Brand brand)?  brandToggled,TResult? Function( InvestingExperience experience)?  experienceSelected,TResult? Function( bool enabled)?  notificationsToggled,TResult? Function()?  completionRequested,TResult? Function()?  analysisStarted,TResult? Function( int step)?  analysisStepUpdated,TResult? Function()?  watchlistAdditionStarted,TResult? Function( int step)?  watchlistStepUpdated,TResult? Function( int index)?  highlightPageChanged,TResult? Function()?  highlightContinuePressed,TResult? Function()?  highlightSkipPressed,TResult? Function()?  landingPageViewed,TResult? Function()?  loginRequested,TResult? Function()?  profileReadyPageViewed,TResult? Function( OnboardingStep step)?  stepViewed,TResult? Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult? Function()?  onboardingFlowFinished,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started();case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested();case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that.brand);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested();case OnboardingAnalysisStarted() when analysisStarted != null:
return analysisStarted();case OnboardingAnalysisStepUpdated() when analysisStepUpdated != null:
return analysisStepUpdated(_that.step);case OnboardingWatchlistAdditionStarted() when watchlistAdditionStarted != null:
return watchlistAdditionStarted();case OnboardingWatchlistStepUpdated() when watchlistStepUpdated != null:
return watchlistStepUpdated(_that.step);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case OnboardingHighlightSkipPressed() when highlightSkipPressed != null:
return highlightSkipPressed();case OnboardingLandingPageViewed() when landingPageViewed != null:
return landingPageViewed();case OnboardingLoginRequested() when loginRequested != null:
return loginRequested();case OnboardingProfileReadyPageViewed() when profileReadyPageViewed != null:
return profileReadyPageViewed();case OnboardingStepViewed() when stepViewed != null:
return stepViewed(_that.step);case OnboardingSubscriptionStatusChanged() when subscriptionStatusChanged != null:
return subscriptionStatusChanged(_that.didSubscribe,_that.subscriptionType);case OnboardingFlowFinished() when onboardingFlowFinished != null:
return onboardingFlowFinished();case OnboardingReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class OnboardingStarted implements OnboardingEvent {
  const OnboardingStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.started()';
}


}




/// @nodoc


class OnboardingNameSubmitted implements OnboardingEvent {
  const OnboardingNameSubmitted(this.name);
  

 final  String name;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingNameSubmittedCopyWith<OnboardingNameSubmitted> get copyWith => _$OnboardingNameSubmittedCopyWithImpl<OnboardingNameSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNameSubmitted&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'OnboardingEvent.nameSubmitted(name: $name)';
}


}

/// @nodoc
abstract mixin class $OnboardingNameSubmittedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingNameSubmittedCopyWith(OnboardingNameSubmitted value, $Res Function(OnboardingNameSubmitted) _then) = _$OnboardingNameSubmittedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$OnboardingNameSubmittedCopyWithImpl<$Res>
    implements $OnboardingNameSubmittedCopyWith<$Res> {
  _$OnboardingNameSubmittedCopyWithImpl(this._self, this._then);

  final OnboardingNameSubmitted _self;
  final $Res Function(OnboardingNameSubmitted) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(OnboardingNameSubmitted(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnboardingSectorSelected implements OnboardingEvent {
  const OnboardingSectorSelected(this.sector);
  

 final  Sector sector;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSectorSelectedCopyWith<OnboardingSectorSelected> get copyWith => _$OnboardingSectorSelectedCopyWithImpl<OnboardingSectorSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSectorSelected&&(identical(other.sector, sector) || other.sector == sector));
}


@override
int get hashCode => Object.hash(runtimeType,sector);

@override
String toString() {
  return 'OnboardingEvent.sectorSelected(sector: $sector)';
}


}

/// @nodoc
abstract mixin class $OnboardingSectorSelectedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingSectorSelectedCopyWith(OnboardingSectorSelected value, $Res Function(OnboardingSectorSelected) _then) = _$OnboardingSectorSelectedCopyWithImpl;
@useResult
$Res call({
 Sector sector
});




}
/// @nodoc
class _$OnboardingSectorSelectedCopyWithImpl<$Res>
    implements $OnboardingSectorSelectedCopyWith<$Res> {
  _$OnboardingSectorSelectedCopyWithImpl(this._self, this._then);

  final OnboardingSectorSelected _self;
  final $Res Function(OnboardingSectorSelected) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sector = null,}) {
  return _then(OnboardingSectorSelected(
null == sector ? _self.sector : sector // ignore: cast_nullable_to_non_nullable
as Sector,
  ));
}


}

/// @nodoc


class OnboardingSp500HistoryRequested implements OnboardingEvent {
  const OnboardingSp500HistoryRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSp500HistoryRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.sp500HistoryRequested()';
}


}




/// @nodoc


class OnboardingBrandToggled implements OnboardingEvent {
  const OnboardingBrandToggled(this.brand);
  

 final  Brand brand;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingBrandToggledCopyWith<OnboardingBrandToggled> get copyWith => _$OnboardingBrandToggledCopyWithImpl<OnboardingBrandToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBrandToggled&&(identical(other.brand, brand) || other.brand == brand));
}


@override
int get hashCode => Object.hash(runtimeType,brand);

@override
String toString() {
  return 'OnboardingEvent.brandToggled(brand: $brand)';
}


}

/// @nodoc
abstract mixin class $OnboardingBrandToggledCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingBrandToggledCopyWith(OnboardingBrandToggled value, $Res Function(OnboardingBrandToggled) _then) = _$OnboardingBrandToggledCopyWithImpl;
@useResult
$Res call({
 Brand brand
});


$BrandCopyWith<$Res> get brand;

}
/// @nodoc
class _$OnboardingBrandToggledCopyWithImpl<$Res>
    implements $OnboardingBrandToggledCopyWith<$Res> {
  _$OnboardingBrandToggledCopyWithImpl(this._self, this._then);

  final OnboardingBrandToggled _self;
  final $Res Function(OnboardingBrandToggled) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? brand = null,}) {
  return _then(OnboardingBrandToggled(
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


class OnboardingExperienceSelected implements OnboardingEvent {
  const OnboardingExperienceSelected(this.experience);
  

 final  InvestingExperience experience;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingExperienceSelectedCopyWith<OnboardingExperienceSelected> get copyWith => _$OnboardingExperienceSelectedCopyWithImpl<OnboardingExperienceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingExperienceSelected&&(identical(other.experience, experience) || other.experience == experience));
}


@override
int get hashCode => Object.hash(runtimeType,experience);

@override
String toString() {
  return 'OnboardingEvent.experienceSelected(experience: $experience)';
}


}

/// @nodoc
abstract mixin class $OnboardingExperienceSelectedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingExperienceSelectedCopyWith(OnboardingExperienceSelected value, $Res Function(OnboardingExperienceSelected) _then) = _$OnboardingExperienceSelectedCopyWithImpl;
@useResult
$Res call({
 InvestingExperience experience
});




}
/// @nodoc
class _$OnboardingExperienceSelectedCopyWithImpl<$Res>
    implements $OnboardingExperienceSelectedCopyWith<$Res> {
  _$OnboardingExperienceSelectedCopyWithImpl(this._self, this._then);

  final OnboardingExperienceSelected _self;
  final $Res Function(OnboardingExperienceSelected) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? experience = null,}) {
  return _then(OnboardingExperienceSelected(
null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as InvestingExperience,
  ));
}


}

/// @nodoc


class OnboardingNotificationsToggled implements OnboardingEvent {
  const OnboardingNotificationsToggled(this.enabled);
  

 final  bool enabled;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingNotificationsToggledCopyWith<OnboardingNotificationsToggled> get copyWith => _$OnboardingNotificationsToggledCopyWithImpl<OnboardingNotificationsToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNotificationsToggled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'OnboardingEvent.notificationsToggled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $OnboardingNotificationsToggledCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingNotificationsToggledCopyWith(OnboardingNotificationsToggled value, $Res Function(OnboardingNotificationsToggled) _then) = _$OnboardingNotificationsToggledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$OnboardingNotificationsToggledCopyWithImpl<$Res>
    implements $OnboardingNotificationsToggledCopyWith<$Res> {
  _$OnboardingNotificationsToggledCopyWithImpl(this._self, this._then);

  final OnboardingNotificationsToggled _self;
  final $Res Function(OnboardingNotificationsToggled) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(OnboardingNotificationsToggled(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class OnboardingCompletionRequested implements OnboardingEvent {
  const OnboardingCompletionRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingCompletionRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.completionRequested()';
}


}




/// @nodoc


class OnboardingAnalysisStarted implements OnboardingEvent {
  const OnboardingAnalysisStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingAnalysisStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.analysisStarted()';
}


}




/// @nodoc


class OnboardingAnalysisStepUpdated implements OnboardingEvent {
  const OnboardingAnalysisStepUpdated(this.step);
  

 final  int step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingAnalysisStepUpdatedCopyWith<OnboardingAnalysisStepUpdated> get copyWith => _$OnboardingAnalysisStepUpdatedCopyWithImpl<OnboardingAnalysisStepUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingAnalysisStepUpdated&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.analysisStepUpdated(step: $step)';
}


}

/// @nodoc
abstract mixin class $OnboardingAnalysisStepUpdatedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingAnalysisStepUpdatedCopyWith(OnboardingAnalysisStepUpdated value, $Res Function(OnboardingAnalysisStepUpdated) _then) = _$OnboardingAnalysisStepUpdatedCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class _$OnboardingAnalysisStepUpdatedCopyWithImpl<$Res>
    implements $OnboardingAnalysisStepUpdatedCopyWith<$Res> {
  _$OnboardingAnalysisStepUpdatedCopyWithImpl(this._self, this._then);

  final OnboardingAnalysisStepUpdated _self;
  final $Res Function(OnboardingAnalysisStepUpdated) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(OnboardingAnalysisStepUpdated(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnboardingWatchlistAdditionStarted implements OnboardingEvent {
  const OnboardingWatchlistAdditionStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingWatchlistAdditionStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.watchlistAdditionStarted()';
}


}




/// @nodoc


class OnboardingWatchlistStepUpdated implements OnboardingEvent {
  const OnboardingWatchlistStepUpdated(this.step);
  

 final  int step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingWatchlistStepUpdatedCopyWith<OnboardingWatchlistStepUpdated> get copyWith => _$OnboardingWatchlistStepUpdatedCopyWithImpl<OnboardingWatchlistStepUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingWatchlistStepUpdated&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.watchlistStepUpdated(step: $step)';
}


}

/// @nodoc
abstract mixin class $OnboardingWatchlistStepUpdatedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingWatchlistStepUpdatedCopyWith(OnboardingWatchlistStepUpdated value, $Res Function(OnboardingWatchlistStepUpdated) _then) = _$OnboardingWatchlistStepUpdatedCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class _$OnboardingWatchlistStepUpdatedCopyWithImpl<$Res>
    implements $OnboardingWatchlistStepUpdatedCopyWith<$Res> {
  _$OnboardingWatchlistStepUpdatedCopyWithImpl(this._self, this._then);

  final OnboardingWatchlistStepUpdated _self;
  final $Res Function(OnboardingWatchlistStepUpdated) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(OnboardingWatchlistStepUpdated(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnboardingHighlightPageChanged implements OnboardingEvent {
  const OnboardingHighlightPageChanged(this.index);
  

 final  int index;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingHighlightPageChangedCopyWith<OnboardingHighlightPageChanged> get copyWith => _$OnboardingHighlightPageChangedCopyWithImpl<OnboardingHighlightPageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingHighlightPageChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'OnboardingEvent.highlightPageChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class $OnboardingHighlightPageChangedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingHighlightPageChangedCopyWith(OnboardingHighlightPageChanged value, $Res Function(OnboardingHighlightPageChanged) _then) = _$OnboardingHighlightPageChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$OnboardingHighlightPageChangedCopyWithImpl<$Res>
    implements $OnboardingHighlightPageChangedCopyWith<$Res> {
  _$OnboardingHighlightPageChangedCopyWithImpl(this._self, this._then);

  final OnboardingHighlightPageChanged _self;
  final $Res Function(OnboardingHighlightPageChanged) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(OnboardingHighlightPageChanged(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnboardingHighlightContinuePressed implements OnboardingEvent {
  const OnboardingHighlightContinuePressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingHighlightContinuePressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.highlightContinuePressed()';
}


}




/// @nodoc


class OnboardingHighlightSkipPressed implements OnboardingEvent {
  const OnboardingHighlightSkipPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingHighlightSkipPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.highlightSkipPressed()';
}


}




/// @nodoc


class OnboardingLandingPageViewed implements OnboardingEvent {
  const OnboardingLandingPageViewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingLandingPageViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.landingPageViewed()';
}


}




/// @nodoc


class OnboardingLoginRequested implements OnboardingEvent {
  const OnboardingLoginRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingLoginRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.loginRequested()';
}


}




/// @nodoc


class OnboardingProfileReadyPageViewed implements OnboardingEvent {
  const OnboardingProfileReadyPageViewed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingProfileReadyPageViewed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.profileReadyPageViewed()';
}


}




/// @nodoc


class OnboardingStepViewed implements OnboardingEvent {
  const OnboardingStepViewed(this.step);
  

 final  OnboardingStep step;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStepViewedCopyWith<OnboardingStepViewed> get copyWith => _$OnboardingStepViewedCopyWithImpl<OnboardingStepViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStepViewed&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'OnboardingEvent.stepViewed(step: $step)';
}


}

/// @nodoc
abstract mixin class $OnboardingStepViewedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingStepViewedCopyWith(OnboardingStepViewed value, $Res Function(OnboardingStepViewed) _then) = _$OnboardingStepViewedCopyWithImpl;
@useResult
$Res call({
 OnboardingStep step
});




}
/// @nodoc
class _$OnboardingStepViewedCopyWithImpl<$Res>
    implements $OnboardingStepViewedCopyWith<$Res> {
  _$OnboardingStepViewedCopyWithImpl(this._self, this._then);

  final OnboardingStepViewed _self;
  final $Res Function(OnboardingStepViewed) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(OnboardingStepViewed(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,
  ));
}


}

/// @nodoc


class OnboardingSubscriptionStatusChanged implements OnboardingEvent {
  const OnboardingSubscriptionStatusChanged({required this.didSubscribe, required this.subscriptionType});
  

 final  bool didSubscribe;
 final  String subscriptionType;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSubscriptionStatusChangedCopyWith<OnboardingSubscriptionStatusChanged> get copyWith => _$OnboardingSubscriptionStatusChangedCopyWithImpl<OnboardingSubscriptionStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSubscriptionStatusChanged&&(identical(other.didSubscribe, didSubscribe) || other.didSubscribe == didSubscribe)&&(identical(other.subscriptionType, subscriptionType) || other.subscriptionType == subscriptionType));
}


@override
int get hashCode => Object.hash(runtimeType,didSubscribe,subscriptionType);

@override
String toString() {
  return 'OnboardingEvent.subscriptionStatusChanged(didSubscribe: $didSubscribe, subscriptionType: $subscriptionType)';
}


}

/// @nodoc
abstract mixin class $OnboardingSubscriptionStatusChangedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingSubscriptionStatusChangedCopyWith(OnboardingSubscriptionStatusChanged value, $Res Function(OnboardingSubscriptionStatusChanged) _then) = _$OnboardingSubscriptionStatusChangedCopyWithImpl;
@useResult
$Res call({
 bool didSubscribe, String subscriptionType
});




}
/// @nodoc
class _$OnboardingSubscriptionStatusChangedCopyWithImpl<$Res>
    implements $OnboardingSubscriptionStatusChangedCopyWith<$Res> {
  _$OnboardingSubscriptionStatusChangedCopyWithImpl(this._self, this._then);

  final OnboardingSubscriptionStatusChanged _self;
  final $Res Function(OnboardingSubscriptionStatusChanged) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? didSubscribe = null,Object? subscriptionType = null,}) {
  return _then(OnboardingSubscriptionStatusChanged(
didSubscribe: null == didSubscribe ? _self.didSubscribe : didSubscribe // ignore: cast_nullable_to_non_nullable
as bool,subscriptionType: null == subscriptionType ? _self.subscriptionType : subscriptionType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnboardingFlowFinished implements OnboardingEvent {
  const OnboardingFlowFinished();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingFlowFinished);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.onboardingFlowFinished()';
}


}




/// @nodoc


class OnboardingReset implements OnboardingEvent {
  const OnboardingReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingEvent.reset()';
}


}




// dart format on
