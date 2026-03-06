// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {

 SubscriptionStatus get status; PaywallSource? get paywallSource;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.paywallSource, paywallSource) || other.paywallSource == paywallSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,paywallSource);

@override
String toString() {
  return 'SubscriptionState(status: $status, paywallSource: $paywallSource)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 SubscriptionStatus status, PaywallSource? paywallSource
});


$SubscriptionStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? paywallSource = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,paywallSource: freezed == paywallSource ? _self.paywallSource : paywallSource // ignore: cast_nullable_to_non_nullable
as PaywallSource?,
  ));
}
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get status {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubscriptionStateInitial value)?  initial,TResult Function( SubscriptionStateLoading value)?  loading,TResult Function( SubscriptionStateLoaded value)?  loaded,TResult Function( SubscriptionStateFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionStateInitial() when initial != null:
return initial(_that);case SubscriptionStateLoading() when loading != null:
return loading(_that);case SubscriptionStateLoaded() when loaded != null:
return loaded(_that);case SubscriptionStateFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubscriptionStateInitial value)  initial,required TResult Function( SubscriptionStateLoading value)  loading,required TResult Function( SubscriptionStateLoaded value)  loaded,required TResult Function( SubscriptionStateFailure value)  failure,}){
final _that = this;
switch (_that) {
case SubscriptionStateInitial():
return initial(_that);case SubscriptionStateLoading():
return loading(_that);case SubscriptionStateLoaded():
return loaded(_that);case SubscriptionStateFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubscriptionStateInitial value)?  initial,TResult? Function( SubscriptionStateLoading value)?  loading,TResult? Function( SubscriptionStateLoaded value)?  loaded,TResult? Function( SubscriptionStateFailure value)?  failure,}){
final _that = this;
switch (_that) {
case SubscriptionStateInitial() when initial != null:
return initial(_that);case SubscriptionStateLoading() when loading != null:
return loading(_that);case SubscriptionStateLoaded() when loaded != null:
return loaded(_that);case SubscriptionStateFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SubscriptionStatus status,  PaywallSource? paywallSource)?  initial,TResult Function( SubscriptionStatus status,  PaywallSource? paywallSource)?  loading,TResult Function( SubscriptionStatus status,  SubscriptionOffering offerings,  SubscriptionPackage? annualPackage,  SubscriptionPackage? monthlyPackage,  SubscriptionPackage? discountAnnualPackage,  List<String> features,  bool isLocalSuccessOverride,  bool isPurchasing,  bool isAnnualSelection,  PaywallSource? paywallSource)?  loaded,TResult Function( SubscriptionStatus status,  Failure failure,  PaywallSource? paywallSource)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionStateInitial() when initial != null:
return initial(_that.status,_that.paywallSource);case SubscriptionStateLoading() when loading != null:
return loading(_that.status,_that.paywallSource);case SubscriptionStateLoaded() when loaded != null:
return loaded(_that.status,_that.offerings,_that.annualPackage,_that.monthlyPackage,_that.discountAnnualPackage,_that.features,_that.isLocalSuccessOverride,_that.isPurchasing,_that.isAnnualSelection,_that.paywallSource);case SubscriptionStateFailure() when failure != null:
return failure(_that.status,_that.failure,_that.paywallSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SubscriptionStatus status,  PaywallSource? paywallSource)  initial,required TResult Function( SubscriptionStatus status,  PaywallSource? paywallSource)  loading,required TResult Function( SubscriptionStatus status,  SubscriptionOffering offerings,  SubscriptionPackage? annualPackage,  SubscriptionPackage? monthlyPackage,  SubscriptionPackage? discountAnnualPackage,  List<String> features,  bool isLocalSuccessOverride,  bool isPurchasing,  bool isAnnualSelection,  PaywallSource? paywallSource)  loaded,required TResult Function( SubscriptionStatus status,  Failure failure,  PaywallSource? paywallSource)  failure,}) {final _that = this;
switch (_that) {
case SubscriptionStateInitial():
return initial(_that.status,_that.paywallSource);case SubscriptionStateLoading():
return loading(_that.status,_that.paywallSource);case SubscriptionStateLoaded():
return loaded(_that.status,_that.offerings,_that.annualPackage,_that.monthlyPackage,_that.discountAnnualPackage,_that.features,_that.isLocalSuccessOverride,_that.isPurchasing,_that.isAnnualSelection,_that.paywallSource);case SubscriptionStateFailure():
return failure(_that.status,_that.failure,_that.paywallSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SubscriptionStatus status,  PaywallSource? paywallSource)?  initial,TResult? Function( SubscriptionStatus status,  PaywallSource? paywallSource)?  loading,TResult? Function( SubscriptionStatus status,  SubscriptionOffering offerings,  SubscriptionPackage? annualPackage,  SubscriptionPackage? monthlyPackage,  SubscriptionPackage? discountAnnualPackage,  List<String> features,  bool isLocalSuccessOverride,  bool isPurchasing,  bool isAnnualSelection,  PaywallSource? paywallSource)?  loaded,TResult? Function( SubscriptionStatus status,  Failure failure,  PaywallSource? paywallSource)?  failure,}) {final _that = this;
switch (_that) {
case SubscriptionStateInitial() when initial != null:
return initial(_that.status,_that.paywallSource);case SubscriptionStateLoading() when loading != null:
return loading(_that.status,_that.paywallSource);case SubscriptionStateLoaded() when loaded != null:
return loaded(_that.status,_that.offerings,_that.annualPackage,_that.monthlyPackage,_that.discountAnnualPackage,_that.features,_that.isLocalSuccessOverride,_that.isPurchasing,_that.isAnnualSelection,_that.paywallSource);case SubscriptionStateFailure() when failure != null:
return failure(_that.status,_that.failure,_that.paywallSource);case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionStateInitial extends SubscriptionState {
  const SubscriptionStateInitial({required this.status, this.paywallSource}): super._();
  

@override final  SubscriptionStatus status;
@override final  PaywallSource? paywallSource;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateInitialCopyWith<SubscriptionStateInitial> get copyWith => _$SubscriptionStateInitialCopyWithImpl<SubscriptionStateInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStateInitial&&(identical(other.status, status) || other.status == status)&&(identical(other.paywallSource, paywallSource) || other.paywallSource == paywallSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,paywallSource);

@override
String toString() {
  return 'SubscriptionState.initial(status: $status, paywallSource: $paywallSource)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateInitialCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateInitialCopyWith(SubscriptionStateInitial value, $Res Function(SubscriptionStateInitial) _then) = _$SubscriptionStateInitialCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, PaywallSource? paywallSource
});


@override $SubscriptionStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SubscriptionStateInitialCopyWithImpl<$Res>
    implements $SubscriptionStateInitialCopyWith<$Res> {
  _$SubscriptionStateInitialCopyWithImpl(this._self, this._then);

  final SubscriptionStateInitial _self;
  final $Res Function(SubscriptionStateInitial) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? paywallSource = freezed,}) {
  return _then(SubscriptionStateInitial(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,paywallSource: freezed == paywallSource ? _self.paywallSource : paywallSource // ignore: cast_nullable_to_non_nullable
as PaywallSource?,
  ));
}

/// Create a copy of SubscriptionState
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


class SubscriptionStateLoading extends SubscriptionState {
  const SubscriptionStateLoading({required this.status, this.paywallSource}): super._();
  

@override final  SubscriptionStatus status;
@override final  PaywallSource? paywallSource;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateLoadingCopyWith<SubscriptionStateLoading> get copyWith => _$SubscriptionStateLoadingCopyWithImpl<SubscriptionStateLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStateLoading&&(identical(other.status, status) || other.status == status)&&(identical(other.paywallSource, paywallSource) || other.paywallSource == paywallSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,paywallSource);

@override
String toString() {
  return 'SubscriptionState.loading(status: $status, paywallSource: $paywallSource)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateLoadingCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateLoadingCopyWith(SubscriptionStateLoading value, $Res Function(SubscriptionStateLoading) _then) = _$SubscriptionStateLoadingCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, PaywallSource? paywallSource
});


@override $SubscriptionStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SubscriptionStateLoadingCopyWithImpl<$Res>
    implements $SubscriptionStateLoadingCopyWith<$Res> {
  _$SubscriptionStateLoadingCopyWithImpl(this._self, this._then);

  final SubscriptionStateLoading _self;
  final $Res Function(SubscriptionStateLoading) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? paywallSource = freezed,}) {
  return _then(SubscriptionStateLoading(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,paywallSource: freezed == paywallSource ? _self.paywallSource : paywallSource // ignore: cast_nullable_to_non_nullable
as PaywallSource?,
  ));
}

