// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserEvent()';
}


}

/// @nodoc
class $UserEventCopyWith<$Res>  {
$UserEventCopyWith(UserEvent _, $Res Function(UserEvent) __);
}


/// Adds pattern-matching-related methods to [UserEvent].
extension UserEventPatterns on UserEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserLoadRequested value)?  loadUser,TResult Function( UserReset value)?  reset,TResult Function( UserAppForegrounded value)?  appForegrounded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that);case UserReset() when reset != null:
return reset(_that);case UserAppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserLoadRequested value)  loadUser,required TResult Function( UserReset value)  reset,required TResult Function( UserAppForegrounded value)  appForegrounded,}){
final _that = this;
switch (_that) {
case UserLoadRequested():
return loadUser(_that);case UserReset():
return reset(_that);case UserAppForegrounded():
return appForegrounded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserLoadRequested value)?  loadUser,TResult? Function( UserReset value)?  reset,TResult? Function( UserAppForegrounded value)?  appForegrounded,}){
final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that);case UserReset() when reset != null:
return reset(_that);case UserAppForegrounded() when appForegrounded != null:
return appForegrounded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String uid,  bool silent)?  loadUser,TResult Function()?  reset,TResult Function()?  appForegrounded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that.uid,_that.silent);case UserReset() when reset != null:
return reset();case UserAppForegrounded() when appForegrounded != null:
return appForegrounded();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String uid,  bool silent)  loadUser,required TResult Function()  reset,required TResult Function()  appForegrounded,}) {final _that = this;
switch (_that) {
case UserLoadRequested():
return loadUser(_that.uid,_that.silent);case UserReset():
return reset();case UserAppForegrounded():
return appForegrounded();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String uid,  bool silent)?  loadUser,TResult? Function()?  reset,TResult? Function()?  appForegrounded,}) {final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that.uid,_that.silent);case UserReset() when reset != null:
return reset();case UserAppForegrounded() when appForegrounded != null:
return appForegrounded();case _:
  return null;

}
}

}

/// @nodoc


class UserLoadRequested implements UserEvent {
  const UserLoadRequested({required this.uid, this.silent = false});
  

 final  String uid;
@JsonKey() final  bool silent;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoadRequestedCopyWith<UserLoadRequested> get copyWith => _$UserLoadRequestedCopyWithImpl<UserLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoadRequested&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.silent, silent) || other.silent == silent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,uid,silent);
}

@override
String toString() {
    return 'UserEvent.loadUser(uid: $uid, silent: $silent)';
}


}

/// @nodoc
abstract mixin class $UserLoadRequestedCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory $UserLoadRequestedCopyWith(UserLoadRequested value, $Res Function(UserLoadRequested) _then) = _$UserLoadRequestedCopyWithImpl;
@useResult
$Res call({
 String uid, bool silent
});




}
/// @nodoc
class _$UserLoadRequestedCopyWithImpl<$Res>
    implements $UserLoadRequestedCopyWith<$Res> {
  _$UserLoadRequestedCopyWithImpl(this._self, this._then);

  final UserLoadRequested _self;
  final $Res Function(UserLoadRequested) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? silent = null,}) {
  return _then(UserLoadRequested(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,silent: null == silent ? _self.silent : silent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class UserReset implements UserEvent {
  const UserReset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserEvent.reset()';
}


}




/// @nodoc


class UserAppForegrounded implements UserEvent {
  const UserAppForegrounded();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAppForegrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'UserEvent.appForegrounded()';
}


}




// dart format on
