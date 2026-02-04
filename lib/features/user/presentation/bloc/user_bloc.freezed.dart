// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserLoadRequested value)?  loadUser,TResult Function( UserClearRequested value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that);case UserClearRequested() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserLoadRequested value)  loadUser,required TResult Function( UserClearRequested value)  clear,}){
final _that = this;
switch (_that) {
case UserLoadRequested():
return loadUser(_that);case UserClearRequested():
return clear(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserLoadRequested value)?  loadUser,TResult? Function( UserClearRequested value)?  clear,}){
final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that);case UserClearRequested() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String uid,  bool silent)?  loadUser,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that.uid,_that.silent);case UserClearRequested() when clear != null:
return clear();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String uid,  bool silent)  loadUser,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case UserLoadRequested():
return loadUser(_that.uid,_that.silent);case UserClearRequested():
return clear();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String uid,  bool silent)?  loadUser,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case UserLoadRequested() when loadUser != null:
return loadUser(_that.uid,_that.silent);case UserClearRequested() when clear != null:
return clear();case _:
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
int get hashCode => Object.hash(runtimeType,uid,silent);

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


class UserClearRequested implements UserEvent {
  const UserClearRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserClearRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.clear()';
}


}




/// @nodoc
mixin _$UserState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState()';
}


}

/// @nodoc
class $UserStateCopyWith<$Res>  {
$UserStateCopyWith(UserState _, $Res Function(UserState) __);
}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserInitial value)?  initial,TResult Function( UserLoading value)?  loading,TResult Function( UserLoaded value)?  loaded,TResult Function( UserNeedsProfile value)?  needsProfile,TResult Function( UserFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial(_that);case UserLoading() when loading != null:
return loading(_that);case UserLoaded() when loaded != null:
return loaded(_that);case UserNeedsProfile() when needsProfile != null:
return needsProfile(_that);case UserFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserInitial value)  initial,required TResult Function( UserLoading value)  loading,required TResult Function( UserLoaded value)  loaded,required TResult Function( UserNeedsProfile value)  needsProfile,required TResult Function( UserFailure value)  failure,}){
final _that = this;
switch (_that) {
case UserInitial():
return initial(_that);case UserLoading():
return loading(_that);case UserLoaded():
return loaded(_that);case UserNeedsProfile():
return needsProfile(_that);case UserFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserInitial value)?  initial,TResult? Function( UserLoading value)?  loading,TResult? Function( UserLoaded value)?  loaded,TResult? Function( UserNeedsProfile value)?  needsProfile,TResult? Function( UserFailure value)?  failure,}){
final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial(_that);case UserLoading() when loading != null:
return loading(_that);case UserLoaded() when loaded != null:
return loaded(_that);case UserNeedsProfile() when needsProfile != null:
return needsProfile(_that);case UserFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? cachedSector)?  loading,TResult Function( UserModel user)?  loaded,TResult Function()?  needsProfile,TResult Function( Failure failure,  String uid,  String? cachedSector)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial();case UserLoading() when loading != null:
return loading(_that.cachedSector);case UserLoaded() when loaded != null:
return loaded(_that.user);case UserNeedsProfile() when needsProfile != null:
return needsProfile();case UserFailure() when failure != null:
return failure(_that.failure,_that.uid,_that.cachedSector);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? cachedSector)  loading,required TResult Function( UserModel user)  loaded,required TResult Function()  needsProfile,required TResult Function( Failure failure,  String uid,  String? cachedSector)  failure,}) {final _that = this;
switch (_that) {
case UserInitial():
return initial();case UserLoading():
return loading(_that.cachedSector);case UserLoaded():
return loaded(_that.user);case UserNeedsProfile():
return needsProfile();case UserFailure():
return failure(_that.failure,_that.uid,_that.cachedSector);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? cachedSector)?  loading,TResult? Function( UserModel user)?  loaded,TResult? Function()?  needsProfile,TResult? Function( Failure failure,  String uid,  String? cachedSector)?  failure,}) {final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial();case UserLoading() when loading != null:
return loading(_that.cachedSector);case UserLoaded() when loaded != null:
return loaded(_that.user);case UserNeedsProfile() when needsProfile != null:
return needsProfile();case UserFailure() when failure != null:
return failure(_that.failure,_that.uid,_that.cachedSector);case _:
  return null;

}
}

}

