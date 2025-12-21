// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthStatusRequested value)?  statusRequested,TResult Function( AuthLogoutRequested value)?  logoutRequested,TResult Function( AuthGoogleSignInRequested value)?  googleSignInRequested,TResult Function( AuthAppleSignInRequested value)?  appleSignInRequested,TResult Function( AuthResetPasswordRequested value)?  resetPasswordRequested,TResult Function( AuthDeleteAccountRequested value)?  deleteAccountRequested,TResult Function( AuthEmailSignInRequested value)?  emailSignInRequested,TResult Function( AuthEmailSignUpRequested value)?  emailSignUpRequested,TResult Function( AuthStatusChanged value)?  statusChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthStatusRequested() when statusRequested != null:
return statusRequested(_that);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case AuthAppleSignInRequested() when appleSignInRequested != null:
return appleSignInRequested(_that);case AuthResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case AuthDeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case AuthEmailSignInRequested() when emailSignInRequested != null:
return emailSignInRequested(_that);case AuthEmailSignUpRequested() when emailSignUpRequested != null:
return emailSignUpRequested(_that);case AuthStatusChanged() when statusChanged != null:
return statusChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthStatusRequested value)  statusRequested,required TResult Function( AuthLogoutRequested value)  logoutRequested,required TResult Function( AuthGoogleSignInRequested value)  googleSignInRequested,required TResult Function( AuthAppleSignInRequested value)  appleSignInRequested,required TResult Function( AuthResetPasswordRequested value)  resetPasswordRequested,required TResult Function( AuthDeleteAccountRequested value)  deleteAccountRequested,required TResult Function( AuthEmailSignInRequested value)  emailSignInRequested,required TResult Function( AuthEmailSignUpRequested value)  emailSignUpRequested,required TResult Function( AuthStatusChanged value)  statusChanged,}){
final _that = this;
switch (_that) {
case AuthStatusRequested():
return statusRequested(_that);case AuthLogoutRequested():
return logoutRequested(_that);case AuthGoogleSignInRequested():
return googleSignInRequested(_that);case AuthAppleSignInRequested():
return appleSignInRequested(_that);case AuthResetPasswordRequested():
return resetPasswordRequested(_that);case AuthDeleteAccountRequested():
return deleteAccountRequested(_that);case AuthEmailSignInRequested():
return emailSignInRequested(_that);case AuthEmailSignUpRequested():
return emailSignUpRequested(_that);case AuthStatusChanged():
return statusChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthStatusRequested value)?  statusRequested,TResult? Function( AuthLogoutRequested value)?  logoutRequested,TResult? Function( AuthGoogleSignInRequested value)?  googleSignInRequested,TResult? Function( AuthAppleSignInRequested value)?  appleSignInRequested,TResult? Function( AuthResetPasswordRequested value)?  resetPasswordRequested,TResult? Function( AuthDeleteAccountRequested value)?  deleteAccountRequested,TResult? Function( AuthEmailSignInRequested value)?  emailSignInRequested,TResult? Function( AuthEmailSignUpRequested value)?  emailSignUpRequested,TResult? Function( AuthStatusChanged value)?  statusChanged,}){
final _that = this;
switch (_that) {
case AuthStatusRequested() when statusRequested != null:
return statusRequested(_that);case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case AuthAppleSignInRequested() when appleSignInRequested != null:
return appleSignInRequested(_that);case AuthResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that);case AuthDeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case AuthEmailSignInRequested() when emailSignInRequested != null:
return emailSignInRequested(_that);case AuthEmailSignUpRequested() when emailSignUpRequested != null:
return emailSignUpRequested(_that);case AuthStatusChanged() when statusChanged != null:
return statusChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  statusRequested,TResult Function()?  logoutRequested,TResult Function()?  googleSignInRequested,TResult Function()?  appleSignInRequested,TResult Function( String email)?  resetPasswordRequested,TResult Function()?  deleteAccountRequested,TResult Function( String email,  String password)?  emailSignInRequested,TResult Function( String email,  String password)?  emailSignUpRequested,TResult Function( UserModel? user)?  statusChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthStatusRequested() when statusRequested != null:
return statusRequested();case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested();case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case AuthAppleSignInRequested() when appleSignInRequested != null:
return appleSignInRequested();case AuthResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case AuthDeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case AuthEmailSignInRequested() when emailSignInRequested != null:
return emailSignInRequested(_that.email,_that.password);case AuthEmailSignUpRequested() when emailSignUpRequested != null:
return emailSignUpRequested(_that.email,_that.password);case AuthStatusChanged() when statusChanged != null:
return statusChanged(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  statusRequested,required TResult Function()  logoutRequested,required TResult Function()  googleSignInRequested,required TResult Function()  appleSignInRequested,required TResult Function( String email)  resetPasswordRequested,required TResult Function()  deleteAccountRequested,required TResult Function( String email,  String password)  emailSignInRequested,required TResult Function( String email,  String password)  emailSignUpRequested,required TResult Function( UserModel? user)  statusChanged,}) {final _that = this;
switch (_that) {
case AuthStatusRequested():
return statusRequested();case AuthLogoutRequested():
return logoutRequested();case AuthGoogleSignInRequested():
return googleSignInRequested();case AuthAppleSignInRequested():
return appleSignInRequested();case AuthResetPasswordRequested():
return resetPasswordRequested(_that.email);case AuthDeleteAccountRequested():
return deleteAccountRequested();case AuthEmailSignInRequested():
return emailSignInRequested(_that.email,_that.password);case AuthEmailSignUpRequested():
return emailSignUpRequested(_that.email,_that.password);case AuthStatusChanged():
return statusChanged(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  statusRequested,TResult? Function()?  logoutRequested,TResult? Function()?  googleSignInRequested,TResult? Function()?  appleSignInRequested,TResult? Function( String email)?  resetPasswordRequested,TResult? Function()?  deleteAccountRequested,TResult? Function( String email,  String password)?  emailSignInRequested,TResult? Function( String email,  String password)?  emailSignUpRequested,TResult? Function( UserModel? user)?  statusChanged,}) {final _that = this;
switch (_that) {
case AuthStatusRequested() when statusRequested != null:
return statusRequested();case AuthLogoutRequested() when logoutRequested != null:
return logoutRequested();case AuthGoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case AuthAppleSignInRequested() when appleSignInRequested != null:
return appleSignInRequested();case AuthResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.email);case AuthDeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case AuthEmailSignInRequested() when emailSignInRequested != null:
return emailSignInRequested(_that.email,_that.password);case AuthEmailSignUpRequested() when emailSignUpRequested != null:
return emailSignUpRequested(_that.email,_that.password);case AuthStatusChanged() when statusChanged != null:
return statusChanged(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class AuthStatusRequested implements AuthEvent {
  const AuthStatusRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStatusRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.statusRequested()';
}


}




/// @nodoc


class AuthLogoutRequested implements AuthEvent {
  const AuthLogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




/// @nodoc


class AuthGoogleSignInRequested implements AuthEvent {
  const AuthGoogleSignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthGoogleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleSignInRequested()';
}


}




/// @nodoc


class AuthAppleSignInRequested implements AuthEvent {
  const AuthAppleSignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAppleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.appleSignInRequested()';
}


}




/// @nodoc


class AuthResetPasswordRequested implements AuthEvent {
  const AuthResetPasswordRequested(this.email);
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResetPasswordRequestedCopyWith<AuthResetPasswordRequested> get copyWith => _$AuthResetPasswordRequestedCopyWithImpl<AuthResetPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResetPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.resetPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthResetPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthResetPasswordRequestedCopyWith(AuthResetPasswordRequested value, $Res Function(AuthResetPasswordRequested) _then) = _$AuthResetPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthResetPasswordRequestedCopyWithImpl<$Res>
    implements $AuthResetPasswordRequestedCopyWith<$Res> {
  _$AuthResetPasswordRequestedCopyWithImpl(this._self, this._then);

  final AuthResetPasswordRequested _self;
  final $Res Function(AuthResetPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthResetPasswordRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthDeleteAccountRequested implements AuthEvent {
  const AuthDeleteAccountRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthDeleteAccountRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.deleteAccountRequested()';
}


}




/// @nodoc


class AuthEmailSignInRequested implements AuthEvent {
  const AuthEmailSignInRequested(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEmailSignInRequestedCopyWith<AuthEmailSignInRequested> get copyWith => _$AuthEmailSignInRequestedCopyWithImpl<AuthEmailSignInRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEmailSignInRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.emailSignInRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthEmailSignInRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthEmailSignInRequestedCopyWith(AuthEmailSignInRequested value, $Res Function(AuthEmailSignInRequested) _then) = _$AuthEmailSignInRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthEmailSignInRequestedCopyWithImpl<$Res>
    implements $AuthEmailSignInRequestedCopyWith<$Res> {
  _$AuthEmailSignInRequestedCopyWithImpl(this._self, this._then);

  final AuthEmailSignInRequested _self;
  final $Res Function(AuthEmailSignInRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthEmailSignInRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthEmailSignUpRequested implements AuthEvent {
  const AuthEmailSignUpRequested(this.email, this.password);
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEmailSignUpRequestedCopyWith<AuthEmailSignUpRequested> get copyWith => _$AuthEmailSignUpRequestedCopyWithImpl<AuthEmailSignUpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEmailSignUpRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.emailSignUpRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthEmailSignUpRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthEmailSignUpRequestedCopyWith(AuthEmailSignUpRequested value, $Res Function(AuthEmailSignUpRequested) _then) = _$AuthEmailSignUpRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthEmailSignUpRequestedCopyWithImpl<$Res>
    implements $AuthEmailSignUpRequestedCopyWith<$Res> {
  _$AuthEmailSignUpRequestedCopyWithImpl(this._self, this._then);

  final AuthEmailSignUpRequested _self;
  final $Res Function(AuthEmailSignUpRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthEmailSignUpRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthStatusChanged implements AuthEvent {
  const AuthStatusChanged(this.user);
  

 final  UserModel? user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStatusChangedCopyWith<AuthStatusChanged> get copyWith => _$AuthStatusChangedCopyWithImpl<AuthStatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStatusChanged&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.statusChanged(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthStatusChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthStatusChangedCopyWith(AuthStatusChanged value, $Res Function(AuthStatusChanged) _then) = _$AuthStatusChangedCopyWithImpl;
@useResult
$Res call({
 UserModel? user
});


$UserModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthStatusChangedCopyWithImpl<$Res>
    implements $AuthStatusChangedCopyWith<$Res> {
  _$AuthStatusChangedCopyWithImpl(this._self, this._then);

  final AuthStatusChanged _self;
  final $Res Function(AuthStatusChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(AuthStatusChanged(
freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
