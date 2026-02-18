// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent()';
}


}

/// @nodoc
class $SubscriptionEventCopyWith<$Res>  {
$SubscriptionEventCopyWith(SubscriptionEvent _, $Res Function(SubscriptionEvent) __);
}


/// Adds pattern-matching-related methods to [SubscriptionEvent].
extension SubscriptionEventPatterns on SubscriptionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubscriptionEventInitialized value)?  initialized,TResult Function( SubscriptionStatusUpdated value)?  statusUpdated,TResult Function( SubscriptionPurchaseRequested value)?  purchaseRequested,TResult Function( SubscriptionRestoreRequested value)?  restoreRequested,TResult Function( SubscriptionPurchaseUICompleted value)?  purchaseUICompleted,TResult Function( SubscriptionUserIdentityChanged value)?  userIdentityChanged,TResult Function( SubscriptionOfferingsRequested value)?  offeringsRequested,TResult Function( SubscriptionRefreshRequested value)?  refreshRequested,TResult Function( SubscriptionPlanToggled value)?  planToggled,TResult Function( SubscriptionAppResumed value)?  appResumed,TResult Function( SubscriptionExpirationReached value)?  expirationReached,TResult Function( SubscriptionResetPurchaseState value)?  resetPurchaseState,TResult Function( SubscriptionViewed value)?  viewed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized(_that);case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested(_that);case SubscriptionPurchaseUICompleted() when purchaseUICompleted != null:
return purchaseUICompleted(_that);case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that);case SubscriptionOfferingsRequested() when offeringsRequested != null:
return offeringsRequested(_that);case SubscriptionRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SubscriptionPlanToggled() when planToggled != null:
return planToggled(_that);case SubscriptionAppResumed() when appResumed != null:
return appResumed(_that);case SubscriptionExpirationReached() when expirationReached != null:
return expirationReached(_that);case SubscriptionResetPurchaseState() when resetPurchaseState != null:
return resetPurchaseState(_that);case SubscriptionViewed() when viewed != null:
return viewed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubscriptionEventInitialized value)  initialized,required TResult Function( SubscriptionStatusUpdated value)  statusUpdated,required TResult Function( SubscriptionPurchaseRequested value)  purchaseRequested,required TResult Function( SubscriptionRestoreRequested value)  restoreRequested,required TResult Function( SubscriptionPurchaseUICompleted value)  purchaseUICompleted,required TResult Function( SubscriptionUserIdentityChanged value)  userIdentityChanged,required TResult Function( SubscriptionOfferingsRequested value)  offeringsRequested,required TResult Function( SubscriptionRefreshRequested value)  refreshRequested,required TResult Function( SubscriptionPlanToggled value)  planToggled,required TResult Function( SubscriptionAppResumed value)  appResumed,required TResult Function( SubscriptionExpirationReached value)  expirationReached,required TResult Function( SubscriptionResetPurchaseState value)  resetPurchaseState,required TResult Function( SubscriptionViewed value)  viewed,}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized():
return initialized(_that);case SubscriptionStatusUpdated():
return statusUpdated(_that);case SubscriptionPurchaseRequested():
return purchaseRequested(_that);case SubscriptionRestoreRequested():
return restoreRequested(_that);case SubscriptionPurchaseUICompleted():
return purchaseUICompleted(_that);case SubscriptionUserIdentityChanged():
return userIdentityChanged(_that);case SubscriptionOfferingsRequested():
return offeringsRequested(_that);case SubscriptionRefreshRequested():
return refreshRequested(_that);case SubscriptionPlanToggled():
return planToggled(_that);case SubscriptionAppResumed():
return appResumed(_that);case SubscriptionExpirationReached():
return expirationReached(_that);case SubscriptionResetPurchaseState():
return resetPurchaseState(_that);case SubscriptionViewed():
return viewed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubscriptionEventInitialized value)?  initialized,TResult? Function( SubscriptionStatusUpdated value)?  statusUpdated,TResult? Function( SubscriptionPurchaseRequested value)?  purchaseRequested,TResult? Function( SubscriptionRestoreRequested value)?  restoreRequested,TResult? Function( SubscriptionPurchaseUICompleted value)?  purchaseUICompleted,TResult? Function( SubscriptionUserIdentityChanged value)?  userIdentityChanged,TResult? Function( SubscriptionOfferingsRequested value)?  offeringsRequested,TResult? Function( SubscriptionRefreshRequested value)?  refreshRequested,TResult? Function( SubscriptionPlanToggled value)?  planToggled,TResult? Function( SubscriptionAppResumed value)?  appResumed,TResult? Function( SubscriptionExpirationReached value)?  expirationReached,TResult? Function( SubscriptionResetPurchaseState value)?  resetPurchaseState,TResult? Function( SubscriptionViewed value)?  viewed,}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized(_that);case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested(_that);case SubscriptionPurchaseUICompleted() when purchaseUICompleted != null:
return purchaseUICompleted(_that);case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that);case SubscriptionOfferingsRequested() when offeringsRequested != null:
return offeringsRequested(_that);case SubscriptionRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SubscriptionPlanToggled() when planToggled != null:
return planToggled(_that);case SubscriptionAppResumed() when appResumed != null:
return appResumed(_that);case SubscriptionExpirationReached() when expirationReached != null:
return expirationReached(_that);case SubscriptionResetPurchaseState() when resetPurchaseState != null:
return resetPurchaseState(_that);case SubscriptionViewed() when viewed != null:
return viewed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialized,TResult Function( SubscriptionStatus status)?  statusUpdated,TResult Function( SubscriptionPackage package)?  purchaseRequested,TResult Function()?  restoreRequested,TResult Function()?  purchaseUICompleted,TResult Function( String? uid)?  userIdentityChanged,TResult Function()?  offeringsRequested,TResult Function()?  refreshRequested,TResult Function( bool isAnnual)?  planToggled,TResult Function()?  appResumed,TResult Function()?  expirationReached,TResult Function()?  resetPurchaseState,TResult Function( PaywallSource source)?  viewed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized();case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that.package);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested();case SubscriptionPurchaseUICompleted() when purchaseUICompleted != null:
return purchaseUICompleted();case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that.uid);case SubscriptionOfferingsRequested() when offeringsRequested != null:
return offeringsRequested();case SubscriptionRefreshRequested() when refreshRequested != null:
return refreshRequested();case SubscriptionPlanToggled() when planToggled != null:
return planToggled(_that.isAnnual);case SubscriptionAppResumed() when appResumed != null:
return appResumed();case SubscriptionExpirationReached() when expirationReached != null:
return expirationReached();case SubscriptionResetPurchaseState() when resetPurchaseState != null:
return resetPurchaseState();case SubscriptionViewed() when viewed != null:
return viewed(_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialized,required TResult Function( SubscriptionStatus status)  statusUpdated,required TResult Function( SubscriptionPackage package)  purchaseRequested,required TResult Function()  restoreRequested,required TResult Function()  purchaseUICompleted,required TResult Function( String? uid)  userIdentityChanged,required TResult Function()  offeringsRequested,required TResult Function()  refreshRequested,required TResult Function( bool isAnnual)  planToggled,required TResult Function()  appResumed,required TResult Function()  expirationReached,required TResult Function()  resetPurchaseState,required TResult Function( PaywallSource source)  viewed,}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized():
return initialized();case SubscriptionStatusUpdated():
return statusUpdated(_that.status);case SubscriptionPurchaseRequested():
return purchaseRequested(_that.package);case SubscriptionRestoreRequested():
return restoreRequested();case SubscriptionPurchaseUICompleted():
return purchaseUICompleted();case SubscriptionUserIdentityChanged():
return userIdentityChanged(_that.uid);case SubscriptionOfferingsRequested():
return offeringsRequested();case SubscriptionRefreshRequested():
return refreshRequested();case SubscriptionPlanToggled():
return planToggled(_that.isAnnual);case SubscriptionAppResumed():
return appResumed();case SubscriptionExpirationReached():
return expirationReached();case SubscriptionResetPurchaseState():
return resetPurchaseState();case SubscriptionViewed():
return viewed(_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialized,TResult? Function( SubscriptionStatus status)?  statusUpdated,TResult? Function( SubscriptionPackage package)?  purchaseRequested,TResult? Function()?  restoreRequested,TResult? Function()?  purchaseUICompleted,TResult? Function( String? uid)?  userIdentityChanged,TResult? Function()?  offeringsRequested,TResult? Function()?  refreshRequested,TResult? Function( bool isAnnual)?  planToggled,TResult? Function()?  appResumed,TResult? Function()?  expirationReached,TResult? Function()?  resetPurchaseState,TResult? Function( PaywallSource source)?  viewed,}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized();case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that.package);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested();case SubscriptionPurchaseUICompleted() when purchaseUICompleted != null:
return purchaseUICompleted();case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that.uid);case SubscriptionOfferingsRequested() when offeringsRequested != null:
return offeringsRequested();case SubscriptionRefreshRequested() when refreshRequested != null:
return refreshRequested();case SubscriptionPlanToggled() when planToggled != null:
return planToggled(_that.isAnnual);case SubscriptionAppResumed() when appResumed != null:
return appResumed();case SubscriptionExpirationReached() when expirationReached != null:
return expirationReached();case SubscriptionResetPurchaseState() when resetPurchaseState != null:
return resetPurchaseState();case SubscriptionViewed() when viewed != null:
return viewed(_that.source);case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionEventInitialized implements SubscriptionEvent {
  const SubscriptionEventInitialized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionEventInitialized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.initialized()';
}


}




