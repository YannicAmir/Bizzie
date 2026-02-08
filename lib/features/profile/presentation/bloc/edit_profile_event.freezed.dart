// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileEvent()';
}


}

/// @nodoc
class $EditProfileEventCopyWith<$Res>  {
$EditProfileEventCopyWith(EditProfileEvent _, $Res Function(EditProfileEvent) __);
}


/// Adds pattern-matching-related methods to [EditProfileEvent].
extension EditProfileEventPatterns on EditProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Started value)?  started,TResult Function( FirstNameChanged value)?  firstNameChanged,TResult Function( EmailChanged value)?  emailChanged,TResult Function( SaveRequested value)?  saveRequested,TResult Function( DeleteAccountRequested value)?  deleteAccountRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case EmailChanged() when emailChanged != null:
return emailChanged(_that);case SaveRequested() when saveRequested != null:
return saveRequested(_that);case DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Started value)  started,required TResult Function( FirstNameChanged value)  firstNameChanged,required TResult Function( EmailChanged value)  emailChanged,required TResult Function( SaveRequested value)  saveRequested,required TResult Function( DeleteAccountRequested value)  deleteAccountRequested,}){
final _that = this;
switch (_that) {
case Started():
return started(_that);case FirstNameChanged():
return firstNameChanged(_that);case EmailChanged():
return emailChanged(_that);case SaveRequested():
return saveRequested(_that);case DeleteAccountRequested():
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Started value)?  started,TResult? Function( FirstNameChanged value)?  firstNameChanged,TResult? Function( EmailChanged value)?  emailChanged,TResult? Function( SaveRequested value)?  saveRequested,TResult? Function( DeleteAccountRequested value)?  deleteAccountRequested,}){
final _that = this;
switch (_that) {
case Started() when started != null:
return started(_that);case FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case EmailChanged() when emailChanged != null:
return emailChanged(_that);case SaveRequested() when saveRequested != null:
return saveRequested(_that);case DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String firstName)?  firstNameChanged,TResult Function( String email)?  emailChanged,TResult Function()?  saveRequested,TResult Function()?  deleteAccountRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case SaveRequested() when saveRequested != null:
return saveRequested();case DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String firstName)  firstNameChanged,required TResult Function( String email)  emailChanged,required TResult Function()  saveRequested,required TResult Function()  deleteAccountRequested,}) {final _that = this;
switch (_that) {
case Started():
return started();case FirstNameChanged():
return firstNameChanged(_that.firstName);case EmailChanged():
return emailChanged(_that.email);case SaveRequested():
return saveRequested();case DeleteAccountRequested():
return deleteAccountRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String firstName)?  firstNameChanged,TResult? Function( String email)?  emailChanged,TResult? Function()?  saveRequested,TResult? Function()?  deleteAccountRequested,}) {final _that = this;
switch (_that) {
case Started() when started != null:
return started();case FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case SaveRequested() when saveRequested != null:
return saveRequested();case DeleteAccountRequested() when deleteAccountRequested != null:
return deleteAccountRequested();case _:
  return null;

}
}

}

/// @nodoc


class Started implements EditProfileEvent {
  const Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileEvent.started()';
}


}




/// @nodoc


class FirstNameChanged implements EditProfileEvent {
  const FirstNameChanged(this.firstName);
  

 final  String firstName;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirstNameChangedCopyWith<FirstNameChanged> get copyWith => _$FirstNameChangedCopyWithImpl<FirstNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirstNameChanged&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode => Object.hash(runtimeType,firstName);

@override
String toString() {
  return 'EditProfileEvent.firstNameChanged(firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class $FirstNameChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory $FirstNameChangedCopyWith(FirstNameChanged value, $Res Function(FirstNameChanged) _then) = _$FirstNameChangedCopyWithImpl;
@useResult
$Res call({
 String firstName
});




}
/// @nodoc
class _$FirstNameChangedCopyWithImpl<$Res>
    implements $FirstNameChangedCopyWith<$Res> {
  _$FirstNameChangedCopyWithImpl(this._self, this._then);

  final FirstNameChanged _self;
  final $Res Function(FirstNameChanged) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,}) {
  return _then(FirstNameChanged(
null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailChanged implements EditProfileEvent {
  const EmailChanged(this.email);
  

 final  String email;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailChangedCopyWith<EmailChanged> get copyWith => _$EmailChangedCopyWithImpl<EmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'EditProfileEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $EmailChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory $EmailChangedCopyWith(EmailChanged value, $Res Function(EmailChanged) _then) = _$EmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$EmailChangedCopyWithImpl<$Res>
    implements $EmailChangedCopyWith<$Res> {
  _$EmailChangedCopyWithImpl(this._self, this._then);

  final EmailChanged _self;
  final $Res Function(EmailChanged) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SaveRequested implements EditProfileEvent {
  const SaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileEvent.saveRequested()';
}


}




/// @nodoc


class DeleteAccountRequested implements EditProfileEvent {
  const DeleteAccountRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteAccountRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditProfileEvent.deleteAccountRequested()';
}


}




// dart format on
