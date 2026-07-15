// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanySecurityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanySecurityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityState()';
}


}

/// @nodoc
class $CompanySecurityStateCopyWith<$Res>  {
$CompanySecurityStateCopyWith(CompanySecurityState _, $Res Function(CompanySecurityState) __);
}


/// Adds pattern-matching-related methods to [CompanySecurityState].
extension CompanySecurityStatePatterns on CompanySecurityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( SecurityLoaded value)?  loaded,TResult Function( SecurityUnsupported value)?  unsupported,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case SecurityLoaded() when loaded != null:
return loaded(_that);case SecurityUnsupported() when unsupported != null:
return unsupported(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( SecurityLoaded value)  loaded,required TResult Function( SecurityUnsupported value)  unsupported,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case SecurityLoaded():
return loaded(_that);case SecurityUnsupported():
return unsupported(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( SecurityLoaded value)?  loaded,TResult? Function( SecurityUnsupported value)?  unsupported,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case SecurityLoaded() when loaded != null:
return loaded(_that);case SecurityUnsupported() when unsupported != null:
return unsupported(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState,  DateTime? lastUpdated)?  loaded,TResult Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState)?  unsupported,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case SecurityLoaded() when loaded != null:
return loaded(_that.securityDetails,_that.analyticsState,_that.lastUpdated);case SecurityUnsupported() when unsupported != null:
return unsupported(_that.securityDetails,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState,  DateTime? lastUpdated)  loaded,required TResult Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState)  unsupported,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case SecurityLoaded():
return loaded(_that.securityDetails,_that.analyticsState,_that.lastUpdated);case SecurityUnsupported():
return unsupported(_that.securityDetails,_that.analyticsState);case _Failure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState,  DateTime? lastUpdated)?  loaded,TResult? Function( SecurityDetails securityDetails,  SecurityTabViewState analyticsState)?  unsupported,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case SecurityLoaded() when loaded != null:
return loaded(_that.securityDetails,_that.analyticsState,_that.lastUpdated);case SecurityUnsupported() when unsupported != null:
return unsupported(_that.securityDetails,_that.analyticsState);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanySecurityState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityState.initial()';
}


}




/// @nodoc


class _Loading implements CompanySecurityState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanySecurityState.loading()';
}


}




/// @nodoc


class SecurityLoaded implements CompanySecurityState {
  const SecurityLoaded(this.securityDetails, {required this.analyticsState, this.lastUpdated});
  

 final  SecurityDetails securityDetails;
 final  SecurityTabViewState analyticsState;
 final  DateTime? lastUpdated;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityLoadedCopyWith<SecurityLoaded> get copyWith => _$SecurityLoadedCopyWithImpl<SecurityLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityLoaded&&(identical(other.securityDetails, securityDetails) || other.securityDetails == securityDetails)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,securityDetails,analyticsState,lastUpdated);

@override
String toString() {
  return 'CompanySecurityState.loaded(securityDetails: $securityDetails, analyticsState: $analyticsState, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $SecurityLoadedCopyWith<$Res> implements $CompanySecurityStateCopyWith<$Res> {
  factory $SecurityLoadedCopyWith(SecurityLoaded value, $Res Function(SecurityLoaded) _then) = _$SecurityLoadedCopyWithImpl;
@useResult
$Res call({
 SecurityDetails securityDetails, SecurityTabViewState analyticsState, DateTime? lastUpdated
});


$SecurityDetailsCopyWith<$Res> get securityDetails;$SecurityTabViewStateCopyWith<$Res> get analyticsState;

}
/// @nodoc
class _$SecurityLoadedCopyWithImpl<$Res>
    implements $SecurityLoadedCopyWith<$Res> {
  _$SecurityLoadedCopyWithImpl(this._self, this._then);

  final SecurityLoaded _self;
  final $Res Function(SecurityLoaded) _then;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? securityDetails = null,Object? analyticsState = null,Object? lastUpdated = freezed,}) {
  return _then(SecurityLoaded(
null == securityDetails ? _self.securityDetails : securityDetails // ignore: cast_nullable_to_non_nullable
as SecurityDetails,analyticsState: null == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as SecurityTabViewState,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityDetailsCopyWith<$Res> get securityDetails {
  
  return $SecurityDetailsCopyWith<$Res>(_self.securityDetails, (value) {
    return _then(_self.copyWith(securityDetails: value));
  });
}/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityTabViewStateCopyWith<$Res> get analyticsState {
  
  return $SecurityTabViewStateCopyWith<$Res>(_self.analyticsState, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class SecurityUnsupported implements CompanySecurityState {
  const SecurityUnsupported(this.securityDetails, {required this.analyticsState});
  

 final  SecurityDetails securityDetails;
 final  SecurityTabViewState analyticsState;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityUnsupportedCopyWith<SecurityUnsupported> get copyWith => _$SecurityUnsupportedCopyWithImpl<SecurityUnsupported>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityUnsupported&&(identical(other.securityDetails, securityDetails) || other.securityDetails == securityDetails)&&(identical(other.analyticsState, analyticsState) || other.analyticsState == analyticsState));
}


@override
int get hashCode => Object.hash(runtimeType,securityDetails,analyticsState);

@override
String toString() {
  return 'CompanySecurityState.unsupported(securityDetails: $securityDetails, analyticsState: $analyticsState)';
}


}

/// @nodoc
abstract mixin class $SecurityUnsupportedCopyWith<$Res> implements $CompanySecurityStateCopyWith<$Res> {
  factory $SecurityUnsupportedCopyWith(SecurityUnsupported value, $Res Function(SecurityUnsupported) _then) = _$SecurityUnsupportedCopyWithImpl;
@useResult
$Res call({
 SecurityDetails securityDetails, SecurityTabViewState analyticsState
});


$SecurityDetailsCopyWith<$Res> get securityDetails;$SecurityTabViewStateCopyWith<$Res> get analyticsState;

}
/// @nodoc
class _$SecurityUnsupportedCopyWithImpl<$Res>
    implements $SecurityUnsupportedCopyWith<$Res> {
  _$SecurityUnsupportedCopyWithImpl(this._self, this._then);

  final SecurityUnsupported _self;
  final $Res Function(SecurityUnsupported) _then;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? securityDetails = null,Object? analyticsState = null,}) {
  return _then(SecurityUnsupported(
null == securityDetails ? _self.securityDetails : securityDetails // ignore: cast_nullable_to_non_nullable
as SecurityDetails,analyticsState: null == analyticsState ? _self.analyticsState : analyticsState // ignore: cast_nullable_to_non_nullable
as SecurityTabViewState,
  ));
}

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityDetailsCopyWith<$Res> get securityDetails {
  
  return $SecurityDetailsCopyWith<$Res>(_self.securityDetails, (value) {
    return _then(_self.copyWith(securityDetails: value));
  });
}/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityTabViewStateCopyWith<$Res> get analyticsState {
  
  return $SecurityTabViewStateCopyWith<$Res>(_self.analyticsState, (value) {
    return _then(_self.copyWith(analyticsState: value));
  });
}
}

/// @nodoc


class _Failure implements CompanySecurityState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CompanySecurityState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $CompanySecurityStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of CompanySecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of CompanySecurityState
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
