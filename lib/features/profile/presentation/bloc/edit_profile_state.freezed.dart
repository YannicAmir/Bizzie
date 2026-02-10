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

 String? get favoriteSector;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'EditProfileState(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteSector = freezed,}) {
  return _then(_self.copyWith(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,TResult Function( _Deleted value)?  deleted,TResult Function( _Form value)?  form,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Deleted() when deleted != null:
return deleted(_that);case _Form() when form != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,required TResult Function( _Deleted value)  deleted,required TResult Function( _Form value)  form,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _Deleted():
return deleted(_that);case _Form():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,TResult? Function( _Deleted value)?  deleted,TResult? Function( _Form value)?  form,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _Deleted() when deleted != null:
return deleted(_that);case _Form() when form != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? favoriteSector)?  initial,TResult Function( String? favoriteSector)?  loading,TResult Function( String? favoriteSector)?  success,TResult Function( Failure failure,  String? favoriteSector)?  failure,TResult Function( String? favoriteSector)?  deleted,TResult Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure,  bool isShowReauthModal,  String? reauthTitle,  ReauthAction? pendingReauthAction,  bool isReauthSubmitting,  Failure? reauthFailure,  int reauthAttempts,  List<String> providers,  bool isReauthPasswordVisible,  bool isDeleting,  bool isShowDeleteConfirmation)?  form,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.favoriteSector);case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Success() when success != null:
return success(_that.favoriteSector);case _Failure() when failure != null:
return failure(_that.failure,_that.favoriteSector);case _Deleted() when deleted != null:
return deleted(_that.favoriteSector);case _Form() when form != null:
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure,_that.isShowReauthModal,_that.reauthTitle,_that.pendingReauthAction,_that.isReauthSubmitting,_that.reauthFailure,_that.reauthAttempts,_that.providers,_that.isReauthPasswordVisible,_that.isDeleting,_that.isShowDeleteConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? favoriteSector)  initial,required TResult Function( String? favoriteSector)  loading,required TResult Function( String? favoriteSector)  success,required TResult Function( Failure failure,  String? favoriteSector)  failure,required TResult Function( String? favoriteSector)  deleted,required TResult Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure,  bool isShowReauthModal,  String? reauthTitle,  ReauthAction? pendingReauthAction,  bool isReauthSubmitting,  Failure? reauthFailure,  int reauthAttempts,  List<String> providers,  bool isReauthPasswordVisible,  bool isDeleting,  bool isShowDeleteConfirmation)  form,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.favoriteSector);case _Loading():
return loading(_that.favoriteSector);case _Success():
return success(_that.favoriteSector);case _Failure():
return failure(_that.failure,_that.favoriteSector);case _Deleted():
return deleted(_that.favoriteSector);case _Form():
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure,_that.isShowReauthModal,_that.reauthTitle,_that.pendingReauthAction,_that.isReauthSubmitting,_that.reauthFailure,_that.reauthAttempts,_that.providers,_that.isReauthPasswordVisible,_that.isDeleting,_that.isShowDeleteConfirmation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? favoriteSector)?  initial,TResult? Function( String? favoriteSector)?  loading,TResult? Function( String? favoriteSector)?  success,TResult? Function( Failure failure,  String? favoriteSector)?  failure,TResult? Function( String? favoriteSector)?  deleted,TResult? Function( String firstName,  String email,  String originalFirstName,  String originalEmail,  String? favoriteSector,  bool isSubmitting,  Failure? saveFailure,  bool isShowReauthModal,  String? reauthTitle,  ReauthAction? pendingReauthAction,  bool isReauthSubmitting,  Failure? reauthFailure,  int reauthAttempts,  List<String> providers,  bool isReauthPasswordVisible,  bool isDeleting,  bool isShowDeleteConfirmation)?  form,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.favoriteSector);case _Loading() when loading != null:
return loading(_that.favoriteSector);case _Success() when success != null:
return success(_that.favoriteSector);case _Failure() when failure != null:
return failure(_that.failure,_that.favoriteSector);case _Deleted() when deleted != null:
return deleted(_that.favoriteSector);case _Form() when form != null:
return form(_that.firstName,_that.email,_that.originalFirstName,_that.originalEmail,_that.favoriteSector,_that.isSubmitting,_that.saveFailure,_that.isShowReauthModal,_that.reauthTitle,_that.pendingReauthAction,_that.isReauthSubmitting,_that.reauthFailure,_that.reauthAttempts,_that.providers,_that.isReauthPasswordVisible,_that.isDeleting,_that.isShowDeleteConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class _Initial extends EditProfileState {
  const _Initial({this.favoriteSector}): super._();
  

@override final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'EditProfileState.initial(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Initial(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Loading extends EditProfileState {
  const _Loading({this.favoriteSector}): super._();
  

@override final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Loading(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Success extends EditProfileState {
  const _Success({this.favoriteSector}): super._();
  

@override final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'EditProfileState.success(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Success(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Failure extends EditProfileState {
  const _Failure(this.failure, {this.favoriteSector}): super._();
  

 final  Failure failure;
@override final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? favoriteSector = freezed,}) {
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


class _Deleted extends EditProfileState {
  const _Deleted({this.favoriteSector}): super._();
  

@override final  String? favoriteSector;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeletedCopyWith<_Deleted> get copyWith => __$DeletedCopyWithImpl<_Deleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Deleted&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector));
}


@override
int get hashCode => Object.hash(runtimeType,favoriteSector);

@override
String toString() {
  return 'EditProfileState.deleted(favoriteSector: $favoriteSector)';
}


}

