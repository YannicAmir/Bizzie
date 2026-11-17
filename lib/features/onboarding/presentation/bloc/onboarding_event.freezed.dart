// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingStarted value)?  started,TResult Function( OnboardingNameSubmitted value)?  nameSubmitted,TResult Function( OnboardingSectorSelected value)?  sectorSelected,TResult Function( OnboardingSp500HistoryRequested value)?  sp500HistoryRequested,TResult Function( OnboardingBrandToggled value)?  brandToggled,TResult Function( OnboardingExperienceSelected value)?  experienceSelected,TResult Function( OnboardingNotificationsToggled value)?  notificationsToggled,TResult Function( OnboardingCompletionRequested value)?  completionRequested,TResult Function( OnboardingBuildingProfileStarted value)?  buildingProfileStarted,TResult Function( OnboardingSkipRequested value)?  skipRequested,TResult Function( OnboardingNotificationGrantPersistRequested value)?  notificationGrantPersistRequested,TResult Function( OnboardingInitialCompanyShown value)?  initialCompanyShown,TResult Function( OnboardingGuestSessionRequested value)?  guestSessionRequested,TResult Function( OnboardingBrandsConfirmed value)?  brandsConfirmed,TResult Function( OnboardingBrandsPrefetchRequested value)?  brandsPrefetchRequested,TResult Function( OnboardingHighlightPageChanged value)?  highlightPageChanged,TResult Function( OnboardingHighlightContinuePressed value)?  highlightContinuePressed,TResult Function( OnboardingLoginRequested value)?  loginRequested,TResult Function( OnboardingStepViewed value)?  stepViewed,TResult Function( OnboardingSubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult Function( OnboardingFlowFinished value)?  onboardingFlowFinished,TResult Function( OnboardingReset value)?  reset,required TResult orElse(),}){
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
return completionRequested(_that);case OnboardingBuildingProfileStarted() when buildingProfileStarted != null:
return buildingProfileStarted(_that);case OnboardingSkipRequested() when skipRequested != null:
return skipRequested(_that);case OnboardingNotificationGrantPersistRequested() when notificationGrantPersistRequested != null:
return notificationGrantPersistRequested(_that);case OnboardingInitialCompanyShown() when initialCompanyShown != null:
return initialCompanyShown(_that);case OnboardingGuestSessionRequested() when guestSessionRequested != null:
return guestSessionRequested(_that);case OnboardingBrandsConfirmed() when brandsConfirmed != null:
return brandsConfirmed(_that);case OnboardingBrandsPrefetchRequested() when brandsPrefetchRequested != null:
return brandsPrefetchRequested(_that);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case OnboardingLoginRequested() when loginRequested != null:
return loginRequested(_that);case OnboardingStepViewed() when stepViewed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingStarted value)  started,required TResult Function( OnboardingNameSubmitted value)  nameSubmitted,required TResult Function( OnboardingSectorSelected value)  sectorSelected,required TResult Function( OnboardingSp500HistoryRequested value)  sp500HistoryRequested,required TResult Function( OnboardingBrandToggled value)  brandToggled,required TResult Function( OnboardingExperienceSelected value)  experienceSelected,required TResult Function( OnboardingNotificationsToggled value)  notificationsToggled,required TResult Function( OnboardingCompletionRequested value)  completionRequested,required TResult Function( OnboardingBuildingProfileStarted value)  buildingProfileStarted,required TResult Function( OnboardingSkipRequested value)  skipRequested,required TResult Function( OnboardingNotificationGrantPersistRequested value)  notificationGrantPersistRequested,required TResult Function( OnboardingInitialCompanyShown value)  initialCompanyShown,required TResult Function( OnboardingGuestSessionRequested value)  guestSessionRequested,required TResult Function( OnboardingBrandsConfirmed value)  brandsConfirmed,required TResult Function( OnboardingBrandsPrefetchRequested value)  brandsPrefetchRequested,required TResult Function( OnboardingHighlightPageChanged value)  highlightPageChanged,required TResult Function( OnboardingHighlightContinuePressed value)  highlightContinuePressed,required TResult Function( OnboardingLoginRequested value)  loginRequested,required TResult Function( OnboardingStepViewed value)  stepViewed,required TResult Function( OnboardingSubscriptionStatusChanged value)  subscriptionStatusChanged,required TResult Function( OnboardingFlowFinished value)  onboardingFlowFinished,required TResult Function( OnboardingReset value)  reset,}){
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
return completionRequested(_that);case OnboardingBuildingProfileStarted():
return buildingProfileStarted(_that);case OnboardingSkipRequested():
return skipRequested(_that);case OnboardingNotificationGrantPersistRequested():
return notificationGrantPersistRequested(_that);case OnboardingInitialCompanyShown():
return initialCompanyShown(_that);case OnboardingGuestSessionRequested():
return guestSessionRequested(_that);case OnboardingBrandsConfirmed():
return brandsConfirmed(_that);case OnboardingBrandsPrefetchRequested():
return brandsPrefetchRequested(_that);case OnboardingHighlightPageChanged():
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed():
return highlightContinuePressed(_that);case OnboardingLoginRequested():
return loginRequested(_that);case OnboardingStepViewed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingStarted value)?  started,TResult? Function( OnboardingNameSubmitted value)?  nameSubmitted,TResult? Function( OnboardingSectorSelected value)?  sectorSelected,TResult? Function( OnboardingSp500HistoryRequested value)?  sp500HistoryRequested,TResult? Function( OnboardingBrandToggled value)?  brandToggled,TResult? Function( OnboardingExperienceSelected value)?  experienceSelected,TResult? Function( OnboardingNotificationsToggled value)?  notificationsToggled,TResult? Function( OnboardingCompletionRequested value)?  completionRequested,TResult? Function( OnboardingBuildingProfileStarted value)?  buildingProfileStarted,TResult? Function( OnboardingSkipRequested value)?  skipRequested,TResult? Function( OnboardingNotificationGrantPersistRequested value)?  notificationGrantPersistRequested,TResult? Function( OnboardingInitialCompanyShown value)?  initialCompanyShown,TResult? Function( OnboardingGuestSessionRequested value)?  guestSessionRequested,TResult? Function( OnboardingBrandsConfirmed value)?  brandsConfirmed,TResult? Function( OnboardingBrandsPrefetchRequested value)?  brandsPrefetchRequested,TResult? Function( OnboardingHighlightPageChanged value)?  highlightPageChanged,TResult? Function( OnboardingHighlightContinuePressed value)?  highlightContinuePressed,TResult? Function( OnboardingLoginRequested value)?  loginRequested,TResult? Function( OnboardingStepViewed value)?  stepViewed,TResult? Function( OnboardingSubscriptionStatusChanged value)?  subscriptionStatusChanged,TResult? Function( OnboardingFlowFinished value)?  onboardingFlowFinished,TResult? Function( OnboardingReset value)?  reset,}){
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
return completionRequested(_that);case OnboardingBuildingProfileStarted() when buildingProfileStarted != null:
return buildingProfileStarted(_that);case OnboardingSkipRequested() when skipRequested != null:
return skipRequested(_that);case OnboardingNotificationGrantPersistRequested() when notificationGrantPersistRequested != null:
return notificationGrantPersistRequested(_that);case OnboardingInitialCompanyShown() when initialCompanyShown != null:
return initialCompanyShown(_that);case OnboardingGuestSessionRequested() when guestSessionRequested != null:
return guestSessionRequested(_that);case OnboardingBrandsConfirmed() when brandsConfirmed != null:
return brandsConfirmed(_that);case OnboardingBrandsPrefetchRequested() when brandsPrefetchRequested != null:
return brandsPrefetchRequested(_that);case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed(_that);case OnboardingLoginRequested() when loginRequested != null:
return loginRequested(_that);case OnboardingStepViewed() when stepViewed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String name)?  nameSubmitted,TResult Function( Sector sector)?  sectorSelected,TResult Function()?  sp500HistoryRequested,TResult Function( Brand brand)?  brandToggled,TResult Function( InvestingExperience experience)?  experienceSelected,TResult Function( bool enabled)?  notificationsToggled,TResult Function()?  completionRequested,TResult Function()?  buildingProfileStarted,TResult Function( OnboardingStep step,  OnboardingSkipReason reason)?  skipRequested,TResult Function()?  notificationGrantPersistRequested,TResult Function( PostOnboardingDestination destination)?  initialCompanyShown,TResult Function()?  guestSessionRequested,TResult Function()?  brandsConfirmed,TResult Function()?  brandsPrefetchRequested,TResult Function( int index)?  highlightPageChanged,TResult Function()?  highlightContinuePressed,TResult Function()?  loginRequested,TResult Function( OnboardingStep step)?  stepViewed,TResult Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult Function()?  onboardingFlowFinished,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started();case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested();case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that.brand);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested();case OnboardingBuildingProfileStarted() when buildingProfileStarted != null:
return buildingProfileStarted();case OnboardingSkipRequested() when skipRequested != null:
return skipRequested(_that.step,_that.reason);case OnboardingNotificationGrantPersistRequested() when notificationGrantPersistRequested != null:
return notificationGrantPersistRequested();case OnboardingInitialCompanyShown() when initialCompanyShown != null:
return initialCompanyShown(_that.destination);case OnboardingGuestSessionRequested() when guestSessionRequested != null:
return guestSessionRequested();case OnboardingBrandsConfirmed() when brandsConfirmed != null:
return brandsConfirmed();case OnboardingBrandsPrefetchRequested() when brandsPrefetchRequested != null:
return brandsPrefetchRequested();case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case OnboardingLoginRequested() when loginRequested != null:
return loginRequested();case OnboardingStepViewed() when stepViewed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String name)  nameSubmitted,required TResult Function( Sector sector)  sectorSelected,required TResult Function()  sp500HistoryRequested,required TResult Function( Brand brand)  brandToggled,required TResult Function( InvestingExperience experience)  experienceSelected,required TResult Function( bool enabled)  notificationsToggled,required TResult Function()  completionRequested,required TResult Function()  buildingProfileStarted,required TResult Function( OnboardingStep step,  OnboardingSkipReason reason)  skipRequested,required TResult Function()  notificationGrantPersistRequested,required TResult Function( PostOnboardingDestination destination)  initialCompanyShown,required TResult Function()  guestSessionRequested,required TResult Function()  brandsConfirmed,required TResult Function()  brandsPrefetchRequested,required TResult Function( int index)  highlightPageChanged,required TResult Function()  highlightContinuePressed,required TResult Function()  loginRequested,required TResult Function( OnboardingStep step)  stepViewed,required TResult Function( bool didSubscribe,  String subscriptionType)  subscriptionStatusChanged,required TResult Function()  onboardingFlowFinished,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case OnboardingStarted():
return started();case OnboardingNameSubmitted():
return nameSubmitted(_that.name);case OnboardingSectorSelected():
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested():
return sp500HistoryRequested();case OnboardingBrandToggled():
return brandToggled(_that.brand);case OnboardingExperienceSelected():
return experienceSelected(_that.experience);case OnboardingNotificationsToggled():
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested():
return completionRequested();case OnboardingBuildingProfileStarted():
return buildingProfileStarted();case OnboardingSkipRequested():
return skipRequested(_that.step,_that.reason);case OnboardingNotificationGrantPersistRequested():
return notificationGrantPersistRequested();case OnboardingInitialCompanyShown():
return initialCompanyShown(_that.destination);case OnboardingGuestSessionRequested():
return guestSessionRequested();case OnboardingBrandsConfirmed():
return brandsConfirmed();case OnboardingBrandsPrefetchRequested():
return brandsPrefetchRequested();case OnboardingHighlightPageChanged():
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed():
return highlightContinuePressed();case OnboardingLoginRequested():
return loginRequested();case OnboardingStepViewed():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String name)?  nameSubmitted,TResult? Function( Sector sector)?  sectorSelected,TResult? Function()?  sp500HistoryRequested,TResult? Function( Brand brand)?  brandToggled,TResult? Function( InvestingExperience experience)?  experienceSelected,TResult? Function( bool enabled)?  notificationsToggled,TResult? Function()?  completionRequested,TResult? Function()?  buildingProfileStarted,TResult? Function( OnboardingStep step,  OnboardingSkipReason reason)?  skipRequested,TResult? Function()?  notificationGrantPersistRequested,TResult? Function( PostOnboardingDestination destination)?  initialCompanyShown,TResult? Function()?  guestSessionRequested,TResult? Function()?  brandsConfirmed,TResult? Function()?  brandsPrefetchRequested,TResult? Function( int index)?  highlightPageChanged,TResult? Function()?  highlightContinuePressed,TResult? Function()?  loginRequested,TResult? Function( OnboardingStep step)?  stepViewed,TResult? Function( bool didSubscribe,  String subscriptionType)?  subscriptionStatusChanged,TResult? Function()?  onboardingFlowFinished,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case OnboardingStarted() when started != null:
return started();case OnboardingNameSubmitted() when nameSubmitted != null:
return nameSubmitted(_that.name);case OnboardingSectorSelected() when sectorSelected != null:
return sectorSelected(_that.sector);case OnboardingSp500HistoryRequested() when sp500HistoryRequested != null:
return sp500HistoryRequested();case OnboardingBrandToggled() when brandToggled != null:
return brandToggled(_that.brand);case OnboardingExperienceSelected() when experienceSelected != null:
return experienceSelected(_that.experience);case OnboardingNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case OnboardingCompletionRequested() when completionRequested != null:
return completionRequested();case OnboardingBuildingProfileStarted() when buildingProfileStarted != null:
return buildingProfileStarted();case OnboardingSkipRequested() when skipRequested != null:
return skipRequested(_that.step,_that.reason);case OnboardingNotificationGrantPersistRequested() when notificationGrantPersistRequested != null:
return notificationGrantPersistRequested();case OnboardingInitialCompanyShown() when initialCompanyShown != null:
return initialCompanyShown(_that.destination);case OnboardingGuestSessionRequested() when guestSessionRequested != null:
return guestSessionRequested();case OnboardingBrandsConfirmed() when brandsConfirmed != null:
return brandsConfirmed();case OnboardingBrandsPrefetchRequested() when brandsPrefetchRequested != null:
return brandsPrefetchRequested();case OnboardingHighlightPageChanged() when highlightPageChanged != null:
return highlightPageChanged(_that.index);case OnboardingHighlightContinuePressed() when highlightContinuePressed != null:
return highlightContinuePressed();case OnboardingLoginRequested() when loginRequested != null:
return loginRequested();case OnboardingStepViewed() when stepViewed != null:
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
int get hashCode {
    return Object.hash(runtimeType,name);
}

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
int get hashCode {
    return Object.hash(runtimeType,sector);
}

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
int get hashCode {
    return Object.hash(runtimeType,brand);
}

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
int get hashCode {
    return Object.hash(runtimeType,experience);
}

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
  const OnboardingNotificationsToggled({required this.enabled});
  

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
int get hashCode {
    return Object.hash(runtimeType,enabled);
}

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
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
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