/// Create a copy of SubscriptionState
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


class SubscriptionStateLoaded extends SubscriptionState {
  const SubscriptionStateLoaded({required this.status, required this.offerings, this.annualPackage, this.monthlyPackage, this.discountAnnualPackage, final  List<String> features = const [], this.isLocalSuccessOverride = false, this.isPurchasing = false, this.isAnnualSelection = true, this.paywallSource}): _features = features,super._();
  

@override final  SubscriptionStatus status;
 final  SubscriptionOffering offerings;
 final  SubscriptionPackage? annualPackage;
 final  SubscriptionPackage? monthlyPackage;
 final  SubscriptionPackage? discountAnnualPackage;
 final  List<String> _features;
@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

@JsonKey() final  bool isLocalSuccessOverride;
@JsonKey() final  bool isPurchasing;
@JsonKey() final  bool isAnnualSelection;
@override final  PaywallSource? paywallSource;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateLoadedCopyWith<SubscriptionStateLoaded> get copyWith => _$SubscriptionStateLoadedCopyWithImpl<SubscriptionStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStateLoaded&&(identical(other.status, status) || other.status == status)&&(identical(other.offerings, offerings) || other.offerings == offerings)&&(identical(other.annualPackage, annualPackage) || other.annualPackage == annualPackage)&&(identical(other.monthlyPackage, monthlyPackage) || other.monthlyPackage == monthlyPackage)&&(identical(other.discountAnnualPackage, discountAnnualPackage) || other.discountAnnualPackage == discountAnnualPackage)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.isLocalSuccessOverride, isLocalSuccessOverride) || other.isLocalSuccessOverride == isLocalSuccessOverride)&&(identical(other.isPurchasing, isPurchasing) || other.isPurchasing == isPurchasing)&&(identical(other.isAnnualSelection, isAnnualSelection) || other.isAnnualSelection == isAnnualSelection)&&(identical(other.paywallSource, paywallSource) || other.paywallSource == paywallSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,offerings,annualPackage,monthlyPackage,discountAnnualPackage,const DeepCollectionEquality().hash(_features),isLocalSuccessOverride,isPurchasing,isAnnualSelection,paywallSource);

