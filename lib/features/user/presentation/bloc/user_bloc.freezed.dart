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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadUser value)?  loadUser,TResult Function( _Clear value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadUser() when loadUser != null:
return loadUser(_that);case _Clear() when clear != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadUser value)  loadUser,required TResult Function( _Clear value)  clear,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadUser():
return loadUser(_that);case _Clear():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadUser value)?  loadUser,TResult? Function( _Clear value)?  clear,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadUser() when loadUser != null:
return loadUser(_that);case _Clear() when clear != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String uid)?  loadUser,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadUser() when loadUser != null:
return loadUser(_that.uid);case _Clear() when clear != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String uid)  loadUser,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _LoadUser():
return loadUser(_that.uid);case _Clear():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String uid)?  loadUser,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _LoadUser() when loadUser != null:
return loadUser(_that.uid);case _Clear() when clear != null:
return clear();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements UserEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserEvent.started()';
}


}




/// @nodoc


class _LoadUser implements UserEvent {
  const _LoadUser(this.uid);
  

 final  String uid;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadUserCopyWith<_LoadUser> get copyWith => __$LoadUserCopyWithImpl<_LoadUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadUser&&(identical(other.uid, uid) || other.uid == uid));
}


@override
int get hashCode => Object.hash(runtimeType,uid);

@override
String toString() {
  return 'UserEvent.loadUser(uid: $uid)';
}


}

/// @nodoc
abstract mixin class _$LoadUserCopyWith<$Res> implements $UserEventCopyWith<$Res> {
  factory _$LoadUserCopyWith(_LoadUser value, $Res Function(_LoadUser) _then) = __$LoadUserCopyWithImpl;
@useResult
$Res call({
 String uid
});




}
/// @nodoc
class __$LoadUserCopyWithImpl<$Res>
    implements _$LoadUserCopyWith<$Res> {
  __$LoadUserCopyWithImpl(this._self, this._then);

  final _LoadUser _self;
  final $Res Function(_LoadUser) _then;

/// Create a copy of UserEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uid = null,}) {
  return _then(_LoadUser(
null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Clear implements UserEvent {
  const _Clear();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Clear);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String? cachedSector)?  loading,TResult Function( UserModel user)?  loaded,TResult Function( String message,  String? cachedSector)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.cachedSector);case _Loaded() when loaded != null:
return loaded(_that.user);case _Failure() when failure != null:
return failure(_that.message,_that.cachedSector);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String? cachedSector)  loading,required TResult Function( UserModel user)  loaded,required TResult Function( String message,  String? cachedSector)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading(_that.cachedSector);case _Loaded():
return loaded(_that.user);case _Failure():
return failure(_that.message,_that.cachedSector);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String? cachedSector)?  loading,TResult? Function( UserModel user)?  loaded,TResult? Function( String message,  String? cachedSector)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading(_that.cachedSector);case _Loaded() when loaded != null:
return loaded(_that.user);case _Failure() when failure != null:
return failure(_that.message,_that.cachedSector);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements UserState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.initial()';
}


}




/// @nodoc


class _Loading implements UserState {
  const _Loading({this.cachedSector});
  

 final  String? cachedSector;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&(identical(other.cachedSector, cachedSector) || other.cachedSector == cachedSector));
}


@override
int get hashCode => Object.hash(runtimeType,cachedSector);

@override
String toString() {
  return 'UserState.loading(cachedSector: $cachedSector)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@useResult
$Res call({
 String? cachedSector
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cachedSector = freezed,}) {
  return _then(_Loading(
cachedSector: freezed == cachedSector ? _self.cachedSector : cachedSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Loaded implements UserState {
  const _Loaded(this.user);
  

 final  UserModel user;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserState.loaded(user: $user)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 UserModel user
});


$UserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_Loaded(
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


class _Failure implements UserState {
  const _Failure(this.message, {this.cachedSector});
  

 final  String message;
 final  String? cachedSector;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.message, message) || other.message == message)&&(identical(other.cachedSector, cachedSector) || other.cachedSector == cachedSector));
}


@override
int get hashCode => Object.hash(runtimeType,message,cachedSector);

@override
String toString() {
  return 'UserState.failure(message: $message, cachedSector: $cachedSector)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@useResult
$Res call({
 String message, String? cachedSector
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cachedSector = freezed,}) {
  return _then(_Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cachedSector: freezed == cachedSector ? _self.cachedSector : cachedSector // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