class OnboardingBuildingProfileStarted implements OnboardingEvent {
  const OnboardingBuildingProfileStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBuildingProfileStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OnboardingEvent.buildingProfileStarted()';
}


}




/// @nodoc


class OnboardingSkipRequested implements OnboardingEvent {
  const OnboardingSkipRequested(this.step, {this.reason = OnboardingSkipReason.userSkipped});
  

 final  OnboardingStep step;
@JsonKey() final  OnboardingSkipReason reason;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSkipRequestedCopyWith<OnboardingSkipRequested> get copyWith => _$OnboardingSkipRequestedCopyWithImpl<OnboardingSkipRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSkipRequested&&(identical(other.step, step) || other.step == step)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,reason);
}

@override
String toString() {
    return 'OnboardingEvent.skipRequested(step: $step, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $OnboardingSkipRequestedCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingSkipRequestedCopyWith(OnboardingSkipRequested value, $Res Function(OnboardingSkipRequested) _then) = _$OnboardingSkipRequestedCopyWithImpl;
@useResult
$Res call({
 OnboardingStep step, OnboardingSkipReason reason
});




}
/// @nodoc
class _$OnboardingSkipRequestedCopyWithImpl<$Res>
    implements $OnboardingSkipRequestedCopyWith<$Res> {
  _$OnboardingSkipRequestedCopyWithImpl(this._self, this._then);

  final OnboardingSkipRequested _self;
  final $Res Function(OnboardingSkipRequested) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,Object? reason = null,}) {
  return _then(OnboardingSkipRequested(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as OnboardingSkipReason,
  ));
}


}