/// @nodoc


class UserInitial implements UserState {
  const UserInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.initial()';
}


}




/// @nodoc


class UserLoading implements UserState {
  const UserLoading({this.cachedSector});
  

 final  String? cachedSector;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoadingCopyWith<UserLoading> get copyWith => _$UserLoadingCopyWithImpl<UserLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoading&&(identical(other.cachedSector, cachedSector) || other.cachedSector == cachedSector));
}


@override
int get hashCode => Object.hash(runtimeType,cachedSector);

@override
String toString() {
  return 'UserState.loading(cachedSector: $cachedSector)';
}


}

/// @nodoc
abstract mixin class $UserLoadingCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserLoadingCopyWith(UserLoading value, $Res Function(UserLoading) _then) = _$UserLoadingCopyWithImpl;
@useResult
$Res call({
 String? cachedSector
});




}
/// @nodoc
class _$UserLoadingCopyWithImpl<$Res>
    implements $UserLoadingCopyWith<$Res> {
  _$UserLoadingCopyWithImpl(this._self, this._then);

  final UserLoading _self;
  final $Res Function(UserLoading) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cachedSector = freezed,}) {
  return _then(UserLoading(
cachedSector: freezed == cachedSector ? _self.cachedSector : cachedSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UserLoaded implements UserState {
  const UserLoaded(this.user);
  

 final  UserModel user;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoadedCopyWith<UserLoaded> get copyWith => _$UserLoadedCopyWithImpl<UserLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoaded&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserState.loaded(user: $user)';
}


}

/// @nodoc
abstract mixin class $UserLoadedCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserLoadedCopyWith(UserLoaded value, $Res Function(UserLoaded) _then) = _$UserLoadedCopyWithImpl;
@useResult
$Res call({
 UserModel user
});


$UserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$UserLoadedCopyWithImpl<$Res>
    implements $UserLoadedCopyWith<$Res> {
  _$UserLoadedCopyWithImpl(this._self, this._then);

  final UserLoaded _self;
  final $Res Function(UserLoaded) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(UserLoaded(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,
  ));
}

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class UserNeedsProfile implements UserState {
  const UserNeedsProfile();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNeedsProfile);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.needsProfile()';
}


}




/// @nodoc


class UserFailure implements UserState {
  const UserFailure(this.failure, {required this.uid, this.cachedSector});
  

 final  Failure failure;
 final  String uid;
 final  String? cachedSector;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFailureCopyWith<UserFailure> get copyWith => _$UserFailureCopyWithImpl<UserFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFailure&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.cachedSector, cachedSector) || other.cachedSector == cachedSector));
}


@override
int get hashCode => Object.hash(runtimeType,failure,uid,cachedSector);

@override
String toString() {
  return 'UserState.failure(failure: $failure, uid: $uid, cachedSector: $cachedSector)';
}


}

/// @nodoc
abstract mixin class $UserFailureCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserFailureCopyWith(UserFailure value, $Res Function(UserFailure) _then) = _$UserFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure, String uid, String? cachedSector
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$UserFailureCopyWithImpl<$Res>
    implements $UserFailureCopyWith<$Res> {
  _$UserFailureCopyWithImpl(this._self, this._then);

  final UserFailure _self;
  final $Res Function(UserFailure) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? uid = null,Object? cachedSector = freezed,}) {
  return _then(UserFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,cachedSector: freezed == cachedSector ? _self.cachedSector : cachedSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserState
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