/// @nodoc


class SubscriptionStatusUpdated implements SubscriptionEvent {
  const SubscriptionStatusUpdated(this.status);
  

 final  SubscriptionStatus status;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStatusUpdatedCopyWith<SubscriptionStatusUpdated> get copyWith => _$SubscriptionStatusUpdatedCopyWithImpl<SubscriptionStatusUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStatusUpdated&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SubscriptionEvent.statusUpdated(status: $status)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStatusUpdatedCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionStatusUpdatedCopyWith(SubscriptionStatusUpdated value, $Res Function(SubscriptionStatusUpdated) _then) = _$SubscriptionStatusUpdatedCopyWithImpl;
@useResult
$Res call({
 SubscriptionStatus status
});


$SubscriptionStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SubscriptionStatusUpdatedCopyWithImpl<$Res>
    implements $SubscriptionStatusUpdatedCopyWith<$Res> {
  _$SubscriptionStatusUpdatedCopyWithImpl(this._self, this._then);

  final SubscriptionStatusUpdated _self;
  final $Res Function(SubscriptionStatusUpdated) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(SubscriptionStatusUpdated(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,
  ));
}

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get status {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc


class SubscriptionPurchaseRequested implements SubscriptionEvent {
  const SubscriptionPurchaseRequested(this.package);
  

 final  SubscriptionPackage package;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPurchaseRequestedCopyWith<SubscriptionPurchaseRequested> get copyWith => _$SubscriptionPurchaseRequestedCopyWithImpl<SubscriptionPurchaseRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPurchaseRequested&&(identical(other.package, package) || other.package == package));
}


@override
int get hashCode => Object.hash(runtimeType,package);

@override
String toString() {
  return 'SubscriptionEvent.purchaseRequested(package: $package)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPurchaseRequestedCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionPurchaseRequestedCopyWith(SubscriptionPurchaseRequested value, $Res Function(SubscriptionPurchaseRequested) _then) = _$SubscriptionPurchaseRequestedCopyWithImpl;
@useResult
$Res call({
 SubscriptionPackage package
});


$SubscriptionPackageCopyWith<$Res> get package;

}
/// @nodoc
class _$SubscriptionPurchaseRequestedCopyWithImpl<$Res>
    implements $SubscriptionPurchaseRequestedCopyWith<$Res> {
  _$SubscriptionPurchaseRequestedCopyWithImpl(this._self, this._then);

  final SubscriptionPurchaseRequested _self;
  final $Res Function(SubscriptionPurchaseRequested) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? package = null,}) {
  return _then(SubscriptionPurchaseRequested(
null == package ? _self.package : package // ignore: cast_nullable_to_non_nullable
as SubscriptionPackage,
  ));
}

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPackageCopyWith<$Res> get package {
  
  return $SubscriptionPackageCopyWith<$Res>(_self.package, (value) {
    return _then(_self.copyWith(package: value));
  });
}
}