/// @nodoc
abstract mixin class _$DeletedCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$DeletedCopyWith(_Deleted value, $Res Function(_Deleted) _then) = __$DeletedCopyWithImpl;
@override @useResult
$Res call({
 String? favoriteSector
});




}
/// @nodoc
class __$DeletedCopyWithImpl<$Res>
    implements _$DeletedCopyWith<$Res> {
  __$DeletedCopyWithImpl(this._self, this._then);

  final _Deleted _self;
  final $Res Function(_Deleted) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteSector = freezed,}) {
  return _then(_Deleted(
favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Form extends EditProfileState {
  const _Form({required this.firstName, required this.email, required this.originalFirstName, required this.originalEmail, this.favoriteSector, this.isSubmitting = false, this.saveFailure, this.isShowReauthModal = false, this.reauthTitle, this.pendingReauthAction, this.isReauthSubmitting = false, this.reauthFailure, this.reauthAttempts = 0, final  List<String> providers = const [], this.isReauthPasswordVisible = false, this.isDeleting = false, this.isShowDeleteConfirmation = false}): _providers = providers,super._();
  

 final  String firstName;
 final  String email;
 final  String originalFirstName;
 final  String originalEmail;
@override final  String? favoriteSector;
@JsonKey() final  bool isSubmitting;
 final  Failure? saveFailure;
@JsonKey() final  bool isShowReauthModal;
 final  String? reauthTitle;
 final  ReauthAction? pendingReauthAction;
@JsonKey() final  bool isReauthSubmitting;
 final  Failure? reauthFailure;
@JsonKey() final  int reauthAttempts;
 final  List<String> _providers;
@JsonKey() List<String> get providers {
  if (_providers is EqualUnmodifiableListView) return _providers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providers);
}

@JsonKey() final  bool isReauthPasswordVisible;
@JsonKey() final  bool isDeleting;
@JsonKey() final  bool isShowDeleteConfirmation;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormCopyWith<_Form> get copyWith => __$FormCopyWithImpl<_Form>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Form&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.email, email) || other.email == email)&&(identical(other.originalFirstName, originalFirstName) || other.originalFirstName == originalFirstName)&&(identical(other.originalEmail, originalEmail) || other.originalEmail == originalEmail)&&(identical(other.favoriteSector, favoriteSector) || other.favoriteSector == favoriteSector)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.saveFailure, saveFailure) || other.saveFailure == saveFailure)&&(identical(other.isShowReauthModal, isShowReauthModal) || other.isShowReauthModal == isShowReauthModal)&&(identical(other.reauthTitle, reauthTitle) || other.reauthTitle == reauthTitle)&&(identical(other.pendingReauthAction, pendingReauthAction) || other.pendingReauthAction == pendingReauthAction)&&(identical(other.isReauthSubmitting, isReauthSubmitting) || other.isReauthSubmitting == isReauthSubmitting)&&(identical(other.reauthFailure, reauthFailure) || other.reauthFailure == reauthFailure)&&(identical(other.reauthAttempts, reauthAttempts) || other.reauthAttempts == reauthAttempts)&&const DeepCollectionEquality().equals(other._providers, _providers)&&(identical(other.isReauthPasswordVisible, isReauthPasswordVisible) || other.isReauthPasswordVisible == isReauthPasswordVisible)&&(identical(other.isDeleting, isDeleting) || other.isDeleting == isDeleting)&&(identical(other.isShowDeleteConfirmation, isShowDeleteConfirmation) || other.isShowDeleteConfirmation == isShowDeleteConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,email,originalFirstName,originalEmail,favoriteSector,isSubmitting,saveFailure,isShowReauthModal,reauthTitle,pendingReauthAction,isReauthSubmitting,reauthFailure,reauthAttempts,const DeepCollectionEquality().hash(_providers),isReauthPasswordVisible,isDeleting,isShowDeleteConfirmation);

