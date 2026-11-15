// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( SettingsLoaded value)?  loaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case SettingsLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( SettingsLoaded value)  loaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case SettingsLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( SettingsLoaded value)?  loaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case SettingsLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SettingsDisplayData data,  bool shouldShowPermissionPrompt)?  loaded,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case SettingsLoaded() when loaded != null:
return loaded(_that.data,_that.shouldShowPermissionPrompt);case _Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SettingsDisplayData data,  bool shouldShowPermissionPrompt)  loaded,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case SettingsLoaded():
return loaded(_that.data,_that.shouldShowPermissionPrompt);case _Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SettingsDisplayData data,  bool shouldShowPermissionPrompt)?  loaded,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case SettingsLoaded() when loaded != null:
return loaded(_that.data,_that.shouldShowPermissionPrompt);case _Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SettingsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.initial()';
}


}




/// @nodoc


class _Loading implements SettingsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




/// @nodoc


class SettingsLoaded implements SettingsState {
  const SettingsLoaded(this.data, {this.shouldShowPermissionPrompt = false});
  

 final  SettingsDisplayData data;
@JsonKey() final  bool shouldShowPermissionPrompt;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsLoadedCopyWith<SettingsLoaded> get copyWith => _$SettingsLoadedCopyWithImpl<SettingsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoaded&&(identical(other.data, data) || other.data == data)&&(identical(other.shouldShowPermissionPrompt, shouldShowPermissionPrompt) || other.shouldShowPermissionPrompt == shouldShowPermissionPrompt));
}


@override
int get hashCode => Object.hash(runtimeType,data,shouldShowPermissionPrompt);

@override
String toString() {
  return 'SettingsState.loaded(data: $data, shouldShowPermissionPrompt: $shouldShowPermissionPrompt)';
}


}

/// @nodoc
abstract mixin class $SettingsLoadedCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsLoadedCopyWith(SettingsLoaded value, $Res Function(SettingsLoaded) _then) = _$SettingsLoadedCopyWithImpl;
@useResult
$Res call({
 SettingsDisplayData data, bool shouldShowPermissionPrompt
});


$SettingsDisplayDataCopyWith<$Res> get data;

}
/// @nodoc
class _$SettingsLoadedCopyWithImpl<$Res>
    implements $SettingsLoadedCopyWith<$Res> {
  _$SettingsLoadedCopyWithImpl(this._self, this._then);

  final SettingsLoaded _self;
  final $Res Function(SettingsLoaded) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? shouldShowPermissionPrompt = null,}) {
  return _then(SettingsLoaded(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SettingsDisplayData,shouldShowPermissionPrompt: null == shouldShowPermissionPrompt ? _self.shouldShowPermissionPrompt : shouldShowPermissionPrompt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettingsDisplayDataCopyWith<$Res> get data {
  
  return $SettingsDisplayDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class _Failure implements SettingsState {
  const _Failure(this.failure);
  

 final  Failure failure;

/// Create a copy of SettingsState
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
  return 'SettingsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
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

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of SettingsState
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
