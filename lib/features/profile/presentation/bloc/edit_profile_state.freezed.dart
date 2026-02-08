// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState()';
}


}

/// @nodoc
class $EditProfileStateCopyWith<$Res>  {
$EditProfileStateCopyWith(EditProfileState _, $Res Function(EditProfileState) __);
}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _Form value)?  form,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Form() when form != null:
return form(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _Form value)  form,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _Form():
return form(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _Form value)?  form,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Form() when form != null:
return form(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? favoriteSector)?  loading,TResult Function()?  success,TResult Function( Failure failure,  String? favoriteSector)?  failure,TResult Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure)?  form,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.failure,_that.favoriteSector);case _Form() when form != null:
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? favoriteSector)  loading,required TResult Function()  success,required TResult Function( Failure failure,  String? favoriteSector)  failure,required TResult Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure)  form,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.favoriteSector);case _Success():
return success();case _Failure():
return failure(_that.failure,_that.favoriteSector);case _Form():
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? favoriteSector)?  loading,TResult? Function()?  success,TResult? Function( Failure failure,  String? favoriteSector)?  failure,TResult? Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure)?  form,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Success() when success != null:
return success();case _Failure() when failure != null:
return failure(_that.failure,_that.favoriteSector);case _Form() when form != null:
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements EditProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.initial()';
}


}




/// @nodoc


class _Loading implements EditProfileState {
  const _Loading({this.favoriteSector});
  

 final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'EditProfileState.loading(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Loading(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Success implements EditProfileState {
  const _Success();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileState.success()';
}


}




/// @nodoc


class _Failure implements EditProfileState {
  const _Failure(this.failure, {this.favoriteSector});
  

 final  Failure failure;
 final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,failure,favoriteSector);

@override
String toString() {
  return 'EditProfileState.failure(failure: $failure, favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 Failure failure, String? favoriteSector
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? favoriteSector = freezed,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

/// @nodoc


class _Form implements EditProfileState {
  const _Form({required this.firstName, required this.email, required this.originalFirstName, required this.originalEmail, this.favoriteSector, this.isSubmitting = false, this.saveFailure});
  

 final  String firstName;
 final  String email;
 final  String originalFirstName;
 final  String originalEmail;
 final  String? favoriteSector;
@JsonKey() final  bool isSubmitting;
 final  Failure? saveFailure;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormCopyWith<_Form> get copyWith => __$FormCopyWithImpl<_Form>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Form&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.email, email) || other.email == email)&&(identical(other.originalFirstName, originalFirstName) || other.originalFirstName == originalFirstName)&&(identical(other.originalEmail, originalEmail) || other.originalEmail == originalEmail)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.saveFailure, saveFailure) || other.saveFailure == saveFailure));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,email,originalFirstName,originalEmail,favoriteSector,isSubmitting,saveFailure);

@override
String toString() {
  return 'EditProfileState.form(firstName: $firstName, email: $email, originalFirstName: $originalFirstName, originalEmail: $originalEmail, favoriteSector: $favoriteSector, isSubmitting: $isSubmitting, saveFailure: $saveFailure)';
}


}

/// @nodoc
abstract mixin class _$FormCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$FormCopyWith(_Form value, $Res Function(_Form) _then) = __$FormCopyWithImpl;
@useResult
$Res call({
 String firstName, String email, String originalFirstName, String originalEmail, String? favoriteSector, bool isSubmitting, Failure? saveFailure
});


$FailureCopyWith<$Res>? get saveFailure;

}
/// @nodoc
class __$FormCopyWithImpl<$Res>
    implements _$FormCopyWith<$Res> {
  __$FormCopyWithImpl(this._self, this._then);

  final _Form _self;
  final $Res Function(_Form) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? email = null,Object? originalFirstName = null,Object? originalEmail = null,Object? favoriteSector = freezed,Object? isSubmitting = null,Object? saveFailure = freezed,}) {
  return _then(_Form(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,originalFirstName: null == originalFirstName ? _self.originalFirstName : originalFirstName // ignore: cast_nullable_to_non_nullable
as String,originalEmail: null == originalEmail ? _self.originalEmail : originalEmail // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get saveFailure {
    if (_self.saveFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.saveFailure!, (value) {
    return _then(_self.copyWith(saveFailure: value));
  });
}
}

// dart format on