/// @nodoc


class SubscriptionRestoreRequested implements SubscriptionEvent {
  const SubscriptionRestoreRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionRestoreRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.restoreRequested()';
}


}




/// @nodoc


class SubscriptionPurchaseUICompleted implements SubscriptionEvent {
  const SubscriptionPurchaseUICompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPurchaseUICompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.purchaseUICompleted()';
}


}




/// @nodoc


class SubscriptionUserIdentityChanged implements SubscriptionEvent {
  const SubscriptionUserIdentityChanged(this.uid);
  

 final  String? uid;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionUserIdentityChangedCopyWith<SubscriptionUserIdentityChanged> get copyWith => _$SubscriptionUserIdentityChangedCopyWithImpl<SubscriptionUserIdentityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionUserIdentityChanged&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,uid);

@override
String toString() {
  return 'SubscriptionEvent.userIdentityChanged(uid: $uid)';
}


}

/// @nodoc
abstract mixin class $SubscriptionUserIdentityChangedCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionUserIdentityChangedCopyWith(SubscriptionUserIdentityChanged value, $Res Function(SubscriptionUserIdentityChanged) _then) = _$SubscriptionUserIdentityChangedCopyWithImpl;
@useResult
$Res call({
 String? uid
});




}
/// @nodoc
class _$SubscriptionUserIdentityChangedCopyWithImpl<$Res>
    implements $SubscriptionUserIdentityChangedCopyWith<$Res> {
  _$SubscriptionUserIdentityChangedCopyWithImpl(this._self, this._then);

  final SubscriptionUserIdentityChanged _self;
  final $Res Function(SubscriptionUserIdentityChanged) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = freezed,}) {
  return _then(SubscriptionUserIdentityChanged(
freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SubscriptionOfferingsRequested implements SubscriptionEvent {
  const SubscriptionOfferingsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionOfferingsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.offeringsRequested()';
}


}




/// @nodoc


class SubscriptionRefreshRequested implements SubscriptionEvent {
  const SubscriptionRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.refreshRequested()';
}


}




/// @nodoc


class SubscriptionPlanToggled implements SubscriptionEvent {
  const SubscriptionPlanToggled({required this.isAnnual});
  

 final  bool isAnnual;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPlanToggledCopyWith<SubscriptionPlanToggled> get copyWith => _$SubscriptionPlanToggledCopyWithImpl<SubscriptionPlanToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPlanToggled&&(identical(other.isAnnual, isAnnual) || other.isAnnual == isAnnual));
}


