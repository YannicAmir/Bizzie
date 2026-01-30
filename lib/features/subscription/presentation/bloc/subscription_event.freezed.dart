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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubscriptionEventInitialized value)?  initialized,TResult Function( SubscriptionStatusUpdated value)?  statusUpdated,TResult Function( SubscriptionPurchaseRequested value)?  purchaseRequested,TResult Function( SubscriptionRestoreRequested value)?  restoreRequested,TResult Function( SubscriptionUserIdentityChanged value)?  userIdentityChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized(_that);case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested(_that);case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubscriptionEventInitialized value)  initialized,required TResult Function( SubscriptionStatusUpdated value)  statusUpdated,required TResult Function( SubscriptionPurchaseRequested value)  purchaseRequested,required TResult Function( SubscriptionRestoreRequested value)  restoreRequested,required TResult Function( SubscriptionUserIdentityChanged value)  userIdentityChanged,}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized():
return initialized(_that);case SubscriptionStatusUpdated():
return statusUpdated(_that);case SubscriptionPurchaseRequested():
return purchaseRequested(_that);case SubscriptionRestoreRequested():
return restoreRequested(_that);case SubscriptionUserIdentityChanged():
return userIdentityChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubscriptionEventInitialized value)?  initialized,TResult? Function( SubscriptionStatusUpdated value)?  statusUpdated,TResult? Function( SubscriptionPurchaseRequested value)?  purchaseRequested,TResult? Function( SubscriptionRestoreRequested value)?  restoreRequested,TResult? Function( SubscriptionUserIdentityChanged value)?  userIdentityChanged,}){
final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized(_that);case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested(_that);case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialized,TResult Function( SubscriptionStatus status)?  statusUpdated,TResult Function( SubscriptionPackage package)?  purchaseRequested,TResult Function()?  restoreRequested,TResult Function( String? uid)?  userIdentityChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized();case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that.package);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested();case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that.uid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialized,required TResult Function( SubscriptionStatus status)  statusUpdated,required TResult Function( SubscriptionPackage package)  purchaseRequested,required TResult Function()  restoreRequested,required TResult Function( String? uid)  userIdentityChanged,}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized():
return initialized();case SubscriptionStatusUpdated():
return statusUpdated(_that.status);case SubscriptionPurchaseRequested():
return purchaseRequested(_that.package);case SubscriptionRestoreRequested():
return restoreRequested();case SubscriptionUserIdentityChanged():
return userIdentityChanged(_that.uid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialized,TResult? Function( SubscriptionStatus status)?  statusUpdated,TResult? Function( SubscriptionPackage package)?  purchaseRequested,TResult? Function()?  restoreRequested,TResult? Function( String? uid)?  userIdentityChanged,}) {final _that = this;
switch (_that) {
case SubscriptionEventInitialized() when initialized != null:
return initialized();case SubscriptionStatusUpdated() when statusUpdated != null:
return statusUpdated(_that.status);case SubscriptionPurchaseRequested() when purchaseRequested != null:
return purchaseRequested(_that.package);case SubscriptionRestoreRequested() when restoreRequested != null:
return restoreRequested();case SubscriptionUserIdentityChanged() when userIdentityChanged != null:
return userIdentityChanged(_that.uid);case _:
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

// dart format on
