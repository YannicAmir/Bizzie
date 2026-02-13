// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangePasswordEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordEvent()';
}


}

/// @nodoc
class $ChangePasswordEventCopyWith<$Res>  {
$ChangePasswordEventCopyWith(ChangePasswordEvent _, $Res Function(ChangePasswordEvent) __);
}


/// Adds pattern-matching-related methods to [ChangePasswordEvent].
extension ChangePasswordEventPatterns on ChangePasswordEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( OldPasswordChanged value)?  oldPasswordChanged,TResult Function( NewPasswordChanged value)?  newPasswordChanged,TResult Function( ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult Function( SaveRequested value)?  saveRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case OldPasswordChanged() when oldPasswordChanged != null:
return oldPasswordChanged(_that);case NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that);case ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( OldPasswordChanged value)  oldPasswordChanged,required TResult Function( NewPasswordChanged value)  newPasswordChanged,required TResult Function( ConfirmPasswordChanged value)  confirmPasswordChanged,required TResult Function( SaveRequested value)  saveRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case OldPasswordChanged():
return oldPasswordChanged(_that);case NewPasswordChanged():
return newPasswordChanged(_that);case ConfirmPasswordChanged():
return confirmPasswordChanged(_that);case SaveRequested():
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( OldPasswordChanged value)?  oldPasswordChanged,TResult? Function( NewPasswordChanged value)?  newPasswordChanged,TResult? Function( ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult? Function( SaveRequested value)?  saveRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case OldPasswordChanged() when oldPasswordChanged != null:
return oldPasswordChanged(_that);case NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that);case ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case SaveRequested() when saveRequested != null:
return saveRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String password)?  oldPasswordChanged,TResult Function( String password)?  newPasswordChanged,TResult Function( String password)?  confirmPasswordChanged,TResult Function()?  saveRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case OldPasswordChanged() when oldPasswordChanged != null:
return oldPasswordChanged(_that.password);case NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that.password);case ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.password);case SaveRequested() when saveRequested != null:
return saveRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String password)  oldPasswordChanged,required TResult Function( String password)  newPasswordChanged,required TResult Function( String password)  confirmPasswordChanged,required TResult Function()  saveRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case OldPasswordChanged():
return oldPasswordChanged(_that.password);case NewPasswordChanged():
return newPasswordChanged(_that.password);case ConfirmPasswordChanged():
return confirmPasswordChanged(_that.password);case SaveRequested():
return saveRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String password)?  oldPasswordChanged,TResult? Function( String password)?  newPasswordChanged,TResult? Function( String password)?  confirmPasswordChanged,TResult? Function()?  saveRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case OldPasswordChanged() when oldPasswordChanged != null:
return oldPasswordChanged(_that.password);case NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that.password);case ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.password);case SaveRequested() when saveRequested != null:
return saveRequested();case _:
  return null;

}
}

}

/// @nodoc


class Started implements ChangePasswordEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordEvent.started()';
}


}




/// @nodoc


class OldPasswordChanged implements ChangePasswordEvent {
  const OldPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OldPasswordChangedCopyWith<OldPasswordChanged> get copyWith => _$OldPasswordChangedCopyWithImpl<OldPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OldPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'ChangePasswordEvent.oldPasswordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $OldPasswordChangedCopyWith<$Res> implements $ChangePasswordEventCopyWith<$Res> {
  factory $OldPasswordChangedCopyWith(OldPasswordChanged value, $Res Function(OldPasswordChanged) _then) = _$OldPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$OldPasswordChangedCopyWithImpl<$Res>
    implements $OldPasswordChangedCopyWith<$Res> {
  _$OldPasswordChangedCopyWithImpl(this._self, this._then);

  final OldPasswordChanged _self;
  final $Res Function(OldPasswordChanged) _then;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(OldPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NewPasswordChanged implements ChangePasswordEvent {
  const NewPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewPasswordChangedCopyWith<NewPasswordChanged> get copyWith => _$NewPasswordChangedCopyWithImpl<NewPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'ChangePasswordEvent.newPasswordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $NewPasswordChangedCopyWith<$Res> implements $ChangePasswordEventCopyWith<$Res> {
  factory $NewPasswordChangedCopyWith(NewPasswordChanged value, $Res Function(NewPasswordChanged) _then) = _$NewPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$NewPasswordChangedCopyWithImpl<$Res>
    implements $NewPasswordChangedCopyWith<$Res> {
  _$NewPasswordChangedCopyWithImpl(this._self, this._then);

  final NewPasswordChanged _self;
  final $Res Function(NewPasswordChanged) _then;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(NewPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ConfirmPasswordChanged implements ChangePasswordEvent {
  const ConfirmPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmPasswordChangedCopyWith<ConfirmPasswordChanged> get copyWith => _$ConfirmPasswordChangedCopyWithImpl<ConfirmPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'ChangePasswordEvent.confirmPasswordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $ConfirmPasswordChangedCopyWith<$Res> implements $ChangePasswordEventCopyWith<$Res> {
  factory $ConfirmPasswordChangedCopyWith(ConfirmPasswordChanged value, $Res Function(ConfirmPasswordChanged) _then) = _$ConfirmPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$ConfirmPasswordChangedCopyWithImpl<$Res>
    implements $ConfirmPasswordChangedCopyWith<$Res> {
  _$ConfirmPasswordChangedCopyWithImpl(this._self, this._then);

  final ConfirmPasswordChanged _self;
  final $Res Function(ConfirmPasswordChanged) _then;

/// Create a copy of ChangePasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(ConfirmPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SaveRequested implements ChangePasswordEvent {
  const SaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChangePasswordEvent.saveRequested()';
}


}




// dart format on