/// @nodoc


class OnboardingNotificationGrantPersistRequested implements OnboardingEvent {
  const OnboardingNotificationGrantPersistRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNotificationGrantPersistRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OnboardingEvent.notificationGrantPersistRequested()';
}


}




/// @nodoc


class OnboardingInitialCompanyShown implements OnboardingEvent {
  const OnboardingInitialCompanyShown(this.destination);
  

 final  PostOnboardingDestination destination;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingInitialCompanyShownCopyWith<OnboardingInitialCompanyShown> get copyWith => _$OnboardingInitialCompanyShownCopyWithImpl<OnboardingInitialCompanyShown>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingInitialCompanyShown&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode {
    return Object.hash(runtimeType,destination);
}

@override
String toString() {
    return 'OnboardingEvent.initialCompanyShown(destination: $destination)';
}


}

/// @nodoc
abstract mixin class $OnboardingInitialCompanyShownCopyWith<$Res> implements $OnboardingEventCopyWith<$Res> {
  factory $OnboardingInitialCompanyShownCopyWith(OnboardingInitialCompanyShown value, $Res Function(OnboardingInitialCompanyShown) _then) = _$OnboardingInitialCompanyShownCopyWithImpl;
@useResult
$Res call({
 PostOnboardingDestination destination
});


$PostOnboardingDestinationCopyWith<$Res> get destination;

}
/// @nodoc
class _$OnboardingInitialCompanyShownCopyWithImpl<$Res>
    implements $OnboardingInitialCompanyShownCopyWith<$Res> {
  _$OnboardingInitialCompanyShownCopyWithImpl(this._self, this._then);

  final OnboardingInitialCompanyShown _self;
  final $Res Function(OnboardingInitialCompanyShown) _then;

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destination = null,}) {
  return _then(OnboardingInitialCompanyShown(
null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as PostOnboardingDestination,
  ));
}

/// Create a copy of OnboardingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostOnboardingDestinationCopyWith<$Res> get destination {
  
  return $PostOnboardingDestinationCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

/// @nodoc


class OnboardingGuestSessionRequested implements OnboardingEvent {
  const OnboardingGuestSessionRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingGuestSessionRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OnboardingEvent.guestSessionRequested()';
}


}




/// @nodoc


class OnboardingBrandsConfirmed implements OnboardingEvent {
  const OnboardingBrandsConfirmed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBrandsConfirmed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OnboardingEvent.brandsConfirmed()';
}


}




/// @nodoc


class OnboardingBrandsPrefetchRequested implements OnboardingEvent {
  const OnboardingBrandsPrefetchRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingBrandsPrefetchRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OnboardingEvent.brandsPrefetchRequested()';
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
int get hashCode {
    return Object.hash(runtimeType,index);
}

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
int get hashCode {
    return Object.hash(runtimeType,step);
}

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
int get hashCode {
    return Object.hash(runtimeType,didSubscribe,subscriptionType);
}

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