@override
String toString() {
  return 'SubscriptionState.loaded(status: $status, offerings: $offerings, annualPackage: $annualPackage, monthlyPackage: $monthlyPackage, discountAnnualPackage: $discountAnnualPackage, features: $features, isLocalSuccessOverride: $isLocalSuccessOverride, isPurchasing: $isPurchasing, isAnnualSelection: $isAnnualSelection, paywallSource: $paywallSource)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateLoadedCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateLoadedCopyWith(SubscriptionStateLoaded value, $Res Function(SubscriptionStateLoaded) _then) = _$SubscriptionStateLoadedCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, SubscriptionOffering offerings, SubscriptionPackage? annualPackage, SubscriptionPackage? monthlyPackage, SubscriptionPackage? discountAnnualPackage, List<String> features, bool isLocalSuccessOverride, bool isPurchasing, bool isAnnualSelection, PaywallSource? paywallSource
});


@override $SubscriptionStatusCopyWith<$Res> get status;$SubscriptionOfferingCopyWith<$Res> get offerings;$SubscriptionPackageCopyWith<$Res>? get annualPackage;$SubscriptionPackageCopyWith<$Res>? get monthlyPackage;$SubscriptionPackageCopyWith<$Res>? get discountAnnualPackage;

}
/// @nodoc
class _$SubscriptionStateLoadedCopyWithImpl<$Res>
    implements $SubscriptionStateLoadedCopyWith<$Res> {
  _$SubscriptionStateLoadedCopyWithImpl(this._self, this._then);

  final SubscriptionStateLoaded _self;
  final $Res Function(SubscriptionStateLoaded) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? offerings = null,Object? annualPackage = freezed,Object? monthlyPackage = freezed,Object? discountAnnualPackage = freezed,Object? features = null,Object? isLocalSuccessOverride = null,Object? isPurchasing = null,Object? isAnnualSelection = null,Object? paywallSource = freezed,}) {
  return _then(SubscriptionStateLoaded(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,offerings: null == offerings ? _self.offerings : offerings // ignore: cast_nullable_to_non_nullable
as SubscriptionOffering,annualPackage: freezed == annualPackage ? _self.annualPackage : annualPackage // ignore: cast_nullable_to_non_nullable
as SubscriptionPackage?,monthlyPackage: freezed == monthlyPackage ? _self.monthlyPackage : monthlyPackage // ignore: cast_nullable_to_non_nullable
as SubscriptionPackage?,discountAnnualPackage: freezed == discountAnnualPackage ? _self.discountAnnualPackage : discountAnnualPackage // ignore: cast_nullable_to_non_nullable
as SubscriptionPackage?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,isLocalSuccessOverride: null == isLocalSuccessOverride ? _self.isLocalSuccessOverride : isLocalSuccessOverride // ignore: cast_nullable_to_non_nullable
as bool,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isAnnualSelection: null == isAnnualSelection ? _self.isAnnualSelection : isAnnualSelection // ignore: cast_nullable_to_non_nullable
as bool,paywallSource: freezed == paywallSource ? _self.paywallSource : paywallSource // ignore: cast_nullable_to_non_nullable
as PaywallSource?,
  ));
}

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get status {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionOfferingCopyWith<$Res> get offerings {
  
  return $SubscriptionOfferingCopyWith<$Res>(_self.offerings, (value) {
    return _then(_self.copyWith(offerings: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPackageCopyWith<$Res>? get annualPackage {
    if (_self.annualPackage == null) {
    return null;
  }

  return $SubscriptionPackageCopyWith<$Res>(_self.annualPackage!, (value) {
    return _then(_self.copyWith(annualPackage: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPackageCopyWith<$Res>? get monthlyPackage {
    if (_self.monthlyPackage == null) {
    return null;
  }

  return $SubscriptionPackageCopyWith<$Res>(_self.monthlyPackage!, (value) {
    return _then(_self.copyWith(monthlyPackage: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPackageCopyWith<$Res>? get discountAnnualPackage {
    if (_self.discountAnnualPackage == null) {
    return null;
  }

  return $SubscriptionPackageCopyWith<$Res>(_self.discountAnnualPackage!, (value) {
    return _then(_self.copyWith(discountAnnualPackage: value));
  });
}
}

/// @nodoc


class SubscriptionStateFailure extends SubscriptionState {
  const SubscriptionStateFailure({required this.status, required this.failure, this.paywallSource}): super._();
  

@override final  SubscriptionStatus status;
 final  Failure failure;
@override final  PaywallSource? paywallSource;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateFailureCopyWith<SubscriptionStateFailure> get copyWith => _$SubscriptionStateFailureCopyWithImpl<SubscriptionStateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStateFailure&&(identical(other.status, status) || other.status == status)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.paywallSource, paywallSource) || other.paywallSource == paywallSource));
}


@override
int get hashCode => Object.hash(runtimeType,status,failure,paywallSource);

@override
String toString() {
  return 'SubscriptionState.failure(status: $status, failure: $failure, paywallSource: $paywallSource)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateFailureCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateFailureCopyWith(SubscriptionStateFailure value, $Res Function(SubscriptionStateFailure) _then) = _$SubscriptionStateFailureCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, Failure failure, PaywallSource? paywallSource
});


@override $SubscriptionStatusCopyWith<$Res> get status;$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$SubscriptionStateFailureCopyWithImpl<$Res>
    implements $SubscriptionStateFailureCopyWith<$Res> {
  _$SubscriptionStateFailureCopyWithImpl(this._self, this._then);

  final SubscriptionStateFailure _self;
  final $Res Function(SubscriptionStateFailure) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? failure = null,Object? paywallSource = freezed,}) {
  return _then(SubscriptionStateFailure(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,paywallSource: freezed == paywallSource ? _self.paywallSource : paywallSource // ignore: cast_nullable_to_non_nullable
as PaywallSource?,
  ));
}

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionStatusCopyWith<$Res> get status {
  
  return $SubscriptionStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of SubscriptionState
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
