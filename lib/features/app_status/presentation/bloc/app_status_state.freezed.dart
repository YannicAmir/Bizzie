// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStatusState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatusState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppStatusState()';
}


}

/// @nodoc
class $AppStatusStateCopyWith<$Res>  {
$AppStatusStateCopyWith(AppStatusState _, $Res Function(AppStatusState) __);
}


/// Adds pattern-matching-related methods to [AppStatusState].
extension AppStatusStatePatterns on AppStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Checked value)?  checked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Checked() when checked != null:
return checked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Checked value)  checked,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Checked():
return checked(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Checked value)?  checked,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Checked() when checked != null:
return checked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( AppStatus status,  bool isRefreshing)?  checked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Checked() when checked != null:
return checked(_that.status,_that.isRefreshing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( AppStatus status,  bool isRefreshing)  checked,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Checked():
return checked(_that.status,_that.isRefreshing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( AppStatus status,  bool isRefreshing)?  checked,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Checked() when checked != null:
return checked(_that.status,_that.isRefreshing);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AppStatusState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'AppStatusState.initial()';
}


}




/// @nodoc


class _Checked implements AppStatusState {
  const _Checked(this.status, {this.isRefreshing = false});
  

 final  AppStatus status;
@JsonKey() final  bool isRefreshing;

/// Create a copy of AppStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckedCopyWith<_Checked> get copyWith => __$CheckedCopyWithImpl<_Checked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Checked&&(identical(other.status, status) || other.status == status)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,isRefreshing);
}

@override
String toString() {
    return 'AppStatusState.checked(status: $status, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$CheckedCopyWith<$Res> implements $AppStatusStateCopyWith<$Res> {
  factory _$CheckedCopyWith(_Checked value, $Res Function(_Checked) _then) = __$CheckedCopyWithImpl;
@useResult
$Res call({
 AppStatus status, bool isRefreshing
});


$AppStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$CheckedCopyWithImpl<$Res>
    implements _$CheckedCopyWith<$Res> {
  __$CheckedCopyWithImpl(this._self, this._then);

  final _Checked _self;
  final $Res Function(_Checked) _then;

/// Create a copy of AppStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isRefreshing = null,}) {
  return _then(_Checked(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AppStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res> get status {
  
  return $AppStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