@override
String toString() {
  return 'EditProfileState.form(firstName: $firstName, email: $email, originalFirstName: $originalFirstName, originalEmail: $originalEmail, favoriteSector: $favoriteSector, isSubmitting: $isSubmitting, saveFailure: $saveFailure, isShowReauthModal: $isShowReauthModal, reauthTitle: $reauthTitle, pendingReauthAction: $pendingReauthAction, isReauthSubmitting: $isReauthSubmitting, reauthFailure: $reauthFailure, reauthAttempts: $reauthAttempts, providers: $providers, isReauthPasswordVisible: $isReauthPasswordVisible, isDeleting: $isDeleting, isShowDeleteConfirmation: $isShowDeleteConfirmation)';
}


}

/// @nodoc
abstract mixin class _$FormCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$FormCopyWith(_Form value, $Res Function(_Form) _then) = __$FormCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String email, String originalFirstName, String originalEmail, String? favoriteSector, bool isSubmitting, Failure? saveFailure, bool isShowReauthModal, String? reauthTitle, ReauthAction? pendingReauthAction, bool isReauthSubmitting, Failure? reauthFailure, int reauthAttempts, List<String> providers, bool isReauthPasswordVisible, bool isDeleting, bool isShowDeleteConfirmation
});


$FailureCopyWith<$Res>? get saveFailure;$FailureCopyWith<$Res>? get reauthFailure;

}
/// @nodoc
class __$FormCopyWithImpl<$Res>
    implements _$FormCopyWith<$Res> {
  __$FormCopyWithImpl(this._self, this._then);

  final _Form _self;
  final $Res Function(_Form) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? email = null,Object? originalFirstName = null,Object? originalEmail = null,Object? favoriteSector = freezed,Object? isSubmitting = null,Object? saveFailure = freezed,Object? isShowReauthModal = null,Object? reauthTitle = freezed,Object? pendingReauthAction = freezed,Object? isReauthSubmitting = null,Object? reauthFailure = freezed,Object? reauthAttempts = null,Object? providers = null,Object? isReauthPasswordVisible = null,Object? isDeleting = null,Object? isShowDeleteConfirmation = null,}) {
  return _then(_Form(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,originalFirstName: null == originalFirstName ? _self.originalFirstName : originalFirstName // ignore: cast_nullable_to_non_nullable
as String,originalEmail: null == originalEmail ? _self.originalEmail : originalEmail // ignore: cast_nullable_to_non_nullable
as String,favoriteSector: freezed == favoriteSector ? _self.favoriteSector : favoriteSector // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,saveFailure: freezed == saveFailure ? _self.saveFailure : saveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,isShowReauthModal: null == isShowReauthModal ? _self.isShowReauthModal : isShowReauthModal // ignore: cast_nullable_to_non_nullable
as bool,reauthTitle: freezed == reauthTitle ? _self.reauthTitle : reauthTitle // ignore: cast_nullable_to_non_nullable
as String?,pendingReauthAction: freezed == pendingReauthAction ? _self.pendingReauthAction : pendingReauthAction // ignore: cast_nullable_to_non_nullable
as ReauthAction?,isReauthSubmitting: null == isReauthSubmitting ? _self.isReauthSubmitting : isReauthSubmitting // ignore: cast_nullable_to_non_nullable
as bool,reauthFailure: freezed == reauthFailure ? _self.reauthFailure : reauthFailure // ignore: cast_nullable_to_non_nullable
as Failure?,reauthAttempts: null == reauthAttempts ? _self.reauthAttempts : reauthAttempts // ignore: cast_nullable_to_non_nullable
as int,providers: null == providers ? _self._providers : providers // ignore: cast_nullable_to_non_nullable
as List<String>,isReauthPasswordVisible: null == isReauthPasswordVisible ? _self.isReauthPasswordVisible : isReauthPasswordVisible // ignore: cast_nullable_to_non_nullable
as bool,isDeleting: null == isDeleting ? _self.isDeleting : isDeleting // ignore: cast_nullable_to_non_nullable
as bool,isShowDeleteConfirmation: null == isShowDeleteConfirmation ? _self.isShowDeleteConfirmation : isShowDeleteConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
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
}/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get reauthFailure {
    if (_self.reauthFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.reauthFailure!, (value) {
    return _then(_self.copyWith(reauthFailure: value));
  });
}
}

// dart format on