@override
int get hashCode => Object.hash(runtimeType,isAnnual);

@override
String toString() {
  return 'SubscriptionEvent.planToggled(isAnnual: $isAnnual)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPlanToggledCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionPlanToggledCopyWith(SubscriptionPlanToggled value, $Res Function(SubscriptionPlanToggled) _then) = _$SubscriptionPlanToggledCopyWithImpl;
@useResult
$Res call({
 bool isAnnual
});




}
/// @nodoc
class _$SubscriptionPlanToggledCopyWithImpl<$Res>
    implements $SubscriptionPlanToggledCopyWith<$Res> {
  _$SubscriptionPlanToggledCopyWithImpl(this._self, this._then);

  final SubscriptionPlanToggled _self;
  final $Res Function(SubscriptionPlanToggled) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isAnnual = null,}) {
  return _then(SubscriptionPlanToggled(
isAnnual: null == isAnnual ? _self.isAnnual : isAnnual // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SubscriptionAppResumed implements SubscriptionEvent {
  const SubscriptionAppResumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionAppResumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.appResumed()';
}


}




/// @nodoc


class SubscriptionExpirationReached implements SubscriptionEvent {
  const SubscriptionExpirationReached();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionExpirationReached);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.expirationReached()';
}


}




/// @nodoc


class SubscriptionResetPurchaseState implements SubscriptionEvent {
  const SubscriptionResetPurchaseState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionResetPurchaseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.resetPurchaseState()';
}


}




/// @nodoc


class SubscriptionViewed implements SubscriptionEvent {
  const SubscriptionViewed({required this.source});
  

 final  PaywallSource source;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionViewedCopyWith<SubscriptionViewed> get copyWith => _$SubscriptionViewedCopyWithImpl<SubscriptionViewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionViewed&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'SubscriptionEvent.viewed(source: $source)';
}


}

/// @nodoc
abstract mixin class $SubscriptionViewedCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $SubscriptionViewedCopyWith(SubscriptionViewed value, $Res Function(SubscriptionViewed) _then) = _$SubscriptionViewedCopyWithImpl;
@useResult
$Res call({
 PaywallSource source
});




}
/// @nodoc
class _$SubscriptionViewedCopyWithImpl<$Res>
    implements $SubscriptionViewedCopyWith<$Res> {
  _$SubscriptionViewedCopyWithImpl(this._self, this._then);

  final SubscriptionViewed _self;
  final $Res Function(SubscriptionViewed) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(SubscriptionViewed(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as PaywallSource,
  ));
}


}

// dart format on
