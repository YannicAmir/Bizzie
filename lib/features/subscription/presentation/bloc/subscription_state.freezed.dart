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

 SubscriptionStatus get status; bool get isLoading; bool get isLocalSuccessOverride; Failure? get failure;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocalSuccessOverride, isLocalSuccessOverride) || other.isLocalSuccessOverride == isLocalSuccessOverride)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,isLoading,isLocalSuccessOverride,failure);

@override
String toString() {
  return 'SubscriptionState(status: $status, isLoading: $isLoading, isLocalSuccessOverride: $isLocalSuccessOverride, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 SubscriptionStatus status, bool isLoading, bool isLocalSuccessOverride, Failure? failure
});


$SubscriptionStatusCopyWith<$Res> get status;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isLoading = null,Object? isLocalSuccessOverride = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocalSuccessOverride: null == isLocalSuccessOverride ? _self.isLocalSuccessOverride : isLocalSuccessOverride // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
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
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( SubscriptionStateImpl value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionStateImpl() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( SubscriptionStateImpl value)  $default,){
final _that = this;
switch (_that) {
case SubscriptionStateImpl():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( SubscriptionStateImpl value)?  $default,){
final _that = this;
switch (_that) {
case SubscriptionStateImpl() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubscriptionStatus status,  bool isLoading,  bool isLocalSuccessOverride,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionStateImpl() when $default != null:
return $default(_that.status,_that.isLoading,_that.isLocalSuccessOverride,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubscriptionStatus status,  bool isLoading,  bool isLocalSuccessOverride,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case SubscriptionStateImpl():
return $default(_that.status,_that.isLoading,_that.isLocalSuccessOverride,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubscriptionStatus status,  bool isLoading,  bool isLocalSuccessOverride,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case SubscriptionStateImpl() when $default != null:
return $default(_that.status,_that.isLoading,_that.isLocalSuccessOverride,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionStateImpl implements SubscriptionState {
  const SubscriptionStateImpl({required this.status, required this.isLoading, required this.isLocalSuccessOverride, this.failure});
  

@override final  SubscriptionStatus status;
@override final  bool isLoading;
@override final  bool isLocalSuccessOverride;
@override final  Failure? failure;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateImplCopyWith<SubscriptionStateImpl> get copyWith => _$SubscriptionStateImplCopyWithImpl<SubscriptionStateImpl>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionStateImpl&&(identical(other.status, status) || other.status == status)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLocalSuccessOverride, isLocalSuccessOverride) || other.isLocalSuccessOverride == isLocalSuccessOverride)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,status,isLoading,isLocalSuccessOverride,failure);

@override
String toString() {
  return 'SubscriptionState(status: $status, isLoading: $isLoading, isLocalSuccessOverride: $isLocalSuccessOverride, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateImplCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateImplCopyWith(SubscriptionStateImpl value, $Res Function(SubscriptionStateImpl) _then) = _$SubscriptionStateImplCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, bool isLoading, bool isLocalSuccessOverride, Failure? failure
});


@override $SubscriptionStatusCopyWith<$Res> get status;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$SubscriptionStateImplCopyWithImpl<$Res>
    implements $SubscriptionStateImplCopyWith<$Res> {
  _$SubscriptionStateImplCopyWithImpl(this._self, this._then);

  final SubscriptionStateImpl _self;
  final $Res Function(SubscriptionStateImpl) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isLoading = null,Object? isLocalSuccessOverride = null,Object? failure = freezed,}) {
  return _then(SubscriptionStateImpl(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLocalSuccessOverride: null == isLocalSuccessOverride ? _self.isLocalSuccessOverride : isLocalSuccessOverride // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
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
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
